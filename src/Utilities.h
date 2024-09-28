#ifndef UTILITIES_H
#define UTILITIES_H

#include <QObject>

class Utilities : public QObject
{
    Q_OBJECT
public:
    explicit Utilities(QObject *parent = nullptr);

    static char convertIntToChar(int num);
    static void convertIntToChars(int num, char &tens, char &ones);

signals:
};

#endif // UTILITIES_H
