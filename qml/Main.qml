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
            selectLeversScene1.wonopacity = 0
            selectLeversScene1.lossopacity = 0
        }
        onLevelpressed:{
            timerrunning = false
            gameScene01.resetgame()
            gamewindow.state = "game1"
            menuScene.music.source = "../assets/snd/game1.mp3"
            menuScene.music.play()
        }

    }

    SelectlevelsScene2{
        id:selectLevelsScene2

        onBackpressed:{
            timerrunning = false
            modelScene.timerrunning = true
            gamewindow.state = "model"
            selectLevelsScene2.wonopacity = 0
            selectLevelsScene2.lossopacity = 0
        }
        onLevelpressed:{
            timerrunning = false
            gameScene02.resetgame()
            gamewindow.state = "game2"
            menuScene.music.source = "../assets/snd/game2.mp3"
            menuScene.music.play()
        }

    }

    GameScene01{
        id:gameScene01

        onHaslossed: {
            selectLeversScene1.wonopacity = 0
            selectLeversScene1.lossopacity = 1
            gameScene01.linerunning = false
            selectLeversScene1.timerrunning = true
            gamewindow.state = "Level1"
            menuScene.music.source = "../assets/snd/title_theme.mp3"
            menuScene.music.play()
        }

        onHaswon: {
            selectLeversScene1.wonopacity = 1
            selectLeversScene1.lossopacity = 0
            gameScene01.linerunning = false
            selectLeversScene1.timerrunning = true
            gamewindow.state = "Level1"
            menuScene.music.source = "../assets/snd/title_theme.mp3"
            menuScene.music.play()
        }

        onBackpressed:{
            selectLeversScene1.wonopacity = 0
            selectLeversScene1.lossopacity = 0
            gameScene01.linerunning = false
            selectLeversScene1.timerrunning = true
            gamewindow.state = "Level1"
            menuScene.music.source = "../assets/snd/title_theme.mp3"
            menuScene.music.play()
        }

    }

    GameScene02{
        id:gameScene02

        onHaslossed: {
            gamewindow.state = "Level2"
            gameScene02.linerunning = false
            selectLevelsScene2.timerrunning = true
            selectLevelsScene2.wonopacity=0
            selectLevelsScene2.lossopacity = 1
            menuScene.music.source = "../assets/snd/title_theme.mp3"
            menuScene.music.play()
        }

        onHaswon: {
            gamewindow.state = "Level2"
            gameScene02.linerunning = false
            selectLevelsScene2.timerrunning = true
            selectLevelsScene2.wonopacity = 1
            selectLevelsScene2.lossopacity = 0
            menuScene.music.source = "../assets/snd/title_theme.mp3"
            menuScene.music.play()
        }

        onBackpressed:{
            selectLevelsScene2.wonopacity = 0
            selectLevelsScene2.lossopacity = 0
            gameScene02.linerunning = false
            selectLevelsScene2.timerrunning = true
            gamewindow.state = "Level2"
            menuScene.music.source = "../assets/snd/title_theme.mp3"
            menuScene.music.play()
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
