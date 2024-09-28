#ifndef BACKENDSINGLETON_H
#define BACKENDSINGLETON_H

#include <QObject>
#include <QTimer>

class BackendSingleton : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int battery     READ getbattery WRITE setbattery NOTIFY batteryChanged)
    Q_PROPERTY(int signalStrength     READ getSignalStrength WRITE setSignalStrength NOTIFY signalStrengthChanged)



public:
    static BackendSingleton* instance();

    int getbattery() const;
    void setbattery(int value);
    int getSignalStrength() const;
    void setSignalStrength(int value);


signals:

    void batteryChanged(int value);
    void signalStrengthChanged(int value);


private slots:
    void updateData();


private:
    int m_battery;
    int m_signalStrength;

    QTimer timerData;

    BackendSingleton() {
        connect(&timerData, SIGNAL(timeout()),this, SLOT(updateData()));
        timerData.start(50);
    };
    static BackendSingleton* m_instance;
};

#endif // BACKENDSINGLETON_H
