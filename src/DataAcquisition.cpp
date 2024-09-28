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


void DataAcquisition::updateData()
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

char DataAcquisition::convertIntToChar(int num) {
    return static_cast<char>(num + 48); // 48 is ASCII value of '0'
}

void DataAcquisition::convertIntToChars(int num, char &tens, char &ones) {
    tens = (num / 10) + 48;
    ones = (num % 10) + 48;
}

void DataAcquisition::getPowerStatusUI(bool status, int paNumber)
{
    qDebug() << " getPowerStatusUI " << status  << " paNumber " << paNumber;

    QByteArray bytes;
    bytes.push_back('p');
    bytes.push_back('a');
    bytes.push_back('_');
    bytes.push_back(convertIntToChar(paNumber));
    bytes.push_back('_');
    if(status)
        bytes.push_back('1');
    else
        bytes.push_back('0');
    bytes.push_back('_');

    int number = 18;
    if(number>9)
    {
        char tens,ones;
        convertIntToChars(number, tens, ones);
        bytes.push_back(tens);
        bytes.push_back(ones);

    }
    else
    {
        bytes.push_back(convertIntToChar(number));
    }



    m_serial->sendData(bytes);

}

void DataAcquisition::getAttenuationUI(int value)
{
    qDebug() << " getAttenuationUI " << value;
    qDebug();

}
