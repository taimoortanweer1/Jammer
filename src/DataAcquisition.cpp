#include "DataAcquisition.h"


DataAcquisition::DataAcquisition(QObject *parent) : QObject(parent), m_sum(2340) {}

int DataAcquisition::getSum() const {
    return m_sum;
}

void DataAcquisition::setSum(int value) {
    if (value != m_sum) {
        m_sum = value;
        emit sumChanged(value);
    }
}
