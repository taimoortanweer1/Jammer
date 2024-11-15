import QtQuick 2.15

Item {
    id: root
    height: 400
    width: 150

    property int     powerAmpNumber: 0
    property bool    powerAmpStatus: false



    ListModel {
        id: dataModel
        ListElement{ paNumber: 0}
        ListElement{ paNumber: 1}
        ListElement{ paNumber: 2}
        ListElement{ paNumber: 3}
        ListElement{ paNumber: 4}
        ListElement{ paNumber: 5}
        ListElement{ paNumber: 6}

    }

    Component {
        id: dataDelegate
        PASwitch
        {
            paNumber: index
            title: index+1
            onPowerStatusChanged: {

                powerAmpNumber = index;
                powerAmpStatus = powerStatus;
                root.dataChanged(powerAmpNumber,powerAmpStatus)
            }

        }
    }

    GridView {
        anchors.fill: parent
        cellWidth: 100; cellHeight: 40
        model: dataModel
        delegate: dataDelegate


    }

}
