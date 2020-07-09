import QtQuick 2.0
import Felgo 3.0

//fenzu 1

EntityBase {
    signal isdisappeared

    property var toRemove: null
    property alias body: collider.body
    property bool isappear: true

    width: 32
    height: 32

    id:smallpig
    entityType: "pig"

    Image {
        id: pigImage
        source: "../../assets/game/pig.png"
        anchors.fill: collider
    }

    BoxCollider {
        id:collider
        friction: 1
        restitution: 0.02

        x:-width/2
        y:-height/2

        categories: Box.Category1
        collidesWith: Box.Category2|Box.Category4|Box.Category5|Box.Category6
        density: 0.001
        bodyType: Body.Dynamic

        anchors.fill: smallpig

        fixture.onBeginContact: {
            var speed = collider.linearVelocity.x*collider.linearVelocity.x+collider.linearVelocity.y*collider.linearVelocity.y
            if(speed>1000){
                toRemove = [entityType,entityId]
                entityManager.removeEntitiesByFilter(toRemove)
                isdisappeared()
            }
        }
    }
}
