import QtQuick 2.0
import QuickFlux 1.0

import harbour_9news.sunrain 1.0

import "../stores"
import "../actions"

StoreWorker {

    QtObject {
        id: internal
        property string id
    }

    ReqArticleContent {
        id: reqArticleContent
        onRequestStarted: {
            ArticleContentStore.requestPending = true;
        }
        onRequestResult: { //RequestRet ret, const QString &replyData
            ArticleContentStore.requestPending = false;

            if (ret == BaseRequest.RET_ABORT) {
                //TODO
            } else if (ret == BaseRequest.RET_FAILURE) {
                //TODO
            } else {
//                console.log("==== "+replyData);
                var json = JSON.parse(replyData);

                var article = json.article;
                ArticleContentStore.id = article._id;
                ArticleContentStore.attachThumb = article.attachments[0].thumb;
                ArticleContentStore.attachImage = article.attachments[0].url;
                ArticleContentStore.category = article.category;
                ArticleContentStore.commentsNum = article.comments;
                ArticleContentStore.content = article.content;
                ArticleContentStore.dateline = article.dateline;
                ArticleContentStore.source = article.source;
                ArticleContentStore.summary = article.summary;
                ArticleContentStore.topic = article.topic;
                ArticleContentStore.author = article.author.nickname

                ArticleContentStore.commentsModel.clear();
                for (var i=0; i<json.comments.length; i++) {
                    ArticleContentStore.commentsModel.append(json.comments[i]);
                }
            }
        }
    }

    Filter {
        type: ActionTypes.showArticleContent
        onDispatched: {
            var id = message.id;
            internal.id = id;
            reqArticleContent.setParameters("id", id);
            reqArticleContent.getRequest();
        }
    }

    Filter {
        type: ActionTypes.refreshArticleContent
        onDispatched: {
            reqArticleContent.setParameters("id", internal.id);
            reqArticleContent.getRequest();
        }
    }
}
