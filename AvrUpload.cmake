set(AVR_UPLOAD_PORT       ""      CACHE STRING "Defauly port for uploading")
set(AVR_UPLOAD_BAUD       115200  CACHE STRING "Default baudrate for the upload port")
set(AVR_UPLOAD_PROGRAMMER arduino CACHE STRING "Default programmer for uploading")

function(add_upload_target target)
    find_program(AVRDUDE_EXE NAMES avrdude)

    if (NOT AVRDUDE_EXE)
        message(WARNING "Cannot find avrdude; not adding upload target "
                        "for ${target}")
        return()
    endif ()

    set(port_var       AVR_${target}_UPLOAD_PORT)
    set(baud_var       AVR_${target}_UPLOAD_BAUD)
    set(programmer_var AVR_${target}_UPLOAD_PROGRAMMER)

    set(${port_var} ${AVR_UPLOAD_PORT}
        CACHE STRING "Port for uploading target ${target}")
    set(${baud_var} ${AVR_UPLOAD_BAUD}
        CACHE STRING "Baudrate for the upload port for target ${target}")
    set(${programmer_var} ${AVR_UPLOAD_PROGRAMMER}
        CACHE STRING "Programmer for uploading target ${target}")

    if (NOT ${port_var})
        message(WARNING "Upload port not set for target ${target}; "
                        "not adding upload target ")
        return()
    endif ()

    add_custom_target(${target}-upload
        COMMAND ${AVRDUDE_EXE}
                -p ${AVR_MCU}
                -c ${${programmer_var}}
                -P ${${port_var}}
                -b ${${baud_var}}
                -U flash:w:$<TARGET_FILE:${target}>:e
        COMMENT "Uploading target ${target}"
        VERBATIM
        USES_TERMINAL)

    add_dependencies(${target}-upload ${target})
endfunction()

