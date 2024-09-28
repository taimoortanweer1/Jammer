import QtQuick 2.15

Item {
    id: root
    height: 507
    width: 817

    property int  powerAmpStatus: 0
    property int  powerAmpNumber: 0
    property int  powerAmpAtten: 0
    property int  attenuation: 0
    signal dataChanged(status: bool, paNumber: int)

    Grid
    {
        anchors.fill: parent
        spacing: 5
        rows: 2
        columns: 4

        Repeater {
            model: 7;
            delegate: PowAmpSettings
            {
                titleText: "CH # "+ index
                paNumber: index
                onPowerStatusChanged: { powerAmpStatus = powerStatus; root.dataChanged(powerStatus,index) }
                onAttenuationChanged: { powerAmpAtten  = attenuation; }
            }
        }

    }

}
