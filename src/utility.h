#ifndef UTILITY_H
#define UTILITY_H

#include <QObject>

class Utility : public QObject
{
    Q_OBJECT
public:
    explicit Utility(QObject *parent = 0);
    virtual ~Utility();

    ///
    /// \brief dateParse
    /// \param datestring
    /// \return
    ///
    Q_INVOKABLE QString dateParseShortStr(const QString &datestring);

    ///
    /// \brief dateParseLongStr
    /// \param datestring
    /// \return
    ///
    Q_INVOKABLE QString dateParseLongStr(const QString &datestring);

    Q_INVOKABLE static QString version();

    Q_INVOKABLE static QString deviceName();
};

#endif // UTILITY_H
