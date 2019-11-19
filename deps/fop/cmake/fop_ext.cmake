#****************************************************************************************
#*** Скрипт поиска и подключения форматера Fop.                                       ***
#***==================================================================================***
#*** В скрипте применяются следующие необязательные унаследованные переменные:        ***
#***    FOP_DIR           - абс. путь к каталогу установки fop.                       ***
#***    env{FOP_ROOT_DIR} - shell-переменная, путь к каталогу установки fop.          ***
#***                                                                                  ***
#*** В скрипте создаётся псевдо-цель:                                                 ***
#***   JAVA::fop - app IMPORTED GLOBAL.                                               ***
#***                                                                                  ***
#*** Редакция: 1                                                                      ***
#*** Авторы: А.В. Кикоть (a.v.kikot@yandex.ru)                                        ***
#*** Институт телекоммуникаций (c) 2019                                               ***
#****************************************************************************************

# Ограничение на минимальную версию CMake.
cmake_minimum_required(VERSION 3.0)

# Формирование дополнительного списка путей, в котором может оказаться fop.jar.
set(FOP_USER_PATHES)
# Приоритет у переменной CMake над переменной окружения.
list(APPEND FOP_USER_PATHES ${FOP_DIR})
list(APPEND FOP_USER_PATHES $ENV{FOP_ROOT_DIR})
#message(STATUS "deps/fop: FOP_USER_PATHES = ${FOP_USER_PATHES}")

# Выполнение поиска.
find_program(FOP_EXECUTABLE
             NAMES fop.jar
             PATHS ${FOP_USER_PATHES}
             PATH_SUFFIXES bin fop fop/build fop/bin)
#message(STATUS "fop path: ${FOP_EXECUTABLE}")

# Обработка результата поиска.
if(FOP_EXECUTABLE)
    # Создание псевдо-цели.
    add_executable(JAVA::fop IMPORTED GLOBAL)
    set_property(TARGET JAVA::fop PROPERTY IMPORTED_LOCATION "${FOP_EXECUTABLE}")
    message(STATUS "JAVA::fop | path: ${FOP_EXECUTABLE}")
else()
    message(WARNING "JAVA::fop | 'fop' не найдена!")
endif()

# Сброс FOP_EXECUTABLE, т.к. find_program() генерирует глобальную переменную.
unset(FOP_EXECUTABLE CACHE)
