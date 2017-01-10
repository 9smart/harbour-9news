import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: panelPage
    property alias contentItem: item
    property bool withPanelView: true
    default property alias content: item.data
    Item {
        id: item
        anchors.fill: parent
    }
}
