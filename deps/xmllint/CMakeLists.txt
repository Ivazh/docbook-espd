#****************************************************************************************
#*** xmllint                                                                          ***
#***    Проект поиска и подключения утилиты xmllint.                                  ***
#***==================================================================================***
#*** В проекте создаётся псевдо-цель:                                                 ***
#***   XML::xmllint - app IMPORTED GLOBAL                                             ***
#***                                                                                  ***
#*** Редакция: 1                                                                      ***
#*** Авторы: А.В. Кикоть (a.v.kikot@yandex.ru)                                        ***
#*** Институт телекоммуникаций (c) 2019                                               ***
#****************************************************************************************

# Ограничение на минимальную версию CMake.
cmake_minimum_required(VERSION 3.0)

# Задание атрибутов проекта.
set(PRJ_NAME xmllint)
project(${PRJ_NAME})

# Выполнение поиска.
find_program(XMLLINT_EXECUTABLE NAMES xmllint)
#message(STATUS "xmllint path: ${XMLLINT_EXECUTABLE}")

# Обработка результата поиска.
if(XMLLINT_EXECUTABLE)
    # Проверка запускаемости.
    exec_program(${XMLLINT_EXECUTABLE} ARGS "-version" OUTPUT_VARIABLE XMLLINT_VERSION RETURN_VALUE XMLLINT_RESULT)
    #message(STATUS "deps/xmllint: XMLLINT_VERSION = ${XMLLINT_VERSION}")
    #message(STATUS "deps/xmllint: XMLLINT_RESULT = ${XMLLINT_RESULT}")
    if(XMLLINT_RESULT EQUAL 0)
        # Создание псевдо-цели.
        add_executable(XML::xmllint IMPORTED GLOBAL)
        set_property(TARGET XML::xmllint PROPERTY IMPORTED_LOCATION "${XMLLINT_EXECUTABLE}")
        message(STATUS "XML::xmllint | path: ${XMLLINT_EXECUTABLE}")
    else()
        message(WARNING "XML::xmllint | 'xmllint' найдена, но не запускается!")
    endif()
else()
    message(WARNING "XML::xmllint | 'xmllint' не найдена!")
endif()

# Сброс XMLLINT_EXECUTABLE, т.к. find_program() генерирует глобальную переменную.
unset(XMLLINT_EXECUTABLE CACHE)
