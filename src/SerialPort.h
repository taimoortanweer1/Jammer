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

    void openSerialPort(const QString &portName, quint32 baudRate);
    void closeSerialPort();
    void sendData(const QByteArray &data);

signals:
    void dataReceived(const QByteArray &data);
    void errorOccurred(const QString &error);

private slots:
    void readData();

private:
    QSerialPort *serial;
};

#endif // SERIALPORT_H
