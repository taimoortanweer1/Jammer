import QtQuick 2.15

Item {

    id: ite
    property alias myProgressBarPBarValue: myProgressBar.pBarValue
    property alias mySignalBarValue: signalBar.signalBarValue

    Image {

        width: ite.width
        height: ite.height
        source: "qrc:/assets/images/background.png"
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
