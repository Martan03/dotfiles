import QtQuick 2.15
import SddmComponents 2.0

Item {
    id: clockRoot
    anchors.fill: parent

    Timer {
        id: clockTimer
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            timeLabel.text = Qt.formatTime(new Date(), "hh:mm")
            dateLabel.text = Qt.formatDate(new Date(), "dddd, dd MMMM yyyy")
        }
    }

    // TIME
    Text {
        id: timeLabel
        text: Qt.formatTime(new Date(), "hh:mm")
        color: config.foreground
        font.family: config.Font
        font.pixelSize: 125
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
            verticalCenterOffset: -150
        }
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignTop
    }

    // DATE
    Text {
        id: dateLabel
        text: Qt.formatDate(new Date(), "dddd, dd MMMM yyyy")
        color: config.foreground
        font.family: config.Font
        font.pixelSize: 35
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: timeLabel.bottom
        }
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignTop
    }
}
