/* SDL main */

#include <GLES2/gl2.h>
#include <GLES2/gl2ext.h>
#include <GLES2/gl2platform.h>

#if !defined(__ANDROID__) && (defined(__CYGWIN__) || defined(__linux__))
#define SDL_MAIN_HANDLED
#define SDL_main main
#endif
#include "SDL_config.h" /* Some of us use special SDL_config.h during build */
#include <SDL.h>

#ifdef __EMSCRIPTEN__
#include <emscripten.h>
#endif

#include "externals/nanovg/src/nanovg.h"
#define NANOVG_GLES2_IMPLEMENTATION
#include "externals/nanovg/src/nanovg_gl.h"

#include <cimgui.h>
int imgui_wrap_init(SDL_Window* window);
void imgui_wrap_newframe(SDL_Window* window);
int imgui_wrap_process_event(SDL_Event* event);
void imgui_wrap_demo_showtest(void);

/* 1000 random rects */

#define NRECTS 1000

static SDL_Rect rects[NRECTS];
SDL_Window* theWindow = NULL;

/* From Wikipedia */

uint32_t x = 0x1234;
uint32_t y = 0x4321;
uint32_t z = 0x9999;
uint32_t w = 0xaaaa;

static uint32_t
xorshift128(void) {
    uint32_t t = x;
    t ^= t << 11;
    t ^= t >> 8;
    x = y; y = z; z = w;
    w ^= w >> 19;
    w ^= t;
    return w;
}

static void
layoutrect(SDL_Rect* r){
    uint32_t xx = xorshift128() & 0x3ff;
    uint32_t yy = xorshift128() & 0x1ff;
    r->x = xx;
    r->y = yy;
    r->w = 64;
    r->h = 64;
}

static void
layoutrects(void){
    int i;
    for(i=0;i!=NRECTS;i++){
        layoutrect(&rects[i]);
    }
}

static void
loop(void* p){
    int i;
    NVGcontext* nvg = (NVGcontext *)p;
    SDL_Event evt;

    while(SDL_PollEvent(&evt)){
        imgui_wrap_process_event(&evt);
        if(evt.type == SDL_QUIT){
            exit(0);
        }
    }
    imgui_wrap_newframe(theWindow);
    imgui_wrap_demo_showtest();

    /* Clear states and the framebuffer */
    glViewport(0,0,1280,720);
    glClearColor(0,0,0,0);
    glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT|GL_STENCIL_BUFFER_BIT);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glEnable(GL_CULL_FACE);

    /* Prepare GLcontext for 2D drawing */
    glDisable(GL_DEPTH_TEST);

    /* Begin nanovg drawing */
    nvgBeginFrame(nvg, 1280, 720, 1.0);
    nvgFillColor(nvg, nvgRGBA(0,255,0,255));
    nvgBeginPath(nvg);
    nvgRect(nvg, 0, 0, 1280, 720);
    nvgFill(nvg);
    nvgFillColor(nvg, nvgRGBA(0,0,0,255));
    layoutrects();
    for(i=0;i!=NRECTS;i++){
        nvgBeginPath(nvg);
        nvgCircle(nvg, rects[i].x, rects[i].y, 16);
        nvgFill(nvg);
    }
    nvgEndFrame(nvg);

    igRender();

    SDL_GL_SwapWindow(theWindow);
}

int
SDL_main(int argc, char** av){
    SDL_DisplayMode mode;
    SDL_Window* window = NULL;
    NVGcontext* nvg = NULL;
    SDL_GLContext glcontext;
    uint32_t flags,w,h;


#ifdef __EMSCRIPTEN__
    emscripten_set_canvas_size(1280, 720);
#endif

    if(SDL_Init(SDL_INIT_VIDEO)){
        return -1;
    }

    /* Always use statically linked GLES */
    SDL_SetHint(SDL_HINT_OPENGL_ES_DRIVER, "1");
    //SDL_SetHint(SDL_HINT_RENDER_DRIVER, "opengles2");
    SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_ES);


#ifdef GRPCORE_FULLSCREEN
    flags = SDL_WINDOW_FULLSCREEN | SDL_WINDOW_OPENGL;
    if(SDL_GetCurrentDisplayMode(0, &mode)){
        return -1;
    }
    w = mode.w;
    h = mode.h;
#else
    flags = SDL_WINDOW_OPENGL;
    w = 1280;
    h = 720;
#endif

    SDL_GL_SetAttribute(SDL_GL_DOUBLEBUFFER, 1);
    SDL_GL_SetAttribute(SDL_GL_DEPTH_SIZE, 24);
    SDL_GL_SetAttribute(SDL_GL_STENCIL_SIZE, 8);
    SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 2);
    SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 2);

    if(!(window = SDL_CreateWindow("grpcore0",
                                   SDL_WINDOWPOS_UNDEFINED,
                                   SDL_WINDOWPOS_UNDEFINED,
                                   w, h, 
                                   flags))){
        return -1;
    }


    glcontext = SDL_GL_CreateContext(window);
    SDL_GL_MakeCurrent(window, glcontext);
    imgui_wrap_init(window);
    nvg = nvgCreateGLES2(NVG_ANTIALIAS | NVG_DEBUG /* | NVG_STENCIL_STROKES */);

    theWindow = window;

    SDL_GL_SetSwapInterval(0);


#ifdef __EMSCRIPTEN__
    emscripten_set_main_loop_arg(loop, nvg, 0, 1);
#else
    for(;;){
        loop(nvg);
    }
#endif
    return 0;
}
