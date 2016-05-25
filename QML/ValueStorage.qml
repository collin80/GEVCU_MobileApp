import QtQuick 2.0

Item {
    id: valueStorage

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
}

