cmake_minimum_required(VERSION 3.16)

project(Jammer VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
find_package(Qt6 6.5 REQUIRED COMPONENTS Quick SerialPort)

<<<<<<< HEAD
qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appJammer
    main.cpp
    images.qrc

)

qt_add_qml_module(appJammer
    URI Jammer
    VERSION 1.0
    QML_FILES
    Main.qml
    components/Base.qml
    components/MyProgressBar.qml
    components/SignalBar.qml
    components/VideoComponent.qml
    components/PowAmpSettings.qml
    components/ToggleButton.qml
    components/TextCustom.qml
    components/ScreenPowerAmpSettings.qml

    SOURCES
    src/SerialPort.h src/SerialPort.cpp
    src/BackendSingleton.cpp src/BackendSingleton.h
    src/DataAcquisition.cpp src/DataAcquisition.h



)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appJammer PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appJammer
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
=======
find_package(Qt6 REQUIRED COMPONENTS Core Gui Multimedia Qml Quick)

if (Qt6_VERSION VERSION_GREATER_EQUAL 6.2)
    qt_standard_project_setup()
endif()

qt_add_executable(JammerApp src/main.cpp
    src/DataAcquisition.h src/DataAcquisition.cpp
    src/BackendSingleton.h src/BackendSingleton.cpp
    src/DataSingle.h src/DataSingle.cpp

)

qt_add_resources(JammerApp "configuration"
    PREFIX "/"
    FILES
        qtquickcontrols2.conf
)



target_link_libraries(JammerApp PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    Qt6::Multimedia
)



set(QT_QML_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/qml)
set(QML_IMPORT_PATH ${QT_QML_OUTPUT_DIRECTORY}
    CACHE STRING "Import paths for Qt Creator's code model"
    FORCE
>>>>>>> 726425c1f7cef8ded788841076a0407466ebf59c
)

target_link_libraries(appJammer
    PRIVATE Qt6::Quick
    Qt6::SerialPort
)

include(GNUInstallDirs)
install(TARGETS appJammer
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
