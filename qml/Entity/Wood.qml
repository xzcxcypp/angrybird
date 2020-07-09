import Felgo 3.0
import QtQuick 2.0

EntityBase {
    property alias bodyType: collider.bodyType
    property alias woodrotation:wood.rotation
    property alias density:collider.density

    function ready(){
        collider.bodyType = Body.Dynamic
    }



    id:wood
    height: 10
    width: 120
    entityType: "wood"


    Image {
        id: woodImage
        anchors.fill: collider
        source: "../../assets/game/wood1.png"
    }

    BoxCollider {
        x: -width/2
        y: -height/2
        anchors.fill: wood
        id:collider
        categories: Box.Category5
        collidesWith: Box.Category2|Box.Category4|Box.Category1|Box.Category5|Box.Category6
        density: 1
        friction: 1.6
        restitution: 0.03
        bodyType: Body.Dynamic
        bullet: false
        angularDamping:0
        linearDamping: 0
        fixedRotation: false

        active: true


        fixture.onBeginContact: {
            //collider.bodyType = Body.Dynamic
        }
    }
}
