import QtQuick 2.0
import Sailfish.Silica 1.0

import harbour_9news.sunrain 1.0

import "../../flux/stores"
import "../../flux/actions"
import "../components"
import ".."

Page {
    id: loginPage

    ReqUserLogin {
        id: userLogin

        onRequestStarted: {
            loginPage.backNavigation = false;
            busyIndicator.running = true;
        }
        onRequestResult: { //RequestRet ret, const QString &replyData
            loginPage.backNavigation = true;
            busyIndicator.running = false;

//            console.log("===== reply "+replyData);

            if (ret == BaseRequest.RET_ABORT) {
                //TODO
                errorLabel.visible = true;
                errorLabel.text = replyData;
            } else if (ret == BaseRequest.RET_FAILURE) {
                //TODO
                errorLabel.visible = true;
                errorLabel.text = replyData;
            } else {
                var json = JSON.parse(replyData);
                if (json.error) {
                    errorLabel.visible = true;
                    errorLabel.text = json.error;
                    AppFunctions.showMsg(noti, json.error);
                } else {
                    errorLabel.visible = false;

                    UserInfoStore.token = json.auth;
                    UserInfoStore.uid = json.uid;
                    UserInfoStore.userInfo = json.info;

                    AppFunctions.showMsg(noti, qsTr("login ok"))
                    AppFunctions.popCurrentPage(pageStack);
                }
            }
        }
    }

    SilicaFlickable {
        id: loginComponent
        width: parent ? parent.width : Screen.width
        height: parent ? parent.height : Screen.height
        contentHeight: column.height

        ScrollDecorator{}

        PullDownMenu {
            MenuItem {
                text: qsTr("register")
                onClicked: {
                    AppFunctions.toRegisterPage(pageStack);
                }
            }
        }

        BusyIndicator {
            id: busyIndicator
            anchors.centerIn: parent
            size: BusyIndicatorSize.Large
        }
        Column {
            id: column
            anchors{
                top: parent.top
                topMargin: Theme.paddingLarge * 4
                horizontalCenter: parent.horizontalCenter
            }
            spacing: Theme.paddingMedium
            PageHeader {
                title: qsTr("Login")
            }
            Rectangle {
                id: rectangle
                width: input.width + Theme.paddingMedium*2
                height: input.height + Theme.paddingMedium*2
                border.color:Theme.highlightColor
                color:"#00000000"
                radius: 30
                Column {
                    id:input
                    anchors.top: parent.top
                    anchors.topMargin: Theme.paddingMedium
                    spacing: Theme.paddingMedium
                    TextField {
                        id: userName
                        width: loginComponent.width - Theme.horizontalPageMargin * 4
                        inputMethodHints:Qt.ImhNoAutoUppercase | Qt.ImhUrlCharactersOnly
                        font.pixelSize: Theme.fontSizeMedium
                        placeholderText: qsTr("Enter e-mail or username")
                        label: qsTr("username")
                        EnterKey.enabled: text || inputMethodComposing
                        EnterKey.iconSource: "image://theme/icon-m-enter-next"
                        EnterKey.onClicked: password.focus = true
                    }
                    TextField {
                        id: password
                        width:loginComponent.width - Theme.horizontalPageMargin * 4
                        echoMode: TextInput.Password
                        font.pixelSize: Theme.fontSizeMedium
                        placeholderText: "Enter Password"
                        label: qsTr("password")
                        EnterKey.iconSource: "image://theme/icon-m-enter-next"
                    }
                }
            }
            TextSwitch {
                text: qsTr("Show Password")
                onCheckedChanged: {
                    checked ? password.echoMode = TextInput.Normal
                            : password.echoMode = TextInput.Password
                }
            }
            Button {
                id: submitButton
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("login")
                enabled: userName.text && password.text
                onClicked: {
                    userLogin.appendPostData("email", userName.text);
                    userLogin.appendPostData("password", password.text);
                    userLogin.postRequest();
                }
            }
            Label {
                id: errorLabel
                width: parent.width - Theme.horizontalPageMargin * 2
                x: Theme.horizontalPageMargin
                color: Theme.highlightColor
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                font.pixelSize: Theme.fontSizeExtraSmall
            }
        }
    }
}
