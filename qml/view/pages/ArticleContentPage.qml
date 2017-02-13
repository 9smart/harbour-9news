import QtQuick 2.0
import Sailfish.Silica 1.0

import harbour_9news.sunrain 1.0

import "../../flux/stores"
import "../../flux/actions"
import "../components"
import "../"

Page {
    id: contentPage

    //TODO scale pic to fit screen size
    function format(str, picWidth) {
        str = str.replace(/\[flash=(\d{2,3}),(\d{2,3})\](.+?)\[\/flash\]/mg,
                          '<embed src="$3" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" wmode="opaque" width="$1" height="$2"></embed>');
        str = str.replace(/\[img\](.+?)\[\/img\]/mg,'<br/><img src="$1" width='+picWidth+' alt="图片" /><br/>');
        str = str.replace(/\[img=(.+)\](.+?)\[\/img\]/mg,
                          '<br/><figure><img src="$2" width='+picWidth+' alt="图片" /><figcaption>$1</figcaption></figure><br/>');
        str = str.replace(/\[p\]((.|\n)+?)\[\/p\]/mg,'<p>$1</p>');
        str = str.replace(/\[h2\](.+?)\[\/h2\]/mg,'<h2>$1</h2>');
        str = str.replace(/\[center\](.+?)\[\/center\]/mg,'<span class="UBB_center">$1</span>');
        str = str.replace(/\[b\](.+?)\[\/b\]/mg,'<strong>$1</strong>');
        str = str.replace(/\[a=(.+?)\](.+?)\[\/a\]/mg,'<a href="$2">$1</a>');
        str = str.replace(/\[a\](.+?)\[\/a\]/mg,'<a href="$1">$1</a>');
        str = str.replace(/\[download=(.+)\](.+?)\[\/download\]/mg,'<a href="/download?url=$2">$1</a>');
        return str;
    }

    SilicaFlickable {
        anchors.fill: parent

        contentWidth: parent.width
        contentHeight: column.height + Theme.paddingLarge

        PullDownMenu {
            enabled: (MainStore.userInfoStore.uid != undefined && MainStore.userInfoStore.token != undefined)
            visible: enabled
            MenuItem {
                text: qsTr("send comment")
                onClicked: {
                    AppFunctions.toCommentWritePage(pageStack,
                                                    MainStore.articleContentStore.id,
                                                    AppConst._ACTION_POST_COMMENTS);
                }
            }
        }

        PushUpMenu {
            enabled: (MainStore.userInfoStore.uid != undefined && MainStore.userInfoStore.token != undefined)
            visible: enabled
            MenuItem {
                text: qsTr("send comment")
                onClicked: {
                    AppFunctions.toCommentWritePage(pageStack,
                                                    MainStore.articleContentStore.id,
                                                    AppConst._ACTION_POST_COMMENTS);
                }
            }
        }

        Column {
            id: column
            width: parent.width - Theme.paddingLarge *2
            x: Theme.paddingLarge
            spacing: Theme.paddingMedium

            PageHeader {
                id: header
                height: titleLable.height
                extraContent.height: titleLable.height
                extraContent.data: [
                    Label {
                        id: titleLable
                        width: column.width - Theme.horizontalPageMargin
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                        text: MainStore.articleContentStore.topic
                        color: Theme.highlightColor
                        font {
                            pixelSize: Theme.fontSizeLarge
                            family: Theme.fontFamilyHeading
                        }
                    }
                ]
            }

            Label {
                anchors.left: parent.left
                color: Theme.secondaryHighlightColor
                text: Utility.dateParseLongStr(MainStore.articleContentStore.dateline)
            }
            Item {
                width: parent.width
                height: summaryLabel.height + Theme.paddingSmall * 2
                Rectangle {
                    anchors.fill: parent
                    radius: 5;
                    color: "#ffffff"
                    opacity: 0.2
                }
                Label {
                    id: summaryLabel
                    width: parent.width - Theme.paddingSmall * 2
                    anchors.centerIn: parent
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    color: Theme.secondaryColor
                    font.pixelSize: Theme.fontSizeSmall
                    text: MainStore.articleContentStore.summary
                }
            }
            Label {
                width: parent.width
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                textFormat: Text.RichText
                color: Theme.primaryColor
                text: format(MainStore.articleContentStore.content, width)
                onLinkActivated: {
                    Qt.openUrlExternally(link);
                }
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeSmall
                text: qsTr("author")
                      +":"
                      +MainStore.articleContentStore.author
                      +"  "
                      +qsTr("source")
                      +":"
                      +MainStore.articleContentStore.source

            }
        }

    }
}
