<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<!DOCTYPE HTML>
<html lang="en">
<head>
<title>登录</title>
<!-- BEGIN PAGE LEVEL STYLES -->
<link href="${basePath}/static/assets/pages/css/login-2.min.css" rel="stylesheet" type="text/css" />
<!-- END PAGE LEVEL STYLES -->
<%@include file="/WEB-INF/jsp/common/common.jsp"%>
<script type="text/javascript">
var appType = ${appType};
$(function(){
	$('#login_form').submit(function() {
		jQuery.ajax({
			url : '${basePath}'+'/game/userLogin',
			data : $('#login_form').serialize(),
			type : "POST",
			success : function(data) {
				var code =data.code;
				if(code != 200){
					alert(data.message);
				}
				if(appType == 1){
					andriodLoginCallback(JSON.stringify(data));
				}
				
				if(appType == 2){
					iosLoginCallback(JSON.stringify(data));
				}
			}
		});
		return false;
	});	
	
	
	function andriodLoginCallback(obj){
		JavaObj.javaScriptToGameSdk(obj);
	}
	
	function iosLoginCallback(obj){
		
	}
});
</script>
</head>
<body class="login">
	<div class="content">
		<form id="login_form" class="login-form" action="${basePath}/game/userLogin" method="post">
			<div class="form-title">
				<span class="form-title">Welcome.</span>
				<span class="form-subtitle">Please login.</span>
			</div>
			<div class="alert alert-danger display-hide">
				<button class="close" data-close="alert"></button>
				<span> Enter any username and password. </span>
			</div>
			<div class="form-group">
				<label class="control-label visible-ie8 visible-ie9">Username</label>
				<input class="form-control form-control-solid placeholder-no-fix" type="text" autocomplete="off" placeholder="Username" name="userName" /> 
			</div>
			<div class="form-group">
				<label class="control-label visible-ie8 visible-ie9">Password</label>
				<input class="form-control form-control-solid placeholder-no-fix" type="password" autocomplete="off" placeholder="Password" name="password" /> 
			</div>
			<div class="display-hide">
				<input class="form-control form-control-solid placeholder-no-fix" type="text" autocomplete="off" placeholder="AppId" name="appId" value="${appId}" />
			</div>
			<div class="display-hide">
				<input class="form-control form-control-solid placeholder-no-fix" type="text" autocomplete="off" placeholder="channelId" name="channelId" value="${channelId}"/>
			</div>
			<div class="form-actions">
				<button id="submit_button" type="submit" class="btn red btn-block uppercase">Logins</button>
			</div>
			<div class="form-actions">
				<div class="pull-left forget-password-block">
					<a href="${basePath}/game/gotoUserRegister" id="register"  class="forget-password">Register</a>
				</div>
				<div class="pull-right forget-password-block">
					<a href="javascript:;" id="forget-password" class="forget-password">Forgot Password?</a>
				</div>
			</div>
		</form>
	</div>
</body>
</html>