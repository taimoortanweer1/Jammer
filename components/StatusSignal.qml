import QtQuick
import QtQuick.Controls


Item {
    width: 30
    height: 30
    property bool statusflag: false

    Rectangle {
        id: outerRect
        anchors.fill: parent
        radius: 15
        color: "white"

        Rectangle {
            id: innerRect
            width: 25
            height: 25
            color : statusflag ? "#00C310" : "#C30010"
            radius: 12.5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter


        }

    }
}
