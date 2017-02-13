import QtQuick 2.0
import QuickFlux 1.0

import harbour_9news.sunrain 1.0

import "../stores"
import "../actions"

StoreWorker {
    id: userInfoStoreWorker

    ReqUserInfo {
        id: reqUserInfo

        onRequestStarted: {
//            ArticleStore.requestPending = true;
        }
        onRequestResult: { //RequestRet ret, const QString &replyData
//            ArticleStore.requestPending = false;
//            console.log("=== reqUserInfo "+replyData);

            if (ret == BaseRequest.RET_ABORT) {
                //TODO
            } else if (ret == BaseRequest.RET_FAILURE) {
                //TODO
            } else {
                var json = JSON.parse(replyData);
                UserInfoStore.detailUserInfo = json.member;
            }
        }
    }

    Filter {
        type: ActionTypes.showUserInfo
        onDispatched: {
            var uid = message.id;
            reqUserInfo.setParameters("id", uid);
            reqUserInfo.getRequest();
        }
    }

}
