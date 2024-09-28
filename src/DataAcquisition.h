#ifndef DATAACQUISITION_H
#define DATAACQUISITION_H


#include <QObject>
#include <QQmlProperty>
#include <QTimer>
#include "src/SerialPort.h"
#include "src/Utilities.h"


class DataAcquisition : public QObject {
    Q_OBJECT
    Q_PROPERTY(int battery            READ getbattery        WRITE setbattery        NOTIFY batteryChanged)
    Q_PROPERTY(int signalStrength     READ getSignalStrength WRITE setSignalStrength NOTIFY signalStrengthChanged)



public:


    struct UIData
    {
        int paNumber;
        bool status;
        int attenuation;
        UIData() {

            paNumber = 0;
            status = false;
            attenuation = 0;
        }

    };
    static DataAcquisition* instance();

    int getbattery() const;
    void setbattery(int value);
    int getSignalStrength() const;
    void setSignalStrength(int value);


signals:

    void batteryChanged(int value);
    void signalStrengthChanged(int value);


public slots:
    void updateData();
    void getUIUpdate(QVariant param1, QVariant param2, QVariant param3);



private:
    int m_battery;
    int m_signalStrength;
    UIData m_uiData;
    SerialPort *m_serial;
    QTimer timerData;

    DataAcquisition() {

        m_serial = new SerialPort("COM1",9600);

        QObject::connect(m_serial, &SerialPort::dataReceived, [this](const QByteArray &data) {
            qDebug() << "Received data:" << data;
        });
        connect(&timerData, SIGNAL(timeout()),this, SLOT(updateData()));
        timerData.start(50);
    };
    static DataAcquisition* m_instance;

    void generateData(UIData data);
};


#endif // DATAACQUISITION_H
