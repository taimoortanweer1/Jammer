import QtQuick 2.15
import QtQuick.Window 2.12

Window {

    id: splashScreen
    width: 1280
    height: 800
    visible: true
    flags: Qt.SplashScreen

    property alias splashTimer: timer
    Rectangle {
        anchors.fill: parent
        color: "black"

        Image {
            id: logo
            anchors.centerIn: parent
            source: "logo.png"
            width: 200
            height: 200
        }

        Text {
            anchors.top: logo.bottom
            anchors.horizontalCenter: logo.horizontalCenter
            text: "Loading..."
            color: "white"
            font.pixelSize: 24
        }

        Timer {
            id: timer
            interval: 3000 // splash screen duration in milliseconds
            running: true
            onTriggered: {
                splashScreen.visible = false
                mainWindow.visible = true
            }
        }
    }
}
