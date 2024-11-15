import QtQuick
import QtQuick.Controls


Rectangle {
    width: 50
    height: 30
    radius: 15
    color: "#C30010"
    border.width: 1
    border.color: "#aaa"


    property bool checked: false



    Rectangle {
        id: handle
        width: 25
        height: 25
        radius: 12.5
        y:2
        color: "#fff"
        border.width: 1
        border.color: "#aaa"
        x: checked ? parent.width - width - 5 : 5
        Behavior on x { SmoothedAnimation { velocity: 250 } }
    }


    MouseArea {
        anchors.fill: parent
        onClicked:
        {
            checked = !checked

            if(checked)
                color = "#00C310"
            else
                color = "#C30010"

        }
    }






}
