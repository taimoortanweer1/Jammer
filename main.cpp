#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "src/DataAcquisition.h"
int main(int argc, char *argv[])
{

    QGuiApplication app(argc, argv);
    // Create the singleton instance
    DataAcquisition* m_DataAcquisition = DataAcquisition::instance();

    qmlRegisterSingletonInstance("MyLib", 1, 0, "DataAcquisition", m_DataAcquisition);

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("Jammer", "Main");

    return app.exec();

}
