import QtQuick
import QtQuick.Controls
import QtQuick.Timeline 1.0

Item {

    id: progressBar
    width: 50
    height: 50
    property alias pBarValue: pBar.value

    Image {
        id: image
        anchors.fill: parent

        source: "qrc:/assets/images/EmptyBattery.png"
        fillMode: Image.Stretch


    }

    ProgressBar {
        id: pBar
        x: 0
        y: 0
        width: 5
        height: 4
        visible: false
        value: 100
        to: 100
    }
    Rectangle {
        id: rectangle
        y: 37
        height: pBar.value * 0.3
        color: "#ffffff"
        radius: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: 17
        anchors.rightMargin: 17
        anchors.bottomMargin: 9
    }



}



/*##^##
Designer {
    D{i:0;formeditorColor:"#000000"}D{i:3}
}
##^##*/

