import QtQuick 2.5
import QtQuick.Controls 1.5
import QtQuick.Extras 1.4
import QtQuick.Window 2.0
import QtQuick.Controls.Styles 1.4

Window {
    id: root
    visible: true
    width: 1024
    height: 600
    color: "#000000"

    Row {
        id: gaugesRow1
        spacing: root.width * 0.02
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 20

        CircularGauge {
            id: throttleGauge
            width: root.width * 0.25 - gaugesRow1.spacing
            height: width
            minimumValue: -100
            maximumValue: 100
            style: DefaultGaugeStyle {
                unitText: "%"
                description: "Throttle"
                lowerDangerValue: -80
                upperDangerValue: 90
                coloredZones: true
            }
        }

        CircularGauge {
            id: torqueGauge
            width: root.width * 0.25 - gaugesRow1.spacing
            height: width
            minimumValue: -150
            maximumValue: 600
            style: DefaultGaugeStyle {
                unitText: "Nm"
                description: "Torque"
                upperDangerValue: 500
                coloredZones: true
            }
        }

        CircularGauge {
            id: currentGauge
            width: root.width * 0.25 - gaugesRow1.spacing
            height: width
            minimumValue: -200
            maximumValue: 400
            style: DefaultGaugeStyle {
                unitText: "A"
                description: "Pack Current"
                lowerDangerValue: -150
                upperDangerValue: 280
                coloredZones: true
            }
        }

        CircularGauge {
            id: rpmGauge
            width: root.width * 0.25 - gaugesRow1.spacing
            height: width
            maximumValue: 8
            style: TachGaugeStyle {
            }
        }
    }

    Row {
        id: gaugesRow2
        spacing: root.width * 0.02
        anchors.left: parent.left
        anchors.top: gaugesRow1.bottom
        anchors.topMargin: 20

        CircularGauge {
            id: dcvoltsGauge
            width: root.width * 0.25 - gaugesRow2.spacing
            height: width
            minimumValue: 200
            maximumValue: 450
            style: DefaultGaugeStyle {
                unitText: "V"
                description: "Pack Voltage"
                lowerDangerValue: 250
                upperDangerValue: 400
                coloredZones: true
            }
        }
        CircularGauge {
            id: powerGauge
            width: root.width * 0.25 - gaugesRow2.spacing
            height: width
            minimumValue: -50
            maximumValue: 250
            style: DefaultGaugeStyle {
                unitText: "kW"
                description: "Power"
                upperDangerValue: 150
                coloredZones: true
            }
        }
    }

    Column {
        id: gaugesCol1
        spacing: root.height * 1
    }


    CircularGauge {
        id: motorTempGauge
        x: 710
        y: 373
        width: 140
        height: 140
        maximumValue: 1
        style: IconGaugeStyle {
            id: motorGaugeStyle
            description: "Motor Temp"

            icon: "qrc:/images/temperature-icon.png"
            maxWarningColor: Qt.rgba(0.5, 0, 0, 1)

            tickmarkLabel: Text {
                color: "white"
                visible: styleData.value === 0 || styleData.value === 1
                font.pixelSize: motorGaugeStyle.toPixels(0.225)
                text: styleData.value === 0 ? "C" : (styleData.value === 1 ? "H" : "")
            }
        }
    }

    CircularGauge {
        id: controllerTempGauge
        x: 710
        y: 471
        width: 140
        height: 140
        maximumValue: 1
        style: IconGaugeStyle {
            id: controllerGaugeStyle
            description: "Controller Temp"

            icon: "qrc:/images/temperature-icon.png"
            maxWarningColor: Qt.rgba(0.5, 0, 0, 1)

            tickmarkLabel: Text {
                color: "white"
                visible: styleData.value === 0 || styleData.value === 1
                font.pixelSize: controllerGaugeStyle.toPixels(0.225)
                text: styleData.value === 0 ? "C" : (styleData.value === 1 ? "H" : "")
            }
        }
    }

    CircularGauge {
        id: energyGauge
        x: 710
        y: 255
        width: 140
        height: 140
        maximumValue: 1
        style: IconGaugeStyle {
            id: energyGaugeStyle
            description: "Battery Capacity"

            icon: "qrc:/images/fuel-icon.png"
            minWarningColor: Qt.rgba(0.5, 0, 0, 1)

            tickmarkLabel: Text {
                color: "white"
                visible: styleData.value === 0 || styleData.value === 1
                font.pixelSize: energyGaugeStyle.toPixels(0.225)
                text: styleData.value === 0 ? "E" : (styleData.value === 1 ? "F" : "")
            }
        }
    }



    StatusIndicator {
        id: statusInput1
        x: 123
        y: 453
    }

    Label {
        id: label1
        x: 19
        y: 457
        color: "#1fcaff"
        text: qsTr("Inputs:")
        font.pointSize: 15
    }

    StatusIndicator {
        id: statusInput2
        x: 180
        y: 453
    }

    StatusIndicator {
        id: statusInput3
        x: 236
        y: 453
    }

    StatusIndicator {
        id: statusInput4
        x: 293
        y: 453
    }

    Label {
        id: label2
        x: 19
        y: 505
        color: "#1fcaff"
        text: qsTr("Outputs:")
        font.pointSize: 15
    }

    StatusIndicator {
        id: statusOutput1
        x: 123
        y: 501
    }

    StatusIndicator {
        id: statusOutput2
        x: 180
        y: 501
    }

    StatusIndicator {
        id: statusOutput3
        x: 236
        y: 501
    }

    StatusIndicator {
        id: statusOutput4
        x: 293
        y: 501
    }

    StatusIndicator {
        id: statusOutput5
        x: 349
        y: 501
    }

    StatusIndicator {
        id: statusOutput6
        x: 406
        y: 501
    }

    StatusIndicator {
        id: statusOutput7
        x: 462
        y: 501
    }

    StatusIndicator {
        id: statusOutput8
        x: 519
        y: 501
    }

    Label {
        id: label3
        x: 19
        y: 554
        color: "#1fcaff"
        text: qsTr("System Status:")
        font.pointSize: 15
    }

    StatusIndicator {
        id: statusSystem
        x: 180
        y: 554
    }
}
