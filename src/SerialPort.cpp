#include "SerialPort.h"

SerialPort::SerialPort(const QString &portName, quint32 baudRate, QObject *parent) : QObject(parent)
{
    serial = new QSerialPort(this);

    serial->setPortName(portName);
    serial->setBaudRate(baudRate);
    if (serial->open(QSerialPort::ReadWrite)) {
        qDebug() << "Serial port opened";
    } else {
        emit errorOccurred(serial->errorString());
    }

    connect(serial, &QSerialPort::readyRead, this, &SerialPort::readData);
}

SerialPort::~SerialPort()
{
    delete serial;
}

void SerialPort::openSerialPort(const QString &portName, quint32 baudRate)
{
    serial->setPortName(portName);
    serial->setBaudRate(baudRate);
    if (serial->open(QSerialPort::ReadWrite)) {
        qDebug() << "Serial port opened";
    } else {
        emit errorOccurred(serial->errorString());
    }
}

void SerialPort::closeSerialPort()
{
    serial->close();
}

void SerialPort::sendData(const QByteArray &data)
{
    if (serial->isOpen()) {
        serial->write(data);
    } else {
        emit errorOccurred("Serial port is not open");
    }
}

void SerialPort::readData()
{
    QByteArray data = serial->readAll();
    emit dataReceived(data);
}
