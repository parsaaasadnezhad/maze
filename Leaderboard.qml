import QtQuick 2.14
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Item {
    id:root
    anchors.fill: parent
    Component.onCompleted: {
        listModel_Id.clear()
        for(var i=0 ; i<HeapSort.getCount() ; i++)
        {
            listModel_Id.append({"name":HeapSort.getname(i) , "age":HeapSort.getage(i) , "avator":HeapSort.getavator(i) , "score":HeapSort.getscore(i) })
        }

    }

    Rectangle{
        id:topRect_Id
        y:-20
        width: parent.width
        height: parent.height/2.5
        color: "#ff5858"
        radius: 30
        gradient: gradient_Id
        Image{
            id:leaderbordImage_Id
            anchors.centerIn: parent
            source: "qrc:/icon/icon/goal.png"
            sourceSize: "150x200"
        }
    }
    Item{
        y:topRect_Id.height
        width: parent.width
        height: parent.height - topRect_Id.height
        clip: true

        Item{
            width: parent.width - 100
            height: parent.height - 100
            anchors.centerIn: parent

            ListView{
                anchors.fill:parent
                model: listModel_Id
                spacing: 20

                delegate: Rectangle{
                    width: root.width - 100
                    height: 70
                    radius: 20
                    color: "orange"
                     //gradient: gradient_Id
                    //1
                    Image{
                        x:-width/2
                        y:-height/2
                        sourceSize: "60x60"
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/icon/icon/" + avator + ".png"
                    }
                    //2
                    Label{
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 40
                        text: name
                        font{family: myfont_Id.name ; pointSize: 18}
                        color: "#555"

                    }
                    //3
                    Label{
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        text:score
                        font{family: myfont_Id.name ; pointSize: 18}
                        color: "#555"
                    }

                }
            }
            ListModel{
                id:listModel_Id
            }
        }
    }
    Gradient {
        id:gradient_Id
        GradientStop {
            position: 0
            color: "#ff5858"
        }
        GradientStop {
            position: 1
            color: "#f09819"
        }
    }
}

