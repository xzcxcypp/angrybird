import QtQuick 2.0

Rectangle{
    id:button
    opacity: 1
    width:buttontext.width
    height:buttontext.height
    radius: 10
    color: "transparent"

    property alias buttontext: buttontext
    property alias text: buttontext.text
    property alias image: image
    property alias buttonopacity: button.opacity
    property bool active: false

    Text {
        id: buttontext
        anchors.centerIn: parent
        font.pixelSize: 24
        color: "black"
    }

    signal clicked

    Image{
        id:image
        anchors.centerIn: parent
        width:parent.width
        height: parent.height
    }

    MouseArea{
        id:mouseArea
        anchors.fill: parent
        onPressed: button.opacity = 0.5
        onReleased: button.opacity = 1
        onClicked:button.clicked()
    }
}
