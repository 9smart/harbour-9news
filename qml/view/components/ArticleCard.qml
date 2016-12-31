import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: articleCard

    width: parent ? parent.width : Screen.width
    height: column.height

    property alias title: title.text
    property alias thumb: thumb.source
    property alias summary: summary.text
    property string timestamp
    property int views: 0
    property int comments: 0

//    Image {
//        id: bg
//        anchors.fill: parent
//        source: Qt.resolvedUrl("../graphics/mask_background_reposted.png")
//    }

    Column {
        id: column
        width: parent.width

        Label {
            id: title
            width: parent.width
            color: Theme.highlightColor
            font.pixelSize: Theme.fontSizeMedium
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        }

        Item {
            width: parent.width
            height: tsLabel.height
            Label {
                id: tsLabel
                anchors.left: parent.left
                //anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: Theme.fontSizeTiny
                color: Theme.secondaryColor
                text: articleCard.timestamp
            }
//            Label {
//                anchors.right: parent.right
//                //anchors.verticalCenter: parent.verticalCenter
//                font.pixelSize: Theme.fontSizeTiny
//                color: Theme.secondaryColor
//                text: "info image"
//            }
            Row {
                anchors.right: parent.right
                anchors.rightMargin: Theme.paddingSmall
                spacing: Theme.paddingSmall
                Image {
                    height: parent.height
                    width: height
                    source: "image://theme/icon-cover-message"
                }
                Label {
                    font.pixelSize: Theme.fontSizeTiny
                    verticalAlignment: Text.AlignVCenter
                    color: Theme.secondaryColor
                    text: articleCard.comments
                }
                Image {
                    height: parent.height
                    width: height
                    source: "image://theme/icon-cover-camera"
                }
                Label {
                    font.pixelSize: Theme.fontSizeTiny
                    verticalAlignment: Text.AlignVCenter
                    color: Theme.secondaryColor
                    text: articleCard.views
                }
            }
        }

        Item {
            width: parent.width
            height: Theme.itemSizeMedium
            Image {
                id: thumb
                height: parent.height
//                anchors.right: parent.right
                anchors.left: parent.left
                width: height
                fillMode: Image.PreserveAspectCrop
            }

            Label {
                id: summary
//                anchors.left: parent.left
//                anchors.right: thumb.left
//                anchors.rightMargin: Theme.paddingSmall
                anchors.left: thumb.right
                anchors.right: parent.right
                anchors.leftMargin: Theme.paddingMedium
                height: parent.height
                maximumLineCount: 3
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                elide: Text.ElideRight
                font.pixelSize: Theme.fontSizeSmall * 0.8
                color: Theme.primaryColor
            }
//            Image {
//                id: thumb
//                height: parent.height
//                anchors.right: parent.right
//                width: height
//                fillMode: Image.PreserveAspectCrop
//            }
        }
    }

}
