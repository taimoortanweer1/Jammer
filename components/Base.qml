import QtQuick 2.15

Item {

    id: ite
    property alias myProgressBarPBarValue: myProgressBar.pBarValue
    property alias mySignalBarValue: signalBar.signalBarValue
    property alias screenIndex: listMenu.screenIndex

    Image {

        width: ite.width
        height: ite.height
        source: "qrc:/assets/images/background2.png"
    }

    ListMenu {

        id: listMenu
        width: 70
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 15
        anchors.topMargin: 32
        anchors.bottomMargin: 120

    }

    Item {
        id: item1
        x: 874
        y: 5
        width: 145
        height: 68
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 8
        anchors.topMargin: 8

        Text {
            id: progressBarText
            x: 95
            y: 0
            width: 50
            height: 50
            color: "#ffffff"
            text: myProgressBar.pBarValue.toString() + "%"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 12
            font.family: "Arial"
        }

        MyProgressBar {
            id: myProgressBar
            x: 51
            y: 0
        }

        SignalBar {

            id: signalBar

            x: 3
            y: -5
            width: 50
            height: 50
        }
    }

}
