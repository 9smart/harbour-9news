import QtQuick 2.0
import Sailfish.Silica 1.0

import harbour_9news.sunrain 1.0

import "../../flux/stores"
import "../../flux/actions"
import "../components"
import ".."

Page {
    id: commentWrite

    property string id
    property string actionType: AppConst._ACTION_POST_COMMENTS


    ReqPostCommnet {
        id: reqPostComment
        onRequestStarted: {
            commentWrite.backNavigation = false;
//            busyIndicator.running = true;
        }
        onRequestResult: { //RequestRet ret, const QString &replyData
            commentWrite.backNavigation = true;
//            busyIndicator.running = false;

            if (ret == BaseRequest.RET_ABORT) {
                AppFunctions.showMsg(noti, replyData);
            } else if (ret == BaseRequest.RET_FAILURE) {
                AppFunctions.showMsg(noti, replyData);
            } else {
                var json = JSON.parse(replyData);
                if (json.error) {
                    AppFunctions.showMsg(noti, json.error);
                } else {
                    AppFunctions.showMsg(noti, json.message);
                    AppActions.refreshArticleContent();
                }
                AppFunctions.popCurrentPage(pageStack);
            }
        }
    }

    ReqReplyComment {
        id: reqReplyComment
        onRequestStarted: {
            commentWrite.backNavigation = false;
        }
        onRequestResult: { //RequestRet ret, const QString &replyData
            commentWrite.backNavigation = true;

            if (ret == BaseRequest.RET_ABORT) {
                AppFunctions.showMsg(noti, replyData);
            } else if (ret == BaseRequest.RET_FAILURE) {
                AppFunctions.showMsg(noti, replyData);
            } else {
                var json = JSON.parse(replyData);
                if (json.error) {
                    AppFunctions.showMsg(noti, json.error);
                } else {
                    AppFunctions.showMsg(noti, json.message);
                    AppActions.refreshArticleContent();
                }
                AppFunctions.popCurrentPage(pageStack);
            }
        }
    }

    function postComment() {
        reqPostComment.setParameters("id", commentWrite.id);
        reqPostComment.setParameters("token", UserInfoStore.token);
        reqPostComment.appendPostData("type", "news");
        reqPostComment.appendPostData("content", content.text);
        reqPostComment.appendPostData("model", Utility.deviceName());
        reqPostComment.postRequest();
    }

    function postReply() {
        reqReplyComment.setParameters("id", commentWrite.id);
        reqReplyComment.setParameters("token", UserInfoStore.token);
        reqReplyComment.appendPostData("content", content.text);
        reqReplyComment.appendPostData("model", Utility.deviceName());
        reqReplyComment.postRequest();
    }

    SilicaFlickable {
        anchors.fill: parent
        clip: true
        contentHeight: column.height
        VerticalScrollDecorator {}

        PullDownMenu {
            MenuItem {
                text: qsTr("send")
                onClicked: {
                    if (commentWrite.actionType == AppConst._ACTION_POST_COMMENTS) {
                        postComment();
                    } else {
                        postReply();
                    }
                }
            }
        }

        PushUpMenu {
            MenuItem {
                text: qsTr("send")
                onClicked: {
                    if (commentWrite.actionType == AppConst._ACTION_POST_COMMENTS) {
                        postComment();
                    } else {
                        postReply();
                    }
                }
            }
        }

        Column {
            id: column
            width: parent.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: qsTr("write comment")
            }
            TextArea {
                id: content
                width: parent.width
                height: Math.max(parent.width/2, implicitHeight)
                focus: true
                horizontalAlignment: TextInput.AlignLeft
                //placeholderText: qsTr("Input Weibo content here");
                text: ""
                label: qsTr("comment")
            }
        }
    }


}
