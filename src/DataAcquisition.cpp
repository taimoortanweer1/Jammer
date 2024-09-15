#include "DataAcquisition.h"


DataAcquisition::DataAcquisition(QObject *parent) : QObject(parent), m_sum(2340) {

    connect(&batteryTimer, SIGNAL(timeout()),this, SLOT(updateBattery()));
    batteryTimer.start(50);
}

int DataAcquisition::getSum() const {
    return m_sum;
}

void DataAcquisition::setSum(int value) {
    if (value != m_sum) {
        m_sum = value;
        emit sumChanged(value);
    }
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



void DataAcquisition::updateBattery()
{
    static int i = 0;
    if(i > 99)
        i = 0;

    i++;

    setbattery(i);
}
