pragma Singleton
import QtQuick 2.0
import Sailfish.Silica 1.0

import "../flux/actions"

QtObject {
    id: appFunctions

    function popAttachedPages(pageStack) {
        // find the first page
        var firstPage = pageStack.previousPage();
        if (!firstPage) {
            return;
        }
        while (pageStack.previousPage(firstPage)) {
            firstPage = pageStack.previousPage(firstPage);
        }
        // pop to first page
        pageStack.pop(firstPage);
    }

    function toFirstPage(stack, pageComponent) {
        popAttachedPages(stack);
        stack.replace(pageComponent);
        AppActions.showArticles();
    }

//    function loadArticleByPager(last_dateline, action, page) {
//        AppActions.showArticleByPager(last_dateline, action, page);
//    }

    function toArticleContent(stack, id) {
        stack.push(Qt.resolvedUrl("pages/ArticleContentPage.qml"));
        stack.pushAttached(Qt.resolvedUrl("pages/ArticleCommnetPage.qml"));
        AppActions.showArticleContent(id);
        AppActions.showComments(id);
    }

    function toLoginPage(stack) {
        stack.push(Qt.resolvedUrl("pages/LoginPage.qml"));
    }

    function toCommentWritePage(stack, id, actionType) {
        stack.push(Qt.resolvedUrl("pages/CommentWritePage.qml"), {id:id, actionType:actionType});
    }

    function toUserInfoPage(stack, uid) {
        stack.push(Qt.resolvedUrl("pages/UserInfoPage.qml"));
        AppActions.showUserInfo(uid);
    }

    function toAboutPage(stack) {
        stack.push(Qt.resolvedUrl("pages/AboutPage.qml"));
    }

    function toRegisterPage(stack) {
        stack.replace(Qt.resolvedUrl("pages/RegisterPage.qml"));
    }

    function popCurrentPage(stack) {
        stack.pop();
    }

    function showMsg(sender, msg) {
        sender.previewBody = qsTr("9News")
        sender.previewSummary = msg;
        sender.close();
        sender.publish();
    }
}
