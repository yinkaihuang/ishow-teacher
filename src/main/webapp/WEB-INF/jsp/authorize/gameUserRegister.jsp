<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<!DOCTYPE HTML>
<html lang="en">
<head>
<title>注册</title>
<!-- BEGIN PAGE LEVEL STYLES -->
<%@include file="/WEB-INF/jsp/common/common.jsp" %>
<link href="${basePath}/static/assets/pages/css/login.min.css" rel="stylesheet" type="text/css" />
<link href="${basePath}/static/css/appUserRegister.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${basePath}/static/js/authorize/register.js?ver=1"></script>
</head>
<body class="login">
	<!-- BEGIN LOGO -->
       <div class="logo">
           <a href="index.html"><img src="${basePath}/static/assets/pages/img/logo-big.png" alt="" /> </a>
       </div>
       <!-- END LOGO -->
       <!-- BEGIN LOGIN -->
       <div class="content">
           <!-- BEGIN REGISTRATION FORM -->
           <form id="register-form-id" class="register-form">
               <div class="form-group">
                   <label class="control-label visible-ie8 visible-ie9">手机号码</label>
                   <input id="phone_num" class="form-control placeholder-no-fix" type="text" placeholder="手机号码" name="mobilePhone" /> 
               </div>
               <div class="form-group">
                   <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
                   <label class="control-label visible-ie8 visible-ie9">请输入验证码</label>
                   <input class="form-control placeholder-no-fix checkCode_input" type="text" placeholder="请输入验证码" name="checkCode" /> 
                   <input class="form-control placeholder-no-fix checkCode_btn getCode" type="button" placeholder="请输入验证码" name="点击获取验证码" value="点击获取验证码"/>
               </div>
               <div class="form-group">
                   <label class="control-label visible-ie8 visible-ie9">密码</label>
                   <input id="password_txt" class="form-control placeholder-no-fix" type="password" placeholder="密码" name="password" /> 
               </div>
           </form>
           <div class="form-actions form-register-submit">
               <button  id="register-submit-btn" class="btn btn-success uppercase pull-right">注册</button>
           </div>
           <div class="form-group userdeal_div">
               <div class="deal_checkbox">
                   	<input id="user_deal_chx" class="userDeal_checkbox" type="checkbox" name="userDeal" /> 
               </div>
               &nbsp;
			   <div class="user_deal_link">
                 	<a href="javascripte:;" class="userdeal_txt">用户协议</a>
			   </div>
           </div>
       </div>
       <div class="copyright"> 2014 © Metronic. Admin Dashboard Template. </div>
</body>
</html>