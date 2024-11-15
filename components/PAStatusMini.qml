import QtQuick 2.15

Item {
    id: root
    height: 275
    width: 120

    property int     powerAmpNumber: 0
    property bool    powerAmpStatus: false

    property var currentDataForPAStatus
    ListModel {
        id: dataModel

        ListElement {
            alrm: "0"
        }
    }

    Component {
        id: dataDelegate
        PAStatus
        {
            paNumber: index
            title: index+1
            vswr:alrm
        }
    }

    GridView {
        anchors.fill: parent
        cellWidth: 100; cellHeight: 40
        model: dataModel
        delegate: dataDelegate


    }


    onCurrentDataForPAStatusChanged:   {

        for(var i = 0; i < 7 ;i++)
        {
            dataModel.set(i, {"alrm":currentDataForPAStatus[i*3 + 2]})
        }

    }

}
