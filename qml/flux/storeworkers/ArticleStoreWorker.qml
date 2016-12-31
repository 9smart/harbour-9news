import QtQuick 2.0
import QuickFlux 1.0

import harbour_9news.sunrain 1.0

import "../stores"
import "../actions"

StoreWorker {
    id: articleStoreWorker

    function fillArticlesData(data, clearModel) {
        var json = JSON.parse(data);
        if (clearModel) {
            ArticleStore.articleModel.clear();
        }
        for (var i=0; i<json.articles.length; i++) {
            ArticleStore.articleModel.append(json.articles[i]);
        }
        ArticleStore.categoryList = json.categorys;
        ArticleStore.page = json.pager.page;
        ArticleStore.pagesize = json.pager.pagesize;
        ArticleStore.pages = json.pager.pages;
        ArticleStore.next_page = json.pager.next_page;
        ArticleStore.pre_page = json.pager.pre_page;
        ArticleStore.first_dateline = json.pager.first_dateline;
        ArticleStore.last_dateline = json.pager.last_dateline;
    }

    QtObject {
        id: internal
        readonly property string _ARTICLE_ALL: "all"
        property string articleType: _ARTICLE_ALL
    }

    ReqArticles {
        id: reqArticles
        onRequestStarted: {
            ArticleStore.requestPending = true;
        }
        onRequestResult: { //RequestRet ret, const QString &replyData
            ArticleStore.requestPending = false;
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
            ArticleStore.requestPending = true;
        }
        onRequestResult: { //RequestRet ret, const QString &replyData
            ArticleStore.requestPending = false;
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
            ArticleStore.requestPending = true;
        }
        onRequestResult: { //RequestRet ret, const QString &replyData
            ArticleStore.requestPending = false;
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
