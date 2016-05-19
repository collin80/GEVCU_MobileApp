import QtQuick 2.5
import QtQuick.Controls 1.5
import QtQuick.Extras 1.4
import QtQuick.Window 2.0
import QtQuick.Controls.Styles 1.4
import Qt.labs.controls 1.0

Window {
    id: root
    visible: true
    width: 1920
    height: 1080
    color: "#000000"

    SwipeView {
        id: swipedView

        currentIndex: 0
        anchors.fill: parent

        Item {
            //Bunch o' gauges
            id: firstPage

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

            Row {
                id: gaugesRow3
                spacing: root.width * 0.1
                anchors.left: gaugesRow2.right
                anchors.top: gaugesRow1.bottom
                anchors.topMargin: 120
                anchors.leftMargin: 50

                CircularGauge {
                    id: motorTempGauge
                    width: root.height / 8
                    height: width
                    maximumValue: 1
                    style: IconGaugeStyle {
                        id: motorGaugeStyle
                        description: "Motor Temp"

                        icon: "qrc:/images/temperature-icon.png"
                        maxWarningColor: Qt.rgba(0.5, 0, 0, 1)

                        tickmarkLabel: Text {
                            color: "white"
                            visible: styleData.value === 0
                                     || styleData.value === 1
                            font.pixelSize: motorGaugeStyle.toPixels(0.225)
                            text: styleData.value === 0 ? "C" : (styleData.value === 1 ? "H" : "")
                        }
                    }
                }

                CircularGauge {
                    id: controllerTempGauge
                    width: root.height / 8
                    height: width
                    maximumValue: 1
                    style: IconGaugeStyle {
                        id: controllerGaugeStyle
                        description: "Controller Temp"

                        icon: "qrc:/images/temperature-icon.png"
                        maxWarningColor: Qt.rgba(0.5, 0, 0, 1)

                        tickmarkLabel: Text {
                            color: "white"
                            visible: styleData.value === 0
                                     || styleData.value === 1
                            font.pixelSize: controllerGaugeStyle.toPixels(0.225)
                            text: styleData.value === 0 ? "C" : (styleData.value === 1 ? "H" : "")
                        }
                    }
                }

                CircularGauge {
                    id: energyGauge
                    width: root.height / 8
                    height: width
                    maximumValue: 1
                    style: IconGaugeStyle {
                        id: energyGaugeStyle
                        description: "Battery Capacity"

                        icon: "qrc:/images/fuel-icon.png"
                        minWarningColor: Qt.rgba(0.5, 0, 0, 1)

                        tickmarkLabel: Text {
                            color: "white"
                            visible: styleData.value === 0
                                     || styleData.value === 1
                            font.pixelSize: energyGaugeStyle.toPixels(0.225)
                            text: styleData.value === 0 ? "E" : (styleData.value === 1 ? "F" : "")
                        }
                    }
                }
            }

            Row {
                id: statusRow1
                spacing: root.width * 0.025
                anchors.left: gaugesRow2.right
                anchors.top: gaugesRow3.bottom
                anchors.topMargin: 20
                anchors.leftMargin: 50

                Label {
                    id: label1
                    color: "#1fcaff"
                    text: qsTr("Inputs:")
                    font.pointSize: 15
                }

                StatusIndicator {
                    id: statusInput1
                }

                StatusIndicator {
                    id: statusInput2
                }

                StatusIndicator {
                    id: statusInput3
                }

                StatusIndicator {
                    id: statusInput4
                }
            }

            Row {
                id: statusRow2
                spacing: root.width * 0.025
                anchors.left: gaugesRow2.right
                anchors.top: statusRow1.bottom
                anchors.topMargin: 20
                anchors.leftMargin: 50

                Label {
                    id: label2
                    color: "#1fcaff"
                    text: qsTr("Outputs:")
                    font.pointSize: 15
                }

                StatusIndicator {
                    id: statusOutput1
                }

                StatusIndicator {
                    id: statusOutput2
                }

                StatusIndicator {
                    id: statusOutput3
                }

                StatusIndicator {
                    id: statusOutput4
                }

                StatusIndicator {
                    id: statusOutput5
                }

                StatusIndicator {
                    id: statusOutput6
                }

                StatusIndicator {
                    id: statusOutput7
                }

                StatusIndicator {
                    id: statusOutput8
                }
            }

            Row {
                id: statusRow3
                spacing: root.width * 0.025
                anchors.left: gaugesRow2.right
                anchors.top: statusRow2.bottom
                anchors.topMargin: 20
                anchors.leftMargin: 50

                Label {
                    id: label3
                    color: "#1fcaff"
                    text: qsTr("System Status:")
                    font.pointSize: 15
                }

                StatusIndicator {
                    id: statusSystem
                }
            }
        }
        Item {
            //general configuration page
            id: secondPage
            Label {
                id: label10
                color: "#1fcaff"
                text: qsTr("Throttle:")
                font.pointSize: 15
                anchors.top: secondPage.top
                anchors.left: secondPage.left
            }
            Row {
                id: configRow1
                spacing: root.width / 20
                anchors.left: secondPage.left
                anchors.top: label10.bottom
                anchors.topMargin: 20
                anchors.leftMargin: 50
                Label {
                    id: label11
                    color: "#1fcaff"
                    text: qsTr("Num of throttle pots:")
                    font.pointSize: 15
                }
                ComboBox {
                    id: cbNumPots
                    model: [ "1","2" ]
                }
                Label {
                    id: label12
                    color: "#1fcaff"
                    text: qsTr("Throttle type:")
                    font.pointSize: 15
                }
                ComboBox {
                    id: cbThrottleType
                    model: [ "Std Pot", "Inv Pot", "Hall Effect" ]
                    implicitWidth: 200
                }

            }

            Row {
                id: configRow2
                spacing: root.width / 20
                anchors.left: secondPage.left
                anchors.top: configRow1.bottom
                anchors.topMargin: 20
                anchors.leftMargin: 50
                Label {
                    id: label13
                    color: "#1fcaff"
                    text: qsTr("Min Level Sig 1")
                    font.pointSize: 15
                }
                SliderWithText {
                    id: sliderMinSig1
                    minimumValue: 0
                    maximumValue: 65536
                    stepSize: 10
                    implicitWidth: root.width / 4
                }
               Label {
                    id: label14
                    color: "#1fcaff"
                    text: qsTr("Regen Max Pedal Position")
                    font.pointSize: 15
                }
               SliderWithText {
                   id: sliderRegenMaxPedal
                   minimumValue: 0
                   maximumValue: 100
                   stepSize: 1
                   implicitWidth: root.width / 4

               }

            }

            Row {
                id: configRow3
                spacing: root.width / 20
                anchors.left: secondPage.left
                anchors.top: configRow2.bottom
                anchors.topMargin: 20
                anchors.leftMargin: 50
                Label {
                    id: label15
                    color: "#1fcaff"
                    text: qsTr("Max Level Sig 1")
                    font.pointSize: 15
                }
                SliderWithText {
                    minimumValue: 0
                    maximumValue: 65536
                    stepSize: 10
                    id: sliderMaxSig1
                    implicitWidth: root.width / 4
                }
               Label {
                    id: label16
                    color: "#1fcaff"
                    text: qsTr("Regen Min Pedal Position")
                    font.pointSize: 15
                }
               SliderWithText {
                   id: sliderRegenMinPedal
                   minimumValue: 0
                   maximumValue: 65536
                   stepSize: 10
                   implicitWidth: root.width / 4
               }

            }
            Row {
                id: configRow4
                spacing: root.width / 20
                anchors.left: secondPage.left
                anchors.top: configRow3.bottom
                anchors.topMargin: 20
                anchors.leftMargin: 50
                Label {
                    id: label17
                    color: "#1fcaff"
                    text: qsTr("Min Level Sig 2")
                    font.pointSize: 15
                }
                SliderWithText {
                    id: sliderMinSig2
                    minimumValue: 0
                    maximumValue: 65536
                    stepSize: 10
                    implicitWidth: root.width / 4

                }
               Label {
                    id: label18
                    color: "#1fcaff"
                    text: qsTr("Motion Start Pedal Position")
                    font.pointSize: 15
                }
               SliderWithText {
                   id: sliderMotionStart
                   minimumValue: 0
                   maximumValue: 100
                   stepSize: 1
                   implicitWidth: root.width / 4
               }

            }
            Row {
                id: configRow5
                spacing: root.width / 20
                anchors.left: secondPage.left
                anchors.top: configRow4.bottom
                anchors.topMargin: 20
                anchors.leftMargin: 50
                Label {
                    id: label19
                    color: "#1fcaff"
                    text: qsTr("Max Level Sig 2")
                    font.pointSize: 15
                }
                SliderWithText {
                    id: sliderMaxSig2
                    minimumValue: 0
                    maximumValue: 65536
                    stepSize: 10
                    implicitWidth: root.width / 4
                }
               Label {
                    id: label20
                    color: "#1fcaff"
                    text: qsTr("50% Throttle Pedal Position")
                    font.pointSize: 15
                }
               SliderWithText {
                   id: sliderHalfThrottle
                   minimumValue: 0
                   maximumValue: 100
                   stepSize: 1
                   implicitWidth: root.width / 4
               }

            }
            Row {
                id: configRow6
                spacing: root.width / 20
                anchors.left: secondPage.left
                anchors.top: configRow5.bottom
                anchors.topMargin: 20
                anchors.leftMargin: 50
                Label {
                    id: label21
                    color: "#1fcaff"
                    text: qsTr("Creep Level")
                    font.pointSize: 15
                }
                SliderWithText {
                    id: sliderCreepLevel
                    minimumValue: 0
                    maximumValue: 100
                    stepSize: 1
                    implicitWidth: root.width / 4
                }
               Label {
                    id: label22
                    color: "#1fcaff"
                    text: qsTr("Min. Throttle Regen")
                    font.pointSize: 15
                }
               SliderWithText {
                   id: sliderMinThrottleRegen
                   minimumValue: 0
                   maximumValue: 100
                   stepSize: 1
                   implicitWidth: root.width / 4
               }
            }





        }
    }

    PageIndicator {
        id: indicator

        count: swipedView.count
        currentIndex: swipedView.currentIndex

        anchors.bottom: swipedView.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
