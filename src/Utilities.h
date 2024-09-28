#ifndef UTILITIES_H
#define UTILITIES_H

#include <QObject>

class Utilities : public QObject
{
    Q_OBJECT
public:
    explicit Utilities(QObject *parent = nullptr);

    /**
     * @brief convertIntToChar, convert int digital to ascii digit
     * @param num
     * @return
     */
    static char convertIntToChar(int num);

    /**
     * @brief convertIntToChars, convert unit and tens digital to ascii digit
     * @param num
     * @param tens
     * @param ones
     */
    static void convertIntToChars(int num, char &tens, char &ones);

signals:
};

#endif // UTILITIES_H
