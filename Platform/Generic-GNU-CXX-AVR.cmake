set(AVR_MCU   "" CACHE STRING "AVR MCU to target")
set(AVR_F_CPU "" CACHE STRING "Clock frequency of the target AVR MCU")

if (AVR_MCU)
    set(CMAKE_CXX_FLAGS_INIT -mmcu=${AVR_MCU})
endif ()

if (AVR_F_CPU)
    add_definitions(-DF_CPU=${AVR_F_CPU})
endif ()
