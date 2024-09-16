#ifndef BACKENDSINGLETON_H
#define BACKENDSINGLETON_H

#include <QObject>
#include <QTimer>
class BackendSingleton : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int battery     READ getbattery WRITE setbattery NOTIFY batteryChanged)

public:
    static BackendSingleton* instance();

    int getbattery() const;
    void setbattery(int value);
    int getSum() const;
    void setSum(int value);


signals:
    void sumChanged(int value);
    void batteryChanged(int value);

private slots:
    void updateBattery();


private:
    int m_battery;
    QTimer batteryTimer;
    BackendSingleton() {
        connect(&batteryTimer, SIGNAL(timeout()),this, SLOT(updateBattery()));
        batteryTimer.start(50);
    };
    static BackendSingleton* m_instance;
};

#endif // BACKENDSINGLETON_H
