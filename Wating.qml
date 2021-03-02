import QtQuick 2.14
import QtQuick.Controls 2.5

Rectangle {
    anchors.fill: parent
    //color: "#fff"
    property real counter: 0
    signal gotoPlayer()

    Component.onCompleted: {
        timer_Id.start()
    }

    Image{
        //anchors.fill: parent
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        //anchors.verticalCenterOffset: -100 + 40
        sourceSize: "400x400"
        fillMode: Image.PreserveAspectFit
        source: "qrc:/icon/icon/brain.png"
        //z:3
        //opacity: 0.3
    }

    Item{
        anchors.centerIn: parent
        width: animation.width
        height: animation.height

        AnimatedImage {
            id: animation;
            source: "qrc:/icon/icon/wating.gif"
            opacity: 0.7
        }
    }
    ProgressBar{
        id:progressbar_Id
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 100
        width: parent.width/2
        height: 30
        value: counter
    }

    Timer{
        id:timer_Id
        interval: 10
        repeat: true
        onTriggered: {
            if(counter > 1)
            {
                timer_Id.stop()
                gotoPlayer()
            }
            else{
                counter += 0.003
            }
        }
    }
}
