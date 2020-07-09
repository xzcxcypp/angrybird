import Felgo 3.0
import QtQuick 2.0

//fenzhu 2


EntityBase {
    signal hasdisappeared
    signal hasclicked

    id:redBird
    property alias image:redImage
    property alias body: collider.body
    property alias bodytype: collider.bodyType
    property alias linearvelocity: collider.linearVelocity

    property var toRemove: null
    property bool isContact: false

    entityType: "redbird"

    height: 26
    width: 26

    function fly(horizontalspeed,verticalspeed){

        collider.bodyType = Body.Dynamic
        collider.linearVelocity = Qt.point(horizontalspeed,verticalspeed)
    }

    function change(x,y){
        birdImage.x = x
        birdImage.y = y
    }

    Image {
        id: redImage
        anchors.fill:collider
        source: "../../assets/game/redbird.png"

    }

    BoxCollider {
        id:collider
        friction: 0.4
        restitution: 0.4

        x: -width/2
        y: -height/2

        categories: Box.Category2
        collidesWith: Box.Category4|Box.Category1|Box.Category2|Box.Category5
        density: 1
        bodyType: Body.Static

        anchors.fill: redBird

        onLinearVelocityChanged: {
            var speed = collider.linearVelocity.x*collider.linearVelocity.x+collider.linearVelocity.y*collider.linearVelocity.y
            if(isContact == true && speed <= 0){
                toRemove = ["redbird", entityId]
                entityManager.removeEntitiesByFilter(toRemove)
                hasdisappeared()
            }
        }

        fixture.onBeginContact: {
             isContact= true
        }
    }

    property int beginposx
    property int beginposy
    property int endposx
    property int endposy

    MouseArea{
        anchors.fill: redBird.image
        onPositionChanged: {
            var mousehorizontaldistance = mouseX-beginposx+72
            var mouseverticaldistance = mouseY-beginposy+480
            var distance = Math.sqrt(Math.pow(mousehorizontaldistance,2)+Math.pow(mouseverticaldistance,2))
            var cos = mousehorizontaldistance/distance
            var sin = mouseverticaldistance/distance
            var horizontaldistance = cos * 50
            var verticaldistance = sin * 50

            if(distance < 50){
                redBird.x = mouseX+72
                redBird.y = mouseY+480
                endposx = redBird.x
                endposy = redBird.y
            }else{
                if(mouseX >= 0){
                    redBird.x = 72 + Math.abs(horizontaldistance)
                }else{
                    redBird.x = 72 - Math.abs(horizontaldistance)
                }

                if(mouseY >= 0){
                    redBird.y = 480 + Math.abs(verticaldistance)
                }else{
                    redBird.y = 480 - Math.abs(verticaldistance)
                }
                endposx = redBird.x
                endposy = redBird.y
            }
        }

        onPressed: {
            hasclicked()
            beginposx = redBird.x
            beginposy = redBird.y
            endposx = redBird.x
            endposy = redBird.y
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

            redBird.fly(horizontalspeed,verticalspeed)
        }
    }
}
