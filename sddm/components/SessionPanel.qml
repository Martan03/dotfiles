import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQml.Models 2.15

Item {
    property var session: sessionList.currentIndex

    implicitHeight: sessionRow.height
    implicitWidth: sessionRow.width

    DelegateModel {
        id: sessionWrapper
        model: sessionModel
        delegate: ItemDelegate {
            id: sessionEntry
            height: inputHeight
            width: parent.width
            highlighted: sessionList.currentIndex == index

            contentItem: Text {
                renderType: Text.NativeRendering
                font.family: config.Font
                font.pointSize: config.FontSize
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: config.foreground
                text: name
            }

            background: Rectangle {
                id: sessionEntryBackground
                color: config.background
                radius: 3
            }

            states: [
                State {
                    name: "hovered"
                    when: sessionEntry.hovered
                    PropertyChanges {
                        target: sessionEntryBackground
                        color: config.backgroundLight
                    }
                }
            ]

            transitions: Transition {
                PropertyAnimation {
                    property: "color"
                    duration: 150
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    sessionList.currentIndex = index
                    sessionPopup.close()
                }
            }
        }
    }

    Row {
        id: sessionRow
        spacing: 8
        anchors.verticalCenter: parent.verticalCenter

        Text {
            id: currentSessionLabel
            renderType: Text.NativeRendering
            font.family: config.Font
            font.pointSize: config.FontSize
            color: config.foreground
            verticalAlignment: Text.AlignVCenter
            text: sessionList.currentIndex >= 0 && sessionList.currentIndex < sessionModel.count
                ? sessionModel.get(sessionList.currentIndex).name
                : sessionModel.get(sessionList.lastIndex).name
        }

        ActionButton {
            id: sessionButton
            iconSource: "../icons/settings.svg"
            clickedHandler: function() {
                sessionPopup.visible ? sessionPopup.close() : sessionPopup.open()
            }

            states: [
                State {
                    name: "pressed"
                    when: sessionButton.down
                    PropertyChanges {
                        target: actionButtonBackground
                        color: config.backgroundLight
                    }
                },
                State {
                    name: "hovered"
                    when: sessionButton.hovered
                    PropertyChanges {
                        target: actionButtonBackground
                        color: config.backgroundLight
                    }
                },
                State {
                    name: "selection"
                    when: sessionPopup.visible
                    PropertyChanges {
                        target: actionButtonBackground
                        color: config.backgroundLight
                    }
                }
            ]
        }
    }


    Popup {
        id: sessionPopup
        width: inputWidth + padding * 2
        x: (sessionButton.width + sessionList.spacing) * -7.6
        y: -(contentHeight + padding * 2) + sessionButton.height
        padding: 10

        background: Rectangle {
            radius: 15
            color: config.background
        }

        contentItem: ListView {
            id: sessionList
            implicitHeight: contentHeight
            spacing: 8
            model: sessionWrapper
            currentIndex: sessionModel.lastIndex
            clip: true
        }

        enter: Transition {
            ParallelAnimation {
                NumberAnimation {
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 400
                    easing.type: Easing.OutExpo
                }
                NumberAnimation {
                    property: "x"
                    from: sessionPopup.x + (inputWidth * 0.1)
                    to: sessionPopup.x
                    duration: 500
                    easing.type: Easing.OutExpo
                }
            }
        }

        exit: Transition {
            NumberAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 300
                easing.type: Easing.OutExpo
            }
        }
    }
}
