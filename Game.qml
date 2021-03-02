import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

Item {
    anchors.fill: parent
    property int col: Maze.getCol()
    property int row: Maze.getRow()
    property bool getInfo: true
    property int time: 0
    property int movmentCount: 0
    property int solveMazeCount: 0

    signal gotoMenu()

    Component.onCompleted: solveMazeCount = Maze.solve()/*Maze.backToFirst()*/

    focus: true
    Keys.onPressed: {
        getInfo = false
        if(event.key === Qt.Key_W)
        {movmentCount = Maze.movment(0 , movmentCount)}
        else if(event.key === Qt.Key_D)
        {movmentCount = Maze.movment(1 , movmentCount)}
        else if(event.key === Qt.Key_S)
        {movmentCount = Maze.movment(2 , movmentCount)}
        if(event.key === Qt.Key_A)
        {movmentCount = Maze.movment(3 , movmentCount)}
        if(movmentCount < 0)
        {
            finishDialog_Id.open()
            movmentCount+=10000
            timer_Id.stop()
        }

        getInfo = true
    }

//    Pane{
//        id:topMenuPad_Id
//        y:10
//        width: parent.width - 20
//        height: 60
//        anchors.horizontalCenter: parent.horizontalCenter
//        Material.background: Material.Lime
//        Material.elevation: 10

//        RowLayout{
//            anchors.fill: parent

//            //1
//            Rectangle{
//                width: parent.width/3
//                height: parent.height-10
//                border.width: 2
//                radius: 10
//                border.color: "darkorange"
//                Rectangle{
//                    id:starRect_Id
//                    anchors.centerIn: parent
//                    width: parent.width - 2
//                    height: parent.height - 2
//                    color: "#ff9a9e"
//                    radius: 10
//                    gradient: Gradient {
//                        GradientStop {
//                            position: 0
//                            color: "#ff9a9e"
//                        }
//                        GradientStop {
//                            position: 0.99
//                            color: "#fecfef"
//                        }
//                        GradientStop {
//                            position: 1
//                            color: "#fecfef"
//                        }
//                    }
//                }
//            }
//        }
//    }

    GridLayout{
        anchors.centerIn: parent
        columns: row
        rowSpacing: 1
        columnSpacing: 1
        Repeater{
            model: col * row
            delegate: Rectangle{
                width: 30
                height: width
                radius: 3
                color: "lightgreen"

                Image{
                    id:img_Id
                    visible: true
                    anchors.fill: parent
                    //sourceSize: "30x30"
                    source:{
                        if(getInfo)
                        {
                            get(modelData)
                        }
                        else
                            ""
                    }
                }
            }
        }

    }
    function get(modelData){
        var value ;
        if(Maze.getMaze(modelData))
            value = Maze.getMaze(modelData)
        else
            value = ""

        return value
    }
    Rectangle{
        id:timerRect_Id
        width: 30
        height: 30
        radius: 8
        color: "skyblue"
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 5
        anchors.bottomMargin: 5
        Text{
            anchors.centerIn: parent
            text: time
        }
    }
    Rectangle{
        id:counterRect_Id
        width: 30
        height: 30
        radius: 8
        color: "skyblue"
        anchors.right: timerRect_Id.left
        anchors.bottom: parent.bottom
        anchors.rightMargin: 5
        anchors.bottomMargin: 5
        Text{
            anchors.centerIn: parent
            text: movmentCount
        }
    }
    Timer{
        id:timer_Id
        interval: 1000
        repeat: true
        running: true
        onTriggered: time++;
    }
    Dialog{
        id:finishDialog_Id
        width: 400
        height: 500
        x:(parent.width-width)/2
        y:(parent.height-height)/2
        modal: true
        focus: true
        //title: "Add"
        standardButtons: Dialog.Ok
        Material.elevation: 10
        onClosed:{
            HeapSort.setPlayerInfo(movmentCount , solveMazeCount , time)

            HeapSort.setCurrentIndex()
            gotoMenu()
        }

        ColumnLayout{
            anchors.centerIn: parent
            spacing: 20
            Layout.alignment: Layout.Center

            Text{
                Layout.alignment: Layout.Center
                text: "AMAZING!!!"
                font{family: "Tahoma" ; pointSize: 30}
                color: "lightpink"
            }

            RowLayout{
                Layout.fillHeight: true
                //                height: 250
                //                width: 200
                Repeater{
                    //width: parent.width
                    //height: parent.height
                    model:3
                    delegate: Rectangle{
                        width:100
                        height: width
                        color: "transparent"
                        Image {
                            anchors.centerIn: parent
                            sourceSize: {
                                if(modelData ===1)
                                    "110x110"
                                else
                                    "80x80"
                            }
                            source: "qrc:/icon/icon/star.png"
                        }
                    }
                }
            }
            RowLayout{
                Layout.alignment: Layout.Center
                Layout.topMargin: 50
                spacing: 20
                Image{
                    sourceSize: "40x40"
                    source: "qrc:/icon/icon/clock.png"
                }
                Label{
                    text: time
                    font{family: "Tahoma" ; pointSize: 30}
                    color: "lightpink"
                }
            }
            RowLayout{
                Layout.alignment: Layout.Center
                spacing: 20
                Image{
                    sourceSize: "40x40"
                    source: "qrc:/icon/icon/steps.png"
                }
                Label{
                    text: movmentCount
                    font{family: "Tahoma" ; pointSize: 30}
                    color: "lightpink"
                }
            }
        }
    }
//    NumberAnimation{
//        target: starRect_Id
//        running: true
//        from:starRect_Id.width
//        to:0
//        duration: 60000
//    }
}
