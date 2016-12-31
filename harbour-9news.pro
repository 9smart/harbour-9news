# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-9news

CONFIG += sailfishapp sailfishapp_no_deploy_qml
CONFIG += c++11

DEFINES += \
    SAILFISH_OS

unix {
    _BASE=$$system(grep 'Version:*' $$PWD/rpm/harbour-9news.yaml)
    _RELEASE=$$system(grep 'Release:*' $$PWD/rpm/harbour-9news.yaml)
    _REV=$$system(if [ -d $$PWD/.git ]; then git rev-parse --short HEAD;fi)
    $$system(echo $$_BASE > $$PWD/Version && echo $$_RELEASE >> $$PWD/Version && echo "Build: $$_REV" >> $$PWD/Version)

    DEFINES += \
        VERSION_FILE=\\\"/usr/share/$${TARGET}/Version\\\"

    version.path =  /usr/share/$${TARGET}
    version.files += $$PWD/Version
    INSTALLS += version
}

include(thirdparty/quickflux/quickflux.pri)
include(src/api/inc.pri)


###############################################
# ugly hack for i486 and arm platform
# Currently, I can only distinguish between i486 and arm from this g++ flag
####################
#arm
linux-g++ {
    lib_armv7hl.path = /usr/share/$${TARGET}/lib/armv7hl
    lib_armv7hl.files += \
        $$PWD/src/api/armv7hl/libharbour-9news.so \
        $$PWD/src/api/armv7hl/libharbour-9news.so.1 \
        $$PWD/src/api/armv7hl/libharbour-9news.so.1.0 \
        $$PWD/src/api/armv7hl/libharbour-9news.so.1.0.0

    INSTALLS += lib_armv7hl
}

#i486
linux-g++-32 {
    lib_i486.path = /usr/share/$${TARGET}/lib/i486
    lib_i486.files += \
        $$PWD/src/api/i486/libharbour-9news.so \
        $$PWD/src/api/i486/libharbour-9news.so.1 \
        $$PWD/src/api/i486/libharbour-9news.so.1.0 \
        $$PWD/src/api/i486/libharbour-9news.so.1.0.0

    INSTALLS += lib_i486
}

LIBS += \
    -lharbour-9news

QMAKE_RPATHDIR += \
    /usr/share/$${TARGET}/lib \
    /usr/share/$${TARGET}/lib/i486 \
    /usr/share/$${TARGET}/lib/armv7hl \
    $$PWD/src/api/armv7hl \
    $$PWD/src/api/i486

#    /home/deploy/installroot/usr/share/$${TARGET}/lib/i486 \
#    /home/deploy/installroot/usr/share/$${TARGET}/lib/armv7hl \
#    /opt/sdk/$${TARGET}/usr/share/$${TARGET}/lib/i486 \
#    /opt/sdk/$${TARGET}/usr/share/$${TARGET}/lib/armv7hl

QMAKE_LIBDIR += \
    /usr/share/$${TARGET}/lib \
    /usr/share/$${TARGET}/lib/i486 \
    /usr/share/$${TARGET}/lib/armv7hl \
    $$PWD/src/api/armv7hl \
    $$PWD/src/api/i486


#    /home/deploy/installroot/usr/share/$${TARGET}/lib/i486 \
#    /home/deploy/installroot/usr/share/$${TARGET}/lib/armv7hl \
#    /opt/sdk/$${TARGET}/usr/share/$${TARGET}/lib/i486 \
#    /opt/sdk/$${TARGET}/usr/share/$${TARGET}/lib/armv7hl


RESOURCES += \
    qml/qml.qrc

HEADERS += \
    src/pluginregister.h \
    src/utility.h

SOURCES += \
    src/harbour-9news.cpp \
    src/pluginregister.cpp \
    src/utility.cpp

OTHER_FILES += \
    rpm/harbour-9news.changes.in \
    rpm/harbour-9news.spec \
    rpm/harbour-9news.yaml \
    translations/*.ts \
    harbour-9news.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += \
    translations/harbour-9news-zh_CN.ts
