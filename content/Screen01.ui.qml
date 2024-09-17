

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 6.7
import QtQuick.Controls 6.7
import Jammer
import QtQuick.Layouts

Item {
    id: root
    width: Constants.width
    height: Constants.height
    property alias myProgressBarPBarValue: myProgressBar.pBarValue
    property alias mySignalBarValue: signalBar.signalBarValue

    Image {
        id: image
        anchors.fill: parent
        source: "images/background.png"
        fillMode: Image.Stretch
    }

    Item {
        id: item1
        x: 874
        y: 5
        width: 145
        height: 68
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 8
        anchors.topMargin: 8

        Text {
            id: progressBarText
            x: 95
            y: 0
            width: 50
            height: 50
            color: "#ffffff"
            text: myProgressBar.pBarValue.toString() + "%"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 12
            font.family: "Arial"
        }

        MyProgressBar {
            id: myProgressBar
            x: 51
            y: 0
        }

        SignalBar {

            id: signalBar

            x: 3
            y: -5
            width: 50
            height: 50
        }
    }
}
