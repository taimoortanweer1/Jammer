#ifndef DATAACQUISITION_H
#define DATAACQUISITION_H


#include <QObject>
#include <QQmlProperty>
#include <QTimer>
#include "src/SerialPort.h"
#include "src/Utilities.h"

#define SENSOR_DATA         0

class DataAcquisition : public QObject {
    Q_OBJECT

    //data to be exposed to qml
    Q_PROPERTY(int battery                READ getbattery        WRITE setbattery        NOTIFY batteryChanged)
    Q_PROPERTY(int signalStrength         READ getSignalStrength WRITE setSignalStrength NOTIFY signalStrengthChanged)
    Q_PROPERTY(QVariantList  currentData  READ getCurrentData                            NOTIFY currentDataChanged)
    Q_PROPERTY(float compass              READ getCompass        WRITE setCompass        NOTIFY signalCompassChanged)
    Q_PROPERTY(QVariantList  panTiltData  READ getPanTiltData    WRITE setPanTiltData    NOTIFY signalPanTiltDataChanged)



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

    /**
     * @brief currentData
     * @return
     */
    QVariantList getCurrentData() const;


    /**
     * @brief getCompass: this will get value from backend
     * @return
     */
    float getCompass() const;


    /**
     * @brief setCompass: this is set value to UI
     * @param value
     */
    void setCompass(float value);

    /**
     * @brief getPanTiltData: this is get values from backend
     * @return
     */
    QVariantList getPanTiltData();

    /**
     * @brief setPanTiltData: this will set data to UI
     * @param values
     */
    void setPanTiltData(QVariantList values);

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

    /**
     * @brief dataListChanged
     */
    void currentDataChanged();


    /**
     * @brief signalCompassChanged, to update UI, this signal is called
     * @param value
     */
    void signalCompassChanged(float value);


    /**
     * @brief signalPanTiltDataChanged: to update UI this signal is called
     * @param values
     */
    void signalPanTiltDataChanged(QVariantList values);

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

    //User Display Data
    int             m_battery;
    int             m_signalStrength;
    UIData          m_uiData;
    QVariantList    m_sensorData;
    float           m_compass;
    QVariantList    m_PanTilt;


    //Backend Logic Data
    SerialPort      *m_serial;
    QTimer          m_timerData;
    int             m_dataType;
    QString         m_dataBuffer;

    int   pa_currents[MAX_VALUES];
    int   pa_temps[MAX_VALUES];
    int   pa_alarm[MAX_VALUES];

    float pa_currents_v[MAX_VALUES];
    float pa_temps_v[MAX_VALUES];

    float pa_temps_c[MAX_VALUES];
    float pa_currents_a[MAX_VALUES];

    //constructor with initializations
    DataAcquisition() {

        m_serial = new SerialPort("COM8",115200);
        m_dataType = 0;

        QObject::connect(m_serial, &SerialPort::dataReceived, [this](const QByteArray &data) {
            handleDataReceived(data); // Call the new method to handle incoming data
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

    /**
     * @brief extractData: main function for data extraction, index represents type of data
     * @param data
     * @param dataIndex
     */
    void extractData(QByteArray data, int dataIndex);

    /**
     * @brief extractSensorData, data parsing function for sensor data
     * @param data
     */
   // void extractSensorData(const char* buffer);

    /**
     * @brief extractSensorData, data parsing function for sensor data
     * @param data
     */
    void extractSensorData(const QByteArray &data);


    /**
     * @brief parseNmeaSentence
     * @param sentence
     * @param data
     */
    void parseNmeaSentence(const QString &sentence, QStringList &data);

    // Updated method to handle received data
    void handleDataReceived(const QByteArray &data) {
        m_dataBuffer.append(QString::fromUtf8(data)); // Append new data to the buffer

        // Check if we have a complete message (i.e., contains closing bracket ']')
        if (m_dataBuffer.contains('$')) {
            // Print the complete message
            //qDebug() << "Received complete data:" << m_dataBuffer;

            // Call your extraction or processing method
            extractData(m_dataBuffer.toUtf8().constData(), 0);
            //extractSensorData(m_dataBuffer.toUtf8().constData());

            // Clear the buffer after processing
            m_dataBuffer.clear();
        }
    }
};


#endif // DATAACQUISITION_H
