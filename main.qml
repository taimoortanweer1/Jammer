import QtQuick
import "components"
import MyLib 1.0
Window {
    width: 1280
    height: 800
    visible: true
    title: qsTr("Hello World")

    Base {
        anchors.fill: parent

        myProgressBarPBarValue: DataAcquisition.battery
        mySignalBarValue: DataAcquisition.signalStrength


        ScreenPowerAmpSettings {
            id: screenPowerAmp
            x: 341
            y: 189
            onDataChanged: (powerAmpNumber,powerAmpStatus,powerAmpAtten) =>  {
                               DataAcquisition.getUIUpdate(powerAmpNumber,powerAmpStatus,powerAmpAtten)
                           }
        }

        /*
        VideoComponent {
            id: videoScreen
            playVideo: true
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 259
            anchors.rightMargin: 5
            anchors.topMargin: 75
            anchors.bottomMargin: 55

        }
        */
    }



}
