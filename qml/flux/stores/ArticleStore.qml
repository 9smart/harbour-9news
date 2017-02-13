import QtQuick 2.0
import QuickFlux 1.1

import harbour_9news.sunrain 1.0

import "../actions"

Store {
    id: articleStore

    property alias articleModel: articleModel

    property var categoryList: undefined

    property int page: 1

    property int pagesize: 15

    property int pages: 0

    property int next_page: 2

    property int pre_page: 0

    property string first_dateline

    property string last_dateline

    property bool requestPending: false

    ListModel {
        id: articleModel
    }

    function fillArticlesData(data, clearModel) {
        var json = JSON.parse(data);
        if (clearModel) {
            articleStore.articleModel.clear();
        }
        for (var i=0; i<json.articles.length; i++) {
            articleStore.articleModel.append(json.articles[i]);
        }
        articleStore.categoryList = json.categorys;
        articleStore.page = json.pager.page;
        articleStore.pagesize = json.pager.pagesize;
        articleStore.pages = json.pager.pages;
        articleStore.next_page = json.pager.next_page;
        articleStore.pre_page = json.pager.pre_page;
        articleStore.first_dateline = json.pager.first_dateline;
        articleStore.last_dateline = json.pager.last_dateline;
    }

    QtObject {
        id: internal
        readonly property string _ARTICLE_ALL: "all"
        property string articleType: _ARTICLE_ALL
    }

    ReqArticles {
        id: reqArticles
        onRequestStarted: {
            articleStore.requestPending = true;
        }
        onRequestResult: { //RequestRet ret, const QString &replyData
            articleStore.requestPending = false;
            if (ret == BaseRequest.RET_ABORT) {
                //TODO
            } else if (ret == BaseRequest.RET_FAILURE) {
                //TODO
            } else {
                fillArticlesData(replyData, true);
            }
        }
    }

    ReqArticleByPager {
        id: reqArticleByPager
        onRequestStarted: {
            articleStore.requestPending = true;
        }
        onRequestResult: { //RequestRet ret, const QString &replyData
            articleStore.requestPending = false;
            if (ret == BaseRequest.RET_ABORT) {
                //TODO
            } else if (ret == BaseRequest.RET_FAILURE) {
                //TODO
            } else {
                fillArticlesData(replyData, false);
            }
        }
    }

    ReqArticleByCategory {
        id: reqArticleByCategory
        onRequestStarted: {
            articleStore.requestPending = true;
        }
        onRequestResult: { //RequestRet ret, const QString &replyData
            articleStore.requestPending = false;
            if (ret == BaseRequest.RET_ABORT) {
                //TODO
            } else if (ret == BaseRequest.RET_FAILURE) {
                //TODO
            } else {
                fillArticlesData(replyData, true);
            }
        }
    }

    Filter {
        type: ActionTypes.showArticles
        onDispatched: {
            internal.articleType = internal._ARTICLE_ALL;
            reqArticles.getRequest();
        }
    }

    Filter {
        type: ActionTypes.showArticleByPager
        onDispatched: {
            var ld = message.last_dateline;
            var action = message.action;
            var page = message.page;
            reqArticleByPager.setParameters("last_dateline", ld);
            reqArticleByPager.setParameters("action", action);
            reqArticleByPager.setParameters("page", page);
            reqArticleByPager.getRequest();
        }
    }

    Filter {
        type: ActionTypes.showArticlesByCategory
        onDispatched: {
            var ct = message.category;
            internal.articleType = ct;
            reqArticleByCategory.setParameters("category", ct);
            reqArticleByCategory.getRequest();
        }
    }

    Filter {
        type: ActionTypes.refreshArticleList
        onDispatched: {
            if (internal.articleType == internal._ARTICLE_ALL) {
                reqArticles.getRequest();
            } else {
                reqArticleByCategory.setParameters("category", internal.articleType);
                reqArticleByCategory.getRequest();
            }
        }
    }

}
