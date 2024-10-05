#include "DataAcquisition.h"

DataAcquisition* DataAcquisition::m_instance = nullptr;

DataAcquisition* DataAcquisition::instance()
{
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



void DataAcquisition::generateData(UIData data)
{
    QByteArray bytes;
    bytes.push_back('p');
    bytes.push_back('a');
    bytes.push_back('_');


    bytes.push_back(Utilities::convertIntToChar(data.paNumber));

    bytes.push_back('_');
    if(data.status)
        bytes.push_back('1');
    else
        bytes.push_back('0');

    bytes.push_back('_');

    //for multiple digits
    if(data.attenuation>9)
    {
        char tens,ones;
        Utilities::convertIntToChars(data.attenuation, tens, ones);
        bytes.push_back(tens);
        bytes.push_back(ones);
    }
    else
    {
        bytes.push_back(Utilities::convertIntToChar(data.attenuation));
    }


    m_serial->sendData(bytes);
}

void DataAcquisition::extractData(QByteArray data, int dataIndex)
{

    switch (dataIndex) {
    case SENSOR_DATA:
            extractSensorData(data.begin());
        break;
    default:
        break;
    }

}


void  DataAcquisition::extractSensorData(const char* buffer) {

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

    qDebug() << " Temp " << " Current " << " Alarm ";

    for(int i = 0 ; i < 7 ; i++)
    {

        qDebug() <<  pa_temps_c[i] << pa_currents_a[i] << pa_alarm[i] ;
    }


}


