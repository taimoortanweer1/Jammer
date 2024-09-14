#ifndef DATAACQUISITION_H
#define DATAACQUISITION_H


#include <QObject>
#include <QQmlProperty>

class DataAcquisition : public QObject {
    Q_OBJECT
    Q_PROPERTY(int sum READ getSum WRITE setSum NOTIFY sumChanged)

public:
    explicit DataAcquisition(QObject *parent = nullptr);
    int getSum() const;
    void setSum(int value);

signals:
    void sumChanged(int value);

private:
    int m_sum;
};


#endif // DATAACQUISITION_H
