set(AVR_UPLOAD_PORT       ""      CACHE STRING "Port for uploading")
set(AVR_UPLOAD_BAUD       115200  CACHE STRING "Baudrate for the upload port")
set(AVR_UPLOAD_PROGRAMMER arduino CACHE STRING "Programmer for uploading")

function(add_upload_target target)
    find_program(AVRDUDE_EXE NAMES avrdude)

    if (NOT AVRDUDE_EXE)
        message(WARNING "Cannot find avrdude; not adding upload target "
                        "for ${target}")
        return()
    endif ()

    if (NOT AVR_UPLOAD_PORT)
        message(WARNING "AVR_UPLOAD_PORT not set; not adding upload target "
                        "for ${target}")
        return()
    endif ()

    add_custom_target(${target}-upload
        COMMAND ${AVRDUDE_EXE}
                -p ${AVR_MCU}
                -c ${AVR_UPLOAD_PROGRAMMER}
                -P ${AVR_UPLOAD_PORT}
                -b ${AVR_UPLOAD_BAUD}
                -U flash:w:$<TARGET_FILE:${target}>:e
        COMMENT "Uploading target ${target}"
        VERBATIM
        USES_TERMINAL)

    add_dependencies(${target}-upload ${target})
endfunction()

