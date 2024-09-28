#ifndef SERIALPORT_H
#define SERIALPORT_H

#include <QtSerialPort/QSerialPort>
#include <QByteArray>
#include <QObject>
#include <QDebug>

class SerialPort : public QObject
{
    Q_OBJECT

public:
    explicit SerialPort(const QString &portName, quint32 baudRate, QObject *parent = nullptr);
    ~SerialPort();

    /**
     * @brief openSerialPort, opens serial port with given parameters
     * @param portName
     * @param baudRate
     */
    void openSerialPort(const QString &portName, quint32 baudRate);

    /**
     * @brief closeSerialPort, close currently opened port
     */
    void closeSerialPort();

    /**
     * @brief sendData, sends given bytearray to serial
     * @param data
     */
    void sendData(const QByteArray &data);

signals:
    /**
     * @brief dataReceived, this signal sends data out when serial data is received
     * @param data
     */
    void dataReceived(const QByteArray &data);

    /**
     * @brief errorOccurred, in case of error this signal is emitted
     * @param error
     */
    void errorOccurred(const QString &error);

private slots:

    /**
     * @brief readData, slot called when data is received using serial
     */
    void readData();

private:
    QSerialPort *m_serial;
};

#endif // SERIALPORT_H
