/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.2
import QtQuick.Controls.Styles 1.4

CircularGaugeStyle {
    tickmarkInset: toPixels(0.04)
    minorTickmarkInset: tickmarkInset
    labelStepSize: tickmarkStepSize
    tickmarkStepSize: (parent.maximumValue - parent.minimumValue) / 8
    labelInset: toPixels(0.23)

    property real xCenter: outerRadius
    property real yCenter: outerRadius
    property real needleLength: outerRadius - tickmarkInset * 1.25
    property real needleTipWidth: toPixels(0.02)
    property real needleBaseWidth: toPixels(0.06)
    property bool halfGauge: false
    property color negColor: Qt.rgba(0, 0, 0.6, 0.5)
    property color posColor: Qt.rgba(0, 0.6, 0, 0.5)
    property color dangerColor: Qt.rgba(1, 0, 0, 0.5)
    property bool coloredZones: false
    property real lowerDangerValue: -1000 //value where gauge turns red at low end
    property real upperDangerValue: 1000 //value where gauge turns red at upper end
    property string description;
    property string unitText;

    function toPixels(percentage) {
        return percentage * outerRadius;
    }

    function degToRad(degrees) {
        return degrees * (Math.PI / 180);
    }

    function radToDeg(radians) {
        return radians * (180 / Math.PI);
    }

    function paintBackground(ctx) {
        if (halfGauge) {
            ctx.beginPath();
            ctx.rect(0, 0, ctx.canvas.width, ctx.canvas.height / 2);
            ctx.clip();
        }

        ctx.beginPath();
        ctx.fillStyle = "black";
        ctx.ellipse(0, 0, ctx.canvas.width, ctx.canvas.height);
        ctx.fill();

        ctx.beginPath();
        ctx.lineWidth = tickmarkInset;
        ctx.strokeStyle = "black";
        ctx.arc(xCenter, yCenter, outerRadius - ctx.lineWidth / 2, outerRadius - ctx.lineWidth / 2, 0, Math.PI * 2);
        ctx.stroke();

        ctx.beginPath();
        ctx.lineWidth = tickmarkInset / 2;
        ctx.strokeStyle = "#222";
        ctx.arc(xCenter, yCenter, outerRadius - ctx.lineWidth / 2, outerRadius - ctx.lineWidth / 2, 0, Math.PI * 2);
        ctx.stroke();

        ctx.beginPath();
        var gradient = ctx.createRadialGradient(xCenter, yCenter, outerRadius * 0.8, xCenter, yCenter, outerRadius);
        gradient.addColorStop(0, Qt.rgba(1, 1, 1, 0));
        gradient.addColorStop(0.7, Qt.rgba(1, 1, 1, 0.23));
        gradient.addColorStop(1, Qt.rgba(1, 1, 1, 1));
        ctx.fillStyle = gradient;
        ctx.arc(xCenter, yCenter, outerRadius - tickmarkInset, outerRadius - tickmarkInset, 0, Math.PI * 2);
        ctx.fill();

        ctx.beginPath();
        var gradient2 = ctx.createRadialGradient(xCenter, yCenter, 0, xCenter, yCenter, outerRadius * 0.08);
        gradient2.addColorStop(0, Qt.rgba(1, 0, 0, 1));
        gradient2.addColorStop(0.7, Qt.rgba(.5, 0, 0, 1));
        gradient2.addColorStop(1, Qt.rgba(0, 0, 0, 1));
        ctx.fillStyle = gradient2;
        ctx.arc(xCenter, yCenter, outerRadius * 0.08, outerRadius * 0.08, 0, Math.PI * 2);
        ctx.fill();

        if (coloredZones)
        {
            var startLowerDanger = minimumValueAngle;
            var endLowerDanger = minimumValueAngle;
            if (lowerDangerValue > parent.minimumValue) endLowerDanger = valueToAngle(lowerDangerValue);
            var startNegZone = endLowerDanger;
            var endNegZone = minimumValueAngle;
            if (parent.minimumValue < 0) endNegZone = valueToAngle(0);
            if (endNegZone < endLowerDanger) endNegZone = endLowerDanger;
            var startPosZone = endNegZone;
            var endPosZone = maximumValueAngle;
            var startUpperDanger = maximumValueAngle;
            var endUpperDanger = maximumValueAngle;
            if (upperDangerValue < parent.maximumValue)
            {
                startUpperDanger = valueToAngle(upperDangerValue);
                endPosZone = startUpperDanger;
            }

            //if we have to draw the lower danger zone then that's first up
            if (endLowerDanger > startLowerDanger)
            {
                ctx.beginPath();
                ctx.strokeStyle = dangerColor;
                ctx.lineWidth = outerRadius * 0.15;

                ctx.arc(outerRadius, outerRadius, outerRadius - ctx.lineWidth / 1.2,
                    degToRad(startLowerDanger - 90), degToRad(endLowerDanger - 90));
                ctx.stroke();
            }
            //if we have to draw a negative region then that's next
            if (endNegZone > startNegZone)
            {
                ctx.beginPath();
                ctx.strokeStyle = negColor;
                ctx.lineWidth = outerRadius * 0.15;

                ctx.arc(outerRadius, outerRadius, outerRadius - ctx.lineWidth / 1.2,
                    degToRad(startNegZone - 90), degToRad(endNegZone - 90));
                ctx.stroke();
            }
            //if we have to draw a positive region then that's next
            if (endPosZone > startPosZone)
            {
                ctx.beginPath();
                ctx.strokeStyle = posColor;
                ctx.lineWidth = outerRadius * 0.15;

                ctx.arc(outerRadius, outerRadius, outerRadius - ctx.lineWidth / 1.2,
                    degToRad(startPosZone - 90), degToRad(endPosZone - 90));
                ctx.stroke();
            }

            //Lastly, if there is an upper danger region then draw it
            if (endUpperDanger > startUpperDanger)
            {
                ctx.beginPath();
                ctx.strokeStyle = dangerColor;
                ctx.lineWidth = outerRadius * 0.15;

                ctx.arc(outerRadius, outerRadius, outerRadius - ctx.lineWidth /1.2,
                    degToRad(startUpperDanger - 90), degToRad(endUpperDanger - 90));
                ctx.stroke();
            }
        }
    }

    background: Canvas {
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            paintBackground(ctx);
        }
        Text {
            id: unit
            font.pixelSize: toPixels(0.15);
            text: unitText
            color: "white"
            anchors.top: valueText.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.verticalCenter
            anchors.topMargin: -toPixels(0.07)
            rotation: 90
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#797979" }
                GradientStop { position: 0.1; color: "#595959" }
                GradientStop { position: 0.5; color: "#797979" }
                GradientStop { position: 0.9; color: "#595959" }
                GradientStop { position: 1.0; color: "#797979" }
            }
            implicitWidth: parent.height / 7
            implicitHeight: parent.width / 3
        }

        Text {
            id: valueText
            font.pixelSize: toPixels(0.25)
            text: theVal
            color: "white"
            horizontalAlignment: Text.AlignRight
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.verticalCenter
            anchors.topMargin: toPixels(0.1)

            readonly property int theVal: control.value
        }
        Text {
            id: descText
            text: description
            color: "white"
            font.pixelSize: toPixels(0.18)
            horizontalAlignment: Text.AlignRight
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.verticalCenter
            anchors.topMargin: -toPixels(0.3)
        }
    }

    needle: Canvas {
        implicitWidth: needleBaseWidth
        implicitHeight: needleLength

        property real xCenter: width / 2
        property real yCenter: height / 2

        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();

            ctx.beginPath();
            ctx.moveTo(xCenter, height);
            ctx.lineTo(xCenter - needleBaseWidth / 2, height - needleBaseWidth / 2);
            ctx.lineTo(xCenter - needleTipWidth / 2, 0);
            ctx.lineTo(xCenter, yCenter - needleLength);
            ctx.lineTo(xCenter, 0);
            ctx.closePath();
            ctx.fillStyle = Qt.rgba(0.66, 0, 0, 0.66);
            ctx.fill();

            ctx.beginPath();
            ctx.moveTo(xCenter, height)
            ctx.lineTo(width, height - needleBaseWidth / 2);
            ctx.lineTo(xCenter + needleTipWidth / 2, 0);
            ctx.lineTo(xCenter, 0);
            ctx.closePath();
            ctx.fillStyle = Qt.lighter(Qt.rgba(0.66, 0, 0, 0.66));
            ctx.fill();
        }
    }

    foreground: null

    tickmarkLabel:  Text {
        font.pixelSize: Math.max(6, outerRadius * 0.1)
        text: Math.round(styleData.value)
        color: "white"
        antialiasing: true
    }
}
