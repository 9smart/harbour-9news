/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0

import harbour_9news.sunrain 1.0

import "../../flux/stores"
import "../../flux/actions"
import "../components"
import ".."

BasePanelPage {
    id: page

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    SilicaListView {
        id: listView
        anchors.fill: parent
//        spacing: Theme.paddingMedium
        header: PageHeader {
            title: qsTr("9News")
        }

        PullDownMenu {
            active: false
            busy: MainStore.articleStore.requestPending
            MenuItem {
                text: qsTr("refresh")
                onClicked: {
                    AppActions.refreshArticleList();
                }
            }
        }

        footer: Button {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("load more")
            //FIXME pages indicated if there are more pages?
            visible: MainStore.articleStore.pages > 1 && MainStore.articleStore.next_page < MainStore.articleStore.pages
            onClicked: {
                AppActions.showArticleByPager(MainStore.articleStore.last_dateline,
                                              "next",
                                              MainStore.articleStore.next_page)
            }
        }

        spacing: Theme.paddingMedium
        model: MainStore.articleStore.articleModel
        delegate: BackgroundItem {
            width: parent.width
            height: column.height
            onClicked: {
                AppFunctions.toArticleContent(pageStack, model._id);
            }

            Column {
                id: column
                width: parent.width
                spacing: Theme.paddingMedium
                ArticleCard {
                    width: listView.width - Theme.horizontalPageMargin * 2
                    anchors.horizontalCenter: parent.horizontalCenter
                    title: model.topic
                    thumb: model.attachments.get(0).thumb
                    summary: model.summary
                    timestamp: Utility.dateParseShortStr(model.dateline)
                    views: model.views
                    comments: model.comments
                }
                Separator {
                    width: parent.width
                    color: Theme.secondaryHighlightColor
                }
//                Item {
//                    height: Theme.paddingSmall
//                }
            }
        }
    }
}

