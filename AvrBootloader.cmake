find_package(PythonInterp 3.0 REQUIRED)

set(AVR_BOOT_SIZE "" CACHE STRING "Size of the boot section in bytes")

function(add_avr_bootloader target)
    if (NOT AVR_BOOT_SIZE)
        message(FATAL_ERROR
                "AVR_BOOT_SIZE has to be defined when building a bootloader")
    endif ()

    set(TOOL ${AVR_TOOLCHAIN_PATH}/Tools/bootloader_start_address.py)
    execute_process(COMMAND ${PYTHON_EXECUTABLE} ${TOOL}
                            --mcu ${AVR_MCU}
                            --bootsize ${AVR_BOOT_SIZE}
                    RESULT_VARIABLE EXIT_CODE
                    OUTPUT_VARIABLE STDOUT
                    ERROR_VARIABLE  STDERR)

    if (NOT ${EXIT_CODE} EQUAL 0)
        message(FATAL_ERROR ${STDERR})
    endif ()

    add_executable(${target} ${ARGN})
    set_target_properties(${target} PROPERTIES
                          LINK_FLAGS "-Wl,--section-start=.text=${STDOUT}")

    set(TOOL ${AVR_TOOLCHAIN_PATH}/Tools/check_bootloader_size.py)
    add_custom_command(TARGET ${target} POST_BUILD
                       COMMAND ${PYTHON_EXECUTABLE} ${TOOL}
                               --elf-file $<TARGET_FILE:${target}>
                               --size ${AVR_BOOT_SIZE})
endfunction()
