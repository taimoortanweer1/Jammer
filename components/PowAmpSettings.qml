import QtQuick
import QtQuick.Controls

Item {

    //transmitted from ui to controller
    property bool   powerStatus:false
    property int    attenuation: spinboxAttenuation.value

    //received from controller to ui
    property alias  title: textTitle.text
    property string temperature: textTemperature.text
    property string current: textCurrent.text
    property int   vswr: textVSWR.text

    //local use
    property int    paNumber: 0

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
                id:textTitle
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

                    text: "ATTEN"
                }

                SpinBox {
                    id: spinboxAttenuation
                    width: 50
                    value: 12

                }

                TextCustom {
                    id: textCustom1
                    text: "W"

                }


                TextCustom {
                    id: textCustom5
                    text: "TEMP"

                }

                TextCustom {
                    id: textTemperature
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
                    id: textVSWR
                    text: "1"

                }

                TextCustom {
                    id: textCustom10
                    text: "-"
                }

                TextCustom {
                    id: textCurrent
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
