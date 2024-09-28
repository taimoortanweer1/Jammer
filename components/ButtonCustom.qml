import QtQuick 2.15
import QtQuick.Controls.Basic

Button {
    id: control
    property string imgSource
    background: Image {
        id: img
        width: control.width
        height: control.height
        source: imgSource
    }

}
