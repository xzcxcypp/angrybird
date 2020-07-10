import Felgo 3.0
import QtQuick 2.0

EntityBase {
    id:slingshot
    width: 60
    height: 90
    entityId: "slingshot"
    entityType: "slingshot"


    Image {
        id: slingshotImage
        anchors.fill:collider
        source: "../../assets/game/slingshot.png"
    }

    BoxCollider {
        x: -width/2
        y: -height/2
        id:collider
        density: 0.001
        bodyType: Body.Static
        categories: Box.Category3
        collidesWith: Box.Category4
        // make the same size as the Image
        anchors.fill: slingshot
    }
}
