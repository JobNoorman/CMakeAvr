set(AVR_MCU   "" CACHE STRING "AVR MCU to target")
set(AVR_F_CPU "" CACHE STRING "Clock frequency of the target AVR MCU")

if (AVR_MCU)
    set(AVR_GNU_GENERIC_FLAGS -mmcu=${AVR_MCU})
endif ()

if (AVR_F_CPU)
    add_definitions(-DF_CPU=${AVR_F_CPU})
endif ()

# Flags for the MinSizeDebug build type
set(AVR_GNU_GENERIC_FLAGS_MINSIZEDEBUG "-g -Os")

