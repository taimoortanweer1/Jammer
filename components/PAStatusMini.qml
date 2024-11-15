import QtQuick 2.15

Item {
    id: root
    height: 275
    width: 120

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
        PAStatus
        {
            paNumber: index
            title: index+1
            paStatus: powerAmpStatus

        }
    }

    GridView {
        anchors.fill: parent
        cellWidth: 100; cellHeight: 40
        model: dataModel
        delegate: dataDelegate


    }

}
