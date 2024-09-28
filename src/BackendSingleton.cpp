#include "BackendSingleton.h"


BackendSingleton* BackendSingleton::m_instance = nullptr;

BackendSingleton* BackendSingleton::instance()
{
    if (!m_instance) {
        m_instance = new BackendSingleton();
    }

    return m_instance;
}


int BackendSingleton::getbattery() const {
    return m_battery;
}

void BackendSingleton::setbattery(int value) {
    if (value != m_battery) {
        m_battery = value;
        emit batteryChanged(value);
    }
}

int BackendSingleton::getSignalStrength() const
{
    return m_signalStrength;
}

void BackendSingleton::setSignalStrength(int value)
{
    if (value != m_signalStrength) {
        m_signalStrength = value;
        emit signalStrengthChanged(value);
    }
}


void BackendSingleton::updateData()
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

