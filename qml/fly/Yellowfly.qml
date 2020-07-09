import QtQuick 2.0
import Felgo 3.0

EntityBase {
    entityType: "Yellowflybird"
    width: 50
    height: 50

    TexturePackerAnimatedSprite{
        source: "../../assets/yellowbird.json"
        frameNames: ["yellowbird1.png","yellowbird2.png"]
        frameRate: 1
        id: yellowflyImage
        width: 60*Math.random()+20
        height: width
    }

    BoxCollider {
        id: yellowflyCollider
        //friction: 1.6
        density: 0.001
        bodyType: Body.Dynamic
        bullet: true
        angularDamping:0
        linearDamping: 0
        fixedRotation: true

        colliderType: Box.Category6

        // initially, move to the right as linearVelocity.x is set to 100
        linearVelocity: Qt.point(Math.random()*400+100, -300)

        // make the same size as the Image
        anchors.fill: yellowflyImage

        fixture.onBeginContact: {

        }
    }
}
