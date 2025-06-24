import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: actionButtonRoot
    property string iconSource
    property var clickedHandler: null
    default property alias customStates: actionButton.states

    implicitHeight: actionButton.height
    implicitWidth: actionButton.width

    Button {
        id: actionButton
        height: 35
        width: 35
        hoverEnabled: true
        onClicked: {
            if (clickedHandler) clickedHandler()
        }

        icon {
            source: Qt.resolvedUrl(iconSource)
            height: parent.height
            width: parent.width
            color: config.foreground
        }

        background: Rectangle {
            id: actionButtonBackground
            radius: 15
            color: config.background
        }

        states: [
            State {
                name: "hovered"
                when: actionButton.hovered
                PropertyChanges {
                    target: actionButtonBackground
                    color: config.backgroundLight
                }
            }
        ]

        transitions: Transition {
            PropertyAnimation {
                properties: "color"
                duration: 150
            }
        }
    }
}

