import QtQuick 2.0
import Sailfish.Silica 1.0

import harbour_9news.sunrain 1.0

import "../../flux/stores"
import "../../flux/actions"
import "../components"
import ".."

Page {

    SilicaListView {
        id: listView
        anchors.fill: parent

        header: PageHeader {
            title: qsTr("comments")
        }

        PullDownMenu {
            enabled: (MainStore.userInfoStore.uid != undefined && MainStore.userInfoStore.token != undefined)
            visible: enabled
            MenuItem {
                text: qsTr("send comment")
                onClicked: {
                    AppFunctions.toCommentWritePage(pageStack,
                                                    ArticleContentStore.id,
                                                    AppConst._ACTION_POST_COMMENTS);
                }
            }
        }

        PushUpMenu {
            enabled: (MainStore.userInfoStore.uid != undefined && MainStore.userInfoStore.token != undefined)
            visible: enabled
            MenuItem {
                text: qsTr("send comment")
                onClicked: {
                    AppFunctions.toCommentWritePage(pageStack, MainStore.articleContentStore.id,
                                                    AppConst._ACTION_POST_COMMENTS);
                }
            }
        }

        spacing: Theme.paddingMedium
        model: MainStore.articleContentStore.commentsModel
        delegate: ListItem {
            width: parent.width
            contentHeight: Math.max(avatar.height, column.height) + sep.height + Theme.paddingMedium * 2
            property int itemIdx: index

            menu: ContextMenu {
                MenuItem {
                    text: qsTr("send comment")
                    onClicked: {
                        var id = MainStore.articleContentStore.commentsModel.get(index)._id;
                        AppFunctions.toCommentWritePage(pageStack,
                                                        id,
                                                        AppConst._ACTION_REPLY_COMMENTS);
                    }
                }
            }

            Image {
                id: avatar
                anchors.left: parent.left
                anchors.leftMargin: Theme.paddingLarge
                anchors.top: parent.top
                anchors.topMargin: Theme.paddingSmall
                height: Theme.iconSizeMedium
                width: height
                fillMode: Image.PreserveAspectFit
                source: MainStore.articleContentStore.commentsModel.get(index).user.avatar
            }

            Column {
                id: column
                anchors.left: avatar.right
                anchors.leftMargin: Theme.paddingMedium
                anchors.top: parent.top
                anchors.topMargin: Theme.paddingSmall
                anchors.right: parent.right
                anchors.rightMargin: Theme.paddingLarge
                spacing: Theme.paddingSmall
                Label {
                    color: Theme.highlightColor
                    font.pixelSize: Theme.fontSizeTiny
                    text: MainStore.articleContentStore.commentsModel.get(index).user.nickname
                }
                Label {
                    color: Theme.secondaryHighlightColor
                    font.pixelSize: Theme.fontSizeTiny
                    text: Utility.dateParseShortStr(MainStore.articleContentStore.commentsModel.get(index).dateline)
                          + "    "
                          + MainStore.articleContentStore.commentsModel.get(index).model
                }
                Label {
                    width: parent.width
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    color: Theme.primaryColor
                    font.pixelSize: Theme.fontSizeMedium
                    text: MainStore.articleContentStore.commentsModel.get(index).content
                }
                // reply to commet
                Column {
                    width: parent.width
                    spacing: Theme.paddingSmall
                    Repeater {
                        id: repeater
                        model: MainStore.articleContentStore.commentsModel.get(itemIdx).replys.count
                        delegate: Item {
                            width: parent.width
                            height: replyColumn.height + Theme.paddingSmall * 2
                            property var replyModel: MainStore.articleContentStore.commentsModel
                                                        .get(itemIdx)
                                                        .replys
                                                        .get(index)
                            Rectangle {
                                anchors.fill: parent
                                radius: 5;
                                color: "#ffffff"
                                opacity: 0.2
                            }
                            Column {
                                id: replyColumn
                                width: parent.width - Theme.paddingSmall * 2
                                anchors.centerIn: parent
                                Item {
                                    width: parent.width
                                    height: replyAvatarBar.height
                                    Image {
                                        id: replyAvatar
                                        height: replyAvatarBar.height
                                        width: height
                                        anchors.left: parent.left
                                        anchors.verticalCenter: parent.verticalCenter
                                        fillMode: Image.PreserveAspectFit
                                        source: replyModel.user.avatar
                                    }
                                    Label {
                                        id: replyAvatarBar
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.right: parent.right
                                        anchors.left: replyAvatar.right
                                        anchors.leftMargin: Theme.paddingSmall
                                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                                        color: Theme.secondaryHighlightColor
                                        font.pixelSize: Theme.fontSizeTiny
                                        text: replyModel.user.nickname
                                        + "  "
                                        + Utility.dateParseShortStr(replyModel.dateline)
                                        + "  "
                                        + replyModel.model
                                    }
                                }
                                Label {
                                    width: parent.width
                                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                                    color: Theme.secondaryColor
                                    font.pixelSize: Theme.fontSizeSmall
                                    text: replyModel.content
                                }
                            }
                        }
                    }
                    Item {
                        height: Theme.paddingSmall
                    }
                }
            }
            Separator {
                id: sep
                anchors.top: column.bottom
                anchors.topMargin: Theme.paddingMedium
                width: parent.width
                color: Theme.highlightColor
            }
        }
    }
}
