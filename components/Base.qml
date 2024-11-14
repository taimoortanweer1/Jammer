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
        x: -190
        y: 5
        width: 205
        height: 53
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: -15
        anchors.topMargin: 8

        Text {
            id: progressBarText
            x: 137
            y: 6
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
            x: 101
            y: 5
        }

        SignalBar {

            id: signalBar

            x: 52
            y: -3
            width: 50
            height: 50
        }

        Image {
            id: phoneJammer
            x: 3
            y: 8
            source: "qrc:/assets/images/PhoneJammer.png"
            fillMode: Image.PreserveAspectFit
        }
    }

}
