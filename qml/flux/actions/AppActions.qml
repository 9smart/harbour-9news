pragma Singleton
import QtQuick 2.0
import QuickFlux 1.0
import "./"

QtObject {

    // Add a new task
//    function add(title) {
//        AppDispatcher.dispatch(ActionTypes.addTask,{title: title });
//    }

//    // Set/unset done on a task
//    function setTaskDone(uid,done) {
//        AppDispatcher.dispatch(ActionTypes.setTaskDone,{uid: uid,done: done })
//    }

//    // Show/hide completed task
//    // @Remarks: Unlike other actions, TodoStore do not listen on this
//    // message.
//    function setShowCompletedTasks(value) {
//        AppDispatcher.dispatch(ActionTypes.setShowCompletedTasks, {value: value })
//    }

    // show all articles
    function showArticles() {
        AppDispatcher.dispatch(ActionTypes.showArticles);
    }

    function showArticlesByCategory(category) {
        AppDispatcher.dispatch(ActionTypes.showArticlesByCategory, {category:category})
    }

    function showArticleByPager(last_dateline, action, page) {
        AppDispatcher.dispatch(ActionTypes.showArticleByPager,
                               {last_dateline:last_dateline, action:action, page:page});
    }

    function refreshArticleList() {
        AppDispatcher.dispatch(ActionTypes.refreshArticleList);
    }

    function showArticleContent(id) {
        AppDispatcher.dispatch(ActionTypes.showArticleContent, {id:id});
    }

    function refreshArticleContent() {
        AppDispatcher.dispatch(ActionTypes.refreshArticleContent);
    }

    function showComments(id, last_dateline, action, page) {
        AppDispatcher.dispatch(ActionTypes.showComments,
                               {id:id, last_dateline:last_dateline, action:action, page:page});
    }

    function postComments(id, token, content) {
        AppDispatcher.dispatch(ActionTypes.postComments, {id:id, token:token, content:content});
    }

    function replyComments(id, token, content) {
        AppDispatcher.dispatch(ActionTypes.replyComments, {id:id, token:token, content:content});
    }

//    function userLogin(username, password) {
//        AppDispatcher.dispatch(ActionTypes.userLogin, {username:username, password:password});
//    }

    function showUserInfo(id) {
        AppDispatcher.dispatch(ActionTypes.showUserInfo, {id:id});
    }



}

