import QtQuick 2.5
import QtQuick.Controls 1.5
import QtQuick.Extras 1.4
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4
import Qt.labs.controls 1.0

Item {
    id: root
    visible: true
    width: root.width
    height: root.height

    ValueStorage {
        id: valueStorage
    }

    property real stretchFactor: (root.width / 1920)
    property real smallTextSize: 9 * stretchFactor
    property real medTextSize: 12 * stretchFactor
    property real largeTextSize: 15 * stretchFactor
    property real textboxSize: 175 * stretchFactor
    property real comboboxSize: 320 * stretchFactor
    property real bigGaugeWidth: 440 * stretchFactor
    property real smallGaugeWidth: 220 * stretchFactor
    property real sliderWidth: 375 * stretchFactor
    property real sliderBuffer: 100 * stretchFactor
    property int adcMaxValue: 4096

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
                columns: 4
                anchors.top: undefined
                anchors.topMargin: medTextSize
                width: root.width

                Label
                {
                    id: mcLabel
                    text: "Motor Control Information"
                    font.pointSize: largeTextSize
                    color: "#AAAAFF"
                    Layout.row: 0
                    Layout.column: 0
                    Layout.columnSpan: 4
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
                    text: bleHandler.isRunning.toString()
                    font.pointSize: smallTextSize
                    color: "white"
                    Layout.fillWidth: true
                }
                Label
                {
                    id: optimeLabel
                    text: "Up Time:"
                    font.pointSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: optimeValueLabel
                    text: bleHandler.timeRunning.toString()
                    font.pointSize: smallTextSize
                    color: "white"
                    Layout.fillWidth: true
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
                    text: bleHandler.rawThrottle1.toString()
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
                    text: bleHandler.rawBrake.toString()
                    font.pointSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: faultLabel
                    text: "Fault:"
                    font.pointSize: smallTextSize
                    color: "white"
                    Layout.row: 4
                    Layout.column: 0
                }

                Label
                {
                    id: faultValueLabel
                    text: bleHandler.isFaulted.toString()
                    font.pointSize: smallTextSize
                    color: "white"
                }
                Label
                {
                    id: warningLabel
                    text: "Warning:"
                    font.pointSize: smallTextSize
                    color: "white"
                    Layout.row: 5
                    Layout.column: 0
                }

                Label
                {
                    id: warningValueLabel
                    text: bleHandler.isWarning.toString()
                    font.pointSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: gearLabel
                    text: "Gear Switch:"
                    font.pointSize: smallTextSize
                    color: "white"
                    Layout.row: 6
                    Layout.column: 0
                }

                Label
                {
                    id: gearValueLabel
                    text: bleHandler.gear.toString()
                    font.pointSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    Layout.row: 7
                    Layout.column: 0
                    id: motorTempLabel
                    text: "Motor Temp:"
                    font.pointSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: motorTempValueLabel
                    text: bleHandler.motorTemperature.toFixed(1)
                    font.pointSize: smallTextSize
                    color: "white"
                }
                Label
                {
                    id: inverterTempLabel
                    text: "Inverter Temp:"
                    font.pointSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: inverterTempValueLabel
                    text: bleHandler.inverterTemperature.toFixed(1)
                    font.pointSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    Layout.row: 8
                    Layout.column: 0
                    id: rTorqueLabel
                    text: "Torque Request:"
                    font.pointSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: rTorqueValueLabel
                    text: bleHandler.reqTorque.toFixed(1)
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
                    text: bleHandler.actTorque.toFixed(1)
                    font.pointSize: smallTextSize
                    color: "white"
                }


                Label
                {
                    Layout.row: 9
                    Layout.column: 0
                    id: voltLabel
                    text: "Battery Voltage:"
                    font.pointSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: voltValueLabel
                    text: bleHandler.busVoltage.toFixed(1)
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
                    text: bleHandler.busCurrent.toFixed(1)
                    font.pointSize: smallTextSize
                    color: "white"
                }
                Label
                {
                    Layout.row: 10
                    Layout.column: 0
                    id: powerLabel
                    text: "Power:"
                    font.pointSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: powerValueLabel
                    text: bleHandler.mechPower.toFixed(1)
                    font.pointSize: smallTextSize
                    color: "white"
                }

            }
            Label
            {
                 id: statusLabel
                 text: bleHandler.bleStatus
                 color: "red"
                 font.pointSize: largeTextSize * 2.0
                 anchors.top: statusGrid.bottom
                 anchors.topMargin: 100 * stretchFactor
                 horizontalAlignment: Text.AlignHCenter
            }
        }

        Item {
            //Bunch o' gauges
            id: gaugesPage

            CircularGauge {
                id: throttleGauge
                width: bigGaugeWidth
                height: width
                x: 0
                y: 0
                minimumValue: -100
                maximumValue: 100
                style: DefaultGaugeStyle {
                    unitText: "%"
                    description: "Throttle"
                    lowerDangerValue: -80
                    upperDangerValue: 90
                    coloredZones: true
                }
                value: bleHandler.percThrottle
            }

            CircularGauge {
                id: torqueGauge
                width: bigGaugeWidth
                height: width
                x: bigGaugeWidth * 1.15
                y: 0
                minimumValue: -150
                maximumValue: 600
                style: DefaultGaugeStyle {
                    unitText: "Nm"
                    description: "Torque"
                    upperDangerValue: 500
                    coloredZones: true
                }
                value: bleHandler.actTorque
            }

            CircularGauge {
                id: rpmGauge
                width: bigGaugeWidth
                height: width
                x: bigGaugeWidth * 2.3
                y: 0
                maximumValue: 8
                style: TachGaugeStyle {
                }
                value: bleHandler.actRPM / 1000.0
            }
            //second row of gauges
            CircularGauge {
                id: dcvoltsGauge
                width: bigGaugeWidth
                height: width
                x: 0
                y: bigGaugeWidth * 1.15
                minimumValue: 200
                maximumValue: 450
                style: DefaultGaugeStyle {
                    unitText: "V"
                    description: "Pack Voltage"
                    lowerDangerValue: 250
                    upperDangerValue: 400
                    coloredZones: true
                }
                value: bleHandler.busVoltage
            }

            CircularGauge {
                id: currentGauge
                width: bigGaugeWidth
                height: width
                x: bigGaugeWidth * 1.15
                y: bigGaugeWidth * 1.15
                minimumValue: -200
                maximumValue: 400
                style: DefaultGaugeStyle {
                    unitText: "A"
                    description: "Pack Current"
                    lowerDangerValue: -150
                    upperDangerValue: 280
                    coloredZones: true
                }
                value: bleHandler.busCurrent
            }

            CircularGauge {
                id: powerGauge
                width: bigGaugeWidth
                height: width
                x: bigGaugeWidth * 2.3
                y: bigGaugeWidth * 1.15
                minimumValue: -50
                maximumValue: 250
                style: DefaultGaugeStyle {
                    unitText: "kW"
                    description: "Power"
                    upperDangerValue: 150
                    coloredZones: true
                }
                value: bleHandler.mechPower
            }

            CircularGauge {
                id: motorTempGauge
                width: smallGaugeWidth
                height: width
                x: bigGaugeWidth * 3.5
                y: bigGaugeWidth / 3
                maximumValue: 1
                value: bleHandler.motorTemperature / 140.0
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
                width: smallGaugeWidth
                height: width
                x: bigGaugeWidth * 3.5
                y: bigGaugeWidth
                maximumValue: 1
                value: bleHandler.inverterTemperature / 140.0
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
                width: smallGaugeWidth
                height: width
                x: bigGaugeWidth * 3.5
                y: bigGaugeWidth * 1.8
                maximumValue: 1
                value: bleHandler.SOC / 100.0
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

        Item {
            //general configuration page
            id: throttleConfigPage
            Label {
                id: label10
                color: "#AAAAFF"
                text: qsTr("Throttle Configuration:")
                font.pointSize: largeTextSize
                anchors.top: throttleConfigPage.top
                anchors.left: throttleConfigPage.left
            }

            GridLayout
            {
                id: throttleConfigGrid
                columns: 4
                anchors.top: label10.bottom
                anchors.topMargin: 20 * stretchFactor
                columnSpacing: 120 * stretchFactor

                Label {
                    id: label11
                    color: "white"
                    text: qsTr("Num of throttle pots:")
                    font.pointSize: smallTextSize
                }
                ComboBox {
                    id: cbNumPots
                    model: [ "1","2"]
                    currentIndex: bleHandler.numThrottleADC
                    implicitWidth: comboboxSize
                    font.pointSize: smallTextSize
                }
                Label {
                    id: label12
                    color: "white"
                    text: qsTr("Throttle type:")
                    font.pointSize: smallTextSize
                }
                ComboBox {
                    id: cbThrottleType
                    model: [ "Std Pot", "Inv Pot", "Hall Effect" ]
                    currentIndex: bleHandler.throttleType
                    implicitWidth: comboboxSize
                    font.pointSize: smallTextSize
                }

                Label {
                    id: label13
                    color: "white"
                    text: qsTr("Min Level Sig 1")
                    font.pointSize: smallTextSize
                }
                SliderWithText {
                    id: sliderMinSig1
                    minimumValue: 0
                    maximumValue: adcMaxValue
                    value: bleHandler.throttle1Min
                    stepSize: 10
                    implicitWidth: sliderWidth
                    Layout.fillWidth: true;
                }

                Label {
                     id: label15
                     color: "white"
                     text: qsTr("Max Level Sig 1")
                     font.pointSize: smallTextSize
                 }
                 SliderWithText {
                     minimumValue: 0
                     maximumValue: adcMaxValue
                     value: bleHandler.throttle1Max
                     stepSize: 10
                     id: sliderMaxSig1
                     implicitWidth: sliderWidth
                     Layout.fillWidth: true;
                 }
                 Label {
                      id: label17
                      color: "white"
                      text: qsTr("Min Level Sig 2")
                      font.pointSize: smallTextSize
                  }
                  SliderWithText {
                      id: sliderMinSig2
                      minimumValue: 0
                      maximumValue: adcMaxValue
                      value: bleHandler.throttle2Min
                      stepSize: 10
                      implicitWidth: sliderWidth
                 }
                  Label {
                       id: label19
                       color: "white"
                       text: qsTr("Max Level Sig 2")
                       font.pointSize: smallTextSize
                   }
                   SliderWithText {
                       id: sliderMaxSig2
                       minimumValue: 0
                       maximumValue: adcMaxValue
                       value: bleHandler.throttle2Max
                       stepSize: 10
                       implicitWidth: sliderWidth
                   }



               Label {
                    id: label14
                    color: "white"
                    text: qsTr("Regen Max Pedal Position")
                    font.pointSize: smallTextSize
                }
               SliderWithText {
                   id: sliderRegenMaxPedal
                   minimumValue: 0
                   maximumValue: 100
                   value: bleHandler.regenMaxPedalPos
                   stepSize: 1
                   implicitWidth: sliderWidth
               }

               Label {
                    id: label16
                    color: "white"
                    text: qsTr("Regen Min Pedal Position")
                    font.pointSize: smallTextSize
                }
               SliderWithText {
                   id: sliderRegenMinPedal
                   minimumValue: 0
                   maximumValue: adcMaxValue
                   value: bleHandler.regenMinPedalPos
                   stepSize: 10
                   implicitWidth: sliderWidth
               }

               Label {
                    id: label18
                    color: "white"
                    text: qsTr("Motion Start Pedal Position")
                    font.pointSize: smallTextSize
                }
               SliderWithText {
                   id: sliderMotionStart
                   minimumValue: 0
                   maximumValue: 100
                   value: bleHandler.fwdMotionPedalPos
                   stepSize: 1
                   implicitWidth: sliderWidth
               }

               Label {
                    id: label20
                    color: "white"
                    text: qsTr("50% Throttle Pedal Position")
                    font.pointSize: smallTextSize
                }
               SliderWithText {
                   id: sliderHalfThrottle
                   minimumValue: 0
                   maximumValue: 100
                   value: bleHandler.mapPedalPos
                   stepSize: 1
                   implicitWidth: sliderWidth
               }

               Label {
                    id: label21
                    color: "white"
                    text: qsTr("Creep Level")
                    font.pointSize: smallTextSize
                }
                SliderWithText {
                    id: sliderCreepLevel
                    minimumValue: 0
                    maximumValue: 100
                    value: bleHandler.creepThrottle
                    stepSize: 1
                    implicitWidth: sliderWidth
                }
               Label {
                    id: label22
                    color: "white"
                    text: qsTr("Min. Throttle Regen")
                    font.pointSize: smallTextSize
                }
               SliderWithText {
                   id: sliderMinThrottleRegen
                   minimumValue: 0
                   maximumValue: 100
                   value: bleHandler.regenThrottleMin
                   stepSize: 1
                   implicitWidth: sliderWidth
               }
               Label {
                    id: label23
                    color: "white"
                    text: qsTr("Max. Throttle Regen")
                    font.pointSize: smallTextSize
                }
               SliderWithText {
                   id: sliderMaxThrottleRegen
                   minimumValue: 0
                   maximumValue: 100
                   value: bleHandler.regenThrottleMax
                   stepSize: 1
                   implicitWidth: sliderWidth
               }
            }
        }
        Item {
            id: brakeSysConfig

            Label {
                id: label100
                color: "#AAAAFF"
                text: qsTr("Brake:")
                font.pointSize: largeTextSize
                anchors.top: brakeSysConfig.top
                anchors.left: brakeSysConfig.left
            }

            GridLayout
            {
                id: throttleConfigGrid2
                columns: 4
                anchors.top: label100.bottom
                anchors.topMargin: 20
                columnSpacing: 120 * stretchFactor

                Label {
                    id: label101
                    color: "white"
                    text: qsTr("Min Signal Level")
                    font.pointSize: smallTextSize
                }
                SliderWithText {
                    id: sliderMinSigBrake
                    minimumValue: 0
                    maximumValue: adcMaxValue
                    value: bleHandler.brakeMinADC
                    stepSize: 10
                    implicitWidth: sliderWidth
                }
               Label {
                    id: label102
                    color: "white"
                    text: qsTr("Min Brake Regen")
                    font.pointSize: smallTextSize
                }
               SliderWithText {
                   id: sliderMinBrakeRegen
                   minimumValue: 0
                   maximumValue: 100
                   value: bleHandler.regenBrakeMin
                   stepSize: 1
                   implicitWidth: sliderWidth
               }

               Label {
                    id: label103
                    color: "white"
                    text: qsTr("Max Signal Level")
                    font.pointSize: smallTextSize
                }
                SliderWithText {
                    id: sliderMaxSigBrake
                    minimumValue: 0
                    maximumValue: adcMaxValue
                    value: bleHandler.brakeMaxADC
                    stepSize: 10
                    implicitWidth: sliderWidth
                }
               Label {
                    id: label104
                    color: "white"
                    text: qsTr("Max Brake Regen")
                    font.pointSize: smallTextSize
                }
               SliderWithText {
                   id: sliderMaxBrakeRegen
                   minimumValue: 0
                   maximumValue: 100
                   value: bleHandler.regenBrakeMax
                   stepSize: 1
                   implicitWidth: sliderWidth
               }
            }

            Label {
                id: label150
                color: "#AAAAFF"
                text: qsTr("Motor Control:")
                font.pointSize: largeTextSize
                anchors.top: throttleConfigGrid2.bottom
                anchors.left: brakeSysConfig.left
            }

            Row {
                id: configRow9
                spacing: 80 * stretchFactor
                anchors.left: brakeSysConfig.left
                anchors.top: label150.bottom
                anchors.topMargin: 20 * stretchFactor
                anchors.leftMargin: 50 * stretchFactor

                Label {
                    id: maxSpeedLabel
                    color: "white"
                    font.pointSize: smallTextSize
                    text: "Max Speed (RPM):"
                }
                TextField
                {
                    id: maxSpeedText
                    text: bleHandler.maxRPM.toString()
                    font.pointSize: medTextSize
                    color: "white"
                    implicitWidth: textboxSize
                }

                Label {
                    id: maxTorqueLabel
                    color: "white"
                    font.pointSize: smallTextSize
                    text: "Max Torque (Nm):"
                }
                TextField
                {
                    id: maxTorqueText
                    text: bleHandler.maxTorque.toString()
                    font.pointSize: medTextSize
                    color: "white"
                    implicitWidth: textboxSize
                }

                Label {
                    id: motorModeLabel
                    color: "white"
                    font.pointSize: smallTextSize
                    text: "Motor Mode:"
                }
                ComboBox {
                    id: cbMotorMode
                    model: [ "Torque Control", "Speed Control" ]
                    currentIndex: bleHandler.powerMode
                    implicitWidth: comboboxSize
                    font.pointSize: smallTextSize
                }

            }

            Label {
                id: label200
                color: "#AAAAFF"
                text: qsTr("System:")
                font.pointSize: largeTextSize
                anchors.top: configRow9.bottom
                anchors.left: brakeSysConfig.left
            }

            Row {
                id: configRow10
                spacing: 80 * stretchFactor
                anchors.left: brakeSysConfig.left
                anchors.top: label200.bottom
                anchors.topMargin: 20 * stretchFactor
                anchors.leftMargin: 50 * stretchFactor

                Label {
                    id: loggingLabel
                    color: "white"
                    font.pointSize: smallTextSize
                    text: "Log Level:"
                }
                ComboBox {
                    id: cbLogMode
                    model: [ "Debug", "Info", "Warning", "Error", "Off" ]
                    currentIndex: bleHandler.logLevel
                    implicitWidth: comboboxSize
                    font.pointSize: smallTextSize
                }

                Label {
                    id: nomVoltsLabel
                    color: "white"
                    font.pointSize: smallTextSize
                    text: "Nominal Battery Voltage:"
                }
                TextField
                {
                    id: nomVoltsText
                    text: bleHandler.nomBattVolts.toString()
                    implicitWidth: textboxSize
                    font.pointSize: medTextSize
                    color: "white"
                }
            }
        }

        Item {
            id: outputConfigPage

            Label
            {
                id:outputLabel1
                color: "#AAAAFF"
                font.pointSize: largeTextSize
                text: "Digital Outputs - DOUT0 - DOUT7"
            }

            GridLayout
            {
                id: outputConfigGrid1
                columns: 6
                anchors.top: outputLabel1.bottom
                anchors.topMargin: 20 * stretchFactor
                columnSpacing: 80 * stretchFactor

                Label
                {
                    id: outputLabel2
                    color: "white"
                    font.pointSize: smallTextSize
                    text: "Fan Output"
                }
                ComboBox {
                    id: cbFanOutput
                    model: [ "None", "0", "1", "2", "3", "4", "5", "6", "7" ]
                    currentIndex: bleHandler.coolingOutput
                    implicitWidth: comboboxSize
                    font.pointSize: smallTextSize
                }
                Label
                {
                    id: outputLabel3
                    color: "white"
                    font.pointSize: smallTextSize
                    text: "Fan On (Deg C)"
                }
                TextField
                {
                    id:fanOnTempText
                    text: bleHandler.coolingOnTemp.toString()
                    font.pointSize: medTextSize
                    color: "white"
                    implicitWidth: textboxSize
                }
                Label
                {
                    id: outputLabel4
                    color: "white"
                    font.pointSize: smallTextSize
                    text: "Fan Off (Deg C)"
                }
                TextField
                {
                    id: fanOffTempText
                    text: bleHandler.coolingOffTemp.toString()
                    font.pointSize: medTextSize
                    color: "white"
                    implicitWidth: textboxSize
                }

                Label
                {
                    id: outputLabel5
                    color: "white"
                    font.pointSize: smallTextSize
                    text: "Precharge Output"
                }
                ComboBox {
                    id: cbPrechargeOutput
                    model: [ "None", "0", "1", "2", "3", "4", "5", "6", "7" ]
                    currentIndex: bleHandler.prechargeOutput
                    implicitWidth: comboboxSize
                    font.pointSize: smallTextSize
                }
                Label
                {
                    id: outputLabel6
                    color: "white"
                    font.pointSize: smallTextSize
                    text: "Precharge Delay (ms)"
                }
                TextField
                {
                    id:prechargeDelayText
                    text: bleHandler.prechargeDuration.toString()
                    font.pointSize: medTextSize
                    color: "white"
                    implicitWidth: textboxSize
                }

                Label
                {
                    id: outputLabel7
                    color: "white"
                    font.pointSize: smallTextSize
                    text: "Main Contactor Output"
                    Layout.row: 2
                    Layout.column: 0
                }
                ComboBox {
                    id: cbMainContOutput
                    model: [ "None", "0", "1", "2", "3", "4", "5", "6", "7" ]
                    currentIndex: bleHandler.mainContactorOutput
                    implicitWidth: comboboxSize
                    font.pointSize: smallTextSize
                }

                Label
                {
                    id: outputLabel8
                    color: "white"
                    font.pointSize: smallTextSize
                    text: "Brake Light Output"
                    Layout.row: 3
                    Layout.column: 0
                }
                ComboBox {
                    id: cbBrakeLightOutput
                    model: [ "None", "0", "1", "2", "3", "4", "5", "6", "7" ]
                    currentIndex: bleHandler.brakeLightOutput
                    implicitWidth: comboboxSize
                    font.pointSize: smallTextSize
                }

                Label
                {
                    id: outputLabel9
                    color: "white"
                    font.pointSize: smallTextSize
                    text: "Reverse Light Output"
                    Layout.row: 4
                    Layout.column: 0
                }
                ComboBox {
                    id: cbReverseLightOutput
                    model: [ "None", "0", "1", "2", "3", "4", "5", "6", "7" ]
                    currentIndex: bleHandler.reverseLightOutput
                    implicitWidth: comboboxSize
                    font.pointSize: smallTextSize
                }
            }

            RowLayout {
                id: dashboardRow2
                spacing: 20 * stretchFactor
                anchors.top: outputConfigGrid1.bottom
                anchors.topMargin: 50 * stretchFactor

                Label {
                    id: label2
                    color: "#1fcaff"
                    text: qsTr("Outputs:")
                    font.pointSize: medTextSize
                }

                StatusIndicator {
                    id: statusOutput1
                    active: bleHandler.digitalOutputs & 1
                }

                StatusIndicator {
                    id: statusOutput2
                    active: bleHandler.digitalOutputs & 2
                }

                StatusIndicator {
                    id: statusOutput3
                    active: bleHandler.digitalOutputs & 4
                }

                StatusIndicator {
                    id: statusOutput4
                    active: bleHandler.digitalOutputs & 8
                }

                StatusIndicator {
                    id: statusOutput5
                    active: bleHandler.digitalOutputs & 16
                }

                StatusIndicator {
                    id: statusOutput6
                    active: bleHandler.digitalOutputs & 32
                }
                StatusIndicator {
                    id: statusOutput7
                    active: bleHandler.digitalOutputs & 64
                }

                StatusIndicator {
                    id: statusOutput8
                    active: bleHandler.digitalOutputs & 128
                }
            }

        }
        Item {
            id: inputsConfigPage

            Label
            {
                id:inputLabel1
                color: "#AAAAFF"
                font.pointSize: largeTextSize
                text: "Digital Inputs - DIN0 - DIN3"
            }

            GridLayout
            {
                id: inputConfigGrid1
                columns: 2
                anchors.top: inputLabel1.bottom
                anchors.topMargin: 20 * stretchFactor
                columnSpacing: 80 * stretchFactor

                Label
                {
                    id: inputLabel2
                    color: "white"
                    font.pointSize: smallTextSize
                    text: "Enable Input"
                }
                ComboBox {
                    id: cbEnableInput
                    model: [ "None", "0", "1", "2", "3" ]
                    currentIndex: bleHandler.enableMotorControlInput
                    implicitWidth: comboboxSize
                    font.pointSize: smallTextSize
                }

                Label
                {
                    id: inputLabel3
                    color: "white"
                    font.pointSize: smallTextSize
                    text: "Reverse Input"
                }
                ComboBox {
                    id: cbReverseInput
                    model: [ "None", "0", "1", "2", "3" ]
                    currentIndex: bleHandler.reverseInput
                    font.pointSize: smallTextSize
                    implicitWidth: comboboxSize
                }
            }

            RowLayout {
                id: dashboardRow1
                spacing: 20 * stretchFactor
                anchors.top: inputConfigGrid1.bottom
                anchors.topMargin: 50 * stretchFactor

                Label {
                    id: label1
                    color: "#1fcaff"
                    text: qsTr("Inputs:")
                    font.pointSize: medTextSize
                }

                StatusIndicator {
                    id: statusInput1
                    active: bleHandler.digitalInputs & 1
                }

                StatusIndicator {
                    id: statusInput2
                    active: bleHandler.digitalInputs & 2
                }

                StatusIndicator {
                    id: statusInput3
                    active: bleHandler.digitalInputs & 4
                }

                StatusIndicator {
                    id: statusInput4
                    active: bleHandler.digitalInputs & 8
                }
            }
        }
        Item {
            id: devicesConfigPage

            Label
            {
                id:deviceLabel1
                color: "#AAAAFF"
                font.pointSize: largeTextSize
                text: "Device Selection / Activation"
            }

            GridLayout
            {
                id: deviceConfigGrid1
                columns: 4
                anchors.top: deviceLabel1.bottom
                anchors.topMargin: 20 * stretchFactor
                columnSpacing: 80 * stretchFactor

                Label
                {
                    id:deviceLabel2
                    color: "#6666BB"
                    font.pointSize: medTextSize
                    text: "Motor Controllers"
                }
                Label
                {
                    id:deviceLabel3
                    color: "#6666BB"
                    font.pointSize: medTextSize
                    text: "Throttle and Brake"
                    Layout.row: 0
                    Layout.column: 2
                }

                Label
                {
                    id:deviceLabel4
                    color: "white"
                    font.pointSize: smallTextSize
                    text: "Azure Dynamics DMOC645"
                    Layout.row: 1
                    Layout.column: 0
                }
                ComboBox {
                    id: cbDMOC645
                    model: [ "Disabled", "Enabled" ]
                    currentIndex: valueStorage.dmocEnabled
                    implicitWidth: comboboxSize
                    font.pointSize: smallTextSize
                }
                Label
                {
                    id:deviceLabel5
                    color: "white"
                    font.pointSize: smallTextSize
                    text: "Potentiometer/Hall Effect Throttle"
                }
                ComboBox {
                    id: cbPotThrottle
                    model: [ "Disabled", "Enabled" ]
                    currentIndex: valueStorage.potThrottleEnabled
                    implicitWidth: comboboxSize
                    font.pointSize: smallTextSize
                }

                Label
                {
                    id:deviceLabel6
                    color: "white"
                    font.pointSize: smallTextSize
                    text: "UQM Powerphase 100"
                }
                ComboBox {
                    id: cbUQMPowerPhase
                    model: [ "Disabled", "Enabled" ]
                    currentIndex: valueStorage.uqmPowerphaseEnabled
                    implicitWidth: comboboxSize
                    font.pointSize: smallTextSize
                }
                Label
                {
                    id:deviceLabel7
                    color: "white"
                    font.pointSize: smallTextSize
                    text: "Potentiometer/Hall Effect Brake"
                }
                ComboBox {
                    id: cbPotBrake
                    model: [ "Disabled", "Enabled" ]
                    currentIndex: valueStorage.potBrakeEnabled
                    implicitWidth: comboboxSize
                    font.pointSize: smallTextSize
                }

                Label
                {
                    id:deviceLabel8
                    color: "white"
                    font.pointSize: smallTextSize
                    text: "Brusa DMC5"
                }
                ComboBox {
                    id: cbBrusaDMC5
                    model: [ "Disabled", "Enabled" ]
                    currentIndex: valueStorage.brusaDMCEnabled
                    implicitWidth: comboboxSize
                    font.pointSize: smallTextSize
                }
                Label
                {
                    id:deviceLabel9
                    color: "white"
                    font.pointSize: smallTextSize
                    text: "CANBus Throttle"
                }
                ComboBox {
                    id: cbCANThrottle
                    model: [ "Disabled", "Enabled" ]
                    currentIndex: valueStorage.canThrottleEnabled
                    implicitWidth: comboboxSize
                    font.pointSize: smallTextSize
                }

                Label
                {
                    id:deviceLabel10
                    color: "white"
                    font.pointSize: smallTextSize
                    text: "CANBus Brake"
                }
                ComboBox {
                    id: cbCANBrake
                    model: [ "Disabled", "Enabled" ]
                    currentIndex: valueStorage.canBrakeEnabled
                    implicitWidth: comboboxSize
                    font.pointSize: smallTextSize
                }

                Label
                {
                    id:deviceLabel20
                    color: "#6666BB"
                    font.pointSize: medTextSize
                    text: "Communication Interfaces"
                    Layout.row: 5
                    Layout.column:0
                }

                Label
                {
                    id:deviceLabel21
                    color: "#6666BB"
                    font.pointSize: medTextSize
                    text: "Battery Chargers and Management"
                    Layout.row: 5
                    Layout.column: 2
                }

                Label
                {
                    id:deviceLabel22
                    color: "white"
                    font.pointSize: smallTextSize
                    text: "ConnectOne WiReach Wifi"
                    Layout.row: 6
                    Layout.column: 0
                }
                ComboBox {
                    id: cbCOWifi
                    model: [ "Disabled", "Enabled" ]
                    currentIndex: valueStorage.wiReachEnabled
                    implicitWidth: comboboxSize
                    font.pointSize: smallTextSize
                }
                Label
                {
                    id:deviceLabel23
                    color: "white"
                    font.pointSize: smallTextSize
                    text: "Brusa NLG5 Charger"
                }
                ComboBox {
                    id: cbBrusaNLG5
                    model: [ "Disabled", "Enabled" ]
                    currentIndex: valueStorage.brusaNLGEnabled
                    implicitWidth: comboboxSize
                    font.pointSize: smallTextSize
                }

                Label
                {
                    id:deviceLabel24
                    color: "white"
                    font.pointSize: smallTextSize
                    text: "ELM327 OBDII Wireless"
                }
                ComboBox {
                    id: cbELM327
                    model: [ "Disabled", "Enabled" ]
                    currentIndex: valueStorage.elm327Enabled
                    implicitWidth: comboboxSize
                    font.pointSize: smallTextSize
                }
                Label
                {
                    id:deviceLabel25
                    color: "white"
                    font.pointSize: smallTextSize
                    text: "TCCH/Elcon Charger"
                }
                ComboBox {
                    id: cbTCCH
                    model: [ "Disabled", "Enabled" ]
                    currentIndex: valueStorage.tcchEnabled
                    implicitWidth: comboboxSize
                    font.pointSize: smallTextSize
                }

                Label
                {
                    id:deviceLabel26
                    color: "white"
                    font.pointSize: smallTextSize
                    text: "OBDII PID Listener (CANBus)"
                }
                ComboBox {
                    id: cbOBD2PID
                    model: [ "Disabled", "Enabled" ]
                    currentIndex: valueStorage.pidListenerEnabled
                    implicitWidth: comboboxSize
                    font.pointSize: smallTextSize
                }
                Label
                {
                    id:deviceLabel27
                    color: "white"
                    font.pointSize: smallTextSize
                    text: "Lear Charger"
                }
                ComboBox {
                    id: cbLearCharger
                    model: [ "Disabled", "Enabled" ]
                    currentIndex: valueStorage.learChargerEnabled
                    implicitWidth: comboboxSize
                    font.pointSize: smallTextSize
                }

                Label
                {
                    id:deviceLabel28
                    color: "white"
                    font.pointSize: smallTextSize
                    text: "Think BMS"
                }
                ComboBox {
                    id: cbThinkBMS
                    model: [ "Disabled", "Enabled" ]
                    currentIndex: valueStorage.thinkBMSEnabled
                    implicitWidth: comboboxSize
                    font.pointSize: smallTextSize
                }
            }
        }
        Item {
            id: aboutPage

            TextArea {
                font.pointSize: smallTextSize
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
