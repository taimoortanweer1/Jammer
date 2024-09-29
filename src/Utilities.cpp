#include "Utilities.h"

Utilities::Utilities(QObject *parent)
    : QObject{parent}
{}


char Utilities::convertIntToChar(int num) {
    return static_cast<char>(num + 48); // 48 is ASCII value of '0'
}

void Utilities::convertIntToChars(int num, char &tens, char &ones) {

    tens = (num / 10) + 48;
    ones = (num % 10) + 48;
}

std::vector<int> Utilities::asciiToInt(const QByteArray& data) {
    std::vector<int> intData;
    QString strData = QString::fromUtf8(data);
    bool prefixFound = false;

    // Check if string starts with "PA Currents = "
    if (strData.startsWith("PA Currents = ")) {
        prefixFound = true;
        // Remove prefix
        strData = strData.mid(14); // 12 is the length of "PA Currents = "
    } else {
        std::cerr << "Error: Invalid prefix. Expected 'PA Currents = '" << std::endl;
        return intData; // Return empty vector
    }

    // Split string by commas and semicolons
    QStringList tokens = strData.split(",");
    for (const QString& token : tokens) {
        // Remove leading/trailing whitespace and semicolon
        QString cleanedToken = token.trimmed();
        cleanedToken = cleanedToken.remove(";");

        // Convert numeric string to integer
        if (!cleanedToken.isEmpty()) {
            bool ok;
            int value = cleanedToken.toInt(&ok);
            if (ok) {
                intData.push_back(value);
            } else {
                std::cerr << "Error: Non-numeric token found." << std::endl;
            }
        }
    }

    return intData;
}

QMap<QString, std::vector<int>> Utilities::parseAsciiData(const QByteArray& data) {
    QMap<QString, std::vector<int>> parsedData;
    QString strData = QString::fromUtf8(data);
    QStringList lines = strData.split("\n");

    for (const QString& line : lines) {
        // Check if line contains "="
        if (line.contains("=")) {
            QStringList parts = line.split("=");
            QString key = parts[0].trimmed();
            QString values = parts[1].trimmed();

            // Remove trailing ";" if present
            if (values.endsWith(";")) {
                values = values.left(values.length() - 1);
            }

            // Split values by commas
            QStringList valueTokens = values.split(",");
            std::vector<int> intValues;

            for (const QString& token : valueTokens) {
                // Remove leading/trailing whitespace
                QString cleanedToken = token.trimmed();

                // Convert numeric string to integer
                bool ok;
                int value = cleanedToken.toInt(&ok);
                if (ok) {
                    intValues.push_back(value);
                } else {
                    std::cerr << "Error: Non-numeric token found." << std::endl;
                }
            }

            parsedData[key] = intValues;
        }
    }

    return parsedData;
}
