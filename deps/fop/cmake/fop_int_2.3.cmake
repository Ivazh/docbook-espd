#****************************************************************************************
#*** Скрипт подключения встроенного в проект форматера Fop версии 2.3.                ***
#***==================================================================================***
#*** В скрипте создаётся псевдо-цель:                                                 ***
#***   JAVA::fop - app IMPORTED GLOBAL.                                               ***
#***                                                                                  ***
#*** Редакция: 1                                                                      ***
#*** Авторы: А.В. Кикоть (a.v.kikot@yandex.ru)                                        ***
#*** Институт телекоммуникаций (c) 2019                                               ***
#****************************************************************************************

# Создание псевдо-цели.
set(FOP_EXECUTABLE "${PROJECT_SOURCE_DIR}/fop-2.3/build/fop.jar")
set(FOP_LIBDIR "${PROJECT_SOURCE_DIR}/fop-2.3/lib")
set(FOP_VERSION "2.3")
#
add_executable(JAVA::fop IMPORTED GLOBAL)
set_property(TARGET JAVA::fop PROPERTY IMPORTED_LOCATION "${FOP_EXECUTABLE}")
set_property(TARGET JAVA::fop PROPERTY FOP_VERSION "${FOP_VERSION}")
message(STATUS "JAVA::fop | path: ${FOP_EXECUTABLE}")
message(STATUS "JAVA::fop | version: ${FOP_VERSION}")
