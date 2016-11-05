# This module is shared by multiple languages; use include blocker.
if(__COMPILER_GNU_AVR)
    return()
endif()
set(__COMPILER_GNU_AVR 1)

set(AVR_MCU   "" CACHE STRING "AVR MCU to target")
set(AVR_F_CPU "" CACHE STRING "Clock frequency of the target AVR MCU")

option(LTO "Enable Link-Time Optimization" ON)

if (AVR_F_CPU)
    add_definitions(-DF_CPU=${AVR_F_CPU})
endif ()

# CMake does not support LTO/IPO yet for GCC. Until it does, we enable it
# manually here.
if (LTO)
    # We need to use gcc-ar and gcc-ranlib for creating static libraries. Note
    # that we cannot simply store the result of find_program in the CMAKE_*
    # variables because these have already been set to ar and ranlib which means
    # find_program would not search for them again.
    find_program(AVR_GCC_AR NAMES avr-gcc-ar)
    find_program(AVR_GCC_RANLIB NAMES avr-gcc-ranlib)
    set(CMAKE_AR ${AVR_GCC_AR})
    set(CMAKE_RANLIB ${AVR_GCC_RANLIB})
endif ()

macro(__compiler_gnu_avr lang)
    if (AVR_MCU)
        set(CMAKE_${lang}_FLAGS_INIT -mmcu=${AVR_MCU})
    endif ()

    # Flags for the MinSizeDebug build type
    set(CMAKE_${lang}_FLAGS_MINSIZEDEBUG "-g -Os")

    # Default extension is .obj if not on UNIX; make it .o
    set(CMAKE_${lang}_OUTPUT_EXTENSION .o)

    if (LTO)
        set(CMAKE_${lang}_FLAGS_INIT "${CMAKE_${lang}_FLAGS_INIT} -flto")
    endif ()
endmacro()

