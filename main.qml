import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.3
import QtMultimedia 5.14


ApplicationWindow {
    id:root
    visible: true
    width: 650
    height: 700
    title: qsTr("Hello World")
    Material.theme: Material.Light


    Component.onCompleted:{
        toolBar_Id.visible = false
        loader_Id.sourceComponent = watingComponent_Id
    }

    FontLoader { id: myfont_Id; source: "qrc:/font/font/Negaar Regular.ttf" ; }

    Loader{
        id:loader_Id
        anchors.fill: parent
        focus: true//very important line

    }
    //1
    Component{
        id:menuComponent_Id
        Menuuu{
            id:menu_Id
            onGotoGame: {
                loader_Id.sourceComponent = gameComponent_Id
                dreamMusic.stop()
                if(switch_Id.checked)
                    summerMusic_Id.play();
            }
            onGotoSolotion: {
                loader_Id.sourceComponent = solotionComponent_Id
            }
            onGotoleaderbord: {
                loader_Id.sourceComponent = leaderbordComponent_Id
            }
        }
    }
    //2
    Component{
        id:playerComponent_Id
        Player{
            id:player_Id
            onChangePage: loader_Id.sourceComponent = menuComponent_Id
        }
    }
    //3
    Component{
        id:gameComponent_Id
        Game{
            id:game_Id
            onGotoMenu: {
                //Maze.backToFirst()
                summerMusic_Id.stop()
                if(switch_Id.checked)
                    dreamMusic.play()
                //HeapSort
                loader_Id.sourceComponent = menuComponent_Id
            }
        }
    }
    //4
    Component{
        id:solotionComponent_Id
        Solotion{
            id:solotion_Id
            onGotoMenu:{
                loader_Id.sourceComponent = menuComponent_Id
            }
        }
    }
    //5
    Component{
        id:watingComponent_Id
        Wating{
            id:wationg_Id
            onGotoPlayer: {
                loader_Id.sourceComponent = playerComponent_Id
                toolBar_Id.visible = true
            }
        }
    }
    //6
    Component{
        id:leaderbordComponent_Id
        Leaderboard{
            id:leaderbord_Id
        }
    }

    //menuBar
    header: ToolBar{
        id:toolBar_Id
        visible: false
        Material.elevation: 10
        Material.background: Material.Yellow
        Material.accent: Material.DeepPurple
        Material.foreground: Material.DeepPurple
        height: 60

        RowLayout{
            x:10
            anchors.verticalCenter: parent.verticalCenter
            spacing: 30
            Image{
                source: "qrc:/icon/icon/gear.png"
                sourceSize: "30x30"
                fillMode: Image.PreserveAspectFit

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if (stackView.depth > 1) {
                            stackView.pop()
                        } else {
                            drawer.open()
                        }
                    }
                }
            }
            Label{
                Layout.fillWidth: true
                text: "Maze"
                font.pointSize: 15
            }
        }
    }
    //++++++++++++++++++++++++++++++++++++++++++++++++++++
    Drawer {
        id: drawer
        width: parent.width * 0.4
        height: parent.height
        opacity: 0.9

        Column {
            anchors.fill: parent

            //0
            Image{
                id:image_Id
                source: "qrc:/icon/icon/brain.png"
                anchors.horizontalCenter: parent.horizontalCenter
                //fillMode: Image.PreserveAspectFit
                width: parent.width/2
                height: width
            }
            //1
            ItemDelegate {
                icon.source: "qrc:/icon/icon/browser.png"
                text: qsTr("HOME")
                width: parent.width
                onClicked: {
                    loader_Id.sourceComponent = playerComponent_Id
                    drawer.close()
                }
            }
            //2
            //  Row{
            ItemDelegate {
                icon.source: "qrc:/icon/icon/technical-support.png"
                text: qsTr("SOUND")
                width: parent.width
                onClicked: {
                    //stackView.push("Page1Form.ui.qml")
                    soundDialog_Id.open()
                    drawer.close()
                }
            }
            //                Switch{
            //                    id:soundSwitch_Id
            //                    anchors.right: drawer.right
            //                }
            //            }
            //3
            ItemDelegate {
                icon.source: "qrc:/icon/icon/user.png"
                text: qsTr("ABOUT ME")
                width: parent.width
                onClicked: {
                    // stackView.push("Page2Form.ui.qml")
                    aboutMeDialog_Id.open()
                    drawer.close()
                }
            }
            //4
            ItemDelegate {
                icon.source: "qrc:/icon/icon/help.png"
                text: qsTr("HELP")
                width: parent.width
                onClicked: {
                    // stackView.push("Page2Form.ui.qml")
                    drawer.close()
                }
            }
        }
    }

    StackView {
        id: stackView
        // initialItem: "main.qml"
        anchors.fill: parent
    }

        Audio {
            id: dreamMusic
            autoPlay: true
            source: "qrc:/song/song/bensound-dreams.mp3"
        }
        Audio {
            id: summerMusic_Id
            //autoPlay: true
            source: "qrc:/song/song/bensound-summer.mp3"
        }
    Dialog{
        id:soundDialog_Id
        width: 200
        height: width
        modal: true
        focus: true
        x:(parent.width-width)/2
        y:(parent.height-height)/2 - 100
        title: "SOUND"
        RowLayout{
            anchors.centerIn: parent
            Image{
                sourceSize: "30x30"
                fillMode: Image.PreserveAspectFit
                source: "qrc:/icon/icon/technical-support.png"
            }
            Switch{
                id:switch_Id
                checked: true
                onCheckedChanged: {
                    if(checked)
                    {
//                        if(summerMusic_Id.muted)
//                            summerMusic_Id.play()
//                        else if(dreamMusic.muted)
                            dreamMusic.play()
                    }
                    else{
                        summerMusic_Id.stop()
                        dreamMusic.stop()
                    }
                }
            }
        }
    }
    //about me Dialog
    Dialog{
        id:aboutMeDialog_Id
        width: 320
        height: width + 100
        modal: true
        focus: true
        x:(parent.width-width)/2
        y:(parent.height-height)/2 - 100
        title: "ABOUT ME"

        ColumnLayout{
            anchors.fill: parent
            RowLayout{
                Image{
                    sourceSize: "200x150"
                    source: "qrc:/image/image/paghsa.jpg"
                }
                Label{
                    //text: "<a href=\"http://google.com\">Parsa Asadnezhad</a>"
                    text: "پارسا اسدنژاد"
                    font{family:myfont_Id.name ; pointSize:20}
                    color: "#555"
                }
            }
            //2
            Text{
                width: 180
                text: "Hi , I am a highly trained computer professional\nwith the following skills:C++,QML,Python"
                font.pointSize: 10
                wrapMode: Text.Wrap
            }
            //3
            Row{
                spacing: 20
                Image{
                    source:"qrc:/icon/icon/gmail.png"
                    sourceSize: "30x30"
                }
                Label{
                    verticalAlignment: Text.AlignVCenter
                    text: "parsaasadnezhad2@gmail.com"
                }
            }
            //4
            Row{
                spacing: 20
                Image{
                    source:"qrc:/icon/icon/instagram.png"
                    sourceSize: "30x30"
                }
                Label{
                    verticalAlignment: Text.AlignVCenter
                    text: "@parsaasadnezhad"
                }
            }
            //5
            Row{
                spacing: 20
                Image{
                    source:"qrc:/icon/icon/telegram.png"
                    sourceSize: "30x30"
                }
                Label{
                    verticalAlignment: Text.AlignVCenter
                    text: "@parsaasadnezhad"
                }
            }
        }
    }
}
