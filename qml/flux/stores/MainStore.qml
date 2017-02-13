pragma Singleton
import QtQuick 2.0
import QuickFlux 1.1

Store {
    bindSource: AppDispatcher

    property alias articleContentStore: articleContentStore

    property alias articleStore: articleStore

    property alias userInfoStore: userInfoStore

    ArticleContentStore {
        id: articleContentStore
    }

    ArticleStore {
        id: articleStore
    }

    UserInfoStore {
        id: userInfoStore
    }
}
