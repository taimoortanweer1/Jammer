#ifndef UTILITIES_H
#define UTILITIES_H

#include <QObject>
#include <QMap>
#include <iostream>
#include <vector>
#include <sstream>
#include <string>
#include <QDebug>
#define MCP9701_OFFSET_V                0.5
#define MCP9701_SENSITIVITY             0.01
#define BASE_ZERO_CURRENT_VOLTAGE       2.5 // Zero current output voltage at 25°C
#define SENSITIVITY                     0.066 // Sensitivity in V/A (for 66 mV/A model)
#define TEMP_SLOPE                      -0.00026 // Zero-current voltage slope in V/°C
#define MAX_BUFFER_SIZE                 1024
#define MAX_VALUES                      7


struct PhaseData {
    int current;
    int temperature;
    bool alarm;
};

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
     * @brief extractSensorData
     * @param buffer
     */
    static void extractSensorData(const char *buffer);

signals:
private:


};

#endif // UTILITIES_H
