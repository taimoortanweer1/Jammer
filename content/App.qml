import QtQuick
import Jammer
import MyLib2
Window {
    width: Constants.width
    height: Constants.height
    color: "transparent"  // Make window background transparent
    flags: Qt.FramelessWindowHint  // Remove window frame


    // Optional: Set window opacity
     // Range: 0.0 (fully transparent) to 1.0 (fully opaque)


    visible: true
    title: "Jammer"

    Screen01 {
        id: mainScreen
        myProgressBarPBarValue:BackendSingleton.battery
        mySignalBarValue: BackendSingleton.signalStrength

        Screen02 {
            id: videoScreen

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 259
            anchors.rightMargin: 5
            anchors.topMargin: 75
            anchors.bottomMargin: 50
            //myProgressBarPBarValue:BackendSingleton.battery
            //mySignalBarValue: BackendSingleton.signalStrength
        }



    }



}

