import QtQuick
import "components"
import MyLib 1.0
import QtQuick.Layouts
Window {
    width: 1280
    height: 800
    visible: true
    //color: "transparent" // Set the window background to transparent
    //flags: Qt.Window | Qt.FramelessWindowHint // Remove window decorations

    Base {
        id: base
        anchors.fill: parent

        //battery data from sesnosr : exposed from c++
        myProgressBarPBarValue: DataAcquisition.battery

        //battery data from sesnosr : exposed from c++
        mySignalBarValue: DataAcquisition.signalStrength

        //when left panel button is switched to another view
        onScreenIndexChanged:
        {
            layout.currentIndex= base.screenIndex
        }

        //stacks of screen items inside
        StackLayout {

            id: layout
            x: 317
            y: 90
            width: 920
            height: 550

            //screen with video layout
            VideoComponent {
                id: videoScreen
                playVideo: true

                //this is data structure
                currentDataLocal: DataAcquisition.currentData

                compass: DataAcquisition.compass

                panTilt: DataAcquisition.panTiltData

                //when UI data is updated, this slot is called that will eventually call c++ function to send data to serial
                onDataChanged: (powerAmpNumber,powerAmpStatus,powerAmpAtten) =>  {
                                   DataAcquisition.getUIUpdate(powerAmpNumber,powerAmpStatus,powerAmpAtten)
                               }

            }
            //temp layer for ScreenSplash
            Item {}


            //screen with Powre Amplifier settings
            ScreenPowerAmpSettings {
                id: screenPowerAmp

                //PA data from controller
                //this is a data structure
                currentDataLocal: DataAcquisition.currentData

                //when UI data is updated, this slot is called that will eventually call c++ function to send data to serial
                onDataChanged: (powerAmpNumber,powerAmpStatus,powerAmpAtten) =>  {
                                   DataAcquisition.getUIUpdate(powerAmpNumber,powerAmpStatus,powerAmpAtten)
                               }
            }

        }

    }

}
