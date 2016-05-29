import QtQuick 2.0

Item {
    id: valueStorage

    //first up, status variables
    property real battVoltage: 0
    property real battCurrent: 0
    property int battSOC: 0
    property int throttleLevel: 0
    property int brakeLevel: 0
    property int operatingTime: 0
    property bool isRunning: false
    property string faultMsg: "no faults"
    property string warningMsg: "no warnings"
    property string gear: "Park"
    property real motorTemp: 0
    property real inverterTemp: 0
    property real reqTorque: 0
    property real actTorque: 0
    property real power: 0
    property int rpm: 0
    property bool input1: false
    property bool input2: false
    property bool input3: false
    property bool input4: false
    property bool output1: false
    property bool output2: false
    property bool output3: false
    property bool output4: false
    property bool output5: false
    property bool output6: false
    property bool output7: false
    property bool output8: false
    property bool sysStatus: false

    //now local storage of configuration options
    property int numThrottles: 1
    property int throttleType: 0
    property int sig1Min: 0
    property int sig1Max: 1000
    property int sig2Min: 0
    property int sig2Max: 1000
    property int regenMaxPedal: 40
    property int regenMinPedal: 0
    property int motionStartPedal: 20
    property int halfMotionPedal: 40
    property int minRegenThrottle: 0
    property int creepLevel: 0
    property int brakeSigMin: 0
    property int brakeSigMax: 1000
    property int brakeRegenMin: 0
    property int brakeRegenMax: 100
    property int maxSpeed: 4000
    property int maxTorque: 300
    property int motorMode: 0
    property int logLevel: 0
    property int nomBattVolts: 340
    property int fanPin: 0
    property int fanOnTemp: 50
    property int fanOffTemp: 40
    property int prechargePin: 0
    property int prechargeDelay: 2000
    property int mainContPin: 0
    property int brakeLightPin: 0
    property int reverseLightPin: 0
    property int enablePin: 0
    property int reversePin: 0
    property bool dmocEnabled: false
    property bool uqmPowerphaseEnabled: false
    property bool brusaDMCEnabled: false
    property bool potThrottleEnabled: false
    property bool potBrakeEnabled: false
    property bool canThrottleEnabled: false
    property bool canBrakeEnabled: false
    property bool wiReachEnabled: false
    property bool elm327Enabled: false
    property bool pidListenerEnabled: false
    property bool thinkBMSEnabled: false
    property bool brusaNLGEnabled: false
    property bool tcchEnabled: false
    property bool learChargerEnabled: false


    SequentialAnimation {
        loops: Animation.Infinite
        running: true

        ParallelAnimation {
            NumberAnimation {
                target: valueStorage
                property: "battVoltage"
                easing.type: Easing.InOutSine
                from: 250
                to: 400
                duration: 3000
            }
            NumberAnimation {
                target: valueStorage
                property: "battCurrent"
                easing.type: Easing.InOutSine
                from: -150
                to: 400
                duration: 3000
            }
            NumberAnimation {
                target: valueStorage
                property: "battSOC"
                easing.type: Easing.InOutSine
                from: 0
                to: 100
                duration: 3000
            }
            NumberAnimation {
                target: valueStorage
                property: "throttleLevel"
                easing.type: Easing.InOutSine
                from: 0
                to: 100
                duration: 3000
            }
            NumberAnimation {
                target: valueStorage
                property: "brakeLevel"
                easing.type: Easing.InOutSine
                from: 0
                to: 100
                duration: 3000
            }
            NumberAnimation {
                target: valueStorage
                property: "motorTemp"
                easing.type: Easing.InOutSine
                from: 0
                to: 200
                duration: 3000
            }
            NumberAnimation {
                target: valueStorage
                property: "inverterTemp"
                easing.type: Easing.InOutSine
                from: 0
                to: 200
                duration: 3000
            }
            NumberAnimation {
                target: valueStorage
                property: "reqTorque"
                easing.type: Easing.InOutSine
                from: 0
                to: 300
                duration: 3000
            }
            NumberAnimation {
                target: valueStorage
                property: "actTorque"
                easing.type: Easing.InOutSine
                from: 0
                to: 100
                duration: 3000
            }
            NumberAnimation {
                target: valueStorage
                property: "power"
                easing.type: Easing.InOutSine
                from: 0
                to: 200
                duration: 3000
            }
            NumberAnimation {
                target: valueStorage
                property: "rpm"
                easing.type: Easing.InOutSine
                from: 0
                to: 6000
                duration: 3000
            }
        }
        PropertyAnimation
        {
            target: valueStorage
            property: "isRunning"
            from: false
            to: true
            duration: 300
        }
        PropertyAnimation
        {
            target: valueStorage
            property: "input1"
            from: false
            to: true
            duration: 300
        }
        PropertyAnimation
        {
            target: valueStorage
            property: "input2"
            from: false
            to: true
            duration: 300
        }
        PropertyAnimation
        {
            target: valueStorage
            property: "input3"
            from: false
            to: true
            duration: 300
        }
        PropertyAnimation
        {
            target: valueStorage
            property: "input4"
            from: false
            to: true
            duration: 300
        }
        PropertyAnimation
        {
            target: valueStorage
            property: "output1"
            from: false
            to: true
            duration: 300
        }
        PropertyAnimation
        {
            target: valueStorage
            property: "output2"
            from: false
            to: true
            duration: 300
        }
        PropertyAnimation
        {
            target: valueStorage
            property: "output3"
            from: false
            to: true
            duration: 300
        }
        PropertyAnimation
        {
            target: valueStorage
            property: "output4"
            from: false
            to: true
            duration: 300
        }
        PropertyAnimation
        {
            target: valueStorage
            property: "output5"
            from: false
            to: true
            duration: 300
        }
        PropertyAnimation
        {
            target: valueStorage
            property: "output6"
            from: false
            to: true
            duration: 300
        }
        PropertyAnimation
        {
            target: valueStorage
            property: "output7"
            from: false
            to: true
            duration: 300
        }
        PropertyAnimation
        {
            target: valueStorage
            property: "output8"
            from: false
            to: true
            duration: 300
        }
        PropertyAnimation
        {
            target: valueStorage
            property: "sysStatus"
            from: false
            to: true
            duration: 300
        }


        PropertyAnimation
        {
            target: valueStorage
            property: "isRunning"
            from: true
            to: false
            duration: 300
        }
        PropertyAnimation
        {
            target: valueStorage
            property: "input1"
            from: true
            to: false
            duration: 300
        }
        PropertyAnimation
        {
            target: valueStorage
            property: "input2"
            from: true
            to: false
            duration: 300
        }
        PropertyAnimation
        {
            target: valueStorage
            property: "input3"
            from: true
            to: false
            duration: 300
        }
        PropertyAnimation
        {
            target: valueStorage
            property: "input4"
            from: true
            to: false
            duration: 300
        }
        PropertyAnimation
        {
            target: valueStorage
            property: "output1"
            from: true
            to: false
            duration: 300
        }
        PropertyAnimation
        {
            target: valueStorage
            property: "output2"
            from: true
            to: false
            duration: 300
        }
        PropertyAnimation
        {
            target: valueStorage
            property: "output3"
            from: true
            to: false
            duration: 300
        }
        PropertyAnimation
        {
            target: valueStorage
            property: "output4"
            from: true
            to: false
            duration: 300
        }
        PropertyAnimation
        {
            target: valueStorage
            property: "output5"
            from: true
            to: false
            duration: 300
        }
        PropertyAnimation
        {
            target: valueStorage
            property: "output6"
            from: true
            to: false
            duration: 300
        }
        PropertyAnimation
        {
            target: valueStorage
            property: "output7"
            from: true
            to: false
            duration: 300
        }
        PropertyAnimation
        {
            target: valueStorage
            property: "output8"
            from: true
            to: false
            duration: 300
        }
        PropertyAnimation
        {
            target: valueStorage
            property: "sysStatus"
            from: true
            to: false
            duration: 300
        }

    }
}
