import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

Item {
    id:root
    anchors.fill: parent

    property int col: Maze.getCol()
    property int row: Maze.getRow()
    property bool getInfo: false
    property int time: 0
    property int movmentCount: 0

    signal gotoMenu()

    Component.onCompleted: {
        Maze.recursiveSolve(Maze.getStartI() , Maze.getStariJ())
        Maze.setPath()
        getInfo = true
    }


    GridLayout{
        anchors.centerIn: parent
        columns: row
        rowSpacing: 1
        columnSpacing: 1
        Repeater{
            model: col * row
            delegate: Rectangle{
                width:30 /*Math.floor(root.width / row)*/
                height:30 /*Math.floor(root.width / row)*/
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
    Rectangle{
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 5
        anchors.bottomMargin: 5
        width: 50
        height: width
        radius: 8
        color: "skyblue"
        MouseArea{
            anchors.fill: parent
            cursorShape: "PointingHandCursor"
            onClicked: {
                gotoMenu()
            }
        }
    }

    function get(modelData){
        var value = Maze.getMaze(modelData)
        if(!value) 
            return ""
        else
            return value
    }
}
