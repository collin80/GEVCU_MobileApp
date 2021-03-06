import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import QtQuick.Window 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4

Item {
    id: root
    visible: true
    width: root.width
    height: root.height

    property real stretchFactor: (root.width / 1920)
    property real smallTextSize: 30 * stretchFactor
    property real tabTextSize: 36 * stretchFactor
    property real medTextSize: 43 * stretchFactor
    property real largeTextSize: 55 * stretchFactor
    property real textboxSize: 175 * stretchFactor
    property real comboboxSize: 240 * stretchFactor
    property real bigGaugeWidth: 440 * stretchFactor
    property real hugeGaugeWidth: 880 * stretchFactor
    property real medGaugeWidth: 330 * stretchFactor
    property real smallGaugeWidth: 220 * stretchFactor
    property real sliderWidth: 800 * stretchFactor
    property real sliderBuffer: 100 * stretchFactor
    property int adcMaxValue: 4096
    property int screenIndex: 0

    /*
      There are two sets of tabbar buttons now and so there is no direct way to get the index into the list of Views.
      However, this function calculates the proper index and updates the screenIndex property which notifies
      the system to change screens
     */
    function calcScreenIndex()
    {
        if (barTopLevel.currentIndex == 0) //status screens
        {
            switch (barTabsStatus.currentIndex)
            {
            case 0:
                screenIndex = 0;
                break;
            case 1:
                screenIndex = 1;
                break;
            case 2:
                screenIndex = 2;
                break;
            case 3:
                screenIndex = 10;
                break;
            }
        }
        else if (barTopLevel.currentIndex == 1) //config screens
        {
            switch (barTabsConfig.currentIndex)
            {
            case 0:
                screenIndex = 3;
                break;
            case 1:
                screenIndex = 4;
                break;
            case 2:
                screenIndex = 5;
                break;
            case 3:
                screenIndex = 6;
                break;
            case 4:
                screenIndex = 7;
                break;
            case 5:
                screenIndex = 8;
                break;
            case 6:
                screenIndex = 9;
                break;

            }
        }
    }

    Image
    {
        source: "qrc:/images/evtvbackground.png"
        width: root.width
        height: root.height
        fillMode: Image.Stretch
    }

    TabBar
    {
        id: barTopLevel
        width: parent.width * 0.20
        height: tabTextSize * 1.2
        onCurrentIndexChanged: calcScreenIndex()
        font.pixelSize: tabTextSize

        background: Rectangle {
            color: "#00cc00"
        }

        TabButton
        {
            text: qsTr("Status")
        }
        TabButton
        {
            text: qsTr("Config")
        }
    }

    StackLayout
    {
        id: swipedView

        currentIndex: barTopLevel.currentIndex
        anchors.right: root.right
        width: parent.width * 0.75

        Item
        {
            id: statusButtons
            TabBar
            {
                id: barTabsStatus
                onCurrentIndexChanged: calcScreenIndex()
                width: parent.width
                height: tabTextSize * 1.2
                font.pixelSize: tabTextSize

                background: Rectangle {
                    color: "#00cc00"
                    opacity: 1
                }

                TabButton {

                    text: qsTr("Status")
                }
                TabButton {

                    text: qsTr("Gauges1")
                }
                TabButton {
                    text: qsTr("Gauge2")
                }
                TabButton {
                    text: qsTr("About")
                }
            }
        }

        Item
        {
            id: configButtons
            TabBar
            {
                id: barTabsConfig
                onCurrentIndexChanged: calcScreenIndex()
                width: parent.width
                height: tabTextSize * 1.2
                font.pixelSize: tabTextSize
                background: Rectangle {
                    color: "#00cc00"
                }

                TabButton {
                    text: qsTr("Throttle")
                }
                TabButton {
                    text: qsTr("Brakes")
                }
                TabButton {
                    text: qsTr("Motor Ctl")
                }
                TabButton {
                    text: qsTr("System")
                }
                TabButton {
                    text: qsTr("Output")
                }
                TabButton {
                    text: qsTr("Input")
                }
                TabButton {
                    text: qsTr("Devices")
                }
            }
        }
    }


    StackLayout {
        id: swipedView2

        currentIndex: screenIndex
        anchors.fill: parent
        anchors.topMargin: 80

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
                    font.pixelSize: largeTextSize
                    color: "#AAAAFF"
                    Layout.row: 0
                    Layout.column: 0
                    Layout.columnSpan: 4
                }

                Label
                {
                    id: runningLabel
                    text: "Running:"
                    font.pixelSize: smallTextSize
                    color: "white"
                    Layout.row: 1
                    Layout.column: 0
                }

                Label
                {
                    id: runningValueLabel
                    text: bleHandler.isRunning.toString()
                    font.pixelSize: smallTextSize
                    color: "white"
                    Layout.fillWidth: true
                }
                Label
                {
                    id: optimeLabel
                    text: "Up Time:"
                    font.pixelSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: optimeValueLabel
                    text: bleHandler.timeRunning.toString()
                    font.pixelSize: smallTextSize
                    color: "white"
                    Layout.fillWidth: true
                }
                Label
                {
                    id: tlevLabel
                    text: "Throttle Level:"
                    font.pixelSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: tlevValueLabel
                    text: bleHandler.rawThrottle1.toString()
                    font.pixelSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: blevLabel
                    text: "Brake Level:"
                    font.pixelSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: blevValueLabel
                    text: bleHandler.rawBrake.toString()
                    font.pixelSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: faultLabel
                    text: "Fault:"
                    font.pixelSize: smallTextSize
                    color: "white"
                    Layout.row: 4
                    Layout.column: 0
                }

                Label
                {
                    id: faultValueLabel
                    text: bleHandler.isFaulted.toString()
                    font.pixelSize: smallTextSize
                    color: "white"
                }
                Label
                {
                    id: warningLabel
                    text: "Warning:"
                    font.pixelSize: smallTextSize
                    color: "white"
                    Layout.row: 5
                    Layout.column: 0
                }

                Label
                {
                    id: warningValueLabel
                    text: bleHandler.isWarning.toString()
                    font.pixelSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: gearLabel
                    text: "Gear Switch:"
                    font.pixelSize: smallTextSize
                    color: "white"
                    Layout.row: 6
                    Layout.column: 0
                }

                Label
                {
                    id: gearValueLabel
                    text: bleHandler.gear.toString()
                    font.pixelSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    Layout.row: 7
                    Layout.column: 0
                    id: motorTempLabel
                    text: "Motor Temp:"
                    font.pixelSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: motorTempValueLabel
                    text: bleHandler.motorTemperature.toFixed(1)
                    font.pixelSize: smallTextSize
                    color: "white"
                }
                Label
                {
                    id: inverterTempLabel
                    text: "Inverter Temp:"
                    font.pixelSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: inverterTempValueLabel
                    text: bleHandler.inverterTemperature.toFixed(1)
                    font.pixelSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    Layout.row: 8
                    Layout.column: 0
                    id: rTorqueLabel
                    text: "Torque Request:"
                    font.pixelSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: rTorqueValueLabel
                    text: bleHandler.reqTorque.toFixed(1)
                    font.pixelSize: smallTextSize
                    color: "white"
                }
                Label
                {
                    id: aTorqueLabel
                    text: "Actual Torque:"
                    font.pixelSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: aTorqueValueLabel
                    text: bleHandler.actTorque.toFixed(1)
                    font.pixelSize: smallTextSize
                    color: "white"
                }


                Label
                {
                    Layout.row: 9
                    Layout.column: 0
                    id: voltLabel
                    text: "Battery Voltage:"
                    font.pixelSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: voltValueLabel
                    text: bleHandler.busVoltage.toFixed(1)
                    font.pixelSize: smallTextSize
                    color: "white"
                }
                Label
                {
                    id: currentLabel
                    text: "Battery Current:"
                    font.pixelSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: currentValueLabel
                    text: bleHandler.busCurrent.toFixed(1)
                    font.pixelSize: smallTextSize
                    color: "white"
                }
                Label
                {
                    Layout.row: 10
                    Layout.column: 0
                    id: powerLabel
                    text: "Power:"
                    font.pixelSize: smallTextSize
                    color: "white"
                }

                Label
                {
                    id: powerValueLabel
                    text: bleHandler.mechPower.toFixed(1)
                    font.pixelSize: smallTextSize
                    color: "white"
                }

            }
            Label
            {
                 id: statusLabel
                 text: bleHandler.bleStatus
                 color: "red"
                 font.pixelSize: largeTextSize * 2.0
                 anchors.top: statusGrid.bottom
                 anchors.topMargin: 100 * stretchFactor
                 horizontalAlignment: Text.AlignHCenter
            }
            Button
            {
                id: scanButton
                text: "Rescan for GEVCU"
                font.pixelSize: medTextSize
                anchors.top: statusLabel.bottom
                anchors.topMargin: 50 * stretchFactor
                onClicked: bleHandler.deviceSearch()
                background: Rectangle {
                    implicitWidth: 150 * stretchFactor
                    implicitHeight: 45 * stretchFactor
                    border.width: scanButton.activeFocus ? 2 : 1
                    border.color: "#888"
                    radius: 16 * stretchFactor
                    gradient: Gradient {
                        GradientStop { position: 0 ; color: scanButton.pressed ? "#eee" : "#eee" }
                        GradientStop { position: 1 ; color: scanButton.pressed ? "#888" : "#ccc" }
                    }
                }
            }
        }

        //RPM gauge large in the center
        //two gauges on each side much smaller
        //torque then current on left side, power then motor temperature on right

        Item
        {
            id: largeGaugePage

            CircularGauge {
                id: rpmGauge1
                width: hugeGaugeWidth
                height: width
                anchors.centerIn: largeGaugePage
                maximumValue: 8
                style: TachGaugeStyle {
                }
                value: bleHandler.actRPM / 1000.0
            }

            CircularGauge {
                id: currentGauge1
                width: medGaugeWidth
                height: width
                anchors.right: rpmGauge1.left
                anchors.top: rpmGauge1.top
                anchors.topMargin: largeTextSize
                anchors.rightMargin: largeTextSize
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
                id: torqueGauge1
                width: medGaugeWidth
                height: width
                anchors.right: rpmGauge1.left
                anchors.bottom: rpmGauge1.bottom
                anchors.bottomMargin: largeTextSize
                anchors.rightMargin: largeTextSize
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
                id: powerGauge1
                width: medGaugeWidth
                height: width
                anchors.left: rpmGauge1.right
                anchors.top: rpmGauge1.top
                anchors.topMargin: largeTextSize
                anchors.leftMargin: largeTextSize
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
                id: motorTempGauge1
                width: medGaugeWidth
                height: width
                anchors.left: rpmGauge1.right
                anchors.bottom: rpmGauge1.bottom
                anchors.bottomMargin: largeTextSize
                anchors.leftMargin: largeTextSize
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
                font.pixelSize: largeTextSize
                anchors.top: throttleConfigPage.top
                anchors.left: throttleConfigPage.left
            }

            GridLayout
            {
                id: throttleConfigGrid
                columns: 3
                anchors.top: label10.bottom
                anchors.topMargin: 20 * stretchFactor
                columnSpacing: 120 * stretchFactor

                Label {
                    id: label11
                    color: "white"
                    text: qsTr("Num of throttle pots:")
                    font.pixelSize: smallTextSize
                }
                ComboBox {
                    id: cbNumPots
                    model: [ "1","2"]
                    currentIndex: bleHandler.numThrottleADC
                    implicitWidth: comboboxSize
                    font.pixelSize: smallTextSize
                    onActivated: bleHandler.numThrottleADC = currentIndex
                }
                Label {
                    id: label12
                    color: "white"
                    text: qsTr("Throttle type:")
                    font.pixelSize: smallTextSize
                    Layout.row: 1
                    Layout.column: 0
                }
                ComboBox {
                    id: cbThrottleType
                    model: [ "Std Pot", "Inv Pot", "Hall Effect" ]
                    currentIndex: bleHandler.throttleType
                    implicitWidth: comboboxSize
                    font.pixelSize: smallTextSize
                    onActivated: bleHandler.throttleType = currentIndex
                }

                Label {
                    id: label13
                    color: "white"
                    text: qsTr("Min Level Sig 1")
                    font.pixelSize: smallTextSize
                    Layout.row: 2
                    Layout.column: 0
                }
                TextField
                {
                    id: textMinSig1
                    text: bleHandler.throttle1Min.toFixed(0)
                    font.pixelSize: medTextSize
                    color: "white"
                    implicitWidth: textboxSize
                    onEditingFinished:  {
                        sliderMinSig1.value = parseInt(text)
                        bleHandler.throttle1Min = sliderMinSig1.value
                    }
                }
                Slider {
                    id: sliderMinSig1                   
                    from: 0
                    to: adcMaxValue
                    value: bleHandler.throttle1Min
                    stepSize: 10
                    implicitWidth: sliderWidth
                    Layout.fillWidth: true;
                    onValueChanged: {
                        bleHandler.throttle1Min = value
                        textMinSig1.text = value.toFixed(0)
                    }
                }
                Label {
                     id: label15
                     color: "white"
                     text: qsTr("Max Level Sig 1")
                     font.pixelSize: smallTextSize
                 }
                TextField
                {
                    id: textMaxSig1
                    text: bleHandler.throttle1Max.toFixed(0)
                    font.pixelSize: medTextSize
                    color: "white"
                    implicitWidth: textboxSize
                    onEditingFinished:  {
                        sliderMaxSig1.value = parseInt(text)
                        bleHandler.throttle1Max = sliderMaxSig1.value
                    }
                }

                 Slider {
                     from: 0
                     to: adcMaxValue
                     value: bleHandler.throttle1Max
                     stepSize: 10
                     id: sliderMaxSig1
                     implicitWidth: sliderWidth
                     Layout.fillWidth: true;
                     onValueChanged: {
                         textMaxSig1.text = value.toFixed(0)
                         bleHandler.throttle1Max = value
                     }
                 }
                 Label {
                      id: label17
                      color: "white"
                      text: qsTr("Min Level Sig 2")
                      font.pixelSize: smallTextSize
                  }
                 TextField
                 {
                     id: textMinSig2
                     text: bleHandler.throttle2Min.toFixed(0)
                     font.pixelSize: medTextSize
                     color: "white"
                     implicitWidth: textboxSize
                     onEditingFinished:  {
                         sliderMinSig2.value = parseInt(text)
                         bleHandler.throttle2Min = sliderMinSig2.value
                     }
                 }
                  Slider {
                      id: sliderMinSig2
                      from: 0
                      to: adcMaxValue
                      value: bleHandler.throttle2Min
                      stepSize: 10
                      implicitWidth: sliderWidth
                      onValueChanged: {
                          textMinSig2.text = value.toFixed(0)
                          bleHandler.throttle2Min = value
                      }
                 }
                  Label {
                       id: label19
                       color: "white"
                       text: qsTr("Max Level Sig 2")
                       font.pixelSize: smallTextSize
                   }
                  TextField
                  {
                      id: textMaxSig2
                      text: bleHandler.throttle2Max.toFixed(0)
                      font.pixelSize: medTextSize
                      color: "white"
                      implicitWidth: textboxSize
                      onEditingFinished:  {
                          sliderMaxSig2.value = parseInt(text)
                          bleHandler.throttle2Max = sliderMaxSig2.value
                      }
                  }

                   Slider {
                       id: sliderMaxSig2
                       from: 0
                       to: adcMaxValue
                       value: bleHandler.throttle2Max
                       stepSize: 10
                       implicitWidth: sliderWidth
                       onValueChanged: {
                           textMaxSig2.text = value.toFixed(0)
                           bleHandler.throttle2Max = value
                       }
                   }



               Label {
                    id: label14
                    color: "white"
                    text: qsTr("Regen Max Pedal Position")
                    font.pixelSize: smallTextSize
                }
               TextField
               {
                   id: textRegenMaxPedal
                   text: bleHandler.regenMaxPedalPos.toFixed(0)
                   font.pixelSize: medTextSize
                   color: "white"
                   implicitWidth: textboxSize
                   onEditingFinished:  {
                       sliderRegenMaxPedal.value = parseInt(text)
                       bleHandler.regenMaxPedalPos = sliderRegenMaxPedal.value
                   }
               }
               Slider {
                   id: sliderRegenMaxPedal
                   from: 0
                   to: 100
                   value: bleHandler.regenMaxPedalPos
                   stepSize: 1
                   implicitWidth: sliderWidth
                   onValueChanged: {
                       textRegenMaxPedal.text = value.toFixed(0)
                       bleHandler.regenMaxPedalPos = value
                   }
               }

               Label {
                    id: label16
                    color: "white"
                    text: qsTr("Regen Min Pedal Position")
                    font.pixelSize: smallTextSize
                }
               TextField
               {
                   id: textRegenMinPedal
                   text: bleHandler.regenMinPedalPos.toFixed(0)
                   font.pixelSize: medTextSize
                   color: "white"
                   implicitWidth: textboxSize
                   onEditingFinished:  {
                       sliderRegenMinPedal.value = parseInt(text)
                       bleHandler.regenMinPedalPos = sliderRegenMinPedal.value
                   }
               }
               Slider {
                   id: sliderRegenMinPedal
                   from: 0
                   to: 100
                   value: bleHandler.regenMinPedalPos
                   stepSize: 10
                   implicitWidth: sliderWidth
                   onValueChanged: {
                       textRegenMinPedal.text = value.toFixed(0)
                       bleHandler.regenMinPedalPos = value
                   }
               }

               Label {
                    id: label18
                    color: "white"
                    text: qsTr("Motion Start Pedal Position")
                    font.pixelSize: smallTextSize
                }
               TextField
               {
                   id: textMotionStart
                   text: bleHandler.fwdMotionPedalPos.toFixed(0)
                   font.pixelSize: medTextSize
                   color: "white"
                   implicitWidth: textboxSize
                   onEditingFinished:  {
                       sliderMotionStart.value = parseInt(text)
                       bleHandler.fwdMotionPedalPos = sliderMotionStart.value
                   }
               }
               Slider {
                   id: sliderMotionStart
                   from: 0
                   to: 100
                   value: bleHandler.fwdMotionPedalPos
                   stepSize: 1
                   implicitWidth: sliderWidth
                   onValueChanged: {
                       textMotionStart.text = value.toFixed(0)
                       bleHandler.fwdMotionPedalPos = value
                   }
               }

               Label {
                    id: label20
                    color: "white"
                    text: qsTr("50% Throttle Pedal Position")
                    font.pixelSize: smallTextSize
                }
               TextField
               {
                   id: textHalfThrottle
                   text: bleHandler.mapPedalPos.toFixed(0)
                   font.pixelSize: medTextSize
                   color: "white"
                   implicitWidth: textboxSize
                   onEditingFinished:  {
                       sliderHalfThrottle.value = parseInt(text)
                       bleHandler.mapPedalPos = sliderHalfThrottle.value
                   }
               }
               Slider {
                   id: sliderHalfThrottle
                   from: 0
                   to: 100
                   value: bleHandler.mapPedalPos
                   stepSize: 1
                   implicitWidth: sliderWidth
                   onValueChanged: {
                       textHalfThrottle.text = value.toFixed(0)
                       bleHandler.mapPedalPos = value
                   }
               }

               Label {
                    id: label21
                    color: "white"
                    text: qsTr("Creep Level")
                    font.pixelSize: smallTextSize
                }
               TextField
               {
                   id: textCreepLevel
                   text: bleHandler.creepThrottle.toFixed(0)
                   font.pixelSize: medTextSize
                   color: "white"
                   implicitWidth: textboxSize
                   onEditingFinished:  {
                       sliderCreepLevel.value = parseInt(text)
                       bleHandler.creepThrottle = sliderCreepLevel.value
                   }
               }
                Slider {
                    id: sliderCreepLevel
                    from: 0
                    to: 100
                    value: bleHandler.creepThrottle
                    stepSize: 1
                    implicitWidth: sliderWidth
                    onValueChanged: {
                        textCreepLevel.text = value.toFixed(0)
                        bleHandler.creepThrottle = value
                    }
                }
               Label {
                    id: label22
                    color: "white"
                    text: qsTr("Min. Throttle Regen")
                    font.pixelSize: smallTextSize
                }
               TextField
               {
                   id: textMinThrottleRegen
                   text: bleHandler.regenThrottleMin.toFixed(0)
                   font.pixelSize: medTextSize
                   color: "white"
                   implicitWidth: textboxSize
                   onEditingFinished:  {
                       sliderMinThrottleRegen.value = parseInt(text)
                       bleHandler.regenThrottleMin = sliderMinThrottleRegen.value
                   }
               }

               Slider {
                   id: sliderMinThrottleRegen
                   from: 0
                   to: 100
                   value: bleHandler.regenThrottleMin
                   stepSize: 1
                   implicitWidth: sliderWidth
                   onValueChanged: {
                       textMinThrottleRegen.text = value.toFixed(0)
                       bleHandler.regenThrottleMin = value
                   }
               }
               Label {
                    id: label23
                    color: "white"
                    text: qsTr("Max. Throttle Regen")
                    font.pixelSize: smallTextSize
                }
               TextField
               {
                   id: textMaxThrottleRegen
                   text: bleHandler.regenThrottleMax.toFixed(0)
                   font.pixelSize: medTextSize
                   color: "white"
                   implicitWidth: textboxSize
                   onEditingFinished:  {
                       sliderMaxThrottleRegen.value = parseInt(text)
                       bleHandler.regenThrottleMax = sliderMaxThrottleRegen.value
                   }
               }
               Slider {
                   id: sliderMaxThrottleRegen
                   from: 0
                   to: 100
                   value: bleHandler.regenThrottleMax
                   stepSize: 1
                   implicitWidth: sliderWidth
                   onValueChanged: {
                       textMaxThrottleRegen.text = value.toFixed(0)
                       bleHandler.regenThrottleMax = value
                   }
               }
            }
        }
        Item {
            id: brakeSysConfig

            Label {
                id: label100
                color: "#AAAAFF"
                text: qsTr("Brake:")
                font.pixelSize: largeTextSize
                anchors.top: brakeSysConfig.top
                anchors.left: brakeSysConfig.left
            }

            GridLayout
            {
                id: throttleConfigGrid2
                columns: 3
                anchors.top: label100.bottom
                anchors.topMargin: 20
                columnSpacing: 120 * stretchFactor

                Label {
                    id: label101
                    color: "white"
                    text: qsTr("Min Signal Level")
                    font.pixelSize: smallTextSize
                }
                TextField
                {
                    id: textMinSigBrake
                    text: bleHandler.brakeMinADC.toFixed(0)
                    font.pixelSize: medTextSize
                    color: "white"
                    implicitWidth: textboxSize
                    onEditingFinished:  {
                        sliderMinSigBrake.value = parseInt(text)
                        bleHandler.brakeMinADC = sliderMinSigBrake.value
                    }
                }
                Slider {
                    id: sliderMinSigBrake
                    from: 0
                    to: adcMaxValue
                    value: bleHandler.brakeMinADC
                    stepSize: 10
                    implicitWidth: sliderWidth
                    onValueChanged: {
                        textMinSigBrake.text = value.toFixed(0)
                        bleHandler.brakeMinADC = value
                    }
                }
               Label {
                    id: label102
                    color: "white"
                    text: qsTr("Min Brake Regen")
                    font.pixelSize: smallTextSize
                }
               TextField
               {
                   id: textMinBrakeRegen
                   text: bleHandler.regenBrakeMin.toFixed(0)
                   font.pixelSize: medTextSize
                   color: "white"
                   implicitWidth: textboxSize
                   onEditingFinished:  {
                       sliderMinBrakeRegen.value = parseInt(text)
                       bleHandler.regenBrakeMin = sliderMinBrakeRegen.value
                   }
               }
               Slider {
                   id: sliderMinBrakeRegen
                   from: 0
                   to: 100
                   value: bleHandler.regenBrakeMin
                   stepSize: 1
                   implicitWidth: sliderWidth
                   onValueChanged: {
                       textMinBrakeRegen.text = value.toFixed(0)
                       bleHandler.regenBrakeMin = value
                   }
               }

               Label {
                    id: label103
                    color: "white"
                    text: qsTr("Max Signal Level")
                    font.pixelSize: smallTextSize
                }
               TextField
               {
                   id: textMaxSigBrake
                   text: bleHandler.brakeMaxADC.toFixed(0)
                   font.pixelSize: medTextSize
                   color: "white"
                   implicitWidth: textboxSize
                   onEditingFinished:  {
                       sliderMaxSigBrake.value = parseInt(text)
                       bleHandler.brakeMaxADC = sliderMaxSigBrake.value
                   }
               }
                Slider {
                    id: sliderMaxSigBrake
                    from: 0
                    to: adcMaxValue
                    value: bleHandler.brakeMaxADC
                    stepSize: 10
                    implicitWidth: sliderWidth
                    onValueChanged: {
                        textMaxSigBrake.text = value.toFixed(0)
                        bleHandler.brakeMaxADC = value
                    }
                }
               Label {
                    id: label104
                    color: "white"
                    text: qsTr("Max Brake Regen")
                    font.pixelSize: smallTextSize
                }
               TextField
               {
                   id: textMaxBrakeRegen
                   text: bleHandler.regenBrakeMax.toFixed(0)
                   font.pixelSize: medTextSize
                   color: "white"
                   implicitWidth: textboxSize
                   onEditingFinished:  {
                       sliderMaxBrakeRegen.value = parseInt(text)
                       bleHandler.regenBrakeMax = sliderMaxBrakeRegen.value
                   }
               }
               Slider {
                   id: sliderMaxBrakeRegen
                   from: 0
                   to: 100
                   value: bleHandler.regenBrakeMax
                   stepSize: 1
                   implicitWidth: sliderWidth
                   onValueChanged: {
                       textMaxBrakeRegen.text = value.toFixed(0)
                       bleHandler.regenBrakeMax = value
                   }
               }
            }
        }

        Item
        {
            id: motorCtrlConfig

            Label {
                id: label150
                color: "#AAAAFF"
                text: qsTr("Motor Control:")
                font.pixelSize: largeTextSize
                anchors.top: throttleConfigGrid2.bottom
                anchors.left: brakeSysConfig.left
            }

            GridLayout
            {
                id: motorConfigGrid2
                columns: 2
                anchors.top: label150.bottom
                anchors.topMargin: 20
                columnSpacing: 120 * stretchFactor

                Label {
                    id: maxSpeedLabel
                    color: "white"
                    font.pixelSize: smallTextSize
                    text: "Max Speed (RPM):"
                }
                TextField
                {
                    id: maxSpeedText
                    text: bleHandler.maxRPM.toFixed(0)
                    font.pixelSize: medTextSize
                    color: "white"
                    implicitWidth: textboxSize
                    onEditingFinished: bleHandler.maxRPM = parseInt(text)
                }

                Label {
                    id: maxTorqueLabel
                    color: "white"
                    font.pixelSize: smallTextSize
                    text: "Max Torque (Nm):"
                }
                TextField
                {
                    id: maxTorqueText
                    text: bleHandler.maxTorque.toFixed(1)
                    font.pixelSize: medTextSize
                    color: "white"
                    implicitWidth: textboxSize
                    onEditingFinished: bleHandler.maxTorque = parseInt(text)
                }

                Label {
                    id: motorModeLabel
                    color: "white"
                    font.pixelSize: smallTextSize
                    text: "Motor Mode:"
                }
                ComboBox {
                    id: cbMotorMode
                    model: [ "Torque Ctl", "Speed Ctl" ]
                    currentIndex: bleHandler.powerMode
                    implicitWidth: comboboxSize
                    font.pixelSize: smallTextSize
                    onActivated: bleHandler.powerMode = currentIndex
                }

            }
        }

        Item
        {
            Label {
                id: label200
                color: "#AAAAFF"
                text: qsTr("System:")
                font.pixelSize: largeTextSize
                anchors.top: configRow9.bottom
                anchors.left: brakeSysConfig.left
            }

            GridLayout
            {
                id: sysConfigGrid2
                columns: 2
                anchors.top: label200.bottom
                anchors.topMargin: 20
                columnSpacing: 120 * stretchFactor


                Label {
                    id: loggingLabel
                    color: "white"
                    font.pixelSize: smallTextSize
                    text: "Log Level:"
                }
                ComboBox {
                    id: cbLogMode
                    model: [ "Debug", "Info", "Warning", "Error", "Off" ]
                    currentIndex: bleHandler.logLevel
                    implicitWidth: comboboxSize
                    font.pixelSize: smallTextSize
                    onActivated: bleHandler.logLevel = currentIndex
                }

                Label {
                    id: nomVoltsLabel
                    color: "white"
                    font.pixelSize: smallTextSize
                    text: "Nominal Battery Voltage:"
                }
                TextField
                {
                    id: nomVoltsText
                    text: bleHandler.nomBattVolts.toFixed(1)
                    implicitWidth: textboxSize
                    font.pixelSize: medTextSize
                    color: "white"
                    onEditingFinished: bleHandler.nomBattVolts = parseInt(text)
                }
            }
        }

        Item {
            id: outputConfigPage

            Label
            {
                id:outputLabel1
                color: "#AAAAFF"
                font.pixelSize: largeTextSize
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
                    font.pixelSize: smallTextSize
                    text: "Fan Output"
                }
                ComboBox {
                    id: cbFanOutput
                    model: [ "None", "0", "1", "2", "3", "4", "5", "6", "7" ]
                    currentIndex: bleHandler.coolingOutput
                    implicitWidth: comboboxSize
                    font.pixelSize: smallTextSize
                    onActivated: bleHandler.coolingOutput = currentIndex
                }
                Label
                {
                    id: outputLabel3
                    color: "white"
                    font.pixelSize: smallTextSize
                    text: "Fan On (Deg C)"
                }
                TextField
                {
                    id:fanOnTempText
                    text: bleHandler.coolingOnTemp.toFixed(1)
                    font.pixelSize: medTextSize
                    color: "white"
                    implicitWidth: textboxSize
                    onEditingFinished: bleHandler.coolingOnTemp = parseInt(text)
                }
                Label
                {
                    id: outputLabel4
                    color: "white"
                    font.pixelSize: smallTextSize
                    text: "Fan Off (Deg C)"
                }
                TextField
                {
                    id: fanOffTempText
                    text: bleHandler.coolingOffTemp.toFixed(1)
                    font.pixelSize: medTextSize
                    color: "white"
                    implicitWidth: textboxSize
                    onEditingFinished: bleHandler.coolingOffTemp = parseInt(text)
                }

                Label
                {
                    id: outputLabel5
                    color: "white"
                    font.pixelSize: smallTextSize
                    text: "Precharge Output"
                }
                ComboBox {
                    id: cbPrechargeOutput
                    model: [ "None", "0", "1", "2", "3", "4", "5", "6", "7" ]
                    currentIndex: bleHandler.prechargeOutput
                    implicitWidth: comboboxSize
                    font.pixelSize: smallTextSize
                    onActivated: bleHandler.prechargeOutput = currentIndex;
                }
                Label
                {
                    id: outputLabel6
                    color: "white"
                    font.pixelSize: smallTextSize
                    text: "Precharge Delay (ms)"
                }
                TextField
                {
                    id:prechargeDelayText
                    text: bleHandler.prechargeDuration.toFixed(1)
                    font.pixelSize: medTextSize
                    color: "white"
                    implicitWidth: textboxSize
                    onEditingFinished: bleHandler.prechargeDuration = parseInt(text)
                }

                Label
                {
                    id: outputLabel7
                    color: "white"
                    font.pixelSize: smallTextSize
                    text: "Main Contactor Output"
                    Layout.row: 2
                    Layout.column: 0
                }
                ComboBox {
                    id: cbMainContOutput
                    model: [ "None", "0", "1", "2", "3", "4", "5", "6", "7" ]
                    currentIndex: bleHandler.mainContactorOutput
                    implicitWidth: comboboxSize
                    font.pixelSize: smallTextSize
                    onActivated: bleHandler.mainContactorOutput = currentIndex;
                }

                Label
                {
                    id: outputLabel8
                    color: "white"
                    font.pixelSize: smallTextSize
                    text: "Brake Light Output"
                    Layout.row: 3
                    Layout.column: 0
                }
                ComboBox {
                    id: cbBrakeLightOutput
                    model: [ "None", "0", "1", "2", "3", "4", "5", "6", "7" ]
                    currentIndex: bleHandler.brakeLightOutput
                    implicitWidth: comboboxSize
                    font.pixelSize: smallTextSize
                    onActivated: bleHandler.brakeLightOutput = currentIndex;
                }

                Label
                {
                    id: outputLabel9
                    color: "white"
                    font.pixelSize: smallTextSize
                    text: "Reverse Light Output"
                    Layout.row: 4
                    Layout.column: 0
                }
                ComboBox {
                    id: cbReverseLightOutput
                    model: [ "None", "0", "1", "2", "3", "4", "5", "6", "7" ]
                    currentIndex: bleHandler.reverseLightOutput
                    implicitWidth: comboboxSize
                    font.pixelSize: smallTextSize
                    onActivated: bleHandler.reverseLightOutput = currentIndex;
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
                    font.pixelSize: medTextSize
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
                font.pixelSize: largeTextSize
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
                    font.pixelSize: smallTextSize
                    text: "Enable Input"
                }
                ComboBox {
                    id: cbEnableInput
                    model: [ "None", "0", "1", "2", "3" ]
                    currentIndex: bleHandler.enableMotorControlInput
                    implicitWidth: comboboxSize
                    font.pixelSize: smallTextSize
                    onActivated: bleHandler.enableMotorControlInput = currentIndex;
                }

                Label
                {
                    id: inputLabel3
                    color: "white"
                    font.pixelSize: smallTextSize
                    text: "Reverse Input"
                }
                ComboBox {
                    id: cbReverseInput
                    model: [ "None", "0", "1", "2", "3" ]
                    currentIndex: bleHandler.reverseInput
                    font.pixelSize: smallTextSize
                    implicitWidth: comboboxSize
                    onActivated: bleHandler.reverseInput = currentIndex;
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
                    font.pixelSize: medTextSize
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
                font.pixelSize: largeTextSize
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
                    font.pixelSize: medTextSize
                    text: "Motor Controllers"
                }
                Label
                {
                    id:deviceLabel3
                    color: "#6666BB"
                    font.pixelSize: medTextSize
                    text: "Throttle and Brake"
                    Layout.row: 0
                    Layout.column: 2
                }

                Label
                {
                    id:deviceLabel4
                    color: "white"
                    font.pixelSize: smallTextSize
                    text: "Azure Dynamics DMOC645"
                    Layout.row: 1
                    Layout.column: 0
                }
                Switch
                {
                    id:switchDMOC645
                    checked: bleHandler.deviceDMOC
                    onCheckedChanged: bleHandler.deviceDMOC = checked
                    font.pixelSize: smallTextSize
                }

                Label
                {
                    id:deviceLabel5
                    color: "white"
                    font.pixelSize: smallTextSize
                    text: "Pot/Hall Effect Throttle"                    
                }
                Switch
                {
                    id:switchPotThrottle
                    checked: bleHandler.devicePotAccel
                    onCheckedChanged: bleHandler.devicePotAccel = checked
                    font.pixelSize: smallTextSize
                }

                Label
                {
                    id:deviceLabel6
                    color: "white"
                    font.pixelSize: smallTextSize
                    text: "UQM Powerphase 100"
                }
                Switch
                {
                    id:switchCodaUQM
                    checked: bleHandler.deviceCodaUQM
                    onCheckedChanged: bleHandler.deviceCodaUQM = checked
                    font.pixelSize: smallTextSize
                }

                Label
                {
                    id:deviceLabel7
                    color: "white"
                    font.pixelSize: smallTextSize
                    text: "Pot/Hall Effect Brake"
                }
                Switch
                {
                    id:switchPotBrake
                    checked: bleHandler.devicePotBrake
                    onCheckedChanged: bleHandler.devicePotBrake = checked
                    font.pixelSize: smallTextSize
                }

                Label
                {
                    id:deviceLabel8
                    color: "white"
                    font.pixelSize: smallTextSize
                    text: "Brusa DMC5"
                }
                Switch
                {
                    id:switchBrusaDMC5
                    checked: bleHandler.deviceBrusaDMC5
                    onCheckedChanged: bleHandler.deviceBrusaDMC5 = checked
                    font.pixelSize: smallTextSize
                }

                Label
                {
                    id:deviceLabel9
                    color: "white"
                    font.pixelSize: smallTextSize
                    text: "CANBus Throttle"
                }
                Switch
                {
                    id:switchCANAccel
                    checked: bleHandler.deviceCANAccel
                    onCheckedChanged: bleHandler.deviceCANAccel = checked
                    font.pixelSize: smallTextSize
                }

                Label
                {
                    id:deviceLabel93
                    color: "white"
                    font.pixelSize: smallTextSize
                    text: "CK Inverter"
                }
                Switch
                {
                    id:switchCKInverter
                    checked: bleHandler.deviceCKInverter
                    onCheckedChanged: bleHandler.deviceCKInverter = checked
                    font.pixelSize: smallTextSize
                }

                Label
                {
                    id:deviceLabel10
                    color: "white"
                    font.pixelSize: smallTextSize
                    text: "CANBus Brake"
                }
                Switch
                {
                    id:switchCANBrake
                    checked: bleHandler.deviceCANBrake
                    onCheckedChanged: bleHandler.deviceCANBrake = checked
                    font.pixelSize: smallTextSize
                }

                Label
                {
                    id:deviceLabel94
                    color: "white"
                    font.pixelSize: smallTextSize
                    text: "Test Inverter"
                }
                Switch
                {
                    id:switchTestInverter
                    checked: bleHandler.deviceTestInverter
                    onCheckedChanged: bleHandler.deviceTestInverter = checked
                    font.pixelSize: smallTextSize
                }

                Label
                {
                    id:deviceLabel50
                    color: "white"
                    font.pixelSize: smallTextSize
                    text: "Test Throttle"
                }
                Switch
                {
                    id:switchTestThrottle
                    checked: bleHandler.deviceTestAccel
                    onCheckedChanged: bleHandler.deviceTestAccel = checked
                    font.pixelSize: smallTextSize
                }

                Label
                {
                    id:deviceLabel20
                    color: "#6666BB"
                    font.pixelSize: medTextSize
                    text: "Communication Interfaces"
                    Layout.row: 6
                    Layout.column:0
                }

                Label
                {
                    id:deviceLabel21
                    color: "#6666BB"
                    font.pixelSize: medTextSize
                    text: "Battery Chargers and Mgmt"
                    Layout.row: 6
                    Layout.column: 2
                }

                Label
                {
                    id:deviceLabel23
                    color: "white"
                    font.pixelSize: smallTextSize
                    text: "Brusa NLG5 Charger"
                    Layout.row: 7
                    Layout.column: 0
                }
                Switch
                {
                    id:switchBrusaNLG5
                    checked: bleHandler.deviceBrusaCharger
                    onCheckedChanged: bleHandler.deviceBrusaCharger = checked
                    font.pixelSize: smallTextSize
                }

                Label
                {
                    id:deviceLabel24
                    color: "white"
                    font.pixelSize: smallTextSize
                    text: "ELM327 OBDII Wireless"
                }
                Switch
                {
                    id:switchELM327
                    checked: bleHandler.deviceELM327Emu
                    onCheckedChanged: bleHandler.deviceELM327Emu = checked
                    font.pixelSize: smallTextSize
                }

                Label
                {
                    id:deviceLabel25
                    color: "white"
                    font.pixelSize: smallTextSize
                    text: "TCCH/Elcon Charger"
                }
                Switch
                {
                    id:switchTCCH
                    checked: bleHandler.deviceTCCH
                    onCheckedChanged: bleHandler.deviceTCCH = checked
                    font.pixelSize: smallTextSize
                }

                Label
                {
                    id:deviceLabel26
                    color: "white"
                    font.pixelSize: smallTextSize
                    text: "OBDII PID Listener (CANBus)"
                }
                Switch
                {
                    id:switchOBDII
                    checked: bleHandler.devicePIDListen
                    onCheckedChanged: bleHandler.devicePIDListen = checked
                    font.pixelSize: smallTextSize
                }

                Label
                {
                    id:deviceLabel27
                    color: "white"
                    font.pixelSize: smallTextSize
                    text: "Lear Charger"
                }
                Switch
                {
                    id:switchLearCharger
                    checked: bleHandler.deviceLearCharger
                    onCheckedChanged: bleHandler.deviceLearCharger = checked
                    font.pixelSize: smallTextSize
                }

                Label
                {
                    id:deviceLabel72
                    color: "white"
                    font.pixelSize: smallTextSize
                    text: "EVIC Display"
                }
                Switch
                {
                    id:switchEvicDisplay
                    checked: bleHandler.deviceEVIC
                    onCheckedChanged: bleHandler.deviceEVIC = checked
                    font.pixelSize: smallTextSize
                }

                Label
                {
                    id:deviceLabel28
                    color: "white"
                    font.pixelSize: smallTextSize
                    text: "Think BMS"
                }
                Switch
                {
                    id:switchThinkBMS
                    checked: bleHandler.deviceThinkBMS
                    onCheckedChanged: bleHandler.deviceThinkBMS = checked
                    font.pixelSize: smallTextSize
                }

                Label
                {
                    id:deviceLabel73
                    color: "white"
                    font.pixelSize: smallTextSize
                    text: "Adafruit BLE"
                }
                Switch
                {
                    id:switchAdaBLE
                    checked: bleHandler.deviceAdaBlue
                    onCheckedChanged: bleHandler.deviceAdaBlue = checked
                    font.pixelSize: smallTextSize
                }
            }
        }
        Item {
            id: aboutPage

            TextArea {
                font.pixelSize: smallTextSize * .92
                color: "white"
                readOnly: true
                width: root.width
                height: root.height
                wrapMode: TextEdit.Wrap
                text:
                    "About GEVCU Mobile App and GEVCU Hardware/Software:\n\n" +
                    "The Generalized Electric Vehicle Control Unit - GEVCU is an open source software and hardware"+
                    "project to develop a Vehicle Control Unit (VCU) specifically for electric vehicles."+
                    "The purpose of GEVCU is to handle throttle control, regenerative braking, forward, reverse,"+
                    "and such peculiarities as precharge, cooling system control, instrumentation etc."+
                    "It is essentially the driver interface of the car. GEVCU then manages torque and speed "+
                    "commands to the power electronics via CAN bus to actually operate the vehicle in response "+
                    "to driver input. But it also provides outputs to instrumentation, brake lights, reverse lights, "+
                    "cooling systems, and other controls specific to that vehicle. GEVCU is both open-source and " +
                    "object-oriented allowing easy addition of additional C++ object modules to incorporate multiple "+
                    "standard power components. It is easily modified using the Arduino IDE to incorporate additional "+
                    "features peculiar to any specific electric car conversion or build. For most operations, it is "+
                    "easily configurable by non-programmers through simple web and serial port interfaces to adapt to"+
                    "a wide variety of power components and vehicle applications.\n\n" +
                    "GEVCU was originally conceived of and proposed by Jack Rickard of Electric Vehicle Television "+
                    "(http://EVtv.me) who wrote the original design specification. The main source of the program was "+
                    "developed and is maintained by Collin Kidder and the latest version is always available at "+
                    "http:/github.com/collin80/GEVCU. A list of major contributors to the project is maintained there. "+
                    "Hardware was designed and developed by Ed Clausen, Collin Kidder, and Paulo Jorge Pires de Almeida "+
                    "based on the Arduino Due. GEVCU is open source hardware and software and is presented as "+
                    "EXPERIMENTAL - USE AT YOUR OWN RISK. It is offered strictly for experimental and educational purposes "+
                    "and is NOT intended for actual use in any commercial product or for any specific useful purpose." +
                    "This mobile app was written by Collin Kidder and is meant as a companion to GEVCU. It allows for easy " +
                    "configuration and monitoring of GEVCU without having to gain physical access to the unit itself.\n\n" +
                    "And, for God's sake, don't use this mobile application while you're driving down the road.\n\n"+
                    "Have some common sense man!"
            }
        }
    }
}
