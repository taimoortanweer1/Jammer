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


    /**
     * @brief The UIData structure, members local to UI only
     */
    struct UIData
    {
        int     paNumber;
        bool    status;
        int     attenuation;
        UIData() {

            paNumber = 0;
            status = false;
            attenuation = 0;
        }

    };

    /**
     * @brief instance, this implementation will make sure of a singleton instance
     * @return
     */
    static DataAcquisition* instance();

    /**
     * @brief getbattery get battery status from UI
     * @return
     */
    int getbattery() const;

    /**
     * @brief setbattery update UI
     * @param value
     */
    void setbattery(int value);

    /**
     * @brief getSignalStrength from UI
     * @return
     */
    int getSignalStrength() const;

    /**
     * @brief setSignalStrength update UI
     * @param value
     */
    void setSignalStrength(int value);


signals:

    /**
     * @brief batteryChanged to update UI, this signal is called
     * @param value
     */
    void batteryChanged(int value);

    /**
     * @brief signalStrengthChanged, to update UI, this signal is called
     * @param value
     */
    void signalStrengthChanged(int value);


public slots:

    /**
     * @brief updateData, backend data is updated in this simulator
     */
    void updateDataSimulator();


    /**
     * @brief getUIUpdate: when any of the one param is changed from ui, this slot is called,
     * this updates data locally
     * @param param1
     * @param param2
     * @param param3
     */
    void getUIUpdate(QVariant param1, QVariant param2, QVariant param3);



private:

    int             m_battery;
    int             m_signalStrength;
    UIData          m_uiData;
    SerialPort      *m_serial;
    QTimer          m_timerData;

    DataAcquisition() {

        m_serial = new SerialPort("COM1",9600);

        QObject::connect(m_serial, &SerialPort::dataReceived, [this](const QByteArray &data) {
            qDebug() << "Received data:" << data;
            extractData(data);
        });
        connect(&m_timerData, SIGNAL(timeout()),this, SLOT(updateDataSimulator()));
        m_timerData.start(50);
    };

    /**
     * @brief m_instance, singleton instance of class
     */
    static DataAcquisition* m_instance;

    /**
     * @brief generateData, formats data according to protocol and then sends to serial
     * @param data
     */
    void generateData(UIData data);
    void extractData(QByteArray data);

};


#endif // DATAACQUISITION_H
