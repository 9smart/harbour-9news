#include "utility.h"

#include <QDebug>
#include <QDateTime>
#include <QFile>

Utility::Utility(QObject *parent)
    : QObject(parent)
{

}

Utility::~Utility()
{

}

QString Utility::dateParseShortStr(const QString &datestring)
{
    QDateTime t = QDateTime::fromMSecsSinceEpoch(datestring.toLongLong());
    return t.toString("yyyy-MM-dd");
}

QString Utility::dateParseLongStr(const QString &datestring)
{
    QDateTime t = QDateTime::fromMSecsSinceEpoch(datestring.toLongLong());
    return t.toString("yyyy-MM-dd HH:mm:ss");
}

QString Utility::version()
{
    qDebug()<<Q_FUNC_INFO<<VERSION_FILE;

#ifdef VERSION_FILE
    QString ff(VERSION_FILE);
    if (!QFile::exists(ff))
        return QString("Unknown");

    QFile f(ff);
    if (!f.open(QIODevice::ReadOnly))
        return QString("Unknown");
    QString v, r, b;
    while (!f.atEnd()) {
        QString str = f.readLine().trimmed();
        //follow .pro macro
        if (str.startsWith("Version")) {
            v = str.replace("Version:", "").trimmed();
        } else if (str.startsWith("Release")) {
            r = str.replace("Release:", "").trimmed();
        } else if (str.startsWith("Build")) {
            b = str.replace("Build:", "").trimmed();
        }
    }
    f.close();
    QString str(v);
    if (!r.isEmpty())
        str = QString("%1.%2").arg(str).arg(r);
    if (!b.isEmpty()) {
        str = QString("%1-build-%2").arg(str).arg(b);
    }
    return str;
#else
    return QString("Unknown");
#endif

}

QString Utility::deviceName()
{
#ifdef SAILFISH_OS
    QString ff("/etc/hw-release");
    if (!QFile::exists(ff))
        return QString("Unknow Sailfish Device");
    QFile f(ff);
    if (!f.open(QIODevice::ReadOnly))
        return QString("Unknow Sailfish Device");

    QString device;
    while (!f.atEnd()) {
        QString str = f.readLine().trimmed();
        if (str.startsWith("NAME=")) {
            device = str.replace("NAME=", "").trimmed().replace("\"", "").trimmed();
            break;
        }
    }
    f.close();
    if (!device.isEmpty())
        return device;
    return QString("Unknow Sailfish Device");
#else
    return QString("Unknow Device");
#endif

}
