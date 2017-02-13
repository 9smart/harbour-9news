import QtQuick 2.0
import QuickFlux 1.1

import org.nemomobile.configuration 1.0

import harbour_9news.sunrain 1.0

import "../actions"

Store {
    id: userInfoStore

    property alias token: tv.value

    property alias uid: ud.value

    property alias userInfo: info.value

    property alias detailUserInfo: dinfo.value

    ConfigurationValue {
        id: tv
        key: "/Token"
    }

    ConfigurationValue {
        id: ud
        key: "/UID"
    }

    ConfigurationValue {
        id: info
        key: "/Info"
    }

    ConfigurationValue {
        id: dinfo
        key: "/DetailInfo"
    }

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
                userInfoStore.detailUserInfo = json.member;
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
