import Felgo 3.0
import QtQuick 2.0
import "../common"
import ".."
import "../Entity"
import "../fly"

SceneBase{
    signal levelpressed
    signal backpressed
    property alias timerrunning:timer.running
    property alias lossopacity:lossinformation.opacity
    property alias wonopacity:woninformation.opacity

    width: 960
    height: 640

    anchors.fill:parent
    id:selectLeverScene

    EntityManager {
        id: entityManager
        entityContainer: scene//指定哪个QML项是使用EntityManager创建的实体的父项,通常是场景项。

    }

    Scene{
        anchors.fill:selectLeverScene
        id:scene
        width: 960
        height: 640

        Timer {
            id: timer
            interval : Math.random()*3000+2000
            running: false // start running from the beginning, when the scene is loaded
            repeat: true // otherwise restart wont work
            onTriggered: {
                var number = Math.random()
                var newEntityProperties = {
                    y: Math.random()*(selectLeverScene.height-2*50)+100

                }

                if(number < 0.25){
                    entityManager.createEntityFromUrlWithProperties(
                                Qt.resolvedUrl("../fly/Yellowfly.qml"),
                                newEntityProperties);
                }

                if(0.25 <= number < 0.5){
                    entityManager.createEntityFromUrlWithProperties(
                                Qt.resolvedUrl("../fly/Greenfly.qml"),
                                newEntityProperties);

                }
                if(0.5<=number<0.75){
                    entityManager.createEntityFromUrlWithProperties(
                                Qt.resolvedUrl("../fly/Bluefly.qml"),
                                newEntityProperties);

                }else{
                    entityManager.createEntityFromUrlWithProperties(
                                Qt.resolvedUrl("../fly/Redfly.qml"),
                                newEntityProperties);

                }
                timer.restart()
            }
        }

        Image {
            id: background
            rotation: 180
            source: "../../assets/newyear/bj.png"
            anchors.fill: scene
        }


        ParallaxScrollingBackground {
            mirrorSecondImage:true

            id:background2
            movementVelocity: Qt.point(10,0)
            ratio: Qt.point(0.5,1.0)
            sourceImage: "../../assets/newyear/pick.png"
            anchors.bottom:scene.bottom
            anchors.bottomMargin: -50
            anchors.right:scene.right
        }


        ParallaxScrollingBackground {
            mirrorSecondImage:true
            height: 120
            id:background3
            movementVelocity: Qt.point(100,0)
            ratio: Qt.point(0.5,1.0)
            sourceImage: "../../assets/newyear/wall.png"
            anchors.bottom:scene.bottom
            anchors.right:scene.right
        }

        ParallaxScrollingBackground {
            mirrorSecondImage:true
            height: 120
            id:background4
            movementVelocity: Qt.point(100,0)
            ratio: Qt.point(0.5,1.0)
            sourceImage: "../../assets/newyear/wall.png"
            anchors.bottom:scene.bottom
            anchors.left:background3.right
        }


        ParallaxScrollingBackground {
            mirrorSecondImage:true
            height: 120
            id:background5
            movementVelocity: Qt.point(100,0)
            ratio: Qt.point(0.5,1.0)
            sourceImage: "../../assets/newyear/wall.png"
            anchors.bottom:scene.bottom
            anchors.right:background4.left
        }

        ParallaxScrollingBackground {
            mirrorSecondImage:true
            height: 120
            movementVelocity: Qt.point(100,0)
            ratio: Qt.point(0.5,1.0)
            sourceImage: "../../assets/newyear/wall.png"
            anchors.bottom:scene.bottom
            anchors.right:background5.left

        }

        ParallaxScrollingBackground {
            mirrorSecondImage:true
            height: 80
            movementVelocity: Qt.point(10,0)
            ratio: Qt.point(0.5,1.0)
            sourceImage: "../../assets/newyear/decoration.png"
            anchors.bottom:scene.bottom
            //anchors.right:scene.right
        }

        BackgroundImage {
            id: leftimage
            width: 150
            height: 120
            source: "../../assets/newyear/left.png"
            anchors.left:scene.left
            anchors.bottom:scene.bottom
        }


        BackgroundImage {
            id: rightimage
            width:150
            height: 120
            source: "../../assets/newyear/right.png"
            anchors.right:scene.right
            anchors.bottom:scene.bottom
        }

        BackgroundImage {
            id: pig
            height: 120
            width: 200
            anchors.horizontalCenter: parent.horizontalCenter
            source: "../../assets/newyear/pig.png"
            anchors.bottom:scene.bottom
        }


        MenuButton{
            image.source: "../../assets/Back.png"
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            width: 30
            height: 30
            onClicked: {
                backpressed()
            }
        }

        Grid{
            anchors.centerIn: parent
            columns: 5
            spacing: 2
            Repeater{
                model: 10
                delegate: Rectangle{
                    width:50
                    height: 50
                    radius: 10
                    color: "white"

                    Rectangle{
                        anchors.centerIn: parent
                        width: 42
                        height: 42
                        radius:10
                        color: "blue"
                        opacity: 0.5

                        MenuButton{
                            // property int  level: index+1
                            anchors.centerIn: parent
                            width:38
                            height: 38
                            radius: 10
                            color: "white"

                            Text{
                                text: index+1
                                font.pixelSize: 20
                                anchors.centerIn: parent
                            }

                            onClicked: {
                                levelpressed()
                            }
                        }
                    }
                }
            }
        }

        Text {
            id: lossinformation
            text: qsTr("You loss")
            opacity: 0
            font.pixelSize: 24
            color: "black"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 100
        }
        Text {
            id: woninformation
            text: qsTr("You won")
            opacity: 0
            font.pixelSize: 24
            color: "black"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 100
        }
    }
}
