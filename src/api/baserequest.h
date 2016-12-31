#ifndef BASEREQUEST_H
#define BASEREQUEST_H

#include <QMap>
#include <QObject>

class QTimer;
class QUrl;
class QNetworkAccessManager;
class QNetworkReply;

class BaseRequest : public QObject
{
    Q_OBJECT
#ifdef SAILFISH_OS
    Q_ENUMS(RequestRet)
#endif
public:
    enum RequestRet {
        RET_ABORT = 0x0,
        RET_SUCCESS,
        RET_FAILURE
    };
#ifndef SAILFISH_OS
    Q_ENUM(RequestRet)
#endif

    explicit BaseRequest(QObject *parent = Q_NULLPTR);
    virtual ~BaseRequest();

    Q_INVOKABLE void appendPostData(const QString &key, const QString &value);

    QMap<QString, QString> postDataMap() const;

    QString getPostValue(const QString &key, const QString &defaultValue = QString()) const;

    Q_INVOKABLE void setParameters(const QString &key, const QString &value);

    QStringList parameterKeys() const;

    QString parameter(const QString &key, const QString &defaultValue = QString()) const;

    BaseRequest& operator()(const QString &key, const QVariant &value);
    BaseRequest& operator()(const QString &key, const char *value);
    BaseRequest& operator()(const QString &key, int value);

protected:
    static QNetworkAccessManager *networkMgr();
    virtual void initParameters();
    virtual QUrl initUrl();
    virtual QNetworkReply *reply();

    void initiate();
    void setBaseUrl(const QString &newUrl);
    void setUrlPath(const QString &urlPath, const QString &tag = QString(""));

    void startTimeout();
    void stopTimeout();

signals:
    void requestStarted();
    void requestResult(RequestRet ret, const QString &replyData);

public slots:
    virtual void postRequest();
    virtual void getRequest();

private:
    bool m_Editable;
    bool m_requestAborted;
    QString m_baseUrl;
    QString m_urlPath;
    QMap<QString, QString> m_parameters;
    QMap<QString, QString> m_postDataMap;
    QNetworkReply *m_reply;
    QTimer *m_timeout;
};

#endif // BASEREQUEST_H
