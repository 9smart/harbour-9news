import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: splashPage

    Column {
        width: parent.width
        anchors {
            bottom: parent.bottom
            bottomMargin: Theme.paddingLarge
        }

        spacing: Theme.paddingLarge

        Label {
            text: qsTr("Welcome to")
            font.pixelSize: Theme.fontSizeExtraLarge
            anchors {
                left: parent.left
                leftMargin: Theme.paddingLarge
            }
        }

        Label {
            text: qsTr("9News")
            font.pixelSize: Theme.fontSizeExtraLarge
            color: Theme.highlightColor
            anchors{
                left: parent.left
                leftMargin: Theme.paddingLarge
            }
        }

        Item {
            height: Theme.paddingLarge
        }

        Label {
            text: qsTr("9Smart.cn")
            font.pixelSize: Theme.fontSizeTiny
            opacity:0.5
            anchors {
                right: parent.right
                rightMargin: Theme.paddingLarge
            }
        }
    }

    BusyIndicator {
        anchors {
            left: parent.left
            leftMargin: Theme.paddingLarge
            bottom: parent.bottom
            bottomMargin: Theme.paddingLarge
        }
        running: true
        size: BusyIndicatorSize.Small
    }
}
