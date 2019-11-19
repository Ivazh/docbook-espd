#****************************************************************************************
#*** Скрипт поиска и подключения утилиты saxon.                                       ***
#***==================================================================================***
#*** В скрипте применяются следующие необязательные унаследованные переменные:        ***
#***    SAXON_DIR           - абс. путь к каталогу установки saxon.                   ***
#***    env{SAXON_ROOT_DIR} - shell-переменная, путь к каталогу установки saxon.      ***
#***                                                                                  ***
#*** В скрипте создаётся псевдо-цель:                                                 ***
#***   JAVA::saxon - app IMPORTED GLOBAL.                                             ***
#***                                                                                  ***
#*** Редакция: 1                                                                      ***
#*** Авторы: А.В. Кикоть (a.v.kikot@yandex.ru)                                        ***
#*** Институт телекоммуникаций (c) 2019                                               ***
#****************************************************************************************

# Ограничение на минимальную версию CMake.
cmake_minimum_required(VERSION 3.0)

# Формирование дополнительного списка путей, в котором может оказаться saxon.jar.
set(SAXON_USER_PATHES)
# Приоритет у переменной CMake над переменной окружения.
list(APPEND SAXON_USER_PATHES ${SAXON_DIR})
list(APPEND SAXON_USER_PATHES $ENV{SAXON_ROOT_DIR})
#message(STATUS "deps/saxon: SAXON_USER_PATHES = ${SAXON_USER_PATHES}")

# Выполнение поиска.
find_program(SAXON_EXECUTABLE
             NAMES saxon.jar saxonhe.jar
             PATHS ${SAXON_USER_PATHES}
             PATH_SUFFIXES bin saxon saxonhe saxon/build saxonhe/build saxon/bin saxonhe/bin)
#message(STATUS "saxon path: ${SAXON_EXECUTABLE}")

# Обработка результата поиска.
if(SAXON_EXECUTABLE)
    # Создание псевдо-цели.
    add_executable(JAVA::saxon IMPORTED GLOBAL)
    set_property(TARGET JAVA::saxon PROPERTY IMPORTED_LOCATION "${SAXON_EXECUTABLE}")
    message(STATUS "JAVA::saxon | path: ${SAXON_EXECUTABLE}")
else()
    message(WARNING "JAVA::saxon | 'saxon' не найдена!")
endif()

# Сброс SAXON_EXECUTABLE, т.к. find_program() генерирует глобальную переменную.
unset(SAXON_EXECUTABLE CACHE)
