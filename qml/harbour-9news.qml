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

import org.nemomobile.notifications 1.0

import "view"
import "view/pages"
import "view/components"

import "flux/adapters"
import "flux/stores"

ApplicationWindow
{
    initialPage: Component {
        SplashPage{
            id: splashPage

            onStatusChanged: {
                if (status == PageStatus.Active) {
                    splashDelay.start();
                }
            }

            Timer {
                id: splashDelay
                interval: 2000
                onTriggered: {
                    AppFunctions.toFirstPage(pageStack, firstPageComponent);
                }
            }
        }

    }
    cover: Qt.resolvedUrl("view/cover/CoverPage.qml")

    allowedOrientations: defaultAllowedOrientations

    PanelView {
        id: panelView

        property Page currentPage: pageStack.currentPage

        width: currentPage.width
        panelWidth: Screen.width *0.6
        panelHeight: pageStack.currentPage.height
        height: currentPage && currentPage.contentHeight || pageStack.currentPage.height
        visible:  (!!currentPage && !!currentPage.withPanelView) || !panelView.closed
        anchors.centerIn: parent
        //anchors.verticalCenterOffset:  -(panelHeight - height) / 2

        anchors.horizontalCenterOffset:  0

        Connections {
            target: pageStack
            onCurrentPageChanged: panelView.hidePanel()
        }

        leftPanel: NavigationPanel {
            id: leftPanel
            busy: false
            Component.onCompleted: {
                panelView.hidePanel();
            }
            onItemClicked: {
                panelView.hidePanel();
            }
        }
    }

    Component {
        id: firstPageComponent
        FirstPage {
            id: firstPage

            Binding {
                target: firstPage.contentItem
                property: "parent"
                value: firstPage.status === PageStatus.Active
                       ? (panelView .closed ? panelView : firstPage)
                       : firstPage
            }
        }
    }

    Notification {
        id: noti
         appName: qsTr("9News")
    }

    // StoreAdapter is a utility to initial Store singleton component and
    // setup waitFor relationship. It is a workaround for QTBUG-49370

    StoreAdapter {

    }

}
