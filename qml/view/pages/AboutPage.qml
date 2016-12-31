import QtQuick 2.0
import Sailfish.Silica 1.0

import harbour_9news.sunrain 1.0

import "../../flux/stores"
import "../../flux/actions"
import "../components"
import ".."

Page {
    id: aboutPage

    SilicaFlickable {
        anchors.fill: parent
        clip: true

        contentWidth: width
        contentHeight: column.height

        ScrollDecorator {}

        Column {
            id: column
            width: parent.width - Theme.paddingLarge * 2
            x: Theme.paddingLarge
            spacing: Theme.paddingMedium
            PageHeader {
                title: qsTr("about")
            }
            Image {
                width: Theme.iconSizeLarge
                height: width
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
//                source: "qrc:/view/graphics/logo.png"
                source: Qt.resolvedUrl("../graphics/logo.png")
            }
            Label {
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                font.pixelSize: Theme.fontSizeSmall
                text: qsTr("version") + " " +Utility.version()
            }
            Label {
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Theme.fontSizeSmall
                wrapMode: Text.Wrap
                text: qsTr("Author:wanggjghost")//作者:wanggjghost(泪の单翼天使)
            }
            Label {
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Theme.fontSizeSmall
                wrapMode: Text.Wrap
                text: qsTr("E-mail:41245110@qq.com")//作者:wanggjghost(泪の单翼天使)
            }
            SectionHeader {
                text: qsTr("about 9news")
            }
            Label {
                width: parent.width
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                text: "《久闻》作为久智网旗下的科技类资讯应用，以小众系统为核心，辅以其它相关科技类资讯。为小众系统爱好者提供最及时有效的新闻资讯。其分类主要包含“小众生态”，“苹果安卓”，“应用游戏”，“前沿科技”，“久智评测”，“智能硬件”。其客户端预计将支持目前市面上所有手机操作系统。前期主要是面向各小众平台（也是重点），后期也会推出Android和iOS平台下的久闻。"
            }



        }

    }

}
