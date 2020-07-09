/*author:wuyuru,chengyang,yangkangqing
  */

import Felgo 3.0
import QtQuick 2.0
import "./Scenes"


GameWindow {
    id: gamewindow


    state: "menu"
    activeScene: menuScene

    screenWidth: 960
    screenHeight: 640


    MenuScene{
        id:menuScene
        anchors.fill:parent
        onPlayPressed: {
            gamewindow.state = "model"
            modelScene.timerrunning = true
        }
    }

    SelectmodelScene{
        id:modelScene

        onModelpressed:{
            timerrunning = false

            if(selectmodel == "SelectlevelsScene1.qml"){
                selectLeversScene1.timerrunning = true
                gamewindow.state = "Level1"
            }
            if(selectmodel == "SelectlevelsScene2.qml"){
                selectLevelsScene2.timerrunning = true
                gamewindow.state = "Level2"
            }
        }
        onBackpressed:{
            timerrunning = false
            gamewindow.state = "menu"
        }

    }

    SelectlevelsScene1{
        id:selectLeversScene1

        onBackpressed:{
            timerrunning = false
            modelScene.timerrunning = true
            gamewindow.state = "model"
        }
        onLevelpressed:{
            timerrunning = false
            gamewindow.state = "game1"
        }

    }

    SelectlevelsScene2{
        id:selectLevelsScene2

        onBackpressed:{
            timerrunning = false
            modelScene.timerrunning = true
            gamewindow.state = "model"
        }
        onLevelpressed:{
            timerrunning = false
            gamewindow.state = "game2"
        }

    }


    GameScene01{
        id:gameScene01

        onHaslossed: {
            gamewindow.state = "Level1"
            selectLeversScene1.wonopacity = 0
            selectLeversScene1.lossopacity = 1
            gameScene01.resetgame()
        }

        onHaswon: {
            gamewindow.state = "Level1"
            selectLeversScene1.wonopacity = 1
            selectLeversScene1.lossopacity = 0
            gameScene01.resetgame()
        }

        onBackpressed:{
            gamewindow.state = "Level1"
            selectLeversScene1.wonopacity = 0
            selectLeversScene1.lossopacity = 0
            gameScene01.resetgame()
        }

    }

    GameScene02{
        id:gameScene02

        onHaslossed: {
            gamewindow.state = "Level2"
            selectLevelsScene2.wonopacity=0
            selectLevelsScene2.lossopacity = 1
            gameScene02.resetgame()
        }

        onHaswon: {
            gamewindow.state = "Level2"
            selectLevelsScene2.wonopacity = 1
            selectLevelsScene2.lossopacity = 0
            gameScene02.resetgame()
        }

        onBackpressed:{
            gamewindow.state = "Level2"
            gameScene02.resetgame()
        }

    }

    states: [
        State {
            name: "menu"
            PropertyChanges {target: menuScene; opacity: 1}
            PropertyChanges {target: gamewindow; activeScene: menuScene}
            PropertyChanges {target: selectLeversScene1;opacity:  0}
            PropertyChanges {target: selectLevelsScene2;opacity:  0}
            PropertyChanges {target: gameScene01;opacity:  0}
            PropertyChanges {target: gameScene02;opacity: 0}
            PropertyChanges {target: modelScene;opacity: 0}
        },
        State {
            name: "model"
            PropertyChanges {target: modelScene; opacity: 1}
            PropertyChanges {target: gamewindow; activeScene: modelScene}
            PropertyChanges {target: menuScene;opacity:  0}
            PropertyChanges {target: selectLeversScene1; opacity: 0}
            PropertyChanges {target: selectLevelsScene2; opacity: 0}
        },
        State {
            name: "Level1"
            PropertyChanges {target: selectLeversScene1; opacity: 1}
            PropertyChanges {target: gamewindow; activeScene: selectLeversScene1}
            PropertyChanges {target: modelScene;opacity: 0}
            PropertyChanges {target: gameScene01;opacity:0}
            PropertyChanges {target: menuScene;opacity:  0}
            PropertyChanges {target: selectLevelsScene2;opacity:  0}
        },
        State {
            name: "Level2"
            PropertyChanges {target: selectLevelsScene2; opacity: 1}
            PropertyChanges {target: gamewindow; activeScene: selectLevelsScene2}
            PropertyChanges {target: modelScene;opacity: 0}
            PropertyChanges {target: gameScene02;opacity:0}
            PropertyChanges {target: menuScene;opacity:  0}
            PropertyChanges {target: selectLeversScene1;opacity:  0}
        },
        State {
            name: "game1"
            PropertyChanges {target: gameScene01; opacity: 1}
            PropertyChanges {target: gamewindow; activeScene: gameScene01}
            PropertyChanges {target: selectLeversScene1;opacity:  0}
            PropertyChanges {target: menuScene;opacity:  0}
        },
        State {
            name: "game2"
            PropertyChanges {target: gameScene02; opacity: 1}
            PropertyChanges {target: gamewindow; activeScene: gameScene02}
            PropertyChanges {target: selectLevelsScene2;opacity:  0}
            PropertyChanges {target: menuScene;opacity:  0}
        }
    ]
}
