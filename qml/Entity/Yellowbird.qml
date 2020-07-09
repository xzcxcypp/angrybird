import QtQuick 2.0
import Felgo 3.0


EntityBase {
    signal hasdisappeared

    property alias linearvelocity:yellowCollider.linearVelocity
    property alias restitution:yellowCollider.restitution
    property alias running:animation.running

    property alias image:yellowImage
    property alias body: yellowCollider.body
    property alias bodytype: yellowCollider.bodyType


    id:yellowBird

    width: 26
    height: 26


    function fly(horizontalspeed,verticalspeed){
        yellowCollider.bodyType = Body.Dynamic
        yellowCollider.linearVelocity = Qt.point(horizontalspeed,verticalspeed)
        yellowBird.isfly = true
    }

    TexturePackerAnimatedSprite{
        id:yellowImage
        source: "../../assets/game/yellowbird.json"
        frameNames: ["yellowbird1.png","yellowbird2.png"]
        frameRate: 1
        anchors.fill: yellowCollider
    }

    ParallelAnimation{
        id:animation
        running: false
        NumberAnimation{
            target: yellowBird
            property: "x"
            duration: 4000
            to:72
        }
        NumberAnimation{
            target: yellowBird
            property: "y"
            duration: 4000
            to:480
        }

        NumberAnimation{
            target: yellowBird
            from:0
            property: "rotation"
            duration: 4000
            to:360
        }
    }



    BoxCollider {
        id: yellowCollider
        friction: 1.6
        density: 1
        bodyType: Body.Dynamic
        fixedRotation: false
        categories: Box.Category6
        collidesWith: Box.Category4|Box.Category5|Box.Category1

        x: -width/2
        y: -height/2

        // make the same size as the Image
        anchors.fill: yellowBird

        onLinearVelocityChanged: {
            if(isfly == true){
                var speed = yellowCollider.linearVelocity.x*yellowCollider.linearVelocity.x+yellowCollider.linearVelocity.y*yellowCollider.linearVelocity.y
                if(speed <= 0){
                    toRemove = [entityType, entityId]
                    entityManager.removeEntitiesByFilter(toRemove)
                    hasdisappeared()
                }
            }
        }
    }

    property int beginposx
    property int beginposy
    property int endposx
    property int endposy

    property bool isfly:false

    MouseArea{
        anchors.fill: yellowImage
        onPositionChanged: {
            var mousehorizontaldistance = mouseX-beginposx+72
            var mouseverticaldistance = mouseY-beginposy+480
            var distance = Math.sqrt(Math.pow(mousehorizontaldistance,2)+Math.pow(mouseverticaldistance,2))
            var cos = mousehorizontaldistance/distance
            var sin = mouseverticaldistance/distance
            var horizontaldistance = cos * 50
            var verticaldistance = sin * 50

            if(distance < 50){
                yellowBird.x = mouseX+72
                yellowBird.y = mouseY+480
                endposx = yellowBird.x
                endposy = yellowBird.y
            }else{
                if(mouseX >= 0){
                    yellowBird.x = 72 + Math.abs(horizontaldistance)
                }else{
                    yellowBird.x = 72 - Math.abs(horizontaldistance)
                }

                if(mouseY >= 0){
                    yellowBird.y = 480 + Math.abs(verticaldistance)
                }else{
                    yellowBird.y = 480 - Math.abs(verticaldistance)
                }
                endposx = yellowBird.x
                endposy = yellowBird.y
            }
        }

        onPressed: {
            var selectedBody = physicsworld.bodyAt(Qt.point(mouseX, mouseY));
            beginposx = yellowBird.x
            beginposy = yellowBird.y
            endposx = yellowBird.x
            endposy = yellowBird.y
        }

        onReleased: {
            var horizontaldistance = beginposx-endposx
            var verticaldistance = beginposy-endposy
            var distance = Math.sqrt(Math.pow(horizontaldistance,2)+Math.pow(verticaldistance,2))
            var horizontalspeed = horizontaldistance * 10
            var verticalspeed = verticaldistance * 10
            upline.points=[{"x":53, "y":container.height-145},
                           {"x":beginposx, "y":beginposy+20}
                    ]
            downline.points=[{"x":100, "y":container.height-145},
                             {"x":beginposx+25, "y":beginposy+20}
                    ]

            yellowBird.fly(horizontalspeed,verticalspeed)
        }
    }

    property int time: 0

    Timer{
        id:timer
        interval: 1000
        running: false
        repeat: true
        onTriggered: {
            time++
        }
    }

    Timer{
        id:remember
        interval: 1000
        running: false
        repeat: true
        onTriggered: {
            ready()
        }
    }

    function ready(){
        timer.running = true
        remember.running = true
        animation.running = true
        if(time == 4){
            yellowCollider.restitution = 0.4
            yellowCollider.bodyType = Body.Static
            timer.running = false
            animation.running = false
            remember.running = false
            time = 0
        }
    }
}
