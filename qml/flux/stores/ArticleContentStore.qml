import QtQuick 2.0
import QuickFlux 1.1

import harbour_9news.sunrain 1.0

import "../actions"

Store {
    id: articleContentStore

    property bool requestPending: false

    property string id

    property string attachThumb

    property string attachImage

    property string category

    property int commentsNum: 0

    property string content

    property string dateline

    property string source

    property string summary

    property string topic

    property string author

    property alias commentsModel: comments

    ListModel {
        id: comments
    }

    QtObject {
        id: internal
        property string id
    }

    ReqArticleContent {
        id: reqArticleContent
        onRequestStarted: {
            articleContentStore.requestPending = true;
        }
        onRequestResult: { //RequestRet ret, const QString &replyData
            articleContentStore.requestPending = false;

            if (ret == BaseRequest.RET_ABORT) {
                //TODO
            } else if (ret == BaseRequest.RET_FAILURE) {
                //TODO
            } else {
//                console.log("==== "+replyData);
                var json = JSON.parse(replyData);

                var article = json.article;
                articleContentStore.id = article._id;
                articleContentStore.attachThumb = article.attachments[0].thumb;
                articleContentStore.attachImage = article.attachments[0].url;
                articleContentStore.category = article.category;
                articleContentStore.commentsNum = article.comments;
                articleContentStore.content = article.content;
                articleContentStore.dateline = article.dateline;
                articleContentStore.source = article.source;
                articleContentStore.summary = article.summary;
                articleContentStore.topic = article.topic;
                articleContentStore.author = article.author.nickname

                articleContentStore.commentsModel.clear();
                for (var i=0; i<json.comments.length; i++) {
                    articleContentStore.commentsModel.append(json.comments[i]);
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
