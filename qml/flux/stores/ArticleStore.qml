pragma Singleton
import QtQuick 2.0
import QuickFlux 1.0

import "../actions"

AppListener {
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



}
