import QtQuick
import "components"
import MyLib 1.0
import QtQuick.Layouts
Window {
    width: 1280
    height: 800
    visible: true

    Base {
        id: base
        anchors.fill: parent

        myProgressBarPBarValue: DataAcquisition.battery
        mySignalBarValue: DataAcquisition.signalStrength

        onScreenIndexChanged:
        {
            layout.currentIndex= base.screenIndex

        }

        StackLayout {

            id: layout
            x: 317
            y: 155
            width: 922
            height: 507


            Item {}

            ScreenPowerAmpSettings {
                id: screenPowerAmp
                x: 341
                y: 189
                currentDataLocal: DataAcquisition.currentData
                onDataChanged: (powerAmpNumber,powerAmpStatus,powerAmpAtten) =>  {
                                   DataAcquisition.getUIUpdate(powerAmpNumber,powerAmpStatus,powerAmpAtten)
                               }
            }

            VideoComponent {
                id: videoScreen
                playVideo: true
                // anchors.left: parent.left
                // anchors.right: parent.right
                // anchors.top: parent.top
                // anchors.bottom: parent.bottom
                // anchors.leftMargin: 259
                // anchors.rightMargin: 5
                // anchors.topMargin: 75
                // anchors.bottomMargin: 55

            }




        }







    }



}
