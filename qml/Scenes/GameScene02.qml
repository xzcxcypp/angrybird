import Felgo 3.0
import QtQuick 2.0
import "../Entity"
import "../fly"
import "../common"

SceneBase{
    signal haswon
    signal haslossed
    signal backpressed

    property alias linerunning:line.running

    width: 960
    height: 640
    id: gamescene
    anchors.fill: parent

    property int linepointx: 72
    property int linepointy: 480

    property var toRemove : "NULL"
    property int usetime: 0
    property int beginposx
    property int beginposy
    property int endposx
    property int endposy

    EntityManager {
        id: entityManager
        entityContainer: container//指定哪个QML项是使用EntityManager创建的实体的父项,通常是场景项。

    }

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

            Slingshot{
                x:50
                y:container.height-150
                id:theslingshot
            }

            LineItem {
                id:upline
                color: "brown"
                lineWidth: 6
                points: [
                    {"x":53, "y":container.height-145},
                    {"x":linepointx, "y":linepointy+20}
                ]
            }

            LineItem {
                id:downline
                lineWidth: 6
                color: "brown"
                points: [
                    {"x":100, "y":container.height-145},
                    {"x":linepointx+25, "y":linepointy+20}
                ]
            }

            Text {
                id: time
                text: "time:"+usetime
                color: "white"
                anchors.horizontalCenter: parent.horizontalCenter
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
                opacity: 0
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
                opacity: 0
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

    property var resetfirstredbird: null
    property var resetfirstyellowbird: null
    property var resetsecondyellowbird: null
    property var resetfirstpig: null
    property var resetsecondpig: null
    property var resetthirdpig: null
    property var resetforthpig: null
    property var resetfifthpig: null
    property var resetsixthpig: null
    property var resetseventhpig: null


    Timer{
        id:check
        interval: 1000
        running: false
        repeat: true
        onTriggered: {
            if(gamescene.firstpig == false && gamescene.secondpig == false && gamescene.thirdpig == false && gamescene.forthpig == false && gamescene.fifthpig == false && gamescene.sixthpig == false && seventhpig == false){
                haswon()
            }else if(gamescene.firstredbird == false && gamescene.firstyellowbird == false && gamescene.secondyellowbird == false){
                haslossed()
            }
        }
    }

    Timer{
        id:firstredchange
        interval: 1000
        repeat: true
        running: false
        onTriggered: {
            if((entityManager.getEntityById(resetfirstredbird)).exist === false){
                (entityManager.getEntityById(resetfirstyellowbird)).ready()
                firstredchange.running = false
                firstredbird = false
            }
        }
    }

    Timer{
        id:firstyellowchange
        interval: 1000
        repeat: true
        running: false
        onTriggered: {
            if((entityManager.getEntityById(resetfirstyellowbird)).exist === false){
                (entityManager.getEntityById(resetsecondyellowbird)).ready()
                firstyellowchange.running = false
                firstyellowbird = false
            }
        }
    }

    Timer{
        id:secondyellowchange
        interval: 1000
        repeat: true
        running: false
        onTriggered: {
            if((entityManager.getEntityById(resetsecondyellowbird)).exist === false){
                secondyellowchange.running = false
                secondyellowbird = false
            }
        }
    }

    Timer{
        id:firstpigchange
        interval: 1000
        repeat: true
        running: false
        onTriggered: {
            if((entityManager.getEntityById(resetfirstpig)).exist === false){
                firstpigchange.running = false
                firstpig = false
            }
        }
    }

    Timer{
        id:secondpigchange
        interval: 1000
        repeat: true
        running: false
        onTriggered: {
            if((entityManager.getEntityById(resetsecondpig)).exist === false){
                secondpigchange.running = false
                secondpig = false
            }
        }
    }

    Timer{
        id:thirdpigchange
        interval: 1000
        repeat: true
        running: false
        onTriggered: {
            if((entityManager.getEntityById(resetthirdpig)).exist === false){
                thirdpigchange.running = false
                thirdpig = false
            }
        }
    }

    Timer{
        id:forthpigchange
        interval: 1000
        repeat: true
        running: false
        onTriggered: {
            if((entityManager.getEntityById(resetforthpig)).exist === false){
                forthpigchange.running = false
                forthpig = false
            }
        }
    }

    Timer{
        id:fifthpigchange
        interval: 1000
        repeat: true
        running: false
        onTriggered: {
            if((entityManager.getEntityById(resetfifthpig)).exist === false){
                fifthpigchange.running = false
                fifthpig = false
            }
        }
    }

    Timer{
        id:sixthpigchange
        interval: 1000
        repeat: true
        running: false
        onTriggered: {
            if((entityManager.getEntityById(resetsixthpig)).exist === false){
                sixthpigchange.running = false
                sixthpig = false
            }
        }
    }

    Timer{
        id:seventhpigchange
        interval: 1000
        repeat: true
        running: false
        onTriggered: {
            if((entityManager.getEntityById(resetseventhpig)).exist === false){
                seventhpigchange.running = false
                seventhpig = false
            }
        }
    }

    Timer{
        id:timing
        interval: 1000
        running: false
        repeat: true
        onTriggered: {
            usetime++
        }
    }

    Timer{
        id:line
        interval: 1
        repeat: true
        running: false
        onTriggered: {
            if((entityManager.getEntityById(resetfirstredbird)).isfly === false){
                linepointx = (entityManager.getEntityById(resetfirstredbird)).x
                linepointy = (entityManager.getEntityById(resetfirstredbird)).y
            }else if((entityManager.getEntityById(resetfirstyellowbird)).isfly === false && (entityManager.getEntityById(resetfirstyellowbird)).isready === false){
                linepointx = 72
                linepointy = 480
                line.running = false
                oneyellowline.running = true
            }
        }
    }

    Timer{
        id:oneyellowline
        interval: 1
        repeat: true
        running: false
        onTriggered: {
            if((entityManager.getEntityById(resetfirstyellowbird)).isfly === false && (entityManager.getEntityById(resetfirstyellowbird)).isready === false){
                linepointx = 72
                linepointy = 480
            }else if((entityManager.getEntityById(resetfirstyellowbird)).isfly === false && (entityManager.getEntityById(resetfirstyellowbird)).isready === true){

                linepointx = (entityManager.getEntityById(resetfirstyellowbird)).x
                linepointy = (entityManager.getEntityById(resetfirstyellowbird)).y
            }else if((entityManager.getEntityById(resetsecondyellowbird)).isfly === false && (entityManager.getEntityById(resetsecondyellowbird)).isready === false){
                linepointx = 72
                linepointy = 480
                oneyellowline.running = false
                twoyellowline.running = true
            }
        }
    }

    Timer{
        id:twoyellowline
        interval: 1
        repeat: true
        running: false
        onTriggered: {
            if((entityManager.getEntityById(resetsecondyellowbird)).isfly === false && (entityManager.getEntityById(resetsecondyellowbird)).isready === false){
                linepointx = 72
                linepointy = 480
            }else if((entityManager.getEntityById(resetsecondyellowbird)).isfly === false && (entityManager.getEntityById(resetsecondyellowbird)).isready === true){           
                linepointx = (entityManager.getEntityById(resetsecondyellowbird)).x
                linepointy = (entityManager.getEntityById(resetsecondyellowbird)).y
            }else{
                linepointx = 72
                linepointy = 480
                twoyellowline.running = false
            }
        }
    }


    function resetgame(){
        check.restart()
        firstredchange.restart()
        firstyellowchange.restart()
        secondyellowchange.restart()
        firstpigchange.restart()
        secondpigchange.restart()
        thirdpigchange.restart()
        forthpigchange.restart()
        fifthpigchange.restart()
        sixthpigchange.restart()
        seventhpigchange.restart()
        usetime = 0
        timing.restart()

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

        //Remove entity
        toRemove = ["pig1","pig2","pig3","pig4","pig5","pig6"]
        entityManager.removeEntitiesByFilter(toRemove)
        toRemove = ["wood"]
        entityManager.removeEntitiesByFilter(toRemove)
        toRemove = ["redbird"]
        entityManager.removeEntitiesByFilter(toRemove)
        toRemove = ["yellowBird1","yellowBird2"]
        entityManager.removeEntitiesByFilter(toRemove)

        //Generate components
        resetfirstyellowbird = entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Yellowbird.qml"),
                    {entityType:"yellowBird1",width:30,height: 30,x:170,y:container.height-100});

        resetsecondyellowbird = entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Yellowbird.qml"),
                    {entityType:"yellowBird2",width: 30,height: 30,x:137,y:container.height-100});

        resetfirstredbird = entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Redbird.qml"),
                    {x:72,y:container.height-160});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {x:500,y:container.height-70});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {x:510,y:container.height-170,width:100,rotation:90});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {x:620,y:container.height-170,width:100,rotation:90});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {x:500,y:container.height-180});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {x:510,y:container.height-280,width:100,rotation:90});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {x:620,y:container.height-280,width:100,rotation:90});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {x:500,y:container.height-290});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {x:750,y:container.height-70});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {x:760,y:container.height-170,width:100,rotation:90});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {x:870,y:container.height-170,width:100,rotation:90});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {x:750,y:container.height-180,density:5});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {x:760,y:container.height-280,width:100,rotation:90});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {x:870,y:container.height-280,width:100,rotation:90});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {x:750,y:container.height-290});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {x:562,y:container.height-380,width:100,rotation:120,density:0.1});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {x:570,y:container.height-385,width:100,rotation:60,density:0.1});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {x:812,y:container.height-380,width:100,rotation:120,density:0.1});

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Wood.qml"),
                    {x:820,y:container.height-385,width:100,rotation:60,density:0.1});

        resetfirstpig = entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Pig.qml"),
                    {entityType:"pig1",y:container.height-102,x:560});

        resetsecondpig = entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Pig.qml"),
                    {entityType:"pig2",y:container.height-202,x:560});

        resetthirdpig = entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Pig.qml"),
                    {entityType:"pig3",y:container.height-102,x:810});

        resetforthpig = entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Pig.qml"),
                    {entityType:"pig4",y:container.height-202,x:810});

        resetfifthpig = entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Pig.qml"),
                    {entityType:"pig5",y:container.height-310,x:570,width:20,height:20});

        resetsixthpig = entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Pig.qml"),
                    {entityType:"pig6",y:container.height-310,x:800,width:20,height:20});

       resetseventhpig = entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../Entity/Pig.qml"),
                    {entityId:"pig7",y:container.height-100,x:680,width:20,height:20});

        line.restart()
    }
}
