#ifndef DATAACQUISITION_H
#define DATAACQUISITION_H


#include <QObject>
#include <QQmlProperty>
#include <QTimer>

class DataAcquisition : public QObject {
    Q_OBJECT
    Q_PROPERTY(int sum         READ getSum     WRITE setSum     NOTIFY sumChanged)
    Q_PROPERTY(int battery     READ getbattery WRITE setbattery NOTIFY batteryChanged)


public:
    explicit DataAcquisition(QObject *parent = nullptr);
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
    int m_sum;
    int m_battery;
    QTimer batteryTimer;
};


#endif // DATAACQUISITION_H
