import QtQuick 2.15

Item {
    id: root
    height: 507
    width: 817

    property bool   powerAmpStatus: false
    property int    powerAmpNumber: 0
    property int    powerAmpAtten : 0
    signal          dataChanged(paNumber: int, status: bool, attentuation: int)

    property var    currentData1

    Grid
    {
        anchors.fill: parent
        spacing: 5
        rows: 2
        columns: 4
        Repeater {
            model: 7
            delegate: PowAmpSettings
            {

                temperature: "23"
                current:"currentData"
                vswr:1


                paNumber: index
                title: "CH # "+ Number(index+1)
                onPowerStatusChanged: {

                    powerAmpNumber = index;
                    powerAmpStatus = powerStatus;
                    powerAmpAtten = attenuation
                    root.dataChanged(powerAmpNumber,powerAmpStatus,powerAmpAtten)
                }
                onAttenuationChanged: {
                    powerAmpNumber = index;
                    powerAmpStatus = powerStatus;
                    powerAmpAtten = attenuation
                    root.dataChanged(index,powerStatus,attenuation)
                }
            }
        }

    }

}
