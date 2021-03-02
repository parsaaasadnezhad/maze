import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.3

Item {
    id: itemId
    anchors.fill: parent

    signal gotoGame()
    signal gotoSolotion()
    signal gotoleaderbord()
    property bool rect1Enalble: true

    Component.onCompleted: Maze.backToFirst()


    Item{
        anchors.fill: itemId
        //spacing: -150
        //1
        Pane{
            id:rect1_Id
            y:10
            enabled: rect1Enalble
            anchors.horizontalCenter: parent.horizontalCenter
            width: itemId.width - 20
            height: itemId.height/2 - 10
            Material.background: Material.Yellow
            Material.elevation: 10
            ColumnLayout{
                anchors.fill:parent
                //1
                RowLayout{
                    Layout.alignment: Layout.Center
                    spacing: 10
                    Label{
                        text:
                        {
                            if(HeapSort.getCount() !== HeapSort.getCurrentIndex())
                            {
                                rect1Enalble = true
                                HeapSort.getname(HeapSort.getCurrentIndex()) + "!!! ، نوبته بازی فرا رسیده"

                            }
                            else
                            {
                                rect1Enalble = false
                                "تمام بازیکنان بازی خود را به اتمام رسانده اند."

                            }
                        }
                        font{family: myfont_Id.name ; pointSize: 18}
                        color: "#555"
                    }
                    Image {
                        source:
                        {
                            if(HeapSort.getCount() !== HeapSort.getCurrentIndex())
                                "qrc:/icon/icon/" + HeapSort.getavator(HeapSort.getCurrentIndex()) + ".png"
                            else
                                ""
                        }
                        sourceSize: "60x60"

                    }
                }
                Image {
                    Layout.alignment: Layout.Center
                    source: "qrc:/icon/icon/entertainment.png"
                    sourceSize: "200x200"
                    fillMode: Image.PreserveAspectFit
                }
            }
            MouseArea{
                anchors.fill: parent
                cursorShape: "PointingHandCursor"
                onClicked: {
                    itemId.gotoGame()
                }
            }
        }
        Item{
            y:parent.height/2
            width: parent.width
            height: parent.height/2
            //2
            Pane{
                x:10
                y:10
                width: parent.width/2 - 10
                height: parent.height -20
                Material.background: Material.Yellow
                Material.elevation: 10
                Image {
                    anchors.centerIn: parent
                    source: "qrc:/icon/icon/leaderboard.png"
                    sourceSize: "100x100"
                    fillMode: Image.PreserveAspectFit
                }
                MouseArea{
                    anchors.fill: parent
                    cursorShape: "PointingHandCursor"
                    onClicked: {
                        gotoleaderbord()
                    }
                }
            }
            //3
            Pane{
                x:parent.width/2 + 10
                y:10
                width: parent.width/2 - 20
                height: parent.height - 20
                Material.background: Material.Yellow
                Material.elevation: 10
                Image {
                    anchors.centerIn: parent
                    source: "qrc:/icon/icon/problem.png"
                    sourceSize: "100x100"
                    fillMode: Image.PreserveAspectFit
                }
                MouseArea{
                    anchors.fill: parent
                    cursorShape: "PointingHandCursor"
                    onClicked: {
                        gotoSolotion()
                    }
                }
            }
        }
    }
}
