import QtQuick 2.0
import Sailfish.Silica 1.0

import harbour_9news.sunrain 1.0

import "../../flux/stores"
import "../../flux/actions"
import "../components"
import ".."

Page {
    id: userInfoPage

    SilicaFlickable {
        width: parent.width - Theme.paddingLarge * 2
        x: Theme.paddingLarge
        anchors.top: parent.top
        anchors.topMargin: Theme.paddingLarge
        anchors.bottom: logoutBtn.top
        anchors.bottomMargin: Theme.paddingLarge

        contentHeight: column.height

        ScrollDecorator {}

        Column {
            id: column
            width: parent.width
            spacing: Theme.paddingMedium

            Image {
                width: Theme.iconSizeExtraLarge
                height: width
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
                source: MainStore.userInfoStore.detailUserInfo.avatar_hd
            }

            Label {
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                text: MainStore.userInfoStore.detailUserInfo.nickname
            }
        }
    }
    //TODO should move to column later
    Button {
        id: logoutBtn
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Theme.paddingLarge
        text: qsTr("logout")
        onClicked: {
            MainStore.userInfoStore.token = undefined;
            MainStore.userInfoStore.uid = undefined;
            MainStore.userInfoStore.userInfo = undefined;
            MainStore.userInfoStore.detailUserInfo = undefined;

            AppFunctions.showMsg(noti, qsTr("logout"));
            AppFunctions.popCurrentPage(pageStack);
        }
    }
}
