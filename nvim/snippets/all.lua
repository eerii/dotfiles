return {
    -- Cross initalization for the GLUT OpenGL library
	s('crossglut', {
        t({
            '#ifdef __APPLE__',
            '   #define GL_SILENCE_DEPRECATION',
            '   #include <OpenGL/gl.h>',
            '   #include <OpenGL/glu.h>',
            '   #include <GLUT/glut.h>',
            '#else',
            '   #ifdef WIN32',
            '   #include <windows.h>',
            '   #endif',
            '   #include <GL/gl.h>',
            '   #include <GL/glu.h>',
            '   #include <glut.h>',
            '#endif',
        })
    })
}
