import QtQuick 2.0
import Sailfish.Silica 1.0

import harbour_9news.sunrain 1.0

import "../../flux/stores"
import "../../flux/actions"
import "../components"
import ".."

Page {
    id: registerPage

    ReqRegister {
        id: reqRegister

        onRequestStarted: {
            registerPage.backNavigation = false;
            busyIndicator.running = true;
        }
        onRequestResult: { //RequestRet ret, const QString &replyData
            registerPage.backNavigation = true;
            busyIndicator.running = false;

            console.log("===== reply "+replyData);

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

                    //TODO remove token && uid atm, need "login after register" implement function
//                    UserInfoStore.token = json.auth;
//                    UserInfoStore.uid = json.uid;

                    AppFunctions.showMsg(noti, qsTr("register ok"));
//                    AppActions.userLogin(email.text, password.text);
                    AppFunctions.popCurrentPage(pageStack);
                }
            }
        }
    }

    SilicaFlickable {
        id: registerComponent
        width: parent ? parent.width : Screen.width
        height: parent ? parent.height : Screen.height
        contentHeight: column.height

        ScrollDecorator{}

        BusyIndicator {
            id: busyIndicator
            anchors.centerIn: parent
            size: BusyIndicatorSize.Large
        }
        Column {
            id: column
            anchors{
                top: parent.top
                topMargin: Theme.paddingLarge * 2
                horizontalCenter: parent.horizontalCenter
            }
            spacing: Theme.paddingMedium
            PageHeader {
                title: qsTr("Register")
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
                        id: email
                        width: registerComponent.width - Theme.horizontalPageMargin * 4
                        inputMethodHints:Qt.ImhNoAutoUppercase | Qt.ImhUrlCharactersOnly
                        font.pixelSize: Theme.fontSizeMedium
                        placeholderText: qsTr("Enter e-mail")
                        label: qsTr("email")
                        EnterKey.enabled: text || inputMethodComposing
                        EnterKey.iconSource: "image://theme/icon-m-enter-next"
                        EnterKey.onClicked: nickname.focus = true
                    }
                    TextField {
                        id: nickname
                        width: registerComponent.width - Theme.horizontalPageMargin * 4
                        inputMethodHints:Qt.ImhNoAutoUppercase | Qt.ImhUrlCharactersOnly
                        font.pixelSize: Theme.fontSizeMedium
                        placeholderText: qsTr("Enter nickname")
                        label: qsTr("nickname")
                        EnterKey.enabled: text || inputMethodComposing
                        EnterKey.iconSource: "image://theme/icon-m-enter-next"
                        EnterKey.onClicked: password.focus = true
                    }
                    TextField {
                        id: password
                        width:registerComponent.width - Theme.horizontalPageMargin * 4
                        echoMode: TextInput.Password
                        font.pixelSize: Theme.fontSizeMedium
                        placeholderText: "Enter Password"
                        label: qsTr("password")
                        EnterKey.enabled: text || inputMethodComposing
                        EnterKey.iconSource: "image://theme/icon-m-enter-next"
                        EnterKey.onClicked: repassword.focus = true
                    }
                    TextField {
                        id: repassword
                        width:registerComponent.width - Theme.horizontalPageMargin * 4
                        echoMode: TextInput.Password
                        font.pixelSize: Theme.fontSizeMedium
                        placeholderText: "Enter Password Again"
                        label: qsTr("password")
                        EnterKey.iconSource: "image://theme/icon-m-enter-next"
                    }
                }
            }
            TextSwitch {
                text: qsTr("Show Password")
                onCheckedChanged: {
                    if (checked) {
                        password.echoMode = TextInput.Normal;
                        repassword.echoMode = TextInput.Normal
                    } else {
                        password.echoMode = TextInput.Password;
                        repassword.echoMode = TextInput.Password;
                    }
                }
            }
            Button {
                id: submitButton
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("login")
                enabled: email.text && nickname.text && password.text && repassword.text && (password.text == repassword.text)
                onClicked: {
                    reqRegister.appendPostData("email", email.text);
                    reqRegister.appendPostData("password", password.text);
                    reqRegister.appendPostData("repassword", repassword.text);
                    reqRegister.appendPostData("nickname", nickname.text);
                    reqRegister.postRequest();
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
