// notification daemon
// heavily based on https://github.com/orhun/runst

use dbus::{
    blocking::{stdintf::org_freedesktop_dbus::RequestNameReply, Connection},
    channel::MatchingReceiver,
    message::MatchRule,
    MethodErr,
};
use dbus_crossroads::Crossroads;
use std::{
    error::Error,
    fmt,
    sync::{
        atomic::{AtomicU32, Ordering},
        mpsc::Sender,
    },
    time::{Duration, SystemTime, UNIX_EPOCH},
};

const SERVER_INFO: [&str; 4] = [
    env!("CARGO_PKG_NAME"),
    env!("CARGO_PKG_AUTHORS"),
    env!("CARGO_PKG_VERSION"),
    "1.2",
];

const SERVER_CAPABILITIES: [&str; 2] = ["actions", "body"];

mod dbus_server {
    #![allow(clippy::too_many_arguments)]
    include!(concat!(env!("OUT_DIR"), "/introspection.rs"));
}

static ID_COUNT: AtomicU32 = AtomicU32::new(1);

const NOTIFICATION_INTERFACE: &str = "org.freedesktop.Notifications";
const NOTIFICATION_PATH: &str = "/org/freedesktop/Notifications";

pub fn register_dbus_handler(sender: Sender<Action>) {
    let server = match DbusServer::init() {
        Ok(s) => s,
        Err(e) => {
            eprintln!("error creating the dbus_server: {}", e);
            return;
        }
    };

    println!("registering dbus handler");
    server
        .register_notification_handler(sender, Duration::from_millis(1000))
        .expect("failed to register dbus notification handler");
}

// ············
// notification
// ············

#[derive(Clone, Debug, Default)]
pub struct Notification {
    pub id: u32,
    pub app_name: String,
    pub summary: String,
    pub body: String,
    pub expire_timeout: Option<Duration>,
    pub timestamp: u64,
}

#[derive(Debug)]
pub enum Action {
    Show(Notification),
    Close(Option<u32>),
}

// ·······
// manager
// ·······

#[derive(Debug)]
pub struct Manager {
    notifications: Vec<Notification>,
}

impl Default for Manager {
    fn default() -> Self {
        Self::new()
    }
}

impl Manager {
    pub fn new() -> Self {
        Self {
            notifications: Vec::new(),
        }
    }

    pub fn count(&self) -> usize {
        self.notifications.len()
    }

    pub fn add(&mut self, notification: Notification) {
        self.notifications.push(notification);
    }
}

// ·················
// dbus notification
// ·················

struct DbusNotification {
    sender: Sender<Action>,
}

impl dbus_server::OrgFreedesktopNotifications for DbusNotification {
    fn get_capabilities(&mut self) -> Result<Vec<String>, dbus::MethodErr> {
        Ok(SERVER_CAPABILITIES.into_iter().map(String::from).collect())
    }

    fn notify(
        &mut self,
        app_name: String,
        replaces_id: u32,
        _app_icon: String,
        summary: String,
        body: String,
        _actions: Vec<String>,
        _hints: dbus::arg::PropMap,
        expire_timeout: i32,
    ) -> Result<u32, dbus::MethodErr> {
        let id = if replaces_id == 0 {
            ID_COUNT.fetch_add(1, Ordering::Relaxed)
        } else {
            replaces_id
        };

        let notification = Notification {
            id,
            app_name,
            summary,
            body,
            expire_timeout: if expire_timeout != -1 {
                match expire_timeout.try_into() {
                    Ok(v) => Some(Duration::from_millis(v)),
                    Err(_) => None,
                }
            } else {
                None
            },
            timestamp: SystemTime::now()
                .duration_since(UNIX_EPOCH)
                .map_err(|e| dbus::MethodErr::failed(&e))?
                .as_secs(),
        };

        match self.sender.send(Action::Show(notification)) {
            Ok(_) => Ok(id),
            Err(e) => Err(dbus::MethodErr::failed(&e)),
        }
    }

    fn close_notification(&mut self, id: u32) -> Result<(), dbus::MethodErr> {
        println!("received close signal for notification: {}", id);
        match self.sender.send(Action::Close(Some(id))) {
            Ok(_) => Ok(()),
            Err(e) => Err(dbus::MethodErr::failed(&e)),
        }
    }

    fn get_server_information(
        &mut self,
    ) -> Result<(String, String, String, String), dbus::MethodErr> {
        Ok((
            SERVER_INFO[0].to_string(),
            SERVER_INFO[1].to_string(),
            SERVER_INFO[2].to_string(),
            SERVER_INFO[3].to_string(),
        ))
    }
}

// ···········
// dbus server
// ···········

struct DbusServer {
    connection: Connection,
    crossroads: Crossroads,
}

#[derive(Debug, Clone)]
enum DbusError {
    NotPrimary,
}

impl fmt::Display for DbusError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match self {
            DbusError::NotPrimary => write!(
                f,
                "not primary dbus notification server, is another running?"
            ),
        }
    }
}

impl Error for DbusError {}

impl DbusServer {
    pub fn init() -> Result<Self, Box<dyn Error>> {
        println!("dbus server information: {:#?}", SERVER_INFO);
        println!("dbus server capabilities: {:?}", SERVER_CAPABILITIES);

        let connection = Connection::new_session()?;
        let crossroads = Crossroads::new();

        Ok(Self {
            connection,
            crossroads,
        })
    }

    pub fn register_notification_handler(
        mut self,
        sender: Sender<Action>,
        timeout: Duration,
    ) -> Result<(), Box<dyn Error>> {
        let reply = self
            .connection
            .request_name(NOTIFICATION_INTERFACE, false, true, false)?;

        if reply != RequestNameReply::PrimaryOwner {
            return Err(DbusError::NotPrimary.into());
        }

        let token = dbus_server::register_org_freedesktop_notifications(&mut self.crossroads);

        self.crossroads.insert(
            NOTIFICATION_PATH,
            &[token],
            DbusNotification {
                sender: sender.clone(),
            },
        );

        let token = self.crossroads.register(NOTIFICATION_INTERFACE, |builder| {
            let sender_cloned = sender.clone();
            builder.method("Close", (), ("reply",), move |_, _, (): ()| {
                sender_cloned
                    .send(Action::Close(None))
                    .map_err(|e| MethodErr::failed(&e))?;
                Ok((String::from("close signal sent"),))
            });
        });

        self.crossroads
            .insert(format!("{NOTIFICATION_PATH}/ctl"), &[token], ());

        self.connection.start_receive(
            MatchRule::new_method_call(),
            Box::new(move |message, connection| {
                self.crossroads
                    .handle_message(message, connection)
                    .expect("failed to handle message");
                true
            }),
        );

        loop {
            self.connection.process(timeout)?;
        }
    }
}
