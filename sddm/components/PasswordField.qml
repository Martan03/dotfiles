import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
    id: passwordField
    focus: true
    selectByMouse: true
    placeholderText: "Input password..."
    echoMode: TextInput.Password
    passwordCharacter: "•"
    passwordMaskDelay: config.PasswordShowLastLetter
    selectionColor: config.selection
    renderType: Text.NativeRendering
    font.family: config.Font
    font.pointSize: config.FontSize
    font.bold: true
    color: config.foreground
    horizontalAlignment: TextInput.AlignHCenter
    width: 200
    height: 50

    Rectangle {
        id: gradientBorder
        anchors.fill: parent
        radius: 15
        gradient: Gradient {
            GradientStop { position: 0.0; color: config.inputGradStart }
            GradientStop { position: 1.0; color: config.inputGradEnd }
        }
        z: -2
    }

    background: Rectangle {
        id: passFieldBackground
        anchors.fill: parent
        anchors.margins: 3
        radius: 13
        color: config.background
        z: -1
    }

    states: [
        State {
            name: "focused"
            when: passwordField.activeFocus
            PropertyChanges {
                target: passFieldBackground
                color: config.backgroundLight
            }
        },
        State {
            name: "hovered"
            when: passwordField.hovered
            PropertyChanges {
                target: passFieldBackground
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
