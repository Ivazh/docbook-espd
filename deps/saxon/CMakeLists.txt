#****************************************************************************************
#*** saxon                                                                            ***
#***    Проект поиска и подключения утилиты saxon.                                    ***
#***==================================================================================***
#*** В проекте применяются следующие необязательные унаследованные переменные:        ***
#***    SAXON_DIR           - абс. путь к каталогу установки saxon.                   ***
#***    env{SAXON_ROOT_DIR} - shell-переменная, путь к каталогу установки saxon.      ***
#***    SAXON_TYPE          - ext - искать в ОС, int - использовать встроенный.       ***
#***    SAXON_VERSION       - номер версии (только для встроенного saxon).            ***
#***                                                                                  ***
#*** В проекте создаётся псевдо-цель:                                                 ***
#***   JAVA::saxon - app IMPORTED GLOBAL.                                             ***
#***                                                                                  ***
#*** Редакция: 1                                                                      ***
#*** Авторы: А.В. Кикоть (a.v.kikot@yandex.ru)                                        ***
#*** Институт телекоммуникаций (c) 2019                                               ***
#****************************************************************************************

# Ограничение на минимальную версию CMake.
cmake_minimum_required(VERSION 3.0)

# Задание атрибутов проекта.
set(PRJ_NAME saxon)
project(${PRJ_NAME} NONE)

# Проверка наличия переменной SAXON_TYPE.
# В зависимости от значения этой переменной будет выполняться поиск в ОС или
# использоваться внутренняя копия saxon.
if(NOT DEFINED SAXON_TYPE)
    message(FATAL_ERROR "deps/saxon: Некорректно подключён проект (не указан тип поиска)!")
endif()

# Проверка на корректное значение SAXON_TYPE.
string(TOUPPER ${SAXON_TYPE} SAXON_TYPE)
if(NOT ${SAXON_TYPE} STREQUAL "EXT" AND NOT ${SAXON_TYPE} STREQUAL "INT")
    message(FATAL_ERROR "deps/saxon: Некорректно подключён проект (указан неподдерживаемый тип поиска)!")
endif()

# Если требуется поиск в ОС, то выполнение соответствующего скрипта и выход.
if(${SAXON_TYPE} STREQUAL "EXT")
    include(cmake/saxon_ext.cmake)
    return()
endif()

# Требуется подключение встроенной версии.
set(SAXON_SUPPORTED_VERSIONS "6.5.5;9.9.1.5")
#--- Если версия не указана, то использование версии по-умолчанию.
if(NOT DEFINED SAXON_VERSION)
    set(SAXON_VERSION "6.5.5")
endif()
#--- Поиск требуемой версии.
list(FIND SAXON_SUPPORTED_VERSIONS ${SAXON_VERSION} SAXON_TEST_VERSION)
if(SAXON_TEST_VERSION EQUAL -1)
    message(FATAL_ERROR "deps/saxon: версия ${SAXON_VERSION} не поддерживается!")
endif()
include(cmake/saxon_int_${SAXON_VERSION}.cmake)
