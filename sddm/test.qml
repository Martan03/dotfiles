import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

import "components"

Item {
    id: root
    width: Screen.width
    height: Screen.height

    Rectangle {
        anchors.fill: parent
        color: config.background
    }

    Image {
        id: backgroundImage
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: config.Background
        cache: true
    }

    ShaderEffectSource {
        id: pass1Source
        sourceItem: backgroundImage
        hideSource: true
        live: true
    }
    ShaderEffect {
        id: blurH
        anchors.fill: parent
        property variant source: pass1Source
        fragmentShader: "
            uniform sampler2D source;
            varying vec2 qt_TexCoord0;
            const float offset = 1.0 / 512.0;
            vec4 blur(vec2 tc) {
                vec4 c = vec4(0.0);
                c += texture2D(source, tc + vec2(-4.0*offset, 0.0)) * 0.05;
                c += texture2D(source, tc + vec2(-3.0*offset, 0.0)) * 0.09;
                c += texture2D(source, tc + vec2(-2.0*offset, 0.0)) * 0.12;
                c += texture2D(source, tc + vec2(-1.0*offset, 0.0)) * 0.15;
                c += texture2D(source, tc                          ) * 0.18;
                c += texture2D(source, tc + vec2( 1.0*offset, 0.0)) * 0.15;
                c += texture2D(source, tc + vec2( 2.0*offset, 0.0)) * 0.12;
                c += texture2D(source, tc + vec2( 3.0*offset, 0.0)) * 0.09;
                c += texture2D(source, tc + vec2( 4.0*offset, 0.0)) * 0.05;
                return c;
            }
            void main() {
                gl_FragColor = blur(qt_TexCoord0);
            }
        "
    }

    ShaderEffectSource {
        id: pass2Source
        sourceItem: blurH
        hideSource: true
        live: true
    }
    ShaderEffect {
        anchors.fill: parent
        property variant source: pass2Source
        fragmentShader: "
            uniform sampler2D source;
            varying vec2 qt_TexCoord0;
            const float offset = 1.0 / 512.0;
            vec4 blur(vec2 tc) {
                vec4 c = vec4(0.0);
                c += texture2D(source, tc + vec2(0.0, -4.0*offset)) * 0.05;
                c += texture2D(source, tc + vec2(0.0, -3.0*offset)) * 0.09;
                c += texture2D(source, tc + vec2(0.0, -2.0*offset)) * 0.12;
                c += texture2D(source, tc + vec2(0.0, -1.0*offset)) * 0.15;
                c += texture2D(source, tc                          ) * 0.18;
                c += texture2D(source, tc + vec2(0.0,  1.0*offset)) * 0.15;
                c += texture2D(source, tc + vec2(0.0,  2.0*offset)) * 0.12;
                c += texture2D(source, tc + vec2(0.0,  3.0*offset)) * 0.09;
                c += texture2D(source, tc + vec2(0.0,  4.0*offset)) * 0.05;
                return c;
            }
            void main() {
                gl_FragColor = blur(qt_TexCoord0);
            }
        "
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
