import QtQuick 2.15

Item {
    id: root
    height: 507
    width: 817

    property bool   powerAmpStatus: false
    property int    powerAmpNumber: 0
    property int    powerAmpAtten : 0
    signal          dataChanged(paNumber: int, status: bool, attentuation: int)
    property var    currentDataLocal



    ListModel {
        id: dataModel

        ListElement {
            curr: 0.00;
            temp: 0.00;
            alrm: 0

        }
    }

    Component {
        id: dataDelegate
        PowAmpSettings
        {
            temperature: temp
            current: curr
            vswr:alrm
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

    GridView {
        anchors.fill: parent
        cellWidth: 200; cellHeight: 250
        model: dataModel
        delegate: dataDelegate

    }

    onCurrentDataLocalChanged:   {

        for(var i = 0; i < 7 ;i++)
            dataModel.set(i, {"curr":Number(currentDataLocal[i*3 + 0]),"temp":Number(currentDataLocal[i*3 + 1]),"alrm":Number(currentDataLocal[i*3 + 2])})
    }
}
