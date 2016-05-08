/* SDL main */

#include <SDL.h>

#ifdef __EMSCRIPTEN__
#include <emscripten.h>
#endif


/* 1000 random rects */

#define NRECTS 1000

static SDL_Rect rects[NRECTS];

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
    for(int i=0;i!=NRECTS;i++){
        layoutrect(&rects[i]);
    }
}

static void
loop(void* p){
    SDL_Renderer* renderer = (SDL_Renderer *)p;
    SDL_Event evt;
    while(SDL_PollEvent(&evt)){
    }
    SDL_SetRenderDrawColor(renderer, 0, 255, 0, 255);
    SDL_RenderClear(renderer);
    layoutrects();
    SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
    SDL_RenderFillRects(renderer, rects, NRECTS);
    SDL_RenderPresent(renderer);
}

int
SDL_main(int argc, char** av){
    SDL_DisplayMode mode;
    SDL_Window* window = NULL;
    SDL_Renderer* renderer = NULL;

#ifdef __EMSCRIPTEN__
    emscripten_set_canvas_size(1280, 720);
#endif

    if(SDL_Init(SDL_INIT_VIDEO)){
        return -1;
    }

    if(SDL_GetCurrentDisplayMode(0, &mode)){
        return -1;
    }

    if(SDL_CreateWindowAndRenderer(mode.w, mode.h, SDL_WINDOW_FULLSCREEN,
                                   &window, &renderer)){
        return -1;
    }

#ifdef __EMSCRIPTEN__
    emscripten_set_main_loop_arg(loop, renderer, 0, 1);
#else
    for(;;){
        loop(renderer);
    }
#endif
    return 0;
}
