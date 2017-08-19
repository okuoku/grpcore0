set(angle_root angle/)

set(angle_fe_translator_srcs
    # Common translator (instatiates implementation)
    ${angle_root}/src/compiler/translator/ShaderLang.cpp
    ${angle_root}/src/compiler/translator/ShaderVars.cpp)

set(angle_fe_preprocessor_srcs
    ${angle_root}/src/compiler/preprocessor/DiagnosticsBase.cpp
    ${angle_root}/src/compiler/preprocessor/DirectiveHandlerBase.cpp
    ${angle_root}/src/compiler/preprocessor/DirectiveParser.cpp
    ${angle_root}/src/compiler/preprocessor/ExpressionParser.cpp
    ${angle_root}/src/compiler/preprocessor/Input.cpp
    ${angle_root}/src/compiler/preprocessor/Lexer.cpp
    ${angle_root}/src/compiler/preprocessor/Macro.cpp
    ${angle_root}/src/compiler/preprocessor/MacroExpander.cpp
    ${angle_root}/src/compiler/preprocessor/Preprocessor.cpp
    ${angle_root}/src/compiler/preprocessor/Token.cpp
    ${angle_root}/src/compiler/preprocessor/Tokenizer.cpp)

set(angle_fe_translator_lib_srcs
    # FIXME: Separate into backends (HLSL/Vulkan/...)
    ${angle_root}/src/compiler/translator/AddAndTrueToLoopCondition.cpp
    ${angle_root}/src/compiler/translator/AddDefaultReturnStatements.cpp
    ${angle_root}/src/compiler/translator/ArrayReturnValueToOutParameter.cpp
    ${angle_root}/src/compiler/translator/ASTMetadataHLSL.cpp
    ${angle_root}/src/compiler/translator/blocklayout.cpp
    ${angle_root}/src/compiler/translator/blocklayoutHLSL.cpp
    ${angle_root}/src/compiler/translator/BreakVariableAliasingInInnerLoops.cpp
    ${angle_root}/src/compiler/translator/BuiltInFunctionEmulator.cpp
    #${angle_root}/src/compiler/translator/BuiltInFunctionEmulatorGLSL.cpp
    ${angle_root}/src/compiler/translator/BuiltInFunctionEmulatorHLSL.cpp
    ${angle_root}/src/compiler/translator/Cache.cpp
    ${angle_root}/src/compiler/translator/CallDAG.cpp
    ${angle_root}/src/compiler/translator/ClampPointSize.cpp
    ${angle_root}/src/compiler/translator/CodeGen.cpp
    ${angle_root}/src/compiler/translator/CollectVariables.cpp
    ${angle_root}/src/compiler/translator/Compiler.cpp
    ${angle_root}/src/compiler/translator/ConstantUnion.cpp
    ${angle_root}/src/compiler/translator/DeclareAndInitBuiltinsForInstancedMultiview.cpp
    ${angle_root}/src/compiler/translator/DeferGlobalInitializers.cpp
    ${angle_root}/src/compiler/translator/Diagnostics.cpp
    ${angle_root}/src/compiler/translator/DirectiveHandler.cpp
    ${angle_root}/src/compiler/translator/emulated_builtin_functions_hlsl_autogen.cpp
    ${angle_root}/src/compiler/translator/EmulateGLFragColorBroadcast.cpp
    ${angle_root}/src/compiler/translator/EmulatePrecision.cpp
    ${angle_root}/src/compiler/translator/ExpandIntegerPowExpressions.cpp
    #${angle_root}/src/compiler/translator/ExtensionGLSL.cpp
    ${angle_root}/src/compiler/translator/FindMain.cpp
    ${angle_root}/src/compiler/translator/FindSymbolNode.cpp
    ${angle_root}/src/compiler/translator/FlagStd140Structs.cpp
    ${angle_root}/src/compiler/translator/glslang_lex.cpp
    ${angle_root}/src/compiler/translator/glslang_tab.cpp
    ${angle_root}/src/compiler/translator/HashNames.cpp
    ${angle_root}/src/compiler/translator/InfoSink.cpp
    ${angle_root}/src/compiler/translator/Initialize.cpp
    ${angle_root}/src/compiler/translator/InitializeDll.cpp
    ${angle_root}/src/compiler/translator/InitializeVariables.cpp
    ${angle_root}/src/compiler/translator/IntermNode.cpp
    ${angle_root}/src/compiler/translator/IntermNodePatternMatcher.cpp
    ${angle_root}/src/compiler/translator/IntermNode_util.cpp
    ${angle_root}/src/compiler/translator/IntermTraverse.cpp
    ${angle_root}/src/compiler/translator/IsASTDepthBelowLimit.cpp
    ${angle_root}/src/compiler/translator/Operator.cpp
    #${angle_root}/src/compiler/translator/OutputESSL.cpp
    #${angle_root}/src/compiler/translator/OutputGLSL.cpp
    #${angle_root}/src/compiler/translator/OutputGLSLBase.cpp
    ${angle_root}/src/compiler/translator/OutputHLSL.cpp
    ${angle_root}/src/compiler/translator/OutputTree.cpp
    #${angle_root}/src/compiler/translator/OutputVulkanGLSL.cpp
    ${angle_root}/src/compiler/translator/ParseContext.cpp
    ${angle_root}/src/compiler/translator/PoolAlloc.cpp
    ${angle_root}/src/compiler/translator/PruneEmptyDeclarations.cpp
    ${angle_root}/src/compiler/translator/PrunePureLiteralStatements.cpp
    ${angle_root}/src/compiler/translator/QualifierTypes.cpp
    ${angle_root}/src/compiler/translator/RecordConstantPrecision.cpp
    ${angle_root}/src/compiler/translator/RegenerateStructNames.cpp
    ${angle_root}/src/compiler/translator/RemoveDynamicIndexing.cpp
    ${angle_root}/src/compiler/translator/RemoveInvariantDeclaration.cpp
    ${angle_root}/src/compiler/translator/RemovePow.cpp
    ${angle_root}/src/compiler/translator/RemoveSwitchFallThrough.cpp
    ${angle_root}/src/compiler/translator/RewriteDoWhile.cpp
    ${angle_root}/src/compiler/translator/RewriteElseBlocks.cpp
    ${angle_root}/src/compiler/translator/RewriteTexelFetchOffset.cpp
    ${angle_root}/src/compiler/translator/RewriteUnaryMinusOperatorFloat.cpp
    ${angle_root}/src/compiler/translator/RewriteUnaryMinusOperatorInt.cpp
    ${angle_root}/src/compiler/translator/RunAtTheEndOfShader.cpp
    ${angle_root}/src/compiler/translator/ScalarizeVecAndMatConstructorArgs.cpp
    ${angle_root}/src/compiler/translator/SearchSymbol.cpp
    ${angle_root}/src/compiler/translator/SeparateArrayInitialization.cpp
    ${angle_root}/src/compiler/translator/SeparateDeclarations.cpp
    ${angle_root}/src/compiler/translator/SeparateExpressionsReturningArrays.cpp
    ${angle_root}/src/compiler/translator/ShaderLang.cpp
    ${angle_root}/src/compiler/translator/ShaderVars.cpp
    ${angle_root}/src/compiler/translator/SimplifyLoopConditions.cpp
    ${angle_root}/src/compiler/translator/SplitSequenceOperator.cpp
    ${angle_root}/src/compiler/translator/StructureHLSL.cpp
    ${angle_root}/src/compiler/translator/SymbolTable.cpp
    ${angle_root}/src/compiler/translator/TextureFunctionHLSL.cpp
    #${angle_root}/src/compiler/translator/TranslatorESSL.cpp
    #${angle_root}/src/compiler/translator/TranslatorGLSL.cpp
    ${angle_root}/src/compiler/translator/TranslatorHLSL.cpp
    #${angle_root}/src/compiler/translator/TranslatorVulkan.cpp
    ${angle_root}/src/compiler/translator/Types.cpp
    ${angle_root}/src/compiler/translator/UnfoldShortCircuitAST.cpp
    ${angle_root}/src/compiler/translator/UnfoldShortCircuitToIf.cpp
    ${angle_root}/src/compiler/translator/UniformHLSL.cpp
    ${angle_root}/src/compiler/translator/UseInterfaceBlockFields.cpp
    ${angle_root}/src/compiler/translator/util.cpp
    ${angle_root}/src/compiler/translator/UtilsHLSL.cpp
    ${angle_root}/src/compiler/translator/ValidateGlobalInitializer.cpp
    ${angle_root}/src/compiler/translator/ValidateLimitations.cpp
    ${angle_root}/src/compiler/translator/ValidateMaxParameters.cpp
    ${angle_root}/src/compiler/translator/ValidateMultiviewWebGL.cpp
    ${angle_root}/src/compiler/translator/ValidateOutputs.cpp
    ${angle_root}/src/compiler/translator/ValidateSwitch.cpp
    ${angle_root}/src/compiler/translator/VariablePacker.cpp
    #${angle_root}/src/compiler/translator/VersionGLSL.cpp
    ${angle_root}/src/third_party/compiler/ArrayBoundsClamper.cpp
    )

set(angle_common_srcs
    ${angle_root}/src/common/angleutils.cpp
    ${angle_root}/src/common/debug.cpp
    ${angle_root}/src/common/event_tracer.cpp # only for ANGLE?
    ${angle_root}/src/common/Float16ToFloat32.cpp
    ${angle_root}/src/common/mathutil.cpp
    ${angle_root}/src/common/MemoryBuffer.cpp
    ${angle_root}/src/common/string_utils.cpp
    ${angle_root}/src/common/third_party/base/anglebase/sha1.cc
    ${angle_root}/src/common/third_party/murmurhash/MurmurHash3.cpp
    ${angle_root}/src/common/tls.cpp
    ${angle_root}/src/common/utilities.cpp)

set(angle_libangle_srcs
    ${angle_root}/src/libANGLE/angletypes.cpp
    ${angle_root}/src/libANGLE/AttributeMap.cpp
    ${angle_root}/src/libANGLE/Buffer.cpp
    ${angle_root}/src/libANGLE/Caps.cpp
    ${angle_root}/src/libANGLE/Compiler.cpp
    ${angle_root}/src/libANGLE/Config.cpp
    ${angle_root}/src/libANGLE/Context.cpp
    ${angle_root}/src/libANGLE/ContextState.cpp
    ${angle_root}/src/libANGLE/Debug.cpp
    ${angle_root}/src/libANGLE/Device.cpp
    ${angle_root}/src/libANGLE/Display.cpp
    ${angle_root}/src/libANGLE/Error.cpp
    ${angle_root}/src/libANGLE/es3_copy_conversion_table_autogen.cpp
    ${angle_root}/src/libANGLE/Fence.cpp
    ${angle_root}/src/libANGLE/formatutils.cpp
    ${angle_root}/src/libANGLE/format_map_autogen.cpp
    ${angle_root}/src/libANGLE/Framebuffer.cpp
    ${angle_root}/src/libANGLE/FramebufferAttachment.cpp
    ${angle_root}/src/libANGLE/HandleAllocator.cpp
    ${angle_root}/src/libANGLE/HandleRangeAllocator.cpp
    ${angle_root}/src/libANGLE/Image.cpp
    ${angle_root}/src/libANGLE/ImageIndex.cpp
    ${angle_root}/src/libANGLE/IndexRangeCache.cpp
    ${angle_root}/src/libANGLE/LoggingAnnotator.cpp
    ${angle_root}/src/libANGLE/MemoryProgramCache.cpp
    ${angle_root}/src/libANGLE/params.cpp
    ${angle_root}/src/libANGLE/Path.cpp
    ${angle_root}/src/libANGLE/Platform.cpp
    ${angle_root}/src/libANGLE/Program.cpp
    ${angle_root}/src/libANGLE/Query.cpp
    ${angle_root}/src/libANGLE/queryconversions.cpp
    ${angle_root}/src/libANGLE/queryutils.cpp
    ${angle_root}/src/libANGLE/Renderbuffer.cpp
    ${angle_root}/src/libANGLE/renderer/ContextImpl.cpp
    ${angle_root}/src/libANGLE/renderer/DeviceImpl.cpp
    ${angle_root}/src/libANGLE/renderer/DisplayImpl.cpp
    ${angle_root}/src/libANGLE/renderer/driver_utils.cpp
    ${angle_root}/src/libANGLE/renderer/Format_table_autogen.cpp
    ${angle_root}/src/libANGLE/renderer/load_functions_table_autogen.cpp
    ${angle_root}/src/libANGLE/renderer/renderer_utils.cpp
    ${angle_root}/src/libANGLE/renderer/SurfaceImpl.cpp
    ${angle_root}/src/libANGLE/renderer/TextureImpl.cpp
    ${angle_root}/src/libANGLE/ResourceManager.cpp
    ${angle_root}/src/libANGLE/Sampler.cpp
    ${angle_root}/src/libANGLE/Shader.cpp
    ${angle_root}/src/libANGLE/State.cpp
    ${angle_root}/src/libANGLE/Stream.cpp
    ${angle_root}/src/libANGLE/Surface.cpp
    ${angle_root}/src/libANGLE/Texture.cpp
    ${angle_root}/src/libANGLE/Thread.cpp
    ${angle_root}/src/libANGLE/TransformFeedback.cpp
    ${angle_root}/src/libANGLE/Uniform.cpp
    ${angle_root}/src/libANGLE/UniformLinker.cpp
    ${angle_root}/src/libANGLE/validationEGL.cpp
    ${angle_root}/src/libANGLE/validationES.cpp
    ${angle_root}/src/libANGLE/validationES2.cpp
    ${angle_root}/src/libANGLE/validationES3.cpp
    ${angle_root}/src/libANGLE/validationES31.cpp
    ${angle_root}/src/libANGLE/VaryingPacking.cpp
    ${angle_root}/src/libANGLE/VertexArray.cpp
    ${angle_root}/src/libANGLE/VertexAttribute.cpp
    ${angle_root}/src/libANGLE/WorkerThread.cpp)

set(angle_libangle_d3d_common_srcs
    ${angle_root}/src/libANGLE/renderer/d3d/BufferD3D.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/CompilerD3D.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/DeviceD3D.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/DisplayD3D.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/DynamicHLSL.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/EGLImageD3D.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/FramebufferD3D.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/HLSLCompiler.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/ImageD3D.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/IndexBuffer.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/IndexDataManager.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/NativeWindowD3D.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/ProgramD3D.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/RenderbufferD3D.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/RendererD3D.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/RenderTargetD3D.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/ShaderD3D.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/ShaderExecutableD3D.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/SurfaceD3D.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/SwapChainD3D.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/TextureD3D.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/VertexBuffer.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/VertexDataManager.cpp)

set(angle_libangle_d3d_9_srcs
    ${angle_root}/src/libANGLE/renderer/d3d/d3d9/Blit9.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d9/Buffer9.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d9/Context9.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d9/DebugAnnotator9.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d9/Fence9.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d9/formatutils9.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d9/Framebuffer9.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d9/Image9.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d9/IndexBuffer9.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d9/NativeWindow9.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d9/Query9.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d9/Renderer9.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d9/renderer9_utils.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d9/RenderTarget9.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d9/ShaderExecutable9.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d9/StateManager9.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d9/SwapChain9.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d9/TextureStorage9.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d9/VertexBuffer9.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d9/VertexDeclarationCache.cpp)

set(angle_libangle_d3d_11_srcs
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/Blit11.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/Buffer11.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/Clear11.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/Context11.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/DebugAnnotator11.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/dxgi_format_map_autogen.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/dxgi_support_table.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/Fence11.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/formatutils11.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/Framebuffer11.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/Image11.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/IndexBuffer11.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/InputLayoutCache.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/PixelTransfer11.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/Query11.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/Renderer11.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/renderer11_utils.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/RenderStateCache.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/RenderTarget11.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/ResourceManager11.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/ShaderExecutable11.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/StateManager11.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/StreamProducerNV12.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/SwapChain11.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/TextureStorage11.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/texture_format_table.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/texture_format_table_autogen.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/TransformFeedback11.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/Trim11.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/VertexArray11.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/VertexBuffer11.cpp)

set(angle_libangle_d3d_11_win32_srcs
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/win32/NativeWindow11Win32.cpp)

set(angle_libangle_d3d_11_winrt_srcs
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/winrt/CoreWindowNativeWindow.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/winrt/InspectableNativeWindow.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/winrt/NativeWindow11WinRT.cpp
    ${angle_root}/src/libANGLE/renderer/d3d/d3d11/winrt/SwapChainPanelNativeWindow.cpp)

set(angle_libglesv2_srcs
    ${angle_root}/src/libGLESv2/entry_points_egl.cpp
    ${angle_root}/src/libGLESv2/entry_points_egl_ext.cpp
    ${angle_root}/src/libGLESv2/entry_points_gles_2_0_autogen.cpp
    ${angle_root}/src/libGLESv2/entry_points_gles_2_0_ext.cpp
    ${angle_root}/src/libGLESv2/entry_points_gles_3_0.cpp
    ${angle_root}/src/libGLESv2/entry_points_gles_3_1.cpp
    ${angle_root}/src/libGLESv2/global_state.cpp
    ${angle_root}/src/libGLESv2/libGLESv2.cpp)

set(angle_egl_srcs
    ${angle_root}/src/libEGL/libEGL.cpp)

set(angle_image_util_srcs # FIXME: Only for Win32??
    ${angle_root}/src/image_util/copyimage.cpp
    ${angle_root}/src/image_util/imageformats.cpp
    ${angle_root}/src/image_util/loadimage.cpp
    ${angle_root}/src/image_util/loadimage_etc.cpp)

set(angle_systeminfo_srcs # FIXME: Only for D3d9??
    ${angle_root}/src/third_party/systeminfo/SystemInfo.cpp)



macro(use_static_angle out_srcs)
    include_directories(
        ${angle_root}/src
        ${angle_root}/include
        ${angle_root}/src/common/third_party/base
        ${CMAKE_CURRENT_BINARY_DIR}/angle/includes
        )

    set(__angle_srcs)

    list(APPEND __angle_srcs
        ${angle_fe_translator_srcs}
        ${angle_fe_preprocessor_srcs}
        ${angle_fe_translator_lib_srcs}
        ${angle_common_srcs}
        ${angle_libangle_srcs}
        ${angle_libangle_d3d_common_srcs}
        #${angle_libangle_d3d_9_srcs}
        ${angle_libangle_d3d_11_srcs}
        ${angle_libangle_d3d_11_win32_srcs}
        #${angle_libangle_d3d_11_winrt_srcs}
        ${angle_libglesv2_srcs}
        ${angle_egl_srcs}
        ${angle_systeminfo_srcs}
        ${angle_image_util_srcs})

    # FIXME: Disables binary with ANGLE_DISABLE_PROGRAM_BINARY_LOAD
    configure_file(${angle_root}/src/commit.h
        ${CMAKE_CURRENT_BINARY_DIR}/angle/includes/id/commit.h
        COPYONLY)

    set(${out_srcs} ${__angle_srcs})

    # Configurations
    set(CMAKE_CXX_STANDARD 11)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)

    add_definitions(
        -DANGLE_TRANSLATOR_IMPLEMENTATION
        -DLIBGLESV2_IMPLEMENTATION
        -DLIBEGL_IMPLEMENTATION
        -DLIBANGLE_IMPLEMENTATION
        -DGL_GLEXT_PROROTYPES
        -DEGL_EGLEXT_PROTOTYPES
        )

    # MSVCRT speicfic?
    add_definitions(-DNOMINMAX)

    # Backend selection
    add_definitions(-DANGLE_ENABLE_HLSL)
    #add_definitions(-DANGLE_ENABLE_D3D9) # Requires d3d9
    add_definitions(-DANGLE_ENABLE_D3D11) # Requires dxguid

    # FIXME: Correct?
    add_definitions(
        "-DANGLE_PRELOADED_D3DCOMPILER_MODULE_NAMES={ \"d3dcompiler_47.dll\", \"d3dcompiler_46.dll\", \"d3dcompiler_43.dll\" }"
        )

    # Headers required for User
    # Definitions required for User
    add_definitions(
        # Use static-link
        -DANGLE_EXPORT= 
        -DEGLAPI= 
        -DGL_APICALL=)
endmacro()
