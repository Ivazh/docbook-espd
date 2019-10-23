#
# Copyright (c) 2012 Brian C. Milco <bcmilco AT gmail DOT com>
#
#    This program is free software; you can redistribute it and/or
#    modify it under the terms of the GNU General Public License
#    as published by the Free Software Foundation; version 2
#    of the License.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# This file contains functions to generate documentation from docbook files.
# TODO: make sure that docbook-xsl-ns package is installed
#
# OUTPUT FORMATS:
# html: generic html with a folder of images.
# pdf: a PDF
# htmlhelp: MS Windows specific html help pages

MACRO(MAKE_WINDOWS_PATH pathname)
    # An extra \\ escape is necessary to get a \ through CMake's processing.
    STRING(REPLACE "/" "\\" ${pathname} "${${pathname}}")
    # Enclose with UNESCAPED quotes.  This means we need to escape our
    # quotes once here, i.e. with \"
    SET(${pathname} ${${pathname}})
ENDMACRO(MAKE_WINDOWS_PATH)

#
#Ex. docbook_generate(pdf "${docbook_source_file}" "${software_version}")
#
function(DOCBOOK_GENERATE format input version type)

    set(working "${CMAKE_CURRENT_BINARY_DIR}/${format}")
    set(working_temp "${CMAKE_CURRENT_BINARY_DIR}/${format}/fo")
    make_directory(${working})
    make_directory(${working_temp})

    #file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/images DESTINATION ${working})
    message("")
    message("==== ${input} ====")
    find_program(xsltproc saxon PATHS ${CMAKE_CURRENT_SOURCE_DIR}/docbook-espd)
    #message("Found xsltproc: ${xsltproc}")
    set(docbookBasePath ${CMAKE_CURRENT_SOURCE_DIR}/espd)
    find_program(fop fop PATHS ${CMAKE_CURRENT_SOURCE_DIR}/docbook-espd NO_DEFAULT_PATH)
    #message("Found fop: ${fop}")
    find_program(xmllint xmllint PATHS ${CMAKE_CURRENT_SOURCE_DIR}/docbook-espd)

    set(DOCBOOK_XSL_NS_PATH ${docbookBasePath})

    #configure_file(${CMAKE_CURRENT_SOURCE_DIR}/myStyle.xsl.in
    #            ${CMAKE_CURRENT_BINARY_DIR}/myStyle.xsl)

    if (format STREQUAL "html")
        set(xslFile "${docbookBasePath}/html/docbook.xsl")
        #TODO: include a custom CSS Style sheet:
        #file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/myStyle.css DESTINATION ${working})
        #--stringparam html.stylesheet myStyle.css
        execute_process(
                COMMAND "${xsltproc}" --xinclude -o "${working}/index.html" "${xslFile}" "${input}"
                OUTPUT_VARIABLE _output)

    elseif (format STREQUAL "pdf")
        get_filename_component(XML_FILE "${input}" NAME)
        get_filename_component(XML_DIR "${input}" DIRECTORY)
        get_filename_component(XML_FD "${XML_DIR}" NAME)
        if(EXISTS "${XML_DIR}/images")
            file(COPY "${XML_DIR}/images" DESTINATION "${CMAKE_CURRENT_BINARY_DIR}/pdf/fo")
        endif()
        set(outputBaseName "${working}/${XML_FD}-${XML_FILE}_${version}")
        set(outputTempName "${working_temp}/${XML_FD}-${XML_FILE}_${version}")
        set(outputTempName "${working_temp}/${XML_FD}-${XML_FILE}_${version}")
            message(${XML_DIR})

        if(type STREQUAL "eskd")
            set(xslFile "${CMAKE_CURRENT_SOURCE_DIR}/docbook-espd/styles/eskd.xsl")
        else()
            set(xslFile "${CMAKE_CURRENT_SOURCE_DIR}/docbook-espd/styles/espd.xsl")
        endif()

        execute_process(
                COMMAND "${xmllint}" --xinclude --noent -o "${outputTempName}.xml" "${input}"
                WORKING_DIRECTORY ${XML_DIR}
                RESULT_VARIABLE ret
                OUTPUT_VARIABLE _output
        )
        if(NOT ${ret} EQUAL 0)
            message(${input})
            return()
        endif()

        execute_process(
                COMMAND "${xsltproc}" -o "${outputTempName}.fo" "${outputTempName}.xml" "${xslFile}"
                WORKING_DIRECTORY ${XML_DIR}
                RESULT_VARIABLE ret
                OUTPUT_VARIABLE _output)
        if(NOT ${ret} EQUAL 0)
            message(${input})
            return()
        endif()

        execute_process(
                COMMAND "${fop}" -c ${CMAKE_CURRENT_SOURCE_DIR}/docbook-espd/fop.xml -fo "${outputTempName}.fo" -pdf "${outputBaseName}.pdf"
                RESULT_VARIABLE ret
                OUTPUT_VARIABLE _output)
        if(NOT ${ret} EQUAL 0)
            message(${input})
            return()
        endif()

        file(REMOVE_RECURSE "${CMAKE_CURRENT_BINARY_DIR}/pdf/fo/images")

    elseif (format STREQUAL "rtf")
        get_filename_component(XML_FILE "${input}" NAME)
        get_filename_component(XML_DIR "${input}" DIRECTORY)
        set(outputBaseName "${working}/${XML_FILE}_${version}")
        set(outputTempName "${working_temp}/${XML_FILE}_${version}")
        message(${XML_DIR})

        set(xslFile "${CMAKE_CURRENT_SOURCE_DIR}/sample.xsl")
        file(COPY ${XML_DIR}/images DESTINATION ${working_temp})

        execute_process(
                COMMAND "${xsltproc}" --encoding utf-8 --xinclude --param double.sided 0 -o "${outputTempName}.fo" "${xslFile}" "${input}"
                WORKING_DIRECTORY ${XML_DIR}
                RESULT_VARIABLE ret
                OUTPUT_VARIABLE _output)

        execute_process(
                COMMAND "${fop}" -c ${CMAKE_CURRENT_SOURCE_DIR}/fop.xml -fo "${outputTempName}.fo" -rtf "${outputBaseName}.rtf"
                RESULT_VARIABLE ret
                OUTPUT_VARIABLE _output)
    else ()
        message(FATAL_ERROR "${format} is not supported by this cmake module. Please choose from html, pdf, pages, or htmlhelp")
    endif ()

    set(${outList} ${${outList}} PARENT_SCOPE)
endfunction()
