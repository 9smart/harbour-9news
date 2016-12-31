#ifndef API_H
#define API_H

#include <QObject>

#include <QUrl>

#include "baserequest.h"

///
/// \brief The ReqArticles class
/// 新闻列表
/// get
///
class ReqArticles : public BaseRequest
{
    Q_OBJECT
public:
    explicit ReqArticles(QObject *parent = Q_NULLPTR);
    virtual ~ReqArticles() {}
};

///
/// \brief The ReqArticleByCategory class
/// 获取某一分类的新闻列表
/// get
///
class ReqArticleByCategory : public BaseRequest
{
    Q_OBJECT
public:
    explicit ReqArticleByCategory(QObject *parent = Q_NULLPTR);

    virtual ~ReqArticleByCategory() {}

    // BaseRequest interface
protected:
    void initParameters() {
        (*this)
        ("category", "")
        ;
    }
};

///
/// \brief The ReqArticleByPager class
/// 获取当前新闻列表的下一页或者上一页内容
/// get
///
class ReqArticleByPager : public BaseRequest
{
    Q_OBJECT
public:
    explicit ReqArticleByPager(QObject *parent = Q_NULLPTR);

    virtual ~ReqArticleByPager() {}

    // BaseRequest interface
protected:
    void initParameters() {
        (*this)
        ("last_dateline", "")
        ("action", "") //string: next/pre
        ("page", "");
    }

    QUrl initUrl();
};

///
/// \brief The ReqArticleContent class
/// 新闻正文
/// get
///
class ReqArticleContent : public BaseRequest
{
    Q_OBJECT
public:
    explicit ReqArticleContent(QObject *parent = Q_NULLPTR);
    virtual ~ReqArticleContent() {}

    // BaseRequest interface
protected:
    void initParameters() {
        (*this)
        ("id", "");
    }

    QUrl initUrl();
};

///
/// \brief The ReqComments class
/// 评论列表
/// get
///
class ReqComments : public BaseRequest
{
    Q_OBJECT
public:
    explicit ReqComments(QObject *parent = Q_NULLPTR);
    virtual ~ReqComments() {}

    // BaseRequest interface
protected:
    void initParameters() {
        (*this)
        ("id", "")
        // these 3 para below should not empty if use any of them
        // 如果使用分页方式,则以下三项的参数必须均不为空
        ("last_dateline", "")
        ("action", "") //string: next/pre
        ("page", "");
    }

    QUrl initUrl();
};


///
/// \brief The ReqPostCommnet class
/// 发布评论
/// post
///

/**********************
   表单内容
   ---------------
   | type = “news”
   | content = “这个新闻挺好的：）”
   | model = “n9”
   ---------------
***********************/
class ReqPostCommnet : public BaseRequest
{
    Q_OBJECT
public:
    explicit ReqPostCommnet(QObject *parent = Q_NULLPTR);
    virtual ~ReqPostCommnet() {}

    // BaseRequest interface
protected:
    void initParameters() {
        (*this)
        ("id", "")
        ("token", "");
    }

    QUrl initUrl();
};

///
/// \brief The ReqReplyComment class
/// post
///

/**********************
   表单内容
   ---------------
   | content = “你的看法我很赞成：）”
   | model = “n9”
   ---------------
***********************/
class ReqReplyComment : public BaseRequest
{
    Q_OBJECT
public:
    explicit ReqReplyComment(QObject *parent = Q_NULLPTR);
    virtual ~ReqReplyComment() {}

    // BaseRequest interface
protected:
    void initParameters() {
        (*this)
        ("id", "")
        ("token", "");
    }

    QUrl initUrl();
};

///
/// \brief The ReqRegister class
/// 注册新用户
/// post
///

/**********************
   表单内容
   ---------------
   | email = “someone@qq.com”
   | password = “somepassword”
   | repassword = “somepassword”
   | nickname = “大好人的昵称”
   ---------------
***********************/
class ReqRegister : public BaseRequest
{
    Q_OBJECT
public:
    explicit ReqRegister(QObject *parent = Q_NULLPTR);
    virtual ~ReqRegister() {}
};

///
/// \brief The ReqUserLogin class
/// 会员登录
/// post
///

/**********************
   表单内容
   ---------------
   | email = 会员的电子邮件
   | password = 会员的密码
   ---------------
***********************/
class ReqUserLogin : public BaseRequest
{
    Q_OBJECT
public:
    explicit ReqUserLogin(QObject *parent = Q_NULLPTR);
    virtual ~ReqUserLogin() {}
};

///
/// \brief The ReqUserInfo class
/// 获取会员个人信息
/// get
///
class ReqUserInfo : public BaseRequest
{
    Q_OBJECT
public:
    explicit ReqUserInfo(QObject *parent = Q_NULLPTR);
    virtual ~ReqUserInfo() {}

    // BaseRequest interface
protected:
    void initParameters() {
        (*this)
        ("id", "");
    }

    QUrl initUrl();
};
#endif // API_H
