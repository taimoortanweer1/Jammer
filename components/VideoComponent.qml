import QtQuick
import QtMultimedia

Item {


    property bool playVideo: false



    Rectangle {
        id:    cameraUI
        x: 40
        y: -60
        width: 600
        height: 600


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
                text: "23.44"

            }
            Text {
                id: elev
                text: "23.44"
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





}


