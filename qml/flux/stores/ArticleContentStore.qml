pragma Singleton
import QtQuick 2.0
import QuickFlux 1.0

import "../actions"

AppListener {
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


}
