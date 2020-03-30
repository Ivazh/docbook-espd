# Подключение проектов-зависимостей, применяемых при генерации документов.
set(FOP_TYPE "int")
set(SAXON_TYPE "int")
add_subdirectory(${PROJECT_SOURCE_DIR}/docbook-espd/deps/xmllint ${PROJECT_BINARY_DIR}/deps/xmllint)
add_subdirectory(${PROJECT_SOURCE_DIR}/docbook-espd/deps/java ${PROJECT_BINARY_DIR}/deps/java)
add_subdirectory(${PROJECT_SOURCE_DIR}/docbook-espd/deps/saxon ${PROJECT_BINARY_DIR}/deps/saxon)
add_subdirectory(${PROJECT_SOURCE_DIR}/docbook-espd/deps/fop ${PROJECT_BINARY_DIR}/deps/fop)


# Проверка наличия в системе сборки необходимых для генерации документации утилит.
if(NOT TARGET XML::xmllint)
    message(FATAL_ERROR "docbook: В системе сборки отсутствует утилита xmllint!")
endif()
if(NOT TARGET JAVA::run)
    message(FATAL_ERROR "docbook: В системе сборки отсутствует виртуальная машина Java!")
endif()
if(NOT TARGET JAVA::saxon)
    message(FATAL_ERROR "docbook: В системе сборки отсутствует утилита saxon!")
endif()
if(NOT TARGET JAVA::fop)
    message(FATAL_ERROR "docbook: В системе сборки отсутствует утилита fop!")
endif()


# Определение переменных запуска.
get_property(xmllint_exec TARGET XML::xmllint PROPERTY IMPORTED_LOCATION)
get_property(java_exec TARGET JAVA::run PROPERTY IMPORTED_LOCATION)
get_property(saxon_exec TARGET JAVA::saxon PROPERTY IMPORTED_LOCATION)
get_property(fop_exec TARGET JAVA::fop PROPERTY IMPORTED_LOCATION)
get_filename_component(fop_dir ${fop_exec} DIRECTORY)
get_filename_component(fop_exec ${fop_exec} NAME)


# Подготовка файла конфигурации для Fop.
# NOTE avk Файл настроек fop.conf - входной параметр и его место в проекте с документацией.
set(FOP_FONT_DIRPATH "${PROJECT_SOURCE_DIR}/docbook-espd/fonts")
set(TIMES_NEW_ROMAN_REGULAR_FONT    "${PROJECT_SOURCE_DIR}/docbook-espd/fonts/TimesNewRoman-Regular.ttf")
set(TIMES_NEW_ROMAN_REGULAR_METRICS "${PROJECT_SOURCE_DIR}/docbook-espd/fonts/TimesNewRoman-Regular.metrics.xml")
set(TIMES_NEW_ROMAN_BOLD_FONT    "${PROJECT_SOURCE_DIR}/docbook-espd/fonts/TimesNewRoman-Bold.ttf")
set(TIMES_NEW_ROMAN_BOLD_METRICS "${PROJECT_SOURCE_DIR}/docbook-espd/fonts/TimesNewRoman-Bold.metrics.xml")
set(fop_conf "${PROJECT_BINARY_DIR}/fop.xml")
configure_file(${PROJECT_SOURCE_DIR}/docbook-espd/conf/fop.xml.in ${fop_conf})


#========================================================================================
#=== Функция генерации docbook -> pdf
#========================================================================================
function(docbook_generate_pdf input version type)
    set(working "${PROJECT_BINARY_DIR}/pdf")
    set(working_temp "${working}/fo")
    make_directory(${working})
    make_directory(${working_temp})
    #
    message("")
    message("")
    message("==== ${input} ====")
    #
    get_filename_component(XML_FILE "${input}" NAME)
    get_filename_component(XML_DIR "${input}" DIRECTORY)
    get_filename_component(XML_FD "${XML_DIR}" NAME)
    if(EXISTS "${XML_DIR}/images")
        file(REMOVE_RECURSE "${working_temp}/images")
        file(COPY "${XML_DIR}/images" DESTINATION "${working_temp}")
    endif()
    set(outputBaseName "${working}/${XML_FD}-${XML_FILE}_${version}")
    set(outputTempName "${working_temp}/${XML_FD}-${XML_FILE}_${version}")
    #
    set(xslFile "${CMAKE_CURRENT_SOURCE_DIR}/docbook-espd/styles/${type}.xsl")
    #
    # Склеивание множества XML-файлов в один.
    execute_process(COMMAND "${xmllint_exec}" --xinclude
                                              --noent
                                              -o "${outputTempName}.xml"
                                              "${input}"
                    WORKING_DIRECTORY ${XML_DIR}
                    RESULT_VARIABLE exec_result_xmllint
                    OUTPUT_VARIABLE exec_output_xmllint
                    ERROR_VARIABLE exec_error_xmllint)
    if(NOT ${exec_result_xmllint} EQUAL 0)
        message(STATUS "xmllint | ERROR | ${input}")
        message(STATUS "xmllint | ERROR | ${exec_error_xmllint}")
        message(STATUS "xmllint | OUTPUT | ${exec_output_xmllint}")
        return()
    endif()
    message(STATUS "xmllint | SUCCESS | ${input}")
    #
    # Формирование fo-представления.
    execute_process(COMMAND "${java_exec}" -jar "${saxon_exec}"
                                           -o "${outputTempName}.fo"
                                           "${outputTempName}.xml"
                                           "${xslFile}"
                    WORKING_DIRECTORY ${XML_DIR}
                    RESULT_VARIABLE exec_result_saxon
                    OUTPUT_VARIABLE exec_output_saxon
                    ERROR_VARIABLE exec_error_saxon)
    if(NOT ${exec_result_saxon} EQUAL 0)
        message(STATUS "saxon | ERROR | ${outputTempName}.xml")
        message(STATUS "saxon | ERROR | ${exec_error_saxon}")
        message(STATUS "saxon | OUTPUT | ${exec_output_saxon}")
        return()
    endif()
    message(STATUS "saxon | SUCCESS | ${outputTempName}.xml")
    #
    # Генерация pdf.
    execute_process(COMMAND "${java_exec}" -jar "${fop_exec}"
                                           -c ${fop_conf}
                                           -fo "${outputTempName}.fo"
                                           -pdf "${outputBaseName}.pdf"
                    WORKING_DIRECTORY ${fop_dir}
                    RESULT_VARIABLE exec_result_fop
                    OUTPUT_VARIABLE exec_output_fop
                    ERROR_VARIABLE exec_error_fop)
    if(NOT ${exec_result_fop} EQUAL 0)
        message(STATUS "fop | ERROR | ${outputTempName}.fo")
        message(STATUS "fop | ERROR | ${exec_error_fop}")
        message(STATUS "fop | OUTPUT | ${exec_output_fop}")
        return()
    endif()
    message(STATUS "fop | SUCCESS | ${outputTempName}.fo")
endfunction()
