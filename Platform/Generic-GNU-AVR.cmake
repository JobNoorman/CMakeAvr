# This module is shared by multiple languages; use include blocker.
if(__COMPILER_GNU_AVR)
    return()
endif()
set(__COMPILER_GNU_AVR 1)

set(AVR_MCU   "" CACHE STRING "AVR MCU to target")
set(AVR_F_CPU "" CACHE STRING "Clock frequency of the target AVR MCU")

if (AVR_F_CPU)
    add_definitions(-DF_CPU=${AVR_F_CPU})
endif ()

macro(__compiler_gnu_avr lang)
    if (AVR_MCU)
        set(CMAKE_${lang}_FLAGS_INIT -mmcu=${AVR_MCU})
    endif ()

    # Flags for the MinSizeDebug build type
    set(CMAKE_${lang}_FLAGS_MINSIZEDEBUG "-g -Os")

    # Default extension is .obj if not on UNIX; make it .o
    set(CMAKE_${lang}_OUTPUT_EXTENSION .o)
endmacro()

