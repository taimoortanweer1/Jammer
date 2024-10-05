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
