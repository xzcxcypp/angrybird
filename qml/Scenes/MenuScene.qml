import Felgo 3.0
import QtQuick 2.0
import QtMultimedia 5.0
import "../common"
import "../Entity"
import "../"


// scene with the main menu
Scene{
    anchors.fill: parent
    id: menuScene
    width: 960
    height: 640


    signal playPressed

    // play background music
//    BackgroundMusic {
//        loops: SoundEffect.Infinite
//        volume: 0.35
//        id: ambienceMusic
//        // an ogg file is not playable on windows, because the extension is not supported!
//        source: "../../assets/snd/title_theme.mp3"
//    }

//    // timer plays the background music
//    Timer {
//        id: timerMusic
//        interval: 100; running: true; repeat: true;
//        onTriggered: {
//            ambienceMusic.play()
//            running = false
//        }
//    }


    Rectangle{
        anchors.fill:menuScene

        Image {
            opacity: 1
            id: background
            source: "../../assets/menuscene/bg.png"
            anchors.fill: parent
            SequentialAnimation on opacity {
                loops: Animation.Infinite
                PropertyAnimation {
                    to: 0.6
                    duration: 1000
                }
                PropertyAnimation {
                    to: 1
                    duration: 1000
                }
            }
        }
    }

    MenuButton {
        id: menuButton
        text: "Play"
        color: "transparent"

        anchors.top: parent.top
        anchors.topMargin: menuScene.height/1.2
        anchors.horizontalCenter: parent.horizontalCenter

        onClicked: playPressed()

        buttontext.color: "black"
        buttontext.opacity: 1
        buttontext.font.pixelSize: 36
    }
}
