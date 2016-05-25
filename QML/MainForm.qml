import QtQuick 2.5
import QtQuick.Controls 1.5
import QtQuick.Extras 1.4
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4
import Qt.labs.controls 1.0

Window {
    id: root
    visible: true
    width: 800
    height: 600
    color: "#000000"


    ValueStorage {
        id: valueStorage
    }

    property real stretchFactor: (width / 1920)
    property real smallTextSize: 15 * stretchFactor
    property real medTextSize: 20 * stretchFactor
    property real largeTextSize: 25 * stretchFactor

    Image
    {
        source: "qrc:/images/evtvbackground.png"
        width: root.width
        height: root.height
        fillMode: Image.Stretch
    }

    SwipeView {
        id: swipedView

        currentIndex: 0
        anchors.fill: parent

        Item {
            id: statusPage

            GridLayout
            {
                id: statusGrid
                columns: 6
                anchors.top: undefined
                anchors.topMargin: medTextSize
                width: root.width

                Label
                {
                    id: mcLabel
                    text: "Motor Control"
                    font.pointSize: largeTextSize
                    color: "#AAAAFF"
                    Layout.row: 0
                    Layout.column: 0
                    Layout.columnSpan: 2
                }
                Label
                {
                    id: thLabel
                    text: "Throttle/Brake"
                    font.pointSize: largeTextSize
                    color: "#AAAAFF"
                    Layout.row: 0
                    Layout.column: 4
                    Layout.columnSpan: 2
                }

                Label
                {
                    id: runningLabel
                    text: "Running:"
                    font.pointSize: smallTextSize
                    color: "white"
                    Layout.row: 1
                    Layout.column: 0
                }

                Label
                {
                    id: runningValueLabel
                    text: valueStorage.isRunning.toString()
                    font.pointSize: smallTextSize
                    color: "white"
                }
                Label
                {
                    id: optimeLabel
                    text: "Operating Time:"
                    font.pointSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: optimeValueLabel
                    text: valueStorage.operatingTime.toString()
                    font.pointSize: smallTextSize
                    color: "white"
                }
                Label
                {
                    id: tlevLabel
                    text: "Throttle Level:"
                    font.pointSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: tlevValueLabel
                    text: valueStorage.throttleLevel.toString()
                    font.pointSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: faultLabel
                    text: "Fault:"
                    font.pointSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: faultValueLabel
                    text: valueStorage.faultMsg
                    font.pointSize: smallTextSize
                    color: "white"
                }
                Label
                {
                    id: warningLabel
                    text: "Warning:"
                    font.pointSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: warningValueLabel
                    text: valueStorage.warningMsg
                    font.pointSize: smallTextSize
                    color: "white"
                }
                Label
                {
                    id: blevLabel
                    text: "Brake Level:"
                    font.pointSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: blevValueLabel
                    text: valueStorage.brakeLevel.toString()
                    font.pointSize: smallTextSize
                    color: "white"
                }


                Label
                {
                    id: gearLabel
                    text: "Gear Switch:"
                    font.pointSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: gearValueLabel
                    text: valueStorage.gear
                    font.pointSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    Layout.row: 4
                    Layout.column: 0
                    id: motorTempLabel
                    text: "Motor Temperature:"
                    font.pointSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: motorTempValueLabel
                    text: valueStorage.motorTemp.toString()
                    font.pointSize: smallTextSize
                    color: "white"
                }
                Label
                {
                    id: inverterTempLabel
                    text: "Inverter Temperature:"
                    font.pointSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: inverterTempValueLabel
                    text: valueStorage.inverterTemp.toString()
                    font.pointSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    Layout.row: 5
                    Layout.column: 0
                    id: rTorqueLabel
                    text: "Requested Torque:"
                    font.pointSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: rTorqueValueLabel
                    text: valueStorage.reqTorque.toString()
                    font.pointSize: smallTextSize
                    color: "white"
                }
                Label
                {
                    id: aTorqueLabel
                    text: "Actual Torque:"
                    font.pointSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: aTorqueValueLabel
                    text: valueStorage.actTorque.toString()
                    font.pointSize: smallTextSize
                    color: "white"
                }


                Label
                {
                    Layout.row: 6
                    Layout.column: 0
                    id: voltLabel
                    text: "Battery Voltage:"
                    font.pointSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: voltValueLabel
                    text: valueStorage.battVoltage.toString()
                    font.pointSize: smallTextSize
                    color: "white"
                }
                Label
                {
                    id: currentLabel
                    text: "Battery Current:"
                    font.pointSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: currentValueLabel
                    text: valueStorage.battCurrent.toString()
                    font.pointSize: smallTextSize
                    color: "white"
                }
                Label
                {
                    id: powerLabel
                    text: "Power:"
                    font.pointSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: powerValueLabel
                    text: valueStorage.power.toString()
                    font.pointSize: smallTextSize
                    color: "white"
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
                    value: valueStorage.throttleLevel
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
                    value: valueStorage.actTorque
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
                    value: valueStorage.battCurrent
                }

                CircularGauge {
                    id: rpmGauge
                    width: root.width * 0.25 - gaugesRow1.spacing
                    height: width
                    maximumValue: 8
                    style: TachGaugeStyle {
                    }
                    value: valueStorage.rpm / 1000.0
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
                    value: valueStorage.battVoltage
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
                    value: valueStorage.power
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
                    value: valueStorage.motorTemp / 140.0
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
                    value: valueStorage.inverterTemp / 140.0
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
                    value: valueStorage.battSOC / 100.0
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
                anchors.topMargin: 20 * stretchFactor
                anchors.leftMargin: 50 * stretchFactor

                Label {
                    id: label1
                    color: "#1fcaff"
                    text: qsTr("Inputs:")
                    font.pointSize: smallTextSize
                }

                StatusIndicator {
                    id: statusInput1
                    active: valueStorage.input1
                }

                StatusIndicator {
                    id: statusInput2
                    active: valueStorage.input2
                }

                StatusIndicator {
                    id: statusInput3
                    active: valueStorage.input3
                }

                StatusIndicator {
                    id: statusInput4
                    active: valueStorage.input4
                }
            }

            Row {
                id: dashboardRow2
                spacing: 20 * stretchFactor
                anchors.left: gaugesRow2.right
                anchors.top: dashboardRow1.bottom
                anchors.topMargin: 20 * stretchFactor
                anchors.leftMargin: 50 * stretchFactor

                Label {
                    id: label2
                    color: "#1fcaff"
                    text: qsTr("Outputs:")
                    font.pointSize: smallTextSize
                }

                StatusIndicator {
                    id: statusOutput1
                    active: valueStorage.output1
                }

                StatusIndicator {
                    id: statusOutput2
                    active: valueStorage.output2
                }

                StatusIndicator {
                    id: statusOutput3
                    active: valueStorage.output3
                }

                StatusIndicator {
                    id: statusOutput4
                    active: valueStorage.output4
                }

                StatusIndicator {
                    id: statusOutput5
                    active: valueStorage.output5
                }

                StatusIndicator {
                    id: statusOutput6
                    active: valueStorage.output6
                }

                StatusIndicator {
                    id: statusOutput7
                    active: valueStorage.output7
                }

                StatusIndicator {
                    id: statusOutput8
                    active: valueStorage.output8
                }
            }

            Row {
                id: dashboardRow3
                spacing: 20 * stretchFactor
                anchors.left: gaugesRow2.right
                anchors.top: dashboardRow2.bottom
                anchors.topMargin: 20 * stretchFactor
                anchors.leftMargin: 50 * stretchFactor

                Label {
                    id: label3
                    color: "#1fcaff"
                    text: qsTr("System Status:")
                    font.pointSize: smallTextSize
                }

                StatusIndicator {
                    id: statusSystem
                    active: valueStorage.sysStatus
                }
            }
        }
        Item {
            //general configuration page
            id: throttleConfigPage
            Label {
                id: label10
                color: "#AAAAFF"
                text: qsTr("Throttle:")
                font.pointSize: 25
                anchors.top: throttleConfigPage.top
                anchors.left: throttleConfigPage.left
            }

            GridLayout
            {
                id: throttleConfigGrid
                columns: 4
                anchors.top: label10.bottom
                anchors.topMargin: 20
                columnSpacing: throttleConfigPage.width / 20

                Label {
                    id: label11
                    color: "white"
                    text: qsTr("Num of throttle pots:")
                    font.pointSize: 15
                }
                ComboBox {
                    id: cbNumPots
                    model: [ "1","2" ]
                }
                Label {
                    id: label12
                    color: "white"
                    text: qsTr("Throttle type:")
                    font.pointSize: 15
                }
                ComboBox {
                    id: cbThrottleType
                    model: [ "Std Pot", "Inv Pot", "Hall Effect" ]
                    implicitWidth: 200
                }

                Label {
                    id: label13
                    color: "white"
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
                    color: "white"
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

               Label {
                    id: label15
                    color: "white"
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
                    color: "white"
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

               Label {
                    id: label17
                    color: "white"
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
                    color: "white"
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

               Label {
                    id: label19
                    color: "white"
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
                    color: "white"
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

               Label {
                    id: label21
                    color: "white"
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
                    color: "white"
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
                color: "#AAAAFF"
                text: qsTr("Brake:")
                font.pointSize: 25
                anchors.top: throttleConfigGrid.bottom
                anchors.left: throttleConfigPage.left
            }

            GridLayout
            {
                id: throttleConfigGrid2
                columns: 4
                anchors.top: label100.bottom
                anchors.topMargin: 20
                columnSpacing: throttleConfigPage.width / 20

                Label {
                    id: label101
                    color: "white"
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
                    color: "white"
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

               Label {
                    id: label103
                    color: "white"
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
                    color: "white"
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
                color: "#AAAAFF"
                text: qsTr("Motor Control:")
                font.pointSize: 25
                anchors.top: throttleConfigGrid2.bottom
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
                    color: "white"
                    font.pointSize: 15
                    text: "Max Speed (RPM):"
                }
                TextField
                {
                    id: maxSpeedText
                }

                Label {
                    id: maxTorqueLabel
                    color: "white"
                    font.pointSize: 15
                    text: "Max Torque (Nm):"
                }
                TextField
                {
                    id: maxTorqueText
                }

                Label {
                    id: motorModeLabel
                    color: "white"
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
                color: "#AAAAFF"
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
                    color: "white"
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
                    color: "white"
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
                color: "#AAAAFF"
                font.pointSize: 25
                text: "Digital Outputs - DOUT0 - DOUT7"
            }

            GridLayout
            {
                id: outputConfigGrid1
                columns: 6
                anchors.top: outputLabel1.bottom
                anchors.topMargin: 20
                columnSpacing: throttleConfigPage.width / 20

                Label
                {
                    id: outputLabel2
                    color: "white"
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
                    color: "white"
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
                    color: "white"
                    font.pointSize: 15
                    text: "Fan Off Temp (Deg C)"
                }
                TextField
                {
                    id: fanOffTempText
                }

                Label
                {
                    id: outputLabel5
                    color: "white"
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
                    color: "white"
                    font.pointSize: 15
                    text: "Precharge Delay (ms)"
                }
                TextField
                {
                    id:prechargeDelayText
                }

                Label
                {
                    id: outputLabel7
                    color: "white"
                    font.pointSize: 15
                    text: "Main Contactor Output"
                    Layout.row: 2
                    Layout.column: 0
                }
                ComboBox {
                    id: cbMainContOutput
                    model: [ "None", "0", "1", "2", "3", "4", "5", "6", "7" ]
                    implicitWidth: 200
                }

                Label
                {
                    id: outputLabel8
                    color: "white"
                    font.pointSize: 15
                    text: "Brake Light Output"
                    Layout.row: 3
                    Layout.column: 0
                }
                ComboBox {
                    id: cbBrakeLightOutput
                    model: [ "None", "0", "1", "2", "3", "4", "5", "6", "7" ]
                    implicitWidth: 200
                }

                Label
                {
                    id: outputLabel9
                    color: "white"
                    font.pointSize: 15
                    text: "Reverse Light Output"
                    Layout.row: 4
                    Layout.column: 0
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
                color: "#AAAAFF"
                font.pointSize: 25
                text: "Digital Inputs - DIN0 - DIN3"
            }

            GridLayout
            {
                id: inputConfigGrid1
                columns: 2
                anchors.top: inputLabel1.bottom
                anchors.topMargin: 20
                columnSpacing: throttleConfigPage.width / 20


                Label
                {
                    id: inputLabel2
                    color: "white"
                    font.pointSize: 15
                    text: "Enable Input"
                }
                ComboBox {
                    id: cbEnableInput
                    model: [ "None", "0", "1", "2", "3" ]
                    implicitWidth: 200
                }

                Label
                {
                    id: inputLabel3
                    color: "white"
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
                color: "#AAAAFF"
                font.pointSize: 25
                text: "Device Selection / Activation"
            }

            GridLayout
            {
                id: deviceConfigGrid1
                columns: 4
                anchors.top: deviceLabel1.bottom
                anchors.topMargin: 20
                columnSpacing: throttleConfigPage.width / 20

                Label
                {
                    id:deviceLabel2
                    color: "#6666BB"
                    font.pointSize: 20
                    text: "Motor Controllers"
                }
                Label
                {
                    id:deviceLabel3
                    color: "#6666BB"
                    font.pointSize: 20
                    text: "Throttle and Brake"
                    Layout.row: 0
                    Layout.column: 2
                }

                Label
                {
                    id:deviceLabel4
                    color: "white"
                    font.pointSize: 15
                    text: "Azure Dynamics DMOC645"
                    Layout.row: 1
                    Layout.column: 0
                }
                ComboBox {
                    id: cbDMOC645
                    model: [ "Disabled", "Enabled" ]
                    implicitWidth: 200
                }
                Label
                {
                    id:deviceLabel5
                    color: "white"
                    font.pointSize: 15
                    text: "Potentiometer/Hall Effect Throttle"
                }
                ComboBox {
                    id: cbPotThrottle
                    model: [ "Disabled", "Enabled" ]
                    implicitWidth: 200
                }

                Label
                {
                    id:deviceLabel6
                    color: "white"
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
                    color: "white"
                    font.pointSize: 15
                    text: "Potentiometer/Hall Effect Brake"
                }
                ComboBox {
                    id: cbPotBrake
                    model: [ "Disabled", "Enabled" ]
                    implicitWidth: 200
                }

                Label
                {
                    id:deviceLabel8
                    color: "white"
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
                    color: "white"
                    font.pointSize: 15
                    text: "CANBus Throttle"
                }
                ComboBox {
                    id: cbCANThrottle
                    model: [ "Disabled", "Enabled" ]
                    implicitWidth: 200
                }

                Label
                {
                    id:deviceLabel10
                    color: "white"
                    font.pointSize: 15
                    text: "CANBus Brake"
                }
                ComboBox {
                    id: cbCANBrake
                    model: [ "Disabled", "Enabled" ]
                    implicitWidth: 200
                }

                Label
                {
                    id:deviceLabel20
                    color: "#6666BB"
                    font.pointSize: 20
                    text: "Communication Interfaces"
                    Layout.row: 5
                    Layout.column:0
                }

                Label
                {
                    id:deviceLabel21
                    color: "#6666BB"
                    font.pointSize: 20
                    text: "Battery Chargers and Management"
                    Layout.row: 5
                    Layout.column: 2
                }

                Label
                {
                    id:deviceLabel22
                    color: "white"
                    font.pointSize: 15
                    text: "ConnectOne WiReach Wifi"
                    Layout.row: 6
                    Layout.column: 0
                }
                ComboBox {
                    id: cbCOWifi
                    model: [ "Disabled", "Enabled" ]
                    implicitWidth: 200
                }
                Label
                {
                    id:deviceLabel23
                    color: "white"
                    font.pointSize: 15
                    text: "Brusa NLG5 Charger"
                }
                ComboBox {
                    id: cbBrusaNLG5
                    model: [ "Disabled", "Enabled" ]
                    implicitWidth: 200
                }

                Label
                {
                    id:deviceLabel24
                    color: "white"
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
                    color: "white"
                    font.pointSize: 15
                    text: "TCCH/Elcon Charger"
                }
                ComboBox {
                    id: cbTCCH
                    model: [ "Disabled", "Enabled" ]
                    implicitWidth: 200
                }

                Label
                {
                    id:deviceLabel26
                    color: "white"
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
                    color: "white"
                    font.pointSize: 15
                    text: "Lear Charger"
                }
                ComboBox {
                    id: cbLearCharger
                    model: [ "Disabled", "Enabled" ]
                    implicitWidth: 200
                }

                Label
                {
                    id:deviceLabel28
                    color: "white"
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
                    "About GEVCU Mobile App and GEVCU Hardware/Software:\n\n" +
                    "The Generalized Electric Vehicle Control Unit - GEVCU is an open source software and hardware \n"+
                    "project to develop a Vehicle Control Unit (VCU) specifically for electric vehicles.\n"+
                    "The purpose of GEVCU is to handle throttle control, regenerative braking, forward, reverse, \n"+
                    "and such peculiarities as precharge, cooling system control, instrumentation etc.\n"+
                    "It is essentially the driver interface of the car. GEVCU then manages torque and speed \n"+
                    "commands to the power electronics via CAN bus to actually operate the vehicle in response\n"+
                    "to driver input. But it also provides outputs to instrumentation, brake lights, reverse lights,\n"+
                    "cooling systems, and other controls specific to that vehicle. GEVCU is both open-source and \n" +
                    "object-oriented allowing easy addition of additional C++ object modules to incorporate multiple \n"+
                    "standard power components. It is easily modified using the Arduino IDE to incorporate additional \n"+
                    "features peculiar to any specific electric car conversion or build. For most operations, it is \n"+
                    "easily configurable by non-programmers through simple web and serial port interfaces to adapt to\n"+
                    "a wide variety of power components and vehicle applications.\n\n" +
                    "GEVCU was originally conceived of and proposed by Jack Rickard of Electric Vehicle Television\n"+
                    "(http://EVtv.me) who wrote the original design specification. The main source of the program was\n"+
                    "developed and is maintained by Collin Kidder and the latest version is always available at \n"+
                    "http:/github.com/collin80/GEVCU. A list of major contributors to the project is maintained there.\n"+
                    "Hardware was designed and developed by Ed Clausen, Collin Kidder, and Paulo Jorge Pires de Almeida\n"+
                    "based on the Arduino Due. GEVCU is open source hardware and software and is presented as \n"+
                    "EXPERIMENTAL - USE AT YOUR OWN RISK. It is offered strictly for experimental and educational purposes\n"+
                    "and is NOT intended for actual use in any commercial product or for any specific useful purpose.\n\n" +
                    "This mobile app was written by Collin Kidder and is meant as a companion to GEVCU. It allows for easy\n" +
                    "configuration and monitoring of GEVCU without having to gain physical access to the unit itself.\n\n" +
                    "And, for God's sake, don't use this mobile application while you're driving down the road.\n"+
                    "Have some common sense man!"
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
