#****************************************************************************************
#*** fop                                                                              ***
#***    Проект поиска и подключения форматера Fop.                                    ***
#***==================================================================================***
#*** В проекте применяются следующие необязательные унаследованные переменные:        ***
#***    FOP_DIR           - абс. путь к каталогу установки fop.                       ***
#***    env{FOP_ROOT_DIR} - shell-переменная, путь к каталогу установки fop.          ***
#***    FOP_TYPE          - ext - искать в ОС, int - использовать встроенный.         ***
#***    FOP_VERSION       - номер версии (только для встроенного fop).                ***
#***                                                                                  ***
#*** В проекте создаётся псевдо-цель:                                                 ***
#***   JAVA::fop - app IMPORTED GLOBAL.                                               ***
#***                                                                                  ***
#*** Редакция: 3                                                                      ***
#*** Авторы: А.В. Кикоть (a.v.kikot@yandex.ru)                                        ***
#*** Институт телекоммуникаций (c) 2019                                               ***
#****************************************************************************************

# Ограничение на минимальную версию CMake.
cmake_minimum_required(VERSION 3.0)

# Задание атрибутов проекта.
set(PRJ_NAME fop)
project(${PRJ_NAME} NONE)

# Проверка наличия переменной FOP_TYPE.
# В зависимости от значения этой переменной будет выполняться поиск в ОС или
# использоваться внутренняя копия fop.
if(NOT DEFINED FOP_TYPE)
    message(FATAL_ERROR "deps/fop: Некорректно подключён проект (не указан тип поиска)!")
endif()

# Проверка на корректное значение FOP_TYPE.
string(TOUPPER ${FOP_TYPE} FOP_TYPE)
if(NOT ${FOP_TYPE} STREQUAL "EXT" AND NOT ${FOP_TYPE} STREQUAL "INT")
    message(FATAL_ERROR "deps/fop: Некорректно подключён проект (указан неподдерживаемый тип поиска)!")
endif()

# Если требуется поиск в ОС, то выполнение соответствующего скрипта и выход.
if(${FOP_TYPE} STREQUAL "EXT")
    include(cmake/fop_ext.cmake)
    return()
endif()

# Требуется подключение встроенной версии.
set(FOP_SUPPORTED_VERSIONS "2.3")
#--- Если версия не указана, то использование версии по-умолчанию.
if(NOT DEFINED FOP_VERSION)
    set(FOP_VERSION "2.3")
endif()
#--- Поиск требуемой версии.
list(FIND FOP_SUPPORTED_VERSIONS ${FOP_VERSION} FOP_TEST_VERSION)
if(FOP_TEST_VERSION EQUAL -1)
    message(FATAL_ERROR "deps/fop: версия ${FOP_VERSION} не поддерживается!")
endif()
include(cmake/fop_int_${FOP_VERSION}.cmake)
