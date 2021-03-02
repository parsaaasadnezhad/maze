import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.3

Item {
    id:root
    visible: true
    anchors.fill: parent
    focus: true

    signal changePage()
    property string avator: "bird"

    Component.onCompleted: {
        listModel_Id.clear()

        for(var i=0 ; i<HeapSort.getCount() ; i++)
            listModel_Id.append({"name":HeapSort.getname(i) , "age":HeapSort.getage(i) , "avatorr":HeapSort.getavator(i)})
    }

    Image{
        //anchors.fill: parent
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: -100
        sourceSize: "400x400"
        fillMode: Image.PreserveAspectFit
        source: "qrc:/icon/icon/brain.png"
    }

    Item{
        width: parent.width - 100
        height: parent.height - 100
        anchors.centerIn: parent

        ListView{
            id:listView_Id
            anchors.fill: parent
            //clip: true
            spacing: 40
            model: listModel_Id//root.modelArray//[1,2,3]

            delegate: ItemDelegate{
                width: root.width - 130
                height: 60
                Pane{
                    anchors.fill: parent
                    Material.elevation: 10
                    Material.background: Material.Yellow

                    RowLayout{
                        anchors.fill: parent
                        Label{
                            Layout.fillWidth: true
                            text:age//HeapSort.getname(0)
                            font{family: myfont_Id.name ; pointSize: 18}
                            //color: "#555"
                            color: Material.color(Material.DeepPurple)
                        }
                        Label{
                            text:name //HeapSort.getage(0)
                            font{family: myfont_Id.name ; pointSize: 18}
                            //color: "#555"
                            color: Material.color(Material.DeepPurple)
                        }
                    }
                    Image {
                        x:parent.width - 5
                        y:-height + 5
                        z:3
                        fillMode: Image.PreserveAspectFit
                        sourceSize: "60x60"
                        source: "qrc:/icon/icon/" + avatorr + ".png"//lion.png
                    }
                }
            }
        }
        ListModel{
            id:listModel_Id
            //ListElement{name:"parsi" ; age:"19"}
        }
    }


    Rectangle{
        id:bottomRect_Id
        //anchors.bottom: parent.bottom
        y:parent.height - height + 20
        width: parent.width
        height: 100
        color: Material.color(Material.Yellow)
        radius: 20

        //roundBotton
        RoundButton{
            id:addRoundButton_Id
            x:parent.width - width - 50
            y:-height/2
            width: 80
            height: 80
            text: "+"
            focus: true
            enabled: HeapSort.getAddButtonEnable()
            font{pointSize: 25}
            Material.background: Material.DeepPurple
            Material.foreground: "#FB5252"

            //rotation: addbtnMouse_Id.containsMouse ? 90 : 0

            MouseArea{
                id:addbtnMouse_Id
                anchors.fill: parent
                cursorShape: "PointingHandCursor"
                hoverEnabled: true
                onClicked: {
                    dialog_Id.open()
                }
//                onEntered: {
//                    addRoundButton_Id.radius = 10
//                }
//                onExited: {
//                    addRoundButton_Id.radius = addRoundButton_Id.width
//                }
            }
            //Behavior on rotation {NumberAnimation{duration:400 ; easing.type:Easing.InBack}}
        }

        RoundButton{
            x: 50
            y:-height/2
            width: 80
            height: 80
            enabled:  (listModel_Id.count > 0 ) ? true : false
            font{pointSize: 20}
            Material.background: Material.DeepPurple
            Material.foreground: Material.Red
            Image {
                id: playImage_Id
                anchors.centerIn: parent
                sourceSize: "30x30"
                fillMode: Image.PreserveAspectFit
                source: "qrc:/icon/icon/play.png"
            }
//            scale: playbtnMouse_Id.containsMouse ? 1.2 : 1
//            rotation: playbtnMouse_Id.containsMouse ? 90 : 0

            MouseArea{
                id:playbtnMouse_Id
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    HeapSort.setAddButtonEnable(false)
                    root.changePage()
                }
            }

//            Behavior on scale {NumberAnimation{duration:500 ; easing.type:Easing.InBack}}
//            Behavior on rotation {NumberAnimation{duration:400 ; easing.type:Easing.InBack}}
        }
    }

    Dialog{
        id:dialog_Id
        x:(parent.width-width)/2
        y:(parent.height - height)/2 - 100
        width: 250
        height: 300
        modal: true
        focus: true
        title: "Add"
        standardButtons: Dialog.Ok | Dialog.Cancel
        Material.elevation: 10
        onAccepted: {    
            listModel_Id.clear()
            if(textFieldAge_Id.text !== "" && textFieldName_Id !== "")
                HeapSort.setlist(textFieldName_Id.text , textFieldAge_Id.text , root.avator)

            for(var i=0 ; i<HeapSort.getCount() ; i++)
            {
                    listModel_Id.append({"name":HeapSort.getname(i) , "age":HeapSort.getage(i) , "avatorr":HeapSort.getavator(i)})
            }
            textFieldAge_Id.text = ""
            textFieldName_Id.text = ""
            textFieldName_Id.focus = true
        }
        onRejected: {
            textFieldAge_Id.text = ""
            textFieldName_Id.text = ""
            textFieldName_Id.focus = true
        }

        ColumnLayout
        {
            anchors.centerIn: parent

            TextField{
                id:textFieldName_Id
                placeholderText: "Name"
                Material.accent: Material.Red
                focus: true
                Layout.fillWidth: true
                //Material.accentColor: Material.Blue
            }
            TextField{
                id:textFieldAge_Id
                placeholderText: "Age"
                Layout.fillWidth: true
            }
            Button{
                text: "chose avator"
                onClicked:dialog_avator_Id.open()
            }
        }
    }

    //dialog avator
    Dialog{
        id:dialog_avator_Id
        x:(parent.width-width)/2
        y:(parent.height - height)/2 - 100
        width: 250
        height: 300
        modal: true
        focus: true
        clip: true
        title: "Avator"
        //standardButtons: Dialog.Ok | Dialog.Cancel
        Material.elevation: 10
        //        onAccepted: {

        //        }
        //        onRejected: {

        //        }
        Flickable{
            width: parent.width
            height: parent.height
            contentWidth: parent.width
            contentHeight: parent.height * 2
            GridLayout{
                anchors.fill: parent
                columns: 3
                rowSpacing: 10
                columnSpacing: 15
                Repeater{
                    model: listModel_avator_Id
                    delegate: Rectangle{
                        id:image_Id
                        width: 60
                        height: 60
                        radius: width
                        //color: Material.color(Material.Red)
                        Image {
                            source: "qrc:/icon/icon/" + sourcee + ".png"//cat.png"
                            fillMode: Image.PreserveAspectFit
                            sourceSize: "60x60"
                        }
                        MouseArea{
                            anchors.fill: parent
                            cursorShape: "PointingHandCursor"
                            onClicked: {
                                root.avator = sourcee
                                //image_Id.color = Material.color(Material.Green)
                                dialog_avator_Id.close()
                                //image_Id.color = Material.color(Material.Red)
                            }
                        }
                    }

                }
            }
        }

        ListModel{
            id:listModel_avator_Id
            ListElement{sourcee:"cat"}
            ListElement{sourcee:"cow"}
            ListElement{sourcee:"dog"}
            ListElement{sourcee:"fox"}
            ListElement{sourcee:"lion"}
            ListElement{sourcee:"panda"}
            ListElement{sourcee:"bird"}
            ListElement{sourcee:"crab"}
            ListElement{sourcee:"spider"}
            ListElement{sourcee:"horse"}
            ListElement{sourcee:"llama"}
            ListElement{sourcee:"seal"}
        }
    }
}
