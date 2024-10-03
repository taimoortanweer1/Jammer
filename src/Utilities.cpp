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


QVector<PhaseData> Utilities::parsePhaseData(const QByteArray& bytes) {
    // Remove endline characters

    // Split bytes into strings
    QString dataString = QString::fromUtf8(bytes);
    QStringList dataList = dataString.split("]");

    // Check if we have exactly 3 lists
    // if (dataList.size() != 3) {
    //     qWarning() << "Invalid data format";
    //     return QVector<PhaseData>();
    // }

    // Extract and split individual lists
    QString PA_Currents = dataList[0].mid(12); // Remove "PA_Currents=["
    QString PA_Temps = dataList[1].mid(10);   // Remove "PA_Temps=["
    QString PA_ALARM = dataList[2].mid(10);   // Remove "PA_ALARM=["

    QStringList currentList = PA_Currents.split("_");
    QStringList tempList = PA_Temps.split("_");
    QStringList alarmList = PA_ALARM.split("_");

    // Check if lists have the same size
    if (currentList.size() != tempList.size() || currentList.size() != alarmList.size()) {
        qWarning() << "Lists have different sizes";
        return QVector<PhaseData>();
    }

    // Parse data
    QVector<PhaseData> phaseData;
    for (int i = 0; i < currentList.size(); ++i) {
        PhaseData data;
        data.current = currentList[i].toInt();
        data.temperature = tempList[i].toInt();
        data.alarm = (alarmList[i] == "1");

        phaseData.append(data);
    }

    return phaseData;
}

// Function to extract PA_Currents, PA_Temps, and PA_ALARM from the buffer and print them
void  Utilities::extract_and_print_values(const char* buffer) {

    int pa_currents[MAX_VALUES];
    int pa_temps[MAX_VALUES];
    int pa_alarm[MAX_VALUES];

    float pa_currents_v[MAX_VALUES];
    float pa_temps_v[MAX_VALUES];
    float pa_alarm_v[MAX_VALUES];

    float pa_temps_c[MAX_VALUES];
    float pa_currents_a[MAX_VALUES];
    // Extract PA_Temps


    const char* start = strstr(buffer, "PA_Temps =[");
    if (start != NULL) {
        start += strlen("PA_Temps =[");
        for (int i = 0; i < MAX_VALUES; i++) {
            pa_temps[i] = atoi(start);
            pa_temps_v[i] = (pa_temps[i] / 1023.0) * 5.0;
            // pa_temps_c[i] = (pa_temps_v[i] - 0.5) * 100;
            pa_temps_c[i] = (pa_temps_v[i] - MCP9701_OFFSET_V) / MCP9701_SENSITIVITY;
            start = strchr(start, '_');
            if (start != NULL) start++;
        }
    }

    // Extract PA_Currents
    start = strstr(buffer, "PA_Currents =[");
    if (start != NULL) {
        start += strlen("PA_Currents =[");
        for (int i = 0; i < MAX_VALUES; i++) {
            pa_currents[i] = atoi(start);
            pa_currents_v[i] = (pa_currents[i] / 1023.0) * 5.0; // Calculate voltage


            float temp = pa_temps_c[i]; // Assuming you've already converted temperature to °C
            float zero_current_voltage = BASE_ZERO_CURRENT_VOLTAGE + (temp - 25) * TEMP_SLOPE;



            pa_currents_a[i] = (pa_currents_v[i] - zero_current_voltage) / SENSITIVITY;
            start = strchr(start, '_');
            if (start != NULL) start++;
        }
    }


    // Extract PA_ALARM
    start = strstr(buffer, "PA_ALARM =[");
    if (start != NULL) {
        start += strlen("PA_ALARM =[");
        for (int i = 0; i < MAX_VALUES; i++) {
            pa_alarm[i] = atoi(start);
            //pa_alarm_v[i] = (pa_alarm[i] / 1.0) * 5.0;
            start = strchr(start, '_');
            if (start != NULL) start++;
        }
    }

    qDebug() << " Temp " << " Current " << " Alarm ";

    for(int i = 0 ; i < 7 ; i++)
    {

    qDebug() <<  pa_temps_c[i] << pa_currents_a[i] << pa_alarm[i] ;
    }


}

