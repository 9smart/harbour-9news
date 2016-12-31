pragma Singleton
import QtQuick 2.0
import QuickFlux 1.0

import org.nemomobile.configuration 1.0

import "../actions"

AppListener {
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

}
