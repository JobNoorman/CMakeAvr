set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR AVR)
set(CMAKE_C_COMPILER avr-gcc)

# Make sure the Platform/ directory is found by CMake
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})
