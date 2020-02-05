<%--
  Created by IntelliJ IDEA.
  User: CIKE
  Date: 2017/9/19
  Time: 10:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <%@include file="/templates/common/common.jsp" %>
    <link href="${basePath}/static/assets/pages/css/login-2.min.css" rel="stylesheet" type="text/css"/>
    <script src="${basePath}/static/js/user/common.js"></script>
    <script src="${basePath}/static/js/user/register.js"></script>
    <script src="${basePath}/static/js/user/code.js"></script>
</head>
<html>
<body class="login">
<!-- BEGIN LOGO -->
<div class="logo">
    <a href="index.html">
        <img src="${basePath}/static/assets/pages/img/logo-big-white.png" style="height: 17px;" alt=""/> </a>
</div>
<!-- END LOGO -->
<!-- BEGIN LOGIN -->
<div class="content">
    <!-- BEGIN LOGIN FORM -->
    <form class="registerForm" action="${basePath}/user/register" method="post" id="registerForm">
        <div class="form-title">
            <span class="form-title">注册</span>
        </div>
        <div class="form-group">
            <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
            <label class="control-label visible-ie8 visible-ie9">手机号</label>
            <input class="form-control form-control-solid placeholder-no-fix phone" type="text" autocomplete="off"
                   placeholder="手机号" name="phone"/></div>
        <div class="form-group">
            <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
            <label class="control-label visible-ie8 visible-ie9">图片验证码</label>
            <input class="form-control form-control-solid placeholder-no-fix imageCode" type="text" autocomplete="off"
                   placeholder="图片验证码" name="imageCode"/></div>
        <div class="form-group">
            <img id="kaptcha" src="/kaptcha.jpg">
        </div>
        <div class="form-actions">
            <button type="button" class="btn btn-block white getCode">获取手机验证码</button>
        </div>
        <div class="form-group">
            <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
            <label class="control-label visible-ie8 visible-ie9">手机验证码</label>
            <input class="form-control form-control-solid placeholder-no-fix phoneCode" type="text" autocomplete="off"
                   placeholder="手机验证码" name="phoneCode"/></div>
        <div class="form-group">
            <label class="control-label visible-ie8 visible-ie9">密码</label>
            <input class="form-control form-control-solid placeholder-no-fix password" type="password"
                   autocomplete="off"
                   placeholder="密码" name="password"/></div>
        <div class="form-actions">
            <button type="button" class="btn green btn-block registerButton">注册</button>
        </div>
        <div class="form-actions">
            <div class="pull-left forget-password-block">
                <a href="${basePath}/user/login" class="forget-password">已有账号，去登陆</a>
            </div>
        </div>
    </form>
    <!-- END LOGIN FORM -->
</div>
</body>
</html>
