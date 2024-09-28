import QtQuick
import QtMultimedia

Item {


    property bool playVideo: false

    Rectangle {
        id : cameraUI

        anchors.fill: parent
        color: "transparent"


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
            fillMode: VideoOutput.Stretch
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


