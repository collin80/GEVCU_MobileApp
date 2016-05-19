import QtQuick 2.5
import QtQuick.Controls 1.5
import QtQuick.Extras 1.4
import QtQuick.Window 2.0
Slider
{
    Label
    {
        anchors.left: parent.right
        anchors.leftMargin: 15
        anchors.top: parent.top
        text: Math.floor(parent.value)
        font.pointSize: 15
        color: "white"
    }
}
