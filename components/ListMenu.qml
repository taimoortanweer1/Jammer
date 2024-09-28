import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root
    width: 100
    height: 400
    y: 100
    property int yoffset: 400
    property int duration: 400

    Column {
        id: column
        width: parent.width-4
        height: parent.height-4
        spacing: 5
        anchors.centerIn: parent

        Rectangle {
            id: rectangle1
            width:   parent.width - 10
            height:  parent.width - 10
            color: "#ff0000"

            MouseArea
            {
                anchors.fill: parent
                onClicked: {

                    if (rectangle.anchors.topMargin === rectangle1.width) {
                        animDown.start()
                    } else {
                        animUp.start()
                    }
                }
            }
        }


        Rectangle {
            id: rectangle2
            width:   parent.width - 10
            height:  parent.width - 10
            color: "#00ff00"
        }

        Rectangle {
            id: rectangle3
            width:   parent.width - 10
            height:  parent.width - 10
            color: "#0000ff"
        }


    }

    PropertyAnimation {
          id: animDown
          target: rectangle
          property: "anchors.topMargin"
          duration: 400
          from: rectangle1.width
          to: 300
          easing.type: Easing.InOutSine
      }

    PropertyAnimation {
          id: animUp
          target: rectangle
          property: "anchors.topMargin"
          duration: 400
          from: 300
          to: rectangle1.width
          easing.type: Easing.InOutSine
    }

      Rectangle {
          id: rectangle
          color: "black"
          anchors.fill: parent
          anchors.topMargin: rectangle1.width
      }

}
