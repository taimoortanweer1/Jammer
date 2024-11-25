import QtQuick
import QtMultimedia

Item {


    id: itemTop
    width: 900
    height: 650
    property bool playVideo: false
    property bool   powerAmpStatus: false
    property int    powerAmpNumber: 0
    property int    powerAmpAtten : 0
    signal          dataChanged(paNumber: int, status: bool, attentuation: int)
    property var    currentDataLocal
    property real   compass: 0.0
    property var    panTilt

    Rectangle {
        id:    cameraUI

        width: 700
        height: 650


        CaptureSession {
            id: captureSession
            camera: Camera {
                id: camera
            }
            imageCapture: ImageCapture {
                id: imageCapture
            }

            recorder: MediaRecorder {
                id: recorder

            }
            videoOutput: viewfinder
        }


        VideoOutput {
            id: viewfinder
            visible: true
            anchors.fill: parent
            fillMode: VideoOutput.PreserveAspectCrop

        }

        // Fill area outside circle
        Canvas {

            id: fillCanvas
            anchors.fill: parent


            Text {
                id: azim
                x: 8
                y: 8
                width: 62
                height: 25
                text: "Elev :" + panTilt[0]
                color: "white"

            }



            Text {
                id: elev
                x: 8
                y: 30
                width: 62
                height: 25
                text: "Azim :" + panTilt[1]
                color: "white"
            }

            Item
            {
                id: directionItem
                x: 572
                y: 8
                height: 120
                width: 120

                Image {
                    id: arrow
                    x: 35
                    width: 50
                    height: 70
                    anchors.verticalCenter: parent.verticalCenter
                    source: "qrc:/assets/images/arrow.png"
                    fillMode: Image.PreserveAspectFit
                    rotation: compass
                }

                Image {
                    id: directionArea
                    anchors.fill: parent
                    source: "qrc:/assets/images/DirectionArea.png"
                    fillMode: Image.PreserveAspectFit
                }
            }
            Joystick
            {
                id: joystick
                width: 120
                height: 120
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.rightMargin: -259
                anchors.bottomMargin: -234
                anchors.verticalCenterOffset: 261
                anchors.horizontalCenterOffset: 286
            }

            renderTarget: Canvas.Image
            onPaint: {
                var ctx = getContext("2d");
                ctx.reset();

                ctx.fillStyle = "black"; // Change to desired color
                ctx.beginPath();
                ctx.rect(0, 0, width, height); // Fill entire rectangle
                ctx.arc(width / 2, height / 2, Math.min(width, height) / 2, 0, 2 * Math.PI);
                ctx.clip();
                ctx.fill();

                ctx.fillStyle = "#331431C0"; // Change to desired color
                ctx.beginPath();
                ctx.rect(0, 0, width, height); // Fill entire rectangle
                ctx.arc(width / 2, height / 2, Math.min(width, height) / 2, 0, 2 * Math.PI);
                ctx.clip();
                ctx.fill();

                ctx.strokeStyle = "green";
                ctx.lineWidth = 2; // Adjust boundary thickness
                ctx.lineCap = "round"; // Optional: adjust line cap style
                ctx.beginPath();
                ctx.rect(0,0, width, height, );
                ctx.stroke();



                // Draw inner circle arc boundary in white
                ctx.strokeStyle = "white";
                ctx.lineWidth = 2; // Adjust boundary thickness
                ctx.lineCap = "round"; // Optional: adjust line cap style
                ctx.beginPath();
                ctx.arc(width / 2, height / 2, Math.min(width, height) / 2, 0, 2 * Math.PI);
                ctx.stroke();

            }


        }

        Component.onCompleted:
        {
            //camera.start()
        }

        states: [
            State {
                name: "play"
                when: playVideo
                StateChangeScript {
                    script: {
                        camera.start()

                    }
                }
            },

            State {
                name: "stop"
                when: !playVideo
                StateChangeScript {
                    script: {
                        camera.stop()
                    }
                }
            }

        ]

    }

    Item{
        id: paControls
        x: 744
        y: 318
        width: 118
        height: 329


        TextCustom
        {
            id: textTitle

            text: "PA CONTROLS"
            anchors.left: pASettingsMini.left
            anchors.right: pASettingsMini.right
            anchors.top: parent.top
            anchors.bottom: textNumber.top
            anchors.leftMargin: 6
            anchors.rightMargin: -12
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            color: "white"
            font.styleName: "Bold"
            font.pointSize: 12
            font.weight: Font.ExtraBold


        }

        TextCustom
        {
            id: textNumber
            y: 29
            width: 67
            height: 25
            text: "PA"
            anchors.left: pASettingsMini.left
            anchors.bottom: pASettingsMini.top
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            color: "#00c310"
            font.styleName: "Bold"
            font.pointSize: 12
            font.weight: Font.ExtraBold

        }

        TextCustom
        {
            id: textStatus
            height: 25

            text: "POWER"
            anchors.right: pASettingsMini.right
            anchors.bottom: pASettingsMini.top
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            color: "#00c310"
            font.styleName: "Bold"
            font.pointSize: 12
            font.weight: Font.ExtraBold

        }

        PASettingsMini {
            id: pASettingsMini
            y: 54
            height: 275
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.bottomMargin: 0

            onDataChanged: {

                powerAmpNumber = _powerAmpNumber;
                powerAmpStatus = _powerAmpStatus;
                powerAmpAtten = 1
                itemTop.dataChanged(powerAmpNumber,powerAmpStatus,powerAmpAtten)
            }
        }

        TextCustom
        {
            id: textTitleStatus
            y: -324
            height: 23

            text: "PA MONITORING"
            anchors.left: pAStatusMini.left
            anchors.right: pAStatusMini.right
            anchors.bottom: pAStatusMini.top
            anchors.leftMargin: 3
            anchors.rightMargin: -3
            anchors.bottomMargin: 24
            color: "white"
            font.styleName: "Bold"
            font.pointSize: 12
            font.weight: Font.ExtraBold


        }

        TextCustom
        {
            id: textNumberStatus
            y: -302
            width: 55
            height: 25
            text: "PA"
            anchors.left: parent.left
            anchors.bottom: pAStatusMini.top
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            color: "#00c310"
            font.styleName: "Bold"
            font.pointSize: 12
            font.weight: Font.ExtraBold

        }

        TextCustom
        {
            id: textStatusStatus
            x: 60
            y: -302
            width: 50
            height: 25

            text: "STATUS"
            anchors.right: pAStatusMini.right
            anchors.bottom: pAStatusMini.top
            anchors.rightMargin: 8
            anchors.bottomMargin: 0
            color: "#00c310"
            font.styleName: "Bold"
            font.pointSize: 12
            font.weight: Font.ExtraBold

        }
        PAStatusMini{


            id: pAStatusMini
            y: -277
            height: 276
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.bottomMargin: 330

        }
    }

    onCurrentDataLocalChanged:   {
        pAStatusMini.currentDataForPAStatus = currentDataLocal
    }
}


