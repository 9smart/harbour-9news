#include "pluginregister.h"

#include <QtQml>

#include "api/api.h"

void registerPlugins(const char *url)
{
    qmlRegisterType<BaseRequest>(url, 1, 0, "BaseRequest");
    qmlRegisterType<ReqArticleByCategory>(url, 1, 0, "ReqArticleByCategory");
    qmlRegisterType<ReqArticleByPager>(url, 1, 0, "ReqArticleByPager");
    qmlRegisterType<ReqArticleContent>(url, 1, 0, "ReqArticleContent");
    qmlRegisterType<ReqArticles>(url, 1, 0, "ReqArticles");
    qmlRegisterType<ReqComments>(url, 1, 0, "ReqComments");
    qmlRegisterType<ReqPostCommnet>(url, 1, 0, "ReqPostCommnet");
    qmlRegisterType<ReqReplyComment>(url, 1, 0, "ReqReplyComment");
    qmlRegisterType<ReqRegister>(url, 1, 0, "ReqRegister");
    qmlRegisterType<ReqUserLogin>(url, 1, 0, "ReqUserLogin");
    qmlRegisterType<ReqUserInfo>(url, 1, 0, "ReqUserInfo");
}
