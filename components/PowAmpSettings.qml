import QtQuick
import QtQuick.Controls

Item {

    property bool powerStatus:false
    property int  attenuation: spinbox.value
    property int  paNumber: 0
    property alias titleText: text1.text
    width: 200
    height: 250


    id: ite
    implicitWidth: 200
    implicitHeight: 250
    Rectangle {

        anchors.fill: parent
        color: "black"

        Image {

            id: image
            anchors.fill: parent
            source: "qrc:/assets/images/OptionFrame.png"
            fillMode: Image.Stretch

            Text {
                id: text1
                width: 51
                height: 30
                color: "#00C310"
                text: qsTr("CH # 1")
                anchors.top: parent.top
                anchors.topMargin: 17
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenterOffset: 0
                font.pointSize: 10
                font.family: "Arial"
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Grid
            {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 19
                anchors.rightMargin: 19
                anchors.topMargin: 73
                anchors.bottomMargin: 27
                rows: 5
                columns: 3
                spacing: 5

                TextCustom {

                    text: "PIN"
                }

                SpinBox {
                    id: spinbox
                    width: 50
                    value: 12

                }

                TextCustom {
                    id: textCustom1
                    text: "W"

                }

                TextCustom {
                    id: textCustom2
                    text: "POUT"

                }

                TextCustom {
                    id: textCustom3
                    text: "2.3"

                }

                TextCustom {
                    id: textCustom4
                    text: "dbM"

                }

                TextCustom {
                    id: textCustom5
                    text: "TEMP"

                }

                TextCustom {
                    id: textCustom6
                    text: "34"

                }

                TextCustom {
                    id: textCustom7
                    text: "C"

                }

                TextCustom {
                    id: textCustom8
                    text: "VSWR"

                }

                TextCustom {
                    id: textCustom9
                    text: "10"

                }

                TextCustom {
                    id: textCustom10
                    text: "-"
                }

                TextCustom {
                    id: textCustom11
                    text: "DC-A"

                }

                TextCustom {
                    id: textCustom12
                    text: "1.2"

                }
                TextCustom {
                    id: textCustom13
                    text: "A"

                }



            }

            ToggleButton {
                id: toggleButton
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 8
                anchors.topMargin: 17

                onCheckedChanged: {

                    powerStatus = checked
                    console.log("my index " , paNumber , " state " , checked)

                }

            }

        }

    }


}
