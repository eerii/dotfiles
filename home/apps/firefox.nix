{
  inputs,
  lib,
  config,
  pkgs,
  sys,
  ...
}:
with lib;
let
  nix-packages-url = "https://search.nixos.org/packages?channel=unstable&type=packages&query={searchTerms}";
  nix-options-url = "https://search.nixos.org/options?channel=unstable&type=options&query={searchTerms}";
  nix-wiki-url = "https://wiki.nixos.org/index.php?search={searchTerms}";
  home-manager-url = "https://home-manager-options.extranix.com/?query={searchTerms}&release=master";
in
{
  options = {
    firefox.enable = mkEnableOption "enable firefox";
  };

  config = mkIf config.firefox.enable {
    # Firefox browser with sane defaults
    programs.firefox = {
      enable = true;
      profiles.${sys.username} = {
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          adnauseam
          browserpass
          duckduckgo-privacy-essentials
          return-youtube-dislikes
          refined-github
          sponsorblock
        ];

        # Settings based on Betterfox
        settings = {
          # Custom
          ## Restore session
          "browser.startup.couldRestoreSession.count" = 1;
          "browser.laterrun.bookkeeping.sessionCount" = 1;
          ## Other
          "browser.toolbars.bookmarks.visibility" = "never";
          "identity.fxaccounts.toolbar.enabled" = false;

          # Fastfox
          ## General
          "content.notify.interval" = "100000";
          ## Gfx
          "gfx.canvas.accelerated.cache-items" = 4096;
          "gfx.canvas.accelerated.cache-size" = 512;
          "gfx.content.skia-font-cache-size" = 20;
          ## Disk cache
          "browser.cache.jsbc_compression_level" = 3;
          ## Media cache
          "media.memory_cache_max_size" = 65536;
          "media.cache_readahead_limit" = 7200;
          "media.cache_resume_threshold" = 3600;
          ## Image cache
          "image.mem.decode_bytes_at_a_time" = 32768;
          ## Network
          "network.http.max-connections" = 1800;
          "network.http.max-persistent-connections-per-server" = 10;
          "network.http.max-urgent-start-excessive-connections-per-host" = 5;
          "network.http.pacing.requests.enabled" = false;
          "network.dnsCacheExpiration" = 3600;
          "network.dns.max_high_priority_threads" = 8;
          "network.ssl_tokens_cache_capacity" = 10240;
          ## Speculative loading
          "network.dns.disablePrefetch" = true;
          "network.prefetch-next" = false;
          "network.predictor.enabled" = false;
          ## Experimental
          "layout.css.grid-template-masonry-value.enabled" = true;
          "dom.enable_web_task_scheduling" = true;
          "layout.css.has-selector.enabled" = true;
          "dom.security.sanitizer.enabled" = true;

          # Peskyfox
          ## Mozilla UI
          "browser.privatebrowsing.vpnpromourl" = "";
          "extensions.getAddons.showPane" = false;
          "extensions.htmlaboutaddons.recommendations.enabled" = false;
          "browser.discovery.enabled" = false;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
          "browser.preferences.moreFromMozilla" = false;
          "browser.tabs.tabmanager.enabled" = false;
          "browser.aboutConfig.showWarning" = false;
          "browser.aboutwelcome.enabled" = false;
          ## Theme adjustments
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "browser.compactmode.show" = true;
          "browser.display.focus_ring_on_anything" = true;
          "browser.display.focus_ring_style" = 0;
          "browser.display.focus_ring_width" = 0;
          "layout.css.prefers-color-scheme.content-override" = 2;
          "browser.privateWindowSeparation.enabled" = false;
          ## Cookie banner handling
          "cookiebanners.service.mode" = 1;
          "cookiebanners.service.mode.privateBrowsing" = 1;
          ## Fullscreen notice
          "full-screen-api.transition-duration.enter" = "0 0";
          "full-screen-api.transition-duration.leave" = "0 0";
          "full-screen-api.warning.delay" = -1;
          "full-screen-api.warning.timeout" = 0;
          ## URL bar
          "browser.urlbar.suggest.calculator" = true;
          "browser.urlbar.unitConversion.enabled" = true;
          "browser.urlbar.trending.featureGate" = false;
          ## New tab page
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          ## Pocket
          "extensions.pocket.enabled" = false;
          ## Downloads
          "browser.download.always_ask_before_handling_new_types" = true;
          "browser.download.manager.addToRecentDocs" = false;
          ## PDF
          "browser.download.open_pdf_attachments_inline" = true;
          ## Tab behavior
          "browser.bookmarks.openInTabClosesMenu" = false;
          "browser.menu.showViewImageInfo" = true;
          "findbar.highlightAll" = true;
          "layout.word_select.eat_space_to_next_word" = false;

          # Securefox
          ## Tracking
          "urlclassifier.trackingSkipURLs" = "*.reddit.com, *.twitter.com, *.twimg.com, *.tiktok.com";
          "urlclassifier.features.socialtracking.skipURLs" = "*.instagram.com, *.twitter.com, *.twimg.com";
          "network.cookie.sameSite.noneRequiresSecure" = true;
          "browser.download.start_downloads_in_tmp_dir" = true;
          "browser.helperApps.deleteTempFileOnExit" = true;
          "browser.uitour.enabled" = false;
          "privacy.globalprivacycontrol.enabled" = true;
          ## OCSP & Certs / HPKP
          "security.OCSP.enabled" = 0;
          "security.remote_settings.crlite_filters.enabled" = true;
          "security.pki.crlite_mode" = 2;
          ## SSL / TLS
          "security.ssl.treat_unsafe_negotiation_as_broken" = true;
          "browser.xul.error_pages.expert_bad_cert" = true;
          "security.tls.enable_0rtt_data" = false;
          ## Disk avoidance
          "browser.privatebrowsing.forceMediaMemoryCache" = true;
          "browser.sessionstore.interval" = 60000;
          ## Shutdown & sanitizing
          "privacy.history.custom" = true;
          ## Search / url bar
          "browser.search.separatePrivateDefault.ui.enabled" = true;
          "browser.urlbar.update2.engineAliasRefresh" = true;
          "browser.urlbar.suggest.quicksuggest.sponsored" = false;
          "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
          "browser.formfill.enable" = false;
          "security.insecure_connection_text.enabled" = true;
          "security.insecure_connection_text.pbmode.enabled" = true;
          "network.IDN_show_punycode" = true;
          ## HTTPS-first policy
          "dom.security.https_first" = true;
          "dom.security.https_first_schemeless" = true;
          ## Passwords
          "signon.rememberSignons" = false;
          "signon.formlessCapture.enabled" = false;
          "signon.privateBrowsingCapture.enabled" = false;
          "network.auth.subresource-http-auth-allow" = 1;
          "editor.truncate_user_pastes" = false;
          ## Address + credit card manager
          "extensions.formautofill.addresses.enabled" = false;
          "extensions.formautofill.creditCards.enabled" = false;
          ## Mixed content + cross-site
          "security.mixed_content.block_display_content" = true;
          "security.mixed_content.upgrade_display_content" = true;
          "security.mixed_content.upgrade_display_content.image" = true;
          "pdfjs.enableScripting" = false;
          "extensions.postDownloadThirdPartyPrompt" = false;
          ## Headers / referers
          "network.http.referer.XOriginTrimmingPolicy" = 2;
          ## Containers
          "privacy.userContext.ui.enabled" = true;
          ## WebRTC
          "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
          "media.peerconnection.ice.default_address_only" = true;
          ## Safe browsing
          "browser.safebrowsing.downloads.remote.enabled" = false;
          ## Mozilla
          "permissions.default.desktop-notification" = 2;
          "permissions.default.geo" = 2;
          "geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
          "permissions.manager.defaultsUrl" = "";
          "webchannel.allowObject.urlWhitelist" = "";
          ## Telemetry
          "datareporting.policy.dataSubmissionEnabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.server" = "data:,";
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.updatePing.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.coverage.opt-out" = true;
          "toolkit.coverage.opt-out" = true;
          "toolkit.coverage.endpoint.base" = "";
          "browser.ping-centre.telemetry" = false;
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          ## Experiments
          "app.shield.optoutstudies.enabled" = false;
          "app.normandy.enabled" = false;
          "app.normandy.api_url" = "";
          ## Crash reports
          "breakpad.reportURL" = "";
          "browser.tabs.crashReporting.sendReport" = false;
          "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
          ## Detection
          "captivedetect.canonicalURL" = "";
          "network.captive-portal-service.enabled" = false;
          "network.connectivity-service.enabled" = false;

          # Smoothfox
          "general.smoothScroll" = true;
          "general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS" = 12;
          "general.smoothScroll.msdPhysics.enabled" = true;
          "general.smoothScroll.msdPhysics.motionBeginSpringConstant" = 600;
          "general.smoothScroll.msdPhysics.regularSpringConstant" = 650;
          "general.smoothScroll.msdPhysics.slowdownMinDeltaMS" = 25;
          "general.smoothScroll.msdPhysics.slowdownMinDeltaRatio" = 2.0;
          "general.smoothScroll.msdPhysics.slowdownSpringConstant" = 250;
          "general.smoothScroll.currentVelocityWeighting" = 1.0;
          "general.smoothScroll.stopDecelerationWeighting" = 1.0;
          "mousewheel.default.delta_multiplier_y" = 300;

          # GTK Theme
          "browser.tabs.drawInTitlebar" = true;
          "svg.context-properties.content.enabled" = true;
          "extensions.activeThemeID" = "firefox-compact@mozilla.org";
        };

        search = {
          force = true;
          engines = {
            "Nix Packages" = {
              urls = [ { template = nix-packages-url; } ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };
            "Nix Options" = {
              urls = [ { template = nix-options-url; } ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@no" ];
            };
            "NixOS Wiki" = {
              urls = [ { template = nix-wiki-url; } ];
              iconUpdateURL = "https://wiki.nixos.org/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = [ "@nw" ];
            };
            "Home Manager Options" = {
              urls = [ { template = home-manager-url; } ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@nh" ];
            };
            "Bing".metaData.hidden = true;
            "eBay".metaData.hidden = true;
            "Google".metaData.alias = "@g";
          };
        };

        userChrome = ''
          /* GTK Theme */
          @import "firefox-gnome-theme/userChrome.css";
          @import "firefox-gnome-theme/theme/colors/dark.css"; 

          /* Sidebery: hide top tabs when sidebar is open */
          #main-window #titlebar {
            overflow: hidden;
            transition: height 0.3s 0.3s !important;
          }
          #main-window #titlebar { height: 3em !important; }
          #main-window[uidensity="touch"] #titlebar { height: 3.35em !important; }
          #main-window[uidensity="compact"] #titlebar { height: 2.7em !important; }
          #main-window[titlepreface*="​"] #titlebar { height: 0 !important; }
          #main-window[titlepreface*="​"] #tabbrowser-tabs { z-index: 0 !important; }
        '';
      };
    };

    # GTK Theme
    home.file."firefox-gnome-theme" = {
      target = ".mozilla/firefox/${sys.username}/chrome/firefox-gnome-theme";
      source = inputs.firefox-gnome-theme;
    };

    # Browserpass host binary
    programs.browserpass = mkIf config.pass.enable {
      enable = true;
      browsers = [ "firefox" ];
    };

    # Impermanence
    persistence.dirs = [ ".mozilla/firefox/${sys.username}" ];
  };
}
