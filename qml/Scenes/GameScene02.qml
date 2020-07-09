import Felgo 3.0
import QtQuick 2.0
import "../Entity"
import "../fly"
import "../common"

//SceneBase
SceneBase{
    signal haswon
    signal haslossed
    signal backpressed

    width: 960
    height: 640
    id: gamescene
    anchors.fill: parent

    property var toRemove : "NULL"
    property int usetime: 0
    property int beginposx
    property int beginposy
    property int endposx
    property int endposy

    EntityManager {
        id: entityManager
        entityContainer: scene//指定哪个QML项是使用EntityManager创建的实体的父项,通常是场景项。

    }

    property bool firstredbird: true
    property bool firstyellowbird: true
    property bool secondyellowbird: true
    property bool firstpig: true
    property bool secondpig: true
    property bool thirdpig: true
    property bool forthpig: true
    property bool fifthpig: true
    property bool sixthpig: true
    property bool seventhpig: true

    Scene {
        anchors.fill: gamescene
        id: scene

        sceneAlignmentX: "left"
        sceneAlignmentY: "top"

        Camera{
            id: camera

            minZoom: 1
            maxZoom: 1.2
            // set the gameWindowSize and entityContainer required for the camera
            gameWindowSize: Qt.point(scene.gameWindowAnchorItem.width, scene.gameWindowAnchorItem.height)
            entityContainer: container

            mouseAreaEnabled: true
            // set the camera's limits
                            limitLeft: 0
                            limitRight: scene.gameWindowAnchorItem.width
                            limitTop: 0
                            limitBottom: scene.gameWindowAnchorItem.height
        }

        Item{
            id:container
            height: scene.height
            width: scene.width

            BackgroundImage{
                rotation: 180
                source: "../../assets/newyear/bj.png"
                anchors.fill: parent
            }

            Image {
                anchors.bottom: container.bottom
                anchors.bottomMargin: -50
                width: container.width
                height: container.height/3
                id: backgroundimage
                source: "../../assets/newyear/pick.png"
            }

            PhysicsWorld {
                id: physicsworld// physics is disabled initially, and enabled after the splash is finished
                running: true
                gravity.y: 9.81
                z: 10 // draw the debugDraw on top of the entities

                debugDrawVisible: true
                updatesPerSecondForPhysics: 60
                velocityIterations: 5
                positionIterations: 5
            }

            Redbird{
                id:redBird
                entityId:"bird1"
                x:72
                y:container.height-160
                onHasdisappeared: {
                    gamescene.firstredbird = false
                    yellowbird.ready()
                }
            }

            Pig{
                anchors.horizontalCenter: wood1.horizontalCenter
                entityType: "pig1"
                id:thepig1
                y:container.height-102
                onIsdisappeared: {
                    gamescene.firstpig = false
                }
            }

            Pig{
                anchors.horizontalCenter: wood4.horizontalCenter
                entityType: "pig2"
                id:thepig2
                y:container.height-202
                onIsdisappeared: {
                    gamescene.secondpig = false
                }
            }

            Pig{
                anchors.horizontalCenter: wood8.horizontalCenter
                entityType: "pig3"
                id:thepig3
                y:container.height-102
                onIsdisappeared: {
                    gamescene.thirdpig = false
                }
            }

            Pig{
                anchors.horizontalCenter: wood11.horizontalCenter
                entityType: "pig4"
                id:thepig4
                y:container.height-202
                onIsdisappeared: {
                    gamescene.forthpig = false
                }
            }

            Pig{
                width: 20
                height: 20
                anchors.horizontalCenter: wood7.horizontalCenter
                entityType: "pig5"
                id:thepig5
                y:container.height-310
                onIsdisappeared: {
                    gamescene.fifthpig = false
                }
            }

            Pig{
                width: 20
                height: 20
                anchors.horizontalCenter: wood14.horizontalCenter
                entityType: "pig6"
                id:thepig6
                y:container.height-310
                onIsdisappeared: {
                    gamescene.sixthpig = false
                }
            }

            Pig{
                entityType: "pig7"
                id:thepig7
                y:container.height-92
                x:669
                onIsdisappeared: {
                    gamescene.seventhpig = false
                }
            }

            Yellowbird{
                entityType: "yellowBird1"
                width: 30
                height: 30
                id:yellowbird
                x:200
                y:container.height-120
                onHasdisappeared: {
                    gamescene.firstyellowbird = false
                    yellowbird1.ready()
                }
            }

            Yellowbird{
                entityType: "yellowBird2"
                width: 30
                height: 30
                id:yellowbird1
                x:150
                y:container.height-120
                onHasdisappeared: {
                    gamescene.secondyellowbird = false
                }
            }

            Slingshot{
                x:50
                y:container.height-150
                id:theslingshot
            }

            Wood{
                id:wood1
                x:500
                y:container.height-70
            }

            Wood{
                id:wood2
                width: 100
                woodrotation: 90
                x:510
                y:container.height-170
            }

            Wood{
                id:wood3
                width: 100
                woodrotation: 90
                x:620
                y:container.height-170
            }

            Wood{
                id:wood4
                x:500
                y:container.height-180
            }

            Wood{
                id:wood5
                width: 100
                woodrotation: 90
                x:510
                y:container.height-280
            }

            Wood{
                id:wood6
                width: 100
                woodrotation: 90
                x:620
                y:container.height-280
            }

            Wood{
                id:wood7
                x:500
                y:container.height-290
            }

            Wood{
                id:wood8
                x:750
                y:container.height-70
            }

            Wood{
                id:wood9
                width: 100
                woodrotation: 90
                x:760
                y:container.height-170
            }

            Wood{
                id:wood10
                width: 100
                woodrotation: 90
                x:870
                y:container.height-170
            }

            Wood{
                id:wood11
                density: 5
                x:750
                y:container.height-180
            }

            Wood{
                id:wood12
                width: 100
                woodrotation: 90
                x:760
                y:container.height-280
            }

            Wood{
                id:wood13
                width: 100
                woodrotation: 90
                x:870
                y:container.height-280
            }

            Wood{
                id:wood14
                x:750
                y:container.height-290
            }

            Wood{
                id:wood15
                density: 0.1
                width: 100
                woodrotation: 120
                x:562
                y:container.height-380
            }

            Wood{
                id:wood16
                density: 0.1
                width: 100
                woodrotation: 60
                x:570
                y:container.height-385
            }

            Wood{
                id:wood17
                density: 0.1
                width: 100
                woodrotation: 120
                x:812
                y:container.height-380
            }

            Wood{
                id:wood18
                density: 0.1
                width: 100
                woodrotation: 60
                x:820
                y:container.height-385
            }

            LineItem {
                id:upline
                color: "brown"
                lineWidth: 6
                points: [
                    {"x":53, "y":container.height-145},
                    {"x":redBird.x, "y":redBird.y+20}
                ]
            }

            LineItem {
                id:downline
                lineWidth: 6
                color: "brown"
                points: [
                    {"x":100, "y":container.height-145},
                    {"x":redBird.x+25, "y":redBird.y+20}
                ]
            }

            Text {
                id: time
                text: "time:"+usetime
                color: "white"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Timer{
                interval: 1000
                running: true
                repeat: true
                onTriggered: {
                    usetime++
                    if(gamescene.firstpig == false && gamescene.secondpig == false && gamescene.thirdpig == false && gamescene.forthpig == false && gamescene.fifthpig == false && gamescene.sixthpig == false && gamescene.seventhpig == false){
                        haswon()
                    }else if(gamescene.firstredbird == false && gamescene.firstyellowbird == false && gamescene.secondyellowbird == false){
                        haslossed()
                    }
                }
            }

            EntityBase {
                id:ground1
                entityId: "ground"
                entityType: "ground"
                height: 60
                width:container.width/5
                anchors.left: container.left
                anchors.bottom: container.bottom

                Image {
                    anchors.fill: colider1
                    id: groundImage
                    source: "../../assets/newyear/wall.png"
                }
                BoxCollider {
                    id:colider1
                    categories: Box.Category4
                    collidesWith: Box.Category2|Box.Category3|Box.Category1|Box.Category5|Box.Category6
                    anchors.fill: ground1
                    bodyType: Body.Static // the body shouldn't move
                }
            }

            EntityBase {
                id:ground2
                entityId: "ground"
                entityType: "ground"
                height: 60
                width:container.width/5
                anchors.left: ground1.right
                anchors.bottom: container.bottom

                Image {
                    anchors.fill: colider2
                    source: "../../assets/newyear/wall.png"
                }
                BoxCollider {
                    id:colider2
                    categories: Box.Category4
                    collidesWith: Box.Category2|Box.Category3|Box.Category1|Box.Category5|Box.Category6
                    anchors.fill: ground2
                    bodyType: Body.Static // the body shouldn't move
                }
            }

            EntityBase {
                id:ground3
                entityId: "ground"
                entityType: "ground"
                height: 60
                width:container.width/5
                anchors.left: ground2.right
                anchors.bottom: container.bottom

                Image {
                    anchors.fill: colider3
                    source: "../../assets/newyear/wall.png"
                }
                BoxCollider {
                    id:colider3
                    categories: Box.Category4
                    collidesWith: Box.Category2|Box.Category3|Box.Category1|Box.Category5|Box.Category6
                    anchors.fill: ground3
                    bodyType: Body.Static // the body shouldn't move
                }
            }

            EntityBase {
                id:ground4
                entityId: "ground"
                entityType: "ground"
                height: 60
                width:container.width/5
                anchors.left: ground3.right
                anchors.bottom: container.bottom

                Image {
                    anchors.fill: colider4
                    source: "../../assets/newyear/wall.png"
                }
                BoxCollider {
                    id:colider4
                    categories: Box.Category4
                    collidesWith: Box.Category2|Box.Category3|Box.Category1|Box.Category5|Box.Category6
                    anchors.fill: ground4
                    bodyType: Body.Static // the body shouldn't move
                }
            }

            EntityBase {
                id:ground5
                entityId: "ground"
                entityType: "ground"
                height: 60
                width:container.width/5
                anchors.left: ground4.right
                anchors.right: container.right
                anchors.bottom: container.bottom

                Image {
                    anchors.fill: colider5
                    source: "../../assets/newyear/wall.png"
                }
                BoxCollider {
                    id:colider5
                    categories: Box.Category4
                    collidesWith: Box.Category2|Box.Category3|Box.Category1|Box.Category5|Box.Category6
                    anchors.fill: ground5
                    bodyType: Body.Static // the body shouldn't move
                }
            }

            EntityBase {
                entityId: "ground2"
                entityType: "ground"
                width: 20
                height:container.height
                anchors {
                    bottom: container.bottom
                    right: container.right
                }

                Rectangle {
                    anchors.fill: parent
                    color: "blue"
                }
                BoxCollider {
                    categories: Box.Category4
                    collidesWith: Box.Category2|Box.Category3|Box.Category1|Box.Category5|Box.Category6
                    anchors.fill: parent
                    bodyType: Body.Static // the body shouldn't move
                }
            }


            EntityBase {
                entityId: "ground3"
                entityType: "ground"
                width: 20
                height:container.height
                anchors {
                    bottom: container.bottom
                    left: container.left
                }

                Rectangle {
                    anchors.fill: parent
                    color: "blue"
                }
                BoxCollider {
                    categories: Box.Category4
                    collidesWith: Box.Category2|Box.Category3|Box.Category1|Box.Category5|Box.Category6
                    anchors.fill: parent
                    bodyType: Body.Static // the body shouldn't move
                }
            }

            ParallaxScrollingBackground {
                height: 20
                movementVelocity: Qt.point(15,0)
                ratio: Qt.point(1.0,1.0)
                mirrorSecondImage: false
                sourceImage: "../../assets/goldenpig/yun.png"
                anchors.top:container.top

            }

            MenuButton{
                image.source: "../../assets/Back.png"
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                width: 30
                height: 30
                onClicked: {
                    backpressed()
                }
            }
        }
    }
    function resetgame(){
        firstpig = true
        secondpig = true
        thirdpig = true
        forthpig = true
        fifthpig = true
        sixthpig = true
        seventhpig = true
        firstredbird = true
        firstyellowbird = true
        secondyellowbird = true
        toRemove = ["pig1","pig2","pig3","pig4","pig5","pig6","pig7"]
        entityManager.removeEntitiesByFilter(toRemove)
        toRemove = ["wood"]
        entityManager.removeEntitiesByFilter(toRemove)
        toRemove = ["redbird"]
        entityManager.removeEntitiesByFilter(toRemove)
        toRemove = ["yellowBird1","yellowBird2"]
        entityManager.removeEntitiesByFilter(toRemove)

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Yellowbird.qml"),
                    {entityType:"yellowBird1",width: 30,height: 30,id:yellowbird,x:200,y:container.height-120});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Yellowbird.qml"),
                    {entityType:"yellowBird2",width: 30,height: 30,id:yellowbird1,x:150,y:container.height-120});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Redbird.qml"),
                    {id:redBird,x:72,y:container.height-160});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {id:wood1,x:500,y:container.height-70});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {id:wood2,x:510,y:container.height-170,width:100,rotation:90});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {id:wood3,x:620,y:container.height-170,width:100,rotation:90});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {id:wood4,x:500,y:container.height-180});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {id:wood5,x:510,y:container.height-280,width:100,rotation:90});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {id:wood6,x:620,y:container.height-280,width:100,rotation:90});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {id:wood7,x:500,y:container.height-290});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {id:wood8,x:750,y:container.height-70});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {id:wood9,x:760,y:container.height-170,width:100,rotation:90});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {id:wood10,x:870,y:container.height-170,width:100,rotation:90});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {id:wood11,x:750,y:container.height-180,density:5});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {id:wood12,x:760,y:container.height-280,width:100,rotation:90});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {id:wood13,x:870,y:container.height-280,width:100,rotation:90});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {id:wood14,x:750,y:container.height-290});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {id:wood15,x:562,y:container.height-380,width:100,rotation:120,density:0.1});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {id:wood16,x:570,y:container.height-385,width:100,rotation:60,density:0.1});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {id:wood17,x:812,y:container.height-380,width:100,rotation:120,density:0.1});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {id:wood18,x:820,y:container.height-385,width:100,rotation:60,density:0.1});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Pig.qml"),
                    {entityType:"pig1",id:thepig1,y:container.height-102,x:560});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Pig.qml"),
                    {entityType:"pig2",id:thepig2,y:container.height-202,x:560});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Pig.qml"),
                    {entityType:"pig3",id:thepig3,y:container.height-102,x:810});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Pig.qml"),
                    {entityType:"pig4",id:thepig4,y:container.height-202,x:810});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Pig.qml"),
                    {entityType:"pig5",id:thepig5,y:container.height-310,x:570,width:20,height:20});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Pig.qml"),
                    {entityType:"pig6",id:thepig6,y:container.height-310,x:800,width:20,height:20});

//        entityManager.createEntityFromUrlWithProperties(
//                    Qt.resolvedUrl("../Entity/Pig.qml"),
//                    {entityId:"pig7",id:thepig7,y:container.height-310,x:800,width:20,height:20});
    }
}
