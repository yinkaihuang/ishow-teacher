<%@ page contentType="text/html;charset=UTF-8" language="java"
	isELIgnored="false"%>
<!DOCTYPE HTML>
<html lang="zh-CN">
<head>
<title>渠道分发管理</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@include file="/WEB-INF/jsp/common/common.jsp"%>
<link href="${basePath}/static/assets/pages/css/login.min.css" rel="stylesheet" type="text/css" />
<link href="${basePath}/static/css/channel/channel.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${basePath}/static/js/channel/agentEdit.js"></script>
</head>
<body class="page-container-bg-solid">
	<div class="page-wrapper">
		<%@include file="/WEB-INF/jsp/common/head.jsp"%>
		<div class="page-wrapper-row full-height">
			<div class="page-wrapper-middle">
				<div class="container">
					<div class="panel panel-default">
						<div class="panel-heading"><h4>分发管理</h4></div>
						<div class="panel-body">
							<form class="form-horizontal channelAppEdit" role="form" method="post">
								<input type="hidden" name="channelId" value="${channelApp.channelId}"> 
								<input type="hidden" name="appId" value="${channelApp.appId}"> 
								<div class="form-group">
									<label class="col-md-2 control-label">应用图标</label>
									<div class="col-md-4">
										<img alt="Preview" style="wdith:50px;height:50px"  src="${basePath}/system/showAppImage.do?path=${channelApp.appImgUrl}">
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">应用名称</label>
									<div class="col-md-4">
										<input type="text" id="appName" name="appName" readonly class="form-control" value="${channelApp.appName}" placeholder="">
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">类型</label>
									<div class="col-md-4">
										<input type="text" id="appType" name="appType" readonly class="form-control" value="" placeholder="">
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">单价</label>
									<div class="col-md-4">
										<input type="text" id="unitPrice" name="unitPrice" readonly class="form-control" value="${channelApp.unitPrice}" placeholder="">
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">推广类型</label>
									<div class="col-md-4">
										<select id="agentType" name="agentType" class="form-control"></select>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">推广URL</label>
									<div class="col-md-4">
										<input type="text" id="agentURL" name="agentURL" class="form-control" value="${channelApp.spreadUrl}" placeholder="">
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">回调地址</label>
									<div class="col-md-4">
										<input type="text" id="callbackUrl" name="callbackUrl" class="form-control" value="${channelApp.callbackUrl}" placeholder="">
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">状态</label>
									<div class="col-md-4">
										<select id="enableStatus" name="enableStatus" class="form-control"></select>
									</div>
								</div>
								<div class="form-group">
									<div class="col-md-offset-2 col-md-10">
										<button type="button" id="submit" class="btn blue">修改</button>
										<button type="button" onclick="back()"  style="margin-left:5px;" class="btn grey-salsa btn-outline">取消</button>
									</div>
								</div>
							</form>
						
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@include file="/WEB-INF/jsp/common/footer.jsp"%>
	<script type="text/javascript">
		channelId = '${channelApp.channelId}';
		basePath = '${basePath}';
		channelApp = '${channelApp}';
		appType = '${channelApp.appType}';
		agentType = '${channelApp.spreadType}';
		enableStatus = '${channelApp.enableStatus}';
	</script>
</body>

</html>