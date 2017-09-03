#include "SDL_config.h"

#include <imgui.h>

struct SDL_Window;
typedef union SDL_Event SDL_Event;

IMGUI_API bool        ImGui_ImplSdl_Init(SDL_Window *window);
IMGUI_API void        ImGui_ImplSdl_Shutdown();
IMGUI_API void        ImGui_ImplSdl_NewFrame(SDL_Window *window);
IMGUI_API bool        ImGui_ImplSdl_ProcessEvent(SDL_Event* event);

// Use if you want to reset your rendering device without losing ImGui state.
IMGUI_API void        ImGui_ImplSdl_InvalidateDeviceObjects();
IMGUI_API bool        ImGui_ImplSdl_CreateDeviceObjects();

extern "C" {

int imgui_wrap_init(SDL_Window* window){
    return ImGui_ImplSdl_Init(window);
}

void imgui_wrap_newframe(SDL_Window* window){
    ImGui_ImplSdl_NewFrame(window);
}

int imgui_wrap_process_event(SDL_Event* event){
    return ImGui_ImplSdl_ProcessEvent(event);
}

void imgui_wrap_demo_showtest(void){
    bool theTrue = true;
    ImGui::ShowTestWindow(&theTrue);
}

};
