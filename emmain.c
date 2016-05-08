/* Main() for emscripten */

extern int SDL_main(int ac, char** av);

int
main(int ac, char** av){
    return SDL_main(ac, av);
}
