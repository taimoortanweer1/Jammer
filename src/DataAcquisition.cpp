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
