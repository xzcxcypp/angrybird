import QtQuick 2.0
import Felgo 3.0

EntityBase {
    entityType: "Redflybird"
    width: 50
    height: 50


    Image {
        id: redflyImage
        source: "../../assets/red.png"
        width: 60*Math.random()+20
        height: width
    }

    BoxCollider {
        id: redflyCollider
        //friction: 1.6

        colliderType: Box.Category6

        density: 0.001
        bodyType: Body.Dynamic
        bullet: true
        angularDamping:0
        linearDamping: 0
        fixedRotation: true

        // initially, move to the right as linearVelocity.x is set to 100
        linearVelocity: Qt.point(Math.random()*400+100, -300)

        // make the same size as the Image
        anchors.fill: redflyImage

        fixture.onBeginContact: {

        }
    }
}
