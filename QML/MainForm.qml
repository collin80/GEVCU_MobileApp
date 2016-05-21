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
            id: statusPage
            Label
            {
                id: mcLabel
                text: "Motor Control"
                font.pointSize: 25
                color: "#AAAAFF"
                width: root.width * 0.66
            }
            Label
            {
                id: thLabel
                text: "Throttle/Brake"
                anchors.left: mcLabel.right
                font.pointSize: 25
                color: "#AAAAFF"
            }
            Row
            {
                id: statusRow1
                spacing: 0
                anchors.top: mcLabel.bottom
                anchors.topMargin: 20

                Label
                {
                    id: runningLabel
                    text: "Running:"
                    font.pointSize: 15
                    color: "white"
                    width: root.width / 6
                }

                Label
                {
                    id: runningValueLabel
                    text: ""
                    font.pointSize: 15
                    color: "white"
                    width: root.width / 6
                }
                Label
                {
                    id: optimeLabel
                    text: "Operating Time:"
                    font.pointSize: 15
                    color: "white"
                    width: root.width / 6
                }

                Label
                {
                    id: optimeValueLabel
                    text: ""
                    font.pointSize: 15
                    color: "white"
                    width: root.width / 6
                }
                Label
                {
                    id: tlevLabel
                    text: "Throttle Level:"
                    font.pointSize: 15
                    color: "white"
                    width: root.width / 6
                }

                Label
                {
                    id: tlevValueLabel
                    text: ""
                    font.pointSize: 15
                    color: "white"
                    width: root.width / 6
                }
            }

            Row
            {
                id: statusRow2
                spacing: 0
                anchors.top: statusRow1.bottom
                anchors.topMargin: 20

                Label
                {
                    id: faultLabel
                    text: "Fault:"
                    font.pointSize: 15
                    color: "white"
                    width: root.width / 6
                }

                Label
                {
                    id: faultValueLabel
                    text: ""
                    font.pointSize: 15
                    color: "white"
                    width: root.width / 6
                }
                Label
                {
                    id: warningLabel
                    text: "Warning:"
                    font.pointSize: 15
                    color: "white"
                    width: root.width / 6
                }

                Label
                {
                    id: warningValueLabel
                    text: ""
                    font.pointSize: 15
                    color: "white"
                    width: root.width / 6
                }
                Label
                {
                    id: blevLabel
                    text: "Brake Level:"
                    font.pointSize: 15
                    color: "white"
                    width: root.width / 6
                }

                Label
                {
                    id: blevValueLabel
                    text: ""
                    font.pointSize: 15
                    color: "white"
                    width: root.width / 6
                }
            }
            Row
            {
                id: statusRow3
                spacing: 0
                anchors.top: statusRow2.bottom
                anchors.topMargin: 20

                Label
                {
                    id: gearLabel
                    text: "Gear Switch:"
                    font.pointSize: 15
                    color: "white"
                    width: root.width / 6
                }

                Label
                {
                    id: gearValueLabel
                    text: ""
                    font.pointSize: 15
                    color: "white"
                    width: root.width / 6
                }

            }
            Row
            {
                id: statusRow4
                spacing: 0
                anchors.top: statusRow3.bottom
                anchors.topMargin: 20

                Label
                {
                    id: motorTempLabel
                    text: "Motor Temperature:"
                    font.pointSize: 15
                    color: "white"
                    width: root.width / 6
                }

                Label
                {
                    id: motorTempValueLabel
                    text: ""
                    font.pointSize: 15
                    color: "white"
                    width: root.width / 6
                }
                Label
                {
                    id: inverterTempLabel
                    text: "Inverter Temperature:"
                    font.pointSize: 15
                    color: "white"
                    width: root.width / 6
                }

                Label
                {
                    id: inverterTempValueLabel
                    text: ""
                    font.pointSize: 15
                    color: "white"
                    width: root.width / 6
                }

            }

            Row
            {
                id: statusRow5
                spacing: 0
                anchors.top: statusRow4.bottom
                anchors.topMargin: 20

                Label
                {
                    id: rTorqueLabel
                    text: "Requested Torque:"
                    font.pointSize: 15
                    color: "white"
                    width: root.width / 6
                }

                Label
                {
                    id: rTorqueValueLabel
                    text: ""
                    font.pointSize: 15
                    color: "white"
                    width: root.width / 6
                }
                Label
                {
                    id: aTorqueLabel
                    text: "Actual Torque:"
                    font.pointSize: 15
                    color: "white"
                    width: root.width / 6
                }

                Label
                {
                    id: aTorqueValueLabel
                    text: ""
                    font.pointSize: 15
                    color: "white"
                    width: root.width / 6
                }

            }


            Row
            {
                id: statusRow6
                spacing: 0
                anchors.top: statusRow5.bottom
                anchors.topMargin: 20

                Label
                {
                    id: voltLabel
                    text: "Battery Voltage:"
                    font.pointSize: 15
                    color: "white"
                    width: root.width / 6
                }

                Label
                {
                    id: voltValueLabel
                    text: ""
                    font.pointSize: 15
                    color: "white"
                    width: root.width / 6
                }
                Label
                {
                    id: currentLabel
                    text: "Battery Current:"
                    font.pointSize: 15
                    color: "white"
                    width: root.width / 6
                }

                Label
                {
                    id: currentValueLabel
                    text: ""
                    font.pointSize: 15
                    color: "white"
                    width: root.width / 6
                }
                Label
                {
                    id: powerLabel
                    text: "Power:"
                    font.pointSize: 15
                    color: "white"
                    width: root.width / 6
                }

                Label
                {
                    id: powerValueLabel
                    text: ""
                    font.pointSize: 15
                    color: "white"
                    width: root.width / 6
                }
            }

        }

        Item {
            //Bunch o' gauges
            id: gaugesPage

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
                id: dashboardRow1
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
                id: dashboardRow2
                spacing: root.width * 0.025
                anchors.left: gaugesRow2.right
                anchors.top: dashboardRow1.bottom
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
                id: dashboardRow3
                spacing: root.width * 0.025
                anchors.left: gaugesRow2.right
                anchors.top: dashboardRow2.bottom
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
            id: throttleConfigPage
            Label {
                id: label10
                color: "#1fcaff"
                text: qsTr("Throttle:")
                font.pointSize: 25
                anchors.top: throttleConfigPage.top
                anchors.left: throttleConfigPage.left
            }
            Row {
                id: configRow1
                spacing: root.width / 20
                anchors.left: throttleConfigPage.left
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
                anchors.left: throttleConfigPage.left
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
                anchors.left: throttleConfigPage.left
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
                anchors.left: throttleConfigPage.left
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
                anchors.left: throttleConfigPage.left
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
                anchors.left: throttleConfigPage.left
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

            Label {
                id: label100
                color: "#1fcaff"
                text: qsTr("Brake:")
                font.pointSize: 25
                anchors.top: configRow6.bottom
                anchors.left: throttleConfigPage.left
            }

            Row {
                id: configRow7
                spacing: root.width / 20
                anchors.left: throttleConfigPage.left
                anchors.top: label100.bottom
                anchors.topMargin: 20
                anchors.leftMargin: 50
                Label {
                    id: label101
                    color: "#1fcaff"
                    text: qsTr("Min Signal Level")
                    font.pointSize: 15
                }
                SliderWithText {
                    id: sliderMinSigBrake
                    minimumValue: 0
                    maximumValue: 65536
                    stepSize: 10
                    implicitWidth: root.width / 4
                }
               Label {
                    id: label102
                    color: "#1fcaff"
                    text: qsTr("Min Brake Regen")
                    font.pointSize: 15
                }
               SliderWithText {
                   id: sliderMinBrakeRegen
                   minimumValue: 0
                   maximumValue: 100
                   stepSize: 1
                   implicitWidth: root.width / 4
               }

            }

            Row {
                id: configRow8
                spacing: root.width / 20
                anchors.left: throttleConfigPage.left
                anchors.top: configRow7.bottom
                anchors.topMargin: 20
                anchors.leftMargin: 50
                Label {
                    id: label103
                    color: "#1fcaff"
                    text: qsTr("Max Signal Level")
                    font.pointSize: 15
                }
                SliderWithText {
                    id: sliderMaxSigBrake
                    minimumValue: 0
                    maximumValue: 65536
                    stepSize: 10
                    implicitWidth: root.width / 4
                }
               Label {
                    id: label104
                    color: "#1fcaff"
                    text: qsTr("Max Brake Regen")
                    font.pointSize: 15
                }
               SliderWithText {
                   id: sliderMaxBrakeRegen
                   minimumValue: 0
                   maximumValue: 100
                   stepSize: 1
                   implicitWidth: root.width / 4
               }

            }

            Label {
                id: label150
                color: "#1fcaff"
                text: qsTr("Motor Control:")
                font.pointSize: 25
                anchors.top: configRow8.bottom
                anchors.left: throttleConfigPage.left
            }

            Row {
                id: configRow9
                spacing: root.width / 20
                anchors.left: throttleConfigPage.left
                anchors.top: label150.bottom
                anchors.topMargin: 20
                anchors.leftMargin: 50

                Label {
                    id: maxSpeedLabel
                    color: "#1fcaff"
                    font.pointSize: 15
                    text: "Max Speed (RPM):"
                }
                TextField
                {
                    id: maxSpeedText
                }

                Label {
                    id: maxTorqueLabel
                    color: "#1fcaff"
                    font.pointSize: 15
                    text: "Max Torque (Nm):"
                }
                TextField
                {
                    id: maxTorqueText
                }

                Label {
                    id: motorModeLabel
                    color: "#1fcaff"
                    font.pointSize: 15
                    text: "Motor Mode:"
                }
                ComboBox {
                    id: cbMotorMode
                    model: [ "Torque Control", "Speed Control" ]
                    implicitWidth: 200
                }

            }


            Label {
                id: label200
                color: "#1fcaff"
                text: qsTr("System:")
                font.pointSize: 25
                anchors.top: configRow9.bottom
                anchors.left: throttleConfigPage.left
            }

            Row {
                id: configRow10
                spacing: root.width / 20
                anchors.left: throttleConfigPage.left
                anchors.top: label200.bottom
                anchors.topMargin: 20
                anchors.leftMargin: 50

                Label {
                    id: loggingLabel
                    color: "#1fcaff"
                    font.pointSize: 15
                    text: "Log Level:"
                }
                ComboBox {
                    id: cbLogMode
                    model: [ "Debug", "Info", "Warning", "Error", "Off" ]
                    implicitWidth: 200
                }

                Label {
                    id: nomVoltsLabel
                    color: "#1fcaff"
                    font.pointSize: 15
                    text: "Nominal Battery Voltage:"
                }
                TextField
                {
                    id: nomVoltsText
                }
            }

        }
        Item {
            id: outputConfigPage

            Label
            {
                id:outputLabel1
                color: "#1fcaff"
                font.pointSize: 25
                text: "Digital Outputs - DOUT0 - DOUT7"
            }
            Row
            {
                id:outputRow1
                anchors.top: outputLabel1.bottom
                anchors.topMargin: 20
                spacing: root.width / 20

                Label
                {
                    id: outputLabel2
                    color: "#1fcaff"
                    font.pointSize: 15
                    text: "Fan Output"
                }
                ComboBox {
                    id: cbFanOutput
                    model: [ "None", "0", "1", "2", "3", "4", "5", "6", "7" ]
                    implicitWidth: 200
                }
                Label
                {
                    id: outputLabel3
                    color: "#1fcaff"
                    font.pointSize: 15
                    text: "Fan On Temp (Deg C)"
                }
                TextField
                {
                    id:fanOnTempText
                }
                Label
                {
                    id: outputLabel4
                    color: "#1fcaff"
                    font.pointSize: 15
                    text: "Fan Off Temp (Deg C)"
                }
                TextField
                {
                    id: fanOffTempText
                }
            }
            Row
            {
                id: outputRow2
                anchors.top: outputRow1.bottom
                anchors.topMargin: 20
                spacing: root.width / 20

                Label
                {
                    id: outputLabel5
                    color: "#1fcaff"
                    font.pointSize: 15
                    text: "Precharge Output"
                }
                ComboBox {
                    id: cbPrechargeOutput
                    model: [ "None", "0", "1", "2", "3", "4", "5", "6", "7" ]
                    implicitWidth: 200
                }
                Label
                {
                    id: outputLabel6
                    color: "#1fcaff"
                    font.pointSize: 15
                    text: "Precharge Delay (ms)"
                }
                TextField
                {
                    id:prechargeDelayText
                }
            }

            Row
            {
                id: outputRow3
                anchors.top: outputRow2.bottom
                anchors.topMargin: 20
                spacing: root.width / 20

                Label
                {
                    id: outputLabel7
                    color: "#1fcaff"
                    font.pointSize: 15
                    text: "Main Contactor Output"
                }
                ComboBox {
                    id: cbMainContOutput
                    model: [ "None", "0", "1", "2", "3", "4", "5", "6", "7" ]
                    implicitWidth: 200
                }
            }

            Row
            {
                id: outputRow4
                anchors.top: outputRow3.bottom
                anchors.topMargin: 20
                spacing: root.width / 20

                Label
                {
                    id: outputLabel8
                    color: "#1fcaff"
                    font.pointSize: 15
                    text: "Brake Light Output"
                }
                ComboBox {
                    id: cbBrakeLightOutput
                    model: [ "None", "0", "1", "2", "3", "4", "5", "6", "7" ]
                    implicitWidth: 200
                }
            }
            Row
            {
                id: outputRow5
                anchors.top: outputRow4.bottom
                anchors.topMargin: 20
                spacing: root.width / 20

                Label
                {
                    id: outputLabel9
                    color: "#1fcaff"
                    font.pointSize: 15
                    text: "Reverse Light Output"
                }
                ComboBox {
                    id: cbReverseLightOutput
                    model: [ "None", "0", "1", "2", "3", "4", "5", "6", "7" ]
                    implicitWidth: 200
                }
            }

        }
        Item {
            id: inputsConfigPage

            Label
            {
                id:inputLabel1
                color: "#1fcaff"
                font.pointSize: 25
                text: "Digital Inputs - DIN0 - DIN3"
            }
            Row
            {
                id:inputRow1
                anchors.top: inputLabel1.bottom
                anchors.topMargin: 20
                spacing: root.width / 20

                Label
                {
                    id: inputLabel2
                    color: "#1fcaff"
                    font.pointSize: 15
                    text: "Enable Input"
                }
                ComboBox {
                    id: cbEnableInput
                    model: [ "None", "0", "1", "2", "3" ]
                    implicitWidth: 200
                }
            }
            Row
            {
                id: inputRow2
                anchors.top: inputRow1.bottom
                anchors.topMargin: 20
                spacing: root.width / 20

                Label
                {
                    id: inputLabel3
                    color: "#1fcaff"
                    font.pointSize: 15
                    text: "Reverse Input"
                }
                ComboBox {
                    id: cbReverseInput
                    model: [ "None", "0", "1", "2", "3" ]
                    implicitWidth: 200
                }
            }

        }
        Item {
            id: devicesConfigPage

            Label
            {
                id:deviceLabel1
                color: "#1fcaff"
                font.pointSize: 25
                text: "Device Selection / Activation"
            }
            Row
            {
                id: deviceRow1
                anchors.top: deviceLabel1.bottom
                anchors.topMargin: 20
                spacing: root.width / 20

                Label
                {
                    id:deviceLabel2
                    color: "#1fcaff"
                    font.pointSize: 20
                    text: "Motor Controllers"
                }
                Label
                {
                    id:deviceLabel3
                    color: "#1fcaff"
                    font.pointSize: 20
                    text: "Throttle and Brake"
                }
            }

            Row
            {
                id: deviceRow2
                anchors.top: deviceRow1.bottom
                anchors.topMargin: 20
                spacing: root.width / 20

                Label
                {
                    id:deviceLabel4
                    color: "#1fcaff"
                    font.pointSize: 15
                    text: "Azure Dynamics DMOC645"
                }
                ComboBox {
                    id: cbDMOC645
                    model: [ "Disabled", "Enabled" ]
                    implicitWidth: 200
                }
                Label
                {
                    id:deviceLabel5
                    color: "#1fcaff"
                    font.pointSize: 15
                    text: "Potentiometer/Hall Effect Throttle"
                }
                ComboBox {
                    id: cbPotThrottle
                    model: [ "Disabled", "Enabled" ]
                    implicitWidth: 200
                }
            }
            Row
            {
                id: deviceRow3
                anchors.top: deviceRow2.bottom
                anchors.topMargin: 20
                spacing: root.width / 20
                Label
                {
                    id:deviceLabel6
                    color: "#1fcaff"
                    font.pointSize: 15
                    text: "UQM Powerphase 100"
                }
                ComboBox {
                    id: cbUQMPowerPhase
                    model: [ "Disabled", "Enabled" ]
                    implicitWidth: 200
                }
                Label
                {
                    id:deviceLabel7
                    color: "#1fcaff"
                    font.pointSize: 15
                    text: "Potentiometer/Hall Effect Brake"
                }
                ComboBox {
                    id: cbPotBrake
                    model: [ "Disabled", "Enabled" ]
                    implicitWidth: 200
                }
            }
            Row
            {
                id: deviceRow4
                anchors.top: deviceRow3.bottom
                anchors.topMargin: 20
                spacing: root.width / 20
                Label
                {
                    id:deviceLabel8
                    color: "#1fcaff"
                    font.pointSize: 15
                    text: "Brusa DMC5"
                }
                ComboBox {
                    id: cbBrusaDMC5
                    model: [ "Disabled", "Enabled" ]
                    implicitWidth: 200
                }
                Label
                {
                    id:deviceLabel9
                    color: "#1fcaff"
                    font.pointSize: 15
                    text: "CANBus Throttle"
                }
                ComboBox {
                    id: cbCANThrottle
                    model: [ "Disabled", "Enabled" ]
                    implicitWidth: 200
                }
            }
            Row
            {
                id: deviceRow5
                anchors.top: deviceRow4.bottom
                anchors.topMargin: 20
                spacing: root.width / 20
                Label
                {
                    id:deviceLabel10
                    color: "#1fcaff"
                    font.pointSize: 15
                    text: "CANBus Brake"
                }
                ComboBox {
                    id: cbCANBrake
                    model: [ "Disabled", "Enabled" ]
                    implicitWidth: 200
                }

            }

            Row
            {
                id: deviceRow6
                anchors.top: deviceRow5.bottom
                anchors.topMargin: 20
                spacing: root.width / 20

                Label
                {
                    id:deviceLabel20
                    color: "#1fcaff"
                    font.pointSize: 20
                    text: "Communication Interfaces"
                }

                Label
                {
                    id:deviceLabel21
                    color: "#1fcaff"
                    font.pointSize: 20
                    text: "Battery Chargers and Management"
                }
            }

            Row
            {
                id: deviceRow7
                anchors.top: deviceRow6.bottom
                anchors.topMargin: 20
                spacing: root.width / 20
                Label
                {
                    id:deviceLabel22
                    color: "#1fcaff"
                    font.pointSize: 15
                    text: "ConnectOne WiReach Wifi"
                }
                ComboBox {
                    id: cbCOWifi
                    model: [ "Disabled", "Enabled" ]
                    implicitWidth: 200
                }
                Label
                {
                    id:deviceLabel23
                    color: "#1fcaff"
                    font.pointSize: 15
                    text: "Brusa NLG5 Charger"
                }
                ComboBox {
                    id: cbBrusaNLG5
                    model: [ "Disabled", "Enabled" ]
                    implicitWidth: 200
                }
            }

            Row
            {
                id: deviceRow8
                anchors.top: deviceRow7.bottom
                anchors.topMargin: 20
                spacing: root.width / 20
                Label
                {
                    id:deviceLabel24
                    color: "#1fcaff"
                    font.pointSize: 15
                    text: "ELM327 OBDII Wireless"
                }
                ComboBox {
                    id: cbELM327
                    model: [ "Disabled", "Enabled" ]
                    implicitWidth: 200
                }
                Label
                {
                    id:deviceLabel25
                    color: "#1fcaff"
                    font.pointSize: 15
                    text: "TCCH/Elcon Charger"
                }
                ComboBox {
                    id: cbTCCH
                    model: [ "Disabled", "Enabled" ]
                    implicitWidth: 200
                }
            }

            Row
            {
                id: deviceRow9
                anchors.top: deviceRow8.bottom
                anchors.topMargin: 20
                spacing: root.width / 20
                Label
                {
                    id:deviceLabel26
                    color: "#1fcaff"
                    font.pointSize: 15
                    text: "OBDII PID Listener (CANBus)"
                }
                ComboBox {
                    id: cbOBD2PID
                    model: [ "Disabled", "Enabled" ]
                    implicitWidth: 200
                }
                Label
                {
                    id:deviceLabel27
                    color: "#1fcaff"
                    font.pointSize: 15
                    text: "Lear Charger"
                }
                ComboBox {
                    id: cbLearCharger
                    model: [ "Disabled", "Enabled" ]
                    implicitWidth: 200
                }
            }

            Row
            {
                id: deviceRow10
                anchors.top: deviceRow9.bottom
                anchors.topMargin: 20
                spacing: root.width / 20
                Label
                {
                    id:deviceLabel28
                    color: "#1fcaff"
                    font.pointSize: 15
                    text: "Think BMS"
                }
                ComboBox {
                    id: cbThinkBMS
                    model: [ "Disabled", "Enabled" ]
                    implicitWidth: 200
                }
            }


        }
        Item {
            id: aboutPage

            TextArea {
                font.pointSize: 20
                color: "white"
                text:
                    "About GEVCU Mobile App and GEVCU Hardware/Software:\n" +
                    "The Generalized Electric Vehicle Control Unit - GEVCU is an open source software and hardware \n"+
                    "project to develop a Vehicle Control Unit (VCU) specifically for electric vehicles.\n"+
                    "The purpose of GEVCU is to handle throttle control, regenerative braking, forward, reverse, \n"+
                    "and such peculiarities as precharge, cooling system control, instrumentation etc.\n"+
                    " - essentially the driver interface of the car. GEVCU then manages torque and speed \n"+
                    "commands to the power electronics via CAN bus to actually operate the vehicle in response\n"+
                    " to driver input. But it also provides outputs to instrumentation, brake lights, reverse lights,\n"+
                    " cooling systems, and other controls specific to that vehicle. GEVCU is both open-source and \n" +
                    "object-oriented allowing easy addition of additional C++ object modules to incorporate multiple \n"+
                    "standard power components. It is easily modified using the Arduino IDE to incorporate additional \n"+
                    "features peculiar to any specific electric car conversion or build. For most operations, it is \n"+
                    "easily configurable by non-programmers through simple web and serial port interfaces to adapt to\n"+
                    " a wide variety of power components and vehicle applications. GEVCU was originally conceived of and \n"+
                    "proposed by Jack Rickard of Electric Vehicle Television (http://EVtv.me) who wrote the original\n"+
                    " design specification. The main source of the program was developed and is maintained by Collin Kidder\n"+
                    " and the latest version is always available at http:/github.com/collin80/GEVCU. A list of major \n"+
                    "contributors to the project is maintained there. Hardware was designed and developed by Ed Clausen\n"+
                    " and Paulo Jorge Pires de Almeida based on the Arduino Due. GEVCU is open source hardware and \n"+
                    "software and is presented as EXPERIMENTAL - USE AT YOUR OWN RISK. It is offered strictly for \n"+
                    "experimental and educational purposes and is NOT intended for actual use in any commercial \n"+
                    "product or for any specific useful purpose."
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
