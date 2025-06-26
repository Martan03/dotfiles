import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import Qt5Compat.GraphicalEffects

import "components"

Item {
    id: root
    width: Screen.width
    height: Screen.height

    Rectangle {
        id: background
        anchors.fill: parent
        z: 0
        color: config.background
    }

    Image {
        id: backgroundImage
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        visible: false
        source: config.Background
        cache: true
        mipmap: true
        clip: true
    }

    FastBlur {
        anchors.fill: parent
        source: backgroundImage
        radius: 64
    }

    Item {
        id: mainPanel
        anchors.fill: parent
        z: 2

        Clock {
            visible: config.ClockEnabled == "true"
        }
        LoginPanel {
            anchors.fill: parent
        }
    }
}
