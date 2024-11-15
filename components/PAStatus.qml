import QtQuick
import QtQuick.Controls

Item {

    //local use
    property int    vswr    :  0
    property int    paNumber:  0
    property string title   : "0"
    width                   :120
    height                  : 35

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

        StatusSignal {
            id: statusSignal
            statusflag: vswr ? true : false
            x: 75
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: 5
            anchors.topMargin: 3
            anchors.bottomMargin: 2


        }

    }

}

