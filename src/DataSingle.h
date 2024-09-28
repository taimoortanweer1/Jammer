#ifndef DATASINGLE_H
#define DATASINGLE_H

#include <QObject>

class DataSingle : public QObject
{
    Q_OBJECT
public:
    explicit DataSingle(QObject *parent = nullptr);

signals:
};

#endif // DATASINGLE_H
