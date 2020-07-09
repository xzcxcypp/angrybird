import Felgo 3.0
import QtQuick 2.0
import QtQuick.Layouts 1.3
import "../common"
import "../Scenes"
import "../Entity"
import "../fly"

SceneBase{
    property alias timerrunning:timer.running

    width: 960
    height: 640
    signal modelpressed(string selectmodel)
    signal backpressed

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
                    y =Math.random()*(selectLeverScene.height-2*50)+100

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
            source: "../../assets/selectmodel/bj.png"
            anchors.fill: scene
        }



        ParallaxScrollingBackground {
              mirrorSecondImage:true
              id:montainImage
              movementVelocity: Qt.point(10,0)
              ratio: Qt.point(0.5,1.0)
              sourceImage: "../../assets/selectmodel/montain.png"
              anchors.bottom:scene.bottom
              anchors.right:scene.right
        }

        ParallaxScrollingBackground {
              mirrorSecondImage:true
              id:wall1
              movementVelocity: Qt.point(100,0)
              ratio: Qt.point(0.5,1.0)
              sourceImage: "../../assets/selectmodel/wall.png"
              anchors.bottom:scene.bottom
              anchors.left: scene.left
//              anchors.right: background6.left
        }

        ParallaxScrollingBackground {
              mirrorSecondImage:true
              id:wall2
              movementVelocity: Qt.point(100,0)
              ratio: Qt.point(0.5,1.0)
              sourceImage: "../../assets/selectmodel/wall.png"
              anchors.bottom:scene.bottom
              anchors.left:wall1.right
//              anchors.right: background7.left
        }

        ParallaxScrollingBackground {
              id:wall3
              mirrorSecondImage:true
              movementVelocity: Qt.point(100,0)
              ratio: Qt.point(0.5,1.0)
              sourceImage: "../../assets/selectmodel/wall.png"
              anchors.bottom:scene.bottom
              anchors.left:wall2.right
//              anchors.right: scene.right
        }

        ParallaxScrollingBackground {
              id:wall4
              mirrorSecondImage:true
              movementVelocity: Qt.point(100,0)
              ratio: Qt.point(0.5,1.0)
              sourceImage: "../../assets/selectmodel/wall.png"
              anchors.bottom:scene.bottom
              anchors.left:wall3.right
//              anchors.right: scene.right
        }

        ParallaxScrollingBackground {
              id:wall5
              mirrorSecondImage:true
              movementVelocity: Qt.point(100,0)
              ratio: Qt.point(0.5,1.0)
              sourceImage: "../../assets/selectmodel/wall.png"
              anchors.bottom:scene.bottom
              anchors.left:wall4.right
//              anchors.right: scene.right
        }

        ParallaxScrollingBackground {
            height: 20
            movementVelocity: Qt.point(15,0)
            ratio: Qt.point(1.0,1.0)
            mirrorSecondImage: false
            sourceImage: "../../assets/selectmodel/yun.png"
            anchors.top:scene.top

        }

        BackgroundImage {
            width:200
            height: 120
            source: "../../assets/good.png"
            anchors.bottom:scene.bottom
            anchors.left: scene.left
        }

        BackgroundImage {
            width:200
            height: 120
            source: "../../assets/selectmodel/kiss.png"
            anchors.bottom:scene.bottom
            anchors.right: scene.right
        }

        Image {
            id: titleImage
            source: "../../assets/selectmodel/titleimage.png"
            height: scene.height/5
            width: scene.width/2
            anchors.top: parent.top
            anchors.topMargin: scene.height/6
            anchors.horizontalCenter: parent.horizontalCenter
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

        Row{
            anchors.top: parent.top
            anchors.topMargin: scene.height/5+scene.height/6
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 2
            Image{
                id: newyear
                width:scene.width/3
                height: scene.height/2.4
                source: "../../assets/selectmodel/newyear.png"
                MouseArea{
                    anchors.fill: parent
                    onPressed: {
                        newyear.opacity = 0.5
                    }
                    onReleased: {
                        newyear.opacity = 1
                    }
                    onClicked: {
                        var modelChance = "SelectlevelsScene1.qml"
                        modelpressed(modelChance)
                    }
                }
            }

            Image{
                id: goldenpig
                width:scene.width/3
                height: scene.height/2.4
                source: "../../assets/selectmodel/goldenpig.png"
                MouseArea{
                    anchors.fill: parent
                    onPressed: {
                        goldenpig.opacity = 0.5
                    }
                    onReleased: {
                        goldenpig.opacity = 1
                    }
                    onClicked: {
                        var modelChance = "SelectlevelsScene2.qml"
                        modelpressed(modelChance)
                    }
                }
            }
        }
    }
}
