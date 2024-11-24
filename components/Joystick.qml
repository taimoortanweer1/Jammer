import QtQuick 2.15

Item {
    id: joystick
          width: 200
          height: 200
          anchors.centerIn: parent

          // Outer circle
          Rectangle {
              id: outerCircle
              anchors.fill: parent
              color: "transparent"
              border.width: 2
              border.color: "#00C310"
              radius: 100
          }

          // Inner circle
          Rectangle {
              id: innerCircle
              x: joystick.width / 2 - width / 2
              y: joystick.height / 2 - height / 2
              width: 30
              height: 30
              color: "#00C310"
              radius: 15
              border.width: 0

              // Mouse area for dragging
              MouseArea {
                  id: mouseArea
                  anchors.fill: parent
                  drag.target: innerCircle
                  drag.minimumX: outerCircle.x
                  drag.maximumX: outerCircle.x + outerCircle.width - innerCircle.width
                  drag.minimumY: outerCircle.y
                  drag.maximumY: outerCircle.y + outerCircle.height - innerCircle.height

                  onReleased: {
                      // Animate inner circle back to center
                      animX.running = true
                      animY.running = true
                  }
              }

              // Animations to move inner circle back to center
              NumberAnimation {
                  id: animX
                  target: innerCircle
                  property: "x"
                  to: joystick.width / 2 - innerCircle.width / 2
                  duration: 200
                  easing.type: Easing.OutQuad
              }

              NumberAnimation {
                  id: animY
                  target: innerCircle
                  property: "y"
                  to: joystick.height / 2 - innerCircle.height / 2
                  duration: 200
                  easing.type: Easing.OutQuad
              }
          }
      }
