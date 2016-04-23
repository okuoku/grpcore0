# FIXME: Use wrapper
set(gradle_command
    "c:/Program Files/Android/Android Studio/gradle/gradle-2.10/bin/gradle")
macro(add_gradle_command tgt dir cmd)
    add_custom_target(${tgt}
        COMMAND "${gradle_command}" ${cmd}
        WORKING_DIRECTORY ${dir}
        COMMENT "Running gradle(${cmd})..."
        )
endmacro()
