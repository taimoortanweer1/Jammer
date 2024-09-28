import QtQuick 6.7
import QtQuick.Controls 6.7
import Jammer
import QtQuick.Layouts
Item {


    Rectangle
    {
        anchors.fill: parent
        VideoComponent
        {
            playVideo: true
            anchors.fill: parent
        }
    }
    
}
