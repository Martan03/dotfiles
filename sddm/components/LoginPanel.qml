import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Item {
    property var user: userModel.lastUser
    property var password: passwordField.text
    property var session: sessionPanel.session

    property var inputHeight: Screen.height * 0.05
    property var inputWidth: Screen.width * 0.2

    PasswordField {
        id: passwordField
        height: inputHeight
        width: inputWidth
        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
            verticalCenterOffset: 100
        }
        onAccepted: {
            if (user !== "" && password !== "") {
                sddm.login(user, password, session)
            }
        }
    }

    Row {
        spacing: 8
        z: 5
        anchors {
            bottom: parent.bottom
            left: parent.left
            leftMargin: 10
            bottomMargin: 10
        }

        ActionButton {
            iconSource: "../icons/power.svg"
            clickedHandler: sddm.powerOff
        }
        ActionButton {
            iconSource: "../icons/reboot.svg"
            clickedHandler: sddm.reboot
        }
        ActionButton {
            iconSource: "../icons/sleep.svg"
            clickedHandler: sddm.suspend
        }
    }

    SessionPanel {
        id: sessionPanel
        z: 5
        anchors {
            bottom: parent.bottom
            right: parent.right
            rightMargin: 10
            bottomMargin: 10
        }
    }

    Connections {
        target: sddm

        function onLoginFailed() {
            passwordField.text = ""
            passwordField.focus = true
        }
    }
}

