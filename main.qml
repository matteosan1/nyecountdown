import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.0
import QtMultimedia 5.5

ApplicationWindow {
    id: mainwindow
    visible: true
    width: 640
    height: 480
    title: qsTr("")
    visibility: Window.FullScreen

    Rectangle {
        anchors.fill: parent
        id: sfondo
        color: "black"
    }

    Timer {
        id: timer_clock
        property string currentTime: ""
        interval: 1000
        repeat: true
        running: true

        onTriggered:
        {
            currentTime =  Qt.formatTime(new Date(),"hh:mm")
            if (currentTime == "23:59") {
                timer_clock.stop()
                timer_clock.running = false
                auguri.visible = false;
                immagine_auguri.visible = false
                my_clock.visible = false;
                root.visible = true
                innerTimer.start();
            }
        }
    }

    Item {
        id: my_clock
        z: 2
        Clock {}
    }

    Rectangle {
        anchors.fill: parent
        id: auguri
        color: "black"

        Image {
            id: immagine_auguri
            anchors.fill: parent
            fillMode: Image.Stretch
            source: "file:///Users/sani/Downloads/wetransfer-a80385/prova2_red_v2.png"
        }

        Loader {
            source: "file:///Users/sani/schermata/Wander.qml"
        }
    }

    Video {
        id: video
        anchors.fill: parent
        fillMode : VideoOutput.PreserveAspectFit
        source: "file:///Users/sani/nyecountdown/fireworks.mp4"
        anchors.centerIn: parent
        visible: false

        onStopped: {
            video.visible = false
            auguri.visible = true
            immagine_auguri.visible = true
            immagine_auguri.source = "file:///Users/sani/Downloads/wetransfer-a80385/prova2_con_auguri_red_v2.png"
        }
    }

    Rectangle {
        id: root
        visible: false
        anchors.fill: parent
        color: "black"
        property int seconds: 60
        property string theText: "1:00"
        signal triggert

        states: [
            State {
                name: "init"
                PropertyChanges { target: text; scale: zoom}
                //PropertyChanges { target: rotation; angle: 0}
            },
            State {
                name: "end"
                PropertyChanges { target: text; scale: 5}
                //PropertyChanges { target: rotation; angle: 0}
            }
        ]


        Text {
            id: text
            anchors.horizontalCenter: root.horizontalCenter
            anchors.verticalCenter: root.verticalCenter
            font.pixelSize: 50
            text: root.theText
            color: "#d6c372"
            scale: 1
            state: "init"
        }


        PropertyAnimation {
            id: anim
            properties: "scale"
            target: text;
            from: 0;
            to: 4;
            duration: 500
        }

        Timer {
            //running: true
            id: innerTimer
            repeat: true
            interval: 1000
            onTriggered: {
                root.seconds--;
                if (root.seconds < 10) {
                    root.theText = "0:0" + root.seconds.toString();
                } else {
                    root.theText = "0:" + root.seconds.toString();
                }

                if (root.seconds <= 10 && root.seconds >= 0) {
                    //console.log(text.scale)
                    //anim.running = false;
                    root.triggert();
                    //text.scale = 0;
                    anim.running = true;
                }
                else if (root.seconds < 0) {
                    innerTimer.stop()
                    auguri.visible = false
                    my_clock.visible = false
                    root.visible = false
                    text.visible = false
                    video.visible = true
                    video.play()
                }
            }
        }
    }
}
