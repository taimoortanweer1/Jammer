#include "DataAcquisition.h"

DataAcquisition* DataAcquisition::m_instance = nullptr;

DataAcquisition* DataAcquisition::instance()
{
    //if instance already created it wont create another one
    if (!m_instance) {
        m_instance = new DataAcquisition();
    }

    return m_instance;
}


int DataAcquisition::getbattery() const {
    return m_battery;
}

void DataAcquisition::setbattery(int value) {
    if (value != m_battery) {
        m_battery = value;
        emit batteryChanged(value);
    }
}

int DataAcquisition::getSignalStrength() const
{
    return m_signalStrength;
}

void DataAcquisition::setSignalStrength(int value)
{
    if (value != m_signalStrength) {
        m_signalStrength = value;
        emit signalStrengthChanged(value);
    }
}

void DataAcquisition::updateDataSimulator()
{
    static int i = 0;
    static int j = 0;
    if(i > 99)
    {
        i = 0;
    }
    if( j > 99)
    {
        j = 0;
    }

    i++;
    j=j+4;

    setbattery(i);
    setSignalStrength(j);

}

void DataAcquisition::getUIUpdate(QVariant param1, QVariant param2, QVariant param3)
{
    m_uiData.paNumber    = QVariant(param1).toInt();
    m_uiData.status      = QVariant(param2).toBool();
    m_uiData.attenuation = QVariant(param3).toInt();

    qDebug() << "m_uiData.paNumber " << m_uiData.paNumber << " m_uiData.status " << m_uiData.status <<  " m_uiData.attenuation " << m_uiData.attenuation;

    generateData(m_uiData);
}

QVariantList DataAcquisition::getCurrentData() const
{
    return m_sensorData;
}



void DataAcquisition::generateData(UIData data)
{
    //data from ui is converted to bytearray for sending to senosr controller
    QByteArray bytes;
    bytes.push_back('p');
    bytes.push_back('a');
    bytes.push_back('_');

    //convert int to ascii
    bytes.push_back(Utilities::convertIntToChar(data.paNumber));

    bytes.push_back('_');

    //power selection status of PA
    if(data.status)
        bytes.push_back('1');
    else
        bytes.push_back('0');

    bytes.push_back('_');

    //for multiple digits: this block needs improvement
    if(data.attenuation>9)
    {
        char tens,ones;
        Utilities::convertIntToChars(data.attenuation, tens, ones);
        bytes.push_back(tens);
        bytes.push_back(ones);
    }
    else
    {
        //for single digit conversion
        bytes.push_back(Utilities::convertIntToChar(data.attenuation));
    }


    //send data to serial port
    m_serial->sendData(bytes);
}

void DataAcquisition::extractData(QByteArray data, int dataIndex)
{

    //depending on data type index byte array is extracted
    switch (dataIndex) {
    case SENSOR_DATA:
        extractSensorData(data);
        break;
    default:
        break;
    }

}

/*
void  DataAcquisition::extractSensorData(const char* buffer) {

    m_sensorData.clear();

    int pa_currents[MAX_VALUES];
    int pa_temps[MAX_VALUES];
    int pa_alarm[MAX_VALUES];

    float pa_currents_v[MAX_VALUES];
    float pa_temps_v[MAX_VALUES];
    float pa_alarm_v[MAX_VALUES];

    float pa_temps_c[MAX_VALUES];
    float pa_currents_a[MAX_VALUES];
    // Extract PA_Temps


    const char* start = strstr(buffer, "PA_Temps =[");
    if (start != NULL) {
        start += strlen("PA_Temps =[");
        for (int i = 0; i < MAX_VALUES; i++) {
            pa_temps[i] = atoi(start);
            pa_temps_v[i] = (pa_temps[i] / 1023.0) * 5.0;
            // pa_temps_c[i] = (pa_temps_v[i] - 0.5) * 100;
            pa_temps_c[i] = (pa_temps_v[i] - MCP9701_OFFSET_V) / MCP9701_SENSITIVITY;
            start = strchr(start, '_');
            if (start != NULL) start++;
        }
    }

    // Extract PA_Currents
    start = strstr(buffer, "PA_Currents =[");
    if (start != NULL) {
        start += strlen("PA_Currents =[");
        for (int i = 0; i < MAX_VALUES; i++) {
            pa_currents[i] = atoi(start);
            pa_currents_v[i] = (pa_currents[i] / 1023.0) * 5.0; // Calculate voltage
            float temp = pa_temps_c[i]; // Assuming you've already converted temperature to °C
            float zero_current_voltage = BASE_ZERO_CURRENT_VOLTAGE + (temp - 25) * TEMP_SLOPE;
            pa_currents_a[i] = (pa_currents_v[i] - zero_current_voltage) / SENSITIVITY;
            start = strchr(start, '_');
            if (start != NULL) start++;
        }
    }


    // Extract PA_ALARM
    start = strstr(buffer, "PA_ALARM =[");
    if (start != NULL) {
        start += strlen("PA_ALARM =[");
        for (int i = 0; i < MAX_VALUES; i++) {
            pa_alarm[i] = atoi(start);
            //pa_alarm_v[i] = (pa_alarm[i] / 1.0) * 5.0;
            start = strchr(start, '_');
            if (start != NULL) start++;
        }
    }

    for(int i = 0 ; i < 7 ; i++)
    {

        //qDebug() <<  pa_temps_c[i] << pa_currents_a[i] << pa_alarm[i] ;
        QString cur   = QString("%1").arg(pa_currents_a[i], 0, 'f', 3);
        QString temp  = QString("%1").arg(pa_temps_c[i], 0, 'f', 3);
        QString alarm  = QString("%1").arg(pa_alarm[i], 0, 'f', 3);

        //this sensor is updated in ui when signal is emitted
        m_sensorData.push_back(cur);
        m_sensorData.push_back(temp);
        m_sensorData.push_back(alarm);

    }

    emit currentDataChanged();

}

*/



void DataAcquisition::parseNmeaSentence(const QString &sentence, QStringList &data) {
    // Remove checksum and split sentence into fields
    QString sentenceNoChecksum = sentence.left(sentence.indexOf("*"));
    QStringList fields = sentenceNoChecksum.split(",");



    // Parse fields based on NMEA sentence type
    if (fields.at(0).contains("$GPGGA") && fields.size() == 22) {

        int i = 0;
        for(int j = 8; j < 15; j++)
        {
            pa_temps[i] = (fields.at(j).toInt());
            pa_temps_v[i] = (pa_temps[i] / 1023.0) * 5.0;
            pa_temps_c[i] = (pa_temps_v[i] - MCP9701_OFFSET_V) / MCP9701_SENSITIVITY;
            i++;
        }

        i = 0;
        for(int j = 1; j < 8; j++)
        {
            pa_currents[i] = (fields.at(j).toInt());
            pa_currents_v[i] = (pa_currents[i] / 1023.0) * 5.0; // Calculate voltage
            float temp = pa_temps_c[i]; // Assuming you've already converted temperature to °C
            float zero_current_voltage = BASE_ZERO_CURRENT_VOLTAGE + (temp - 25) * TEMP_SLOPE;
            pa_currents_a[i] = (pa_currents_v[i] - zero_current_voltage) / SENSITIVITY;
            i++;
        }

        i = 0;
        for(int j = 15; j < 22; j++)
        {
            pa_alarm[i] = (fields.at(j).toInt());
            i++;
        }

    }

}
void  DataAcquisition::extractSensorData(const QByteArray &data)
{
    m_sensorData.clear();
    QString buffer;

    if(data.size() > 0)
    {
        buffer += data;

        // Split buffer into individual NMEA sentences
        QStringList sentences = buffer.split("\r\n");
        buffer = sentences.last();


        int i = 0;
        foreach (QString sentence, sentences) {
            sentence = sentence.trimmed();
            if (sentence.startsWith("$")) {
                QStringList parsedData;
                parseNmeaSentence(sentence, parsedData);

            }
        }

        for(int i = 0 ; i < 7 ; i++)
        {

            //qDebug() <<  pa_temps_c[i] << pa_currents_a[i] << pa_alarm[i] ;
            QString cur   = QString("%1").arg(pa_currents_a[i], 0, 'f', 3);
            QString temp  = QString("%1").arg(pa_temps_c[i], 0, 'f', 3);
            QString alarm  = QString("%1").arg(pa_alarm[i], 0, 'f', 3);

            //this sensor is updated in ui when signal is emitted
            m_sensorData.push_back(cur);
            m_sensorData.push_back(temp);
            m_sensorData.push_back(alarm);

        }

        emit currentDataChanged();
    }
}
