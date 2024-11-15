import QtQuick
import QtMultimedia

Item {


    property bool playVideo: false
    width: 900
    height: 650


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
                text: "Elev : 23.44"
                color: "white"

            }



            Text {
                id: elev
                x: 8
                y: 30
                width: 62
                height: 25
                text: "Azim : 23.44"
                color: "white"
            }

            Item
            {
                id: directionItem
                height: 120
                width: 120
               // anchors.right: parent.right
              //  anchors.top: parent.top
                anchors.rightMargin: 10
                anchors.topMargin: 10


                Image {
                    id: arrow
                    x: 35
                    width: 50
                    height: 70
                    anchors.verticalCenter: parent.verticalCenter
                    source: "qrc:/assets/images/arrow.png"
                    fillMode: Image.PreserveAspectFit
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
        id: paControl123


        TextCustom
        {
            id: textRow0
            y: 291
            height: 25
            text: "PA Controls"
            anchors.left: pASettingsMini.left
            anchors.right: pASettingsMini.right
            anchors.bottom: textRow1.top
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            color: "white"
            font.styleName: "Bold"
            font.pointSize: 12
            font.weight: Font.ExtraBold


        }

        TextCustom
        {
            id: textRow1
            y: 322
            height: 25
            text: "PA #"
            anchors.left: pASettingsMini.left
            anchors.right: textRow2.left
            anchors.bottom: pASettingsMini.top
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            color: "green"
            font.styleName: "Bold"
            font.pointSize: 12
            font.weight: Font.ExtraBold

        }

        TextCustom
        {
            id: textRow2
            y: 322
            height: 25
            text: "Status"
            anchors.left: textRow1.left
            anchors.right: pASettingsMini.right
            anchors.bottom: pASettingsMini.top
            anchors.leftMargin: 59
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            color: "green"
            font.styleName: "Bold"
            font.pointSize: 12
            font.weight: Font.ExtraBold

        }

        PASettingsMini {
            id: pASettingsMini
            x: 745
            y: 347
            width: 115
            height: 275
        }
    }





}


