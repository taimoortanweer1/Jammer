#include "SerialPort.h"

SerialPort::SerialPort(const QString &portName, quint32 baudRate, QObject *parent) : QObject(parent)
{
    m_serial = new QSerialPort(this);
    m_serial->setPortName(portName);
    m_serial->setBaudRate(baudRate);

    //trying to open serial port
    if (m_serial->open(QSerialPort::ReadWrite)) {
        qDebug() << "Serial port opened";
    } else {
        emit errorOccurred(m_serial->errorString());
    }

    connect(m_serial, &QSerialPort::readyRead, this, &SerialPort::readData);
}


SerialPort::~SerialPort()
{
    delete m_serial;
}


void SerialPort::openSerialPort(const QString &portName, quint32 baudRate)
{
    m_serial->setPortName(portName);
    m_serial->setBaudRate(baudRate);
    if (m_serial->open(QSerialPort::ReadWrite)) {
        qDebug() << "Serial port opened";
    } else {
        emit errorOccurred(m_serial->errorString());
    }
}


void SerialPort::closeSerialPort()
{
    m_serial->close();
}


void SerialPort::sendData(const QByteArray &data)
{
    if (m_serial->isOpen()) {
        m_serial->write(data);
    } else {
        emit errorOccurred("Serial port is not open");
    }
}


void SerialPort::readData()
{
    QByteArray data = m_serial->readAll();
    emit dataReceived(data);
}
