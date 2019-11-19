#****************************************************************************************
#*** Скрипт подключения встроенного в проект утилиты saxon версии 9.9.1.5.            ***
#***==================================================================================***
#*** В скрипте создаётся псевдо-цель:                                                 ***
#***   JAVA::saxon - app IMPORTED GLOBAL.                                             ***
#***                                                                                  ***
#*** Редакция: 1                                                                      ***
#*** Авторы: А.В. Кикоть (a.v.kikot@yandex.ru)                                        ***
#*** Институт телекоммуникаций (c) 2019                                               ***
#****************************************************************************************

# Создание псевдо-цели.
set(SAXON_EXECUTABLE "${PROJECT_SOURCE_DIR}/saxon-9.9.1.5/saxon9he.jar")
set(SAXON_VERSION "9.9.1.5")
#
add_executable(JAVA::saxon IMPORTED GLOBAL)
set_property(TARGET JAVA::saxon PROPERTY IMPORTED_LOCATION "${SAXON_EXECUTABLE}")
set_property(TARGET JAVA::saxon PROPERTY SAXON_VERSION "${SAXON_VERSION}")
message(STATUS "JAVA::saxon | path: ${SAXON_EXECUTABLE}")
message(STATUS "JAVA::saxon | version: ${SAXON_VERSION}")
