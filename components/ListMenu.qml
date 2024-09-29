import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root
    width: 50
    height: 700
    y: 100
    property int duration: 200
    property int screenIndex: 0

    Column {
        id: column
        width: parent.width-4
        height: parent.height-4
        spacing: 7
        anchors.centerIn: parent



        ButtonCustom {

            id: buttonMenu
            width:   parent.width - 10
            height:  parent.width - 10
            imgSource: "qrc:/assets/images/MenuVertical.png"
            onClicked: {

                if (rectangle.anchors.topMargin === buttonMenu.width) {
                    animDown.start()
                } else {
                    animUp.start()
                }
            }
        }


        ButtonCustom {

            id: buttonMenu2
            width:   parent.width - 10
            height:  parent.width - 10
            imgSource: "qrc:/assets/images/Power.png"

            onClicked: {

              screenIndex = 0
            }

        }



        ButtonCustom {

            id: buttonMenu3
            width:   parent.width - 10
            height:  parent.width - 10
            imgSource: "qrc:/assets/images/Adjust.png"


            onClicked: {

              screenIndex = 1
            }

        }

        ButtonCustom {

            id: buttonMenu4
            width:   parent.width - 10
            height:  parent.width - 10
            imgSource: "qrc:/assets/images/LiveVideoOn.png"


            onClicked: {

              screenIndex = 2
            }

        }



        ButtonCustom {

            id: buttonMenu5
            width:   parent.width - 10
            height:  parent.width - 10
            imgSource: "qrc:/assets/images/Map.png"


            onClicked: {

              screenIndex = 3
            }

        }


    }

    PropertyAnimation {
          id: animDown
          target: rectangle
          property: "anchors.topMargin"
          duration: root.duration
          from: buttonMenu.width
          to: 600
          easing.type: Easing.InOutSine
      }

    PropertyAnimation {
          id: animUp
          target: rectangle
          property: "anchors.topMargin"
          duration: root.duration
          from: 600
          to: buttonMenu.width
          easing.type: Easing.InOutSine
    }

      Rectangle {
          id: rectangle
          color: "black"
          anchors.fill: parent
          anchors.topMargin: buttonMenu.width
      }

}
