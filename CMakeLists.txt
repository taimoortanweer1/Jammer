cmake_minimum_required(VERSION 3.16)

project(Jammer VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
find_package(Qt6 6.5 REQUIRED COMPONENTS Quick SerialPort)

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
    src/Utilities.h src/Utilities.cpp




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
