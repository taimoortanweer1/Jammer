#include "BackendSingleton.h"


BackendSingleton* BackendSingleton::m_instance = nullptr;

BackendSingleton* BackendSingleton::instance()
{
    if (!m_instance) {
        m_instance = new BackendSingleton();
    }

    return m_instance;
}

int BackendSingleton::getSum() const {
    return m_sum;
}

void BackendSingleton::setSum(int value) {
    if (value != m_sum) {
        m_sum = value;
        emit sumChanged(value);
    }
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

void BackendSingleton::updateBattery()
{
    static int i = 0;
    if(i > 99)
        i = 0;

    i++;

    setbattery(i);
}
