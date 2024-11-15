import QtQuick
import QtQuick.Controls

Item {

    //transmitted from ui to controller
    property bool   powerStatus:false

    //local use
    property int    paNumber: 0
    property string title: "0"

    width: 120
    height: 35

    Rectangle {
        id: rectangle

        anchors.fill: parent
        anchors.rightMargin: 0
        color: "black"


        TextCustom {
            id: paLabelText
            text: title
            color: "white"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 5
            anchors.topMargin: 5
            anchors.bottomMargin: 5
        }

        ToggleButton {
            id: toggleButton1
            x: 75
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: 5
            anchors.topMargin: 3
            anchors.bottomMargin: 2
            onCheckedChanged: {
                powerStatus = checked
                console.log("my index " , paNumber , " state " , checked)
            }

        }

    }

}

