#****************************************************************************************
#*** java                                                                             ***
#***    Проект поиска и подключения виртуальной машины Java.                          ***
#***==================================================================================***
#*** В проекте создаётся псевдо-цель:                                                 ***
#***   JAVA::run - app IMPORTED GLOBAL                                                ***
#***                                                                                  ***
#*** Редакция: 1                                                                      ***
#*** Авторы: А.В. Кикоть (a.v.kikot@yandex.ru)                                        ***
#*** Институт телекоммуникаций (c) 2019                                               ***
#****************************************************************************************

# Ограничение на минимальную версию CMake.
cmake_minimum_required(VERSION 3.0)

# Задание атрибутов проекта.
set(PRJ_NAME java)
project(${PRJ_NAME} NONE)

# Выполнение поиска.
find_program(JAVA_EXECUTABLE NAMES java)
#message(STATUS "java path: ${JAVA_EXECUTABLE}")

# Обработка результата поиска.
if(JAVA_EXECUTABLE)
    # Проверка запускаемости.
    exec_program(${JAVA_EXECUTABLE} ARGS "-version" OUTPUT_VARIABLE JAVA_VERSION RETURN_VALUE JAVA_RESULT)
    #message(STATUS "deps/java: JAVA_VERSION = ${JAVA_VERSION}")
    #message(STATUS "deps/java: JAVA_RESULT = ${JAVA_RESULT}")
    if(JAVA_RESULT EQUAL 0)
        # Создание псевдо-цели.
        add_executable(JAVA::run IMPORTED GLOBAL)
        set_property(TARGET JAVA::run PROPERTY IMPORTED_LOCATION "${JAVA_EXECUTABLE}")
        message(STATUS "JAVA::run | path: ${JAVA_EXECUTABLE}")
    else()
        message(WARNING "JAVA::run | 'java' найдена, но не запускается!")
    endif()
else()
    message(WARNING "JAVA::run | 'java' не найдена!")
endif()

# Сброс JAVA_EXECUTABLE, т.к. find_program() генерирует глобальную переменную.
unset(JAVA_EXECUTABLE CACHE)
