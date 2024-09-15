import QtQuick 6.7

Item {
    id: root
    width: 50
    height: 50

    property int signalBarValue: 30
    Row {
        id: row
        width: parent.width
        height: parent.height
        rotation: 180
        spacing: 2
        layoutDirection: Qt.RightToLeft


        Rectangle {

            id: rect1
            width: parent.width/5
            height: 10
            color: "#ffffff"
            border.color: "#ffffff"
        }

        Rectangle {
            id: rect2
            width: parent.width/5
            height: 20
            color: "#ffffff"
            border.color: "#ffffff"
        }

        Rectangle {
            id: rect3
            width: parent.width/5
            height: 30
            color: "#ffffff"
            border.color: "#ffffff"
        }

        Rectangle {
            id: rect4
            width: parent.width/5
            height: 40
            color: "#ffffff"
            border.color: "#ffffff"
        }
    }
    states: [
        State {
            name: "State1"
            when: root.signalBarValue < 20
            PropertyChanges { target: rect1; color: "#ffffff";    border.color: "#ffffff" }
            PropertyChanges { target: rect2; color: "#00ffffff";  border.color: "#ffffff" }
            PropertyChanges { target: rect3; color: "#00ffffff";  border.color: "#ffffff" }
            PropertyChanges { target: rect4; color: "#00ffffff";  border.color: "#ffffff" }
        },

        State {
            name: "State2"
            when: root.signalBarValue < 50
            PropertyChanges { target: rect1; color: "#ffffff";    border.color: "#ffffff" }
            PropertyChanges { target: rect2; color: "#ffffff";    border.color: "#ffffff" }
            PropertyChanges { target: rect3; color: "#00ffffff";  border.color: "#ffffff" }
            PropertyChanges { target: rect4; color: "#00ffffff";  border.color: "#ffffff" }
        },

        State {
            name: "State3"
            when: root.signalBarValue < 80
            PropertyChanges { target: rect1; color: "#ffffff";    border.color: "#ffffff" }
            PropertyChanges { target: rect2; color: "#ffffff";    border.color: "#ffffff" }
            PropertyChanges { target: rect3; color: "#ffffff";    border.color: "#ffffff" }
            PropertyChanges { target: rect4; color: "#00ffffff";  border.color: "#ffffff" }
        },

        State {
            name: "State4"
            when: root.signalBarValue < 100
            PropertyChanges { target: rect1; color: "#ffffff";    border.color: "#ffffff" }
            PropertyChanges { target: rect2; color: "#ffffff";    border.color: "#ffffff" }
            PropertyChanges { target: rect3; color: "#ffffff";    border.color: "#ffffff" }
            PropertyChanges { target: rect4; color: "#ffffff";    border.color: "#ffffff" }
        }


    ]



}

/*##^##
Designer {
    D{i:0;formeditorColor:"#00000c"}
}
##^##*/
