import QtQuick 2.0
import Sailfish.Silica 1.0

import harbour_9news.sunrain 1.0

import "../../flux/stores"
import "../../flux/actions"
import ".."

Panel {
    id: navPanel

    signal itemClicked

    Column {
        width: parent.width
        anchors.top: parent.top
        spacing: Theme.paddingMedium

        Item {
            id: userInfoBar
            width: parent.width
            height: Theme.itemSizeExtraLarge

            Rectangle {
                anchors.fill: parent
                color: Theme.rgba(Theme.highlightBackgroundColor, Theme.highlightBackgroundOpacity)
            }
            Button {
                anchors.centerIn: parent
                text: qsTr("login/register")
                enabled: (UserInfoStore.uid == undefined || UserInfoStore.token == undefined)
                visible: enabled
                onClicked: {
                    AppFunctions.toLoginPage(pageStack);
                }
            }
            Image {
                height: Math.min(parent.width, parent.height)/2
                width: height
                anchors.centerIn: parent
                fillMode: Image.PreserveAspectFit
                enabled: (UserInfoStore.uid != undefined && UserInfoStore.token != undefined)
                visible: enabled
                source: UserInfoStore.userInfo.avatar
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        AppFunctions.toUserInfoPage(pageStack, UserInfoStore.uid);
                    }
                }
            }
        }

        BackgroundItem {
            width: parent.width
            height: Theme.itemSizeMedium
            Label {
                anchors.left: parent.left
                anchors.leftMargin: Theme.paddingLarge
                anchors.verticalCenter: parent.verticalCenter
                color: highlighted ? Theme.highlightColor : Theme.primaryColor
                text: qsTr("all articles")
            }
            onClicked: {
                AppActions.showArticles();
                navPanel.itemClicked();
            }
        }
        Repeater {
            model: ArticleStore.categoryList
            BackgroundItem {
                width: parent.width
                height: Theme.itemSizeSmall
                Label {
                    anchors.left: parent.left
                    anchors.leftMargin: Theme.paddingLarge
                    anchors.verticalCenter: parent.verticalCenter
                    color: highlighted ? Theme.highlightColor : Theme.primaryColor
                    text: modelData
                }
                onClicked: {
                    AppActions.showArticlesByCategory(modelData);
                    navPanel.itemClicked();
                }
            }
        }
        Separator {
            width: parent.width
            color: Theme.highlightColor
        }
        BackgroundItem {
            width: parent.width
            height: Theme.itemSizeSmall
            Label {
                anchors.left: parent.left
                anchors.leftMargin: Theme.paddingLarge
                anchors.verticalCenter: parent.verticalCenter
                color: highlighted ? Theme.highlightColor : Theme.primaryColor
                text: qsTr("about")
            }
            onClicked: {
                AppFunctions.toAboutPage(pageStack);
                navPanel.itemClicked();
            }
        }
    }
}
