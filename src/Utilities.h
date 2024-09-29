#ifndef UTILITIES_H
#define UTILITIES_H

#include <QObject>
#include <QMap>
#include <iostream>
#include <vector>
#include <sstream>
#include <string>

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

    /**
     * @brief asciiToInt
     * @param data
     * @return
     */
    static std::vector<int> asciiToInt(const QByteArray& data);


    /**
     * @brief parseAsciiData
     * @param data
     * @return
     */
    static QMap<QString, std::vector<int>> parseAsciiData(const QByteArray& data);


signals:
};

#endif // UTILITIES_H
