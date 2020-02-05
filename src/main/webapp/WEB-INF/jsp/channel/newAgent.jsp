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
<link href="${basePath}/static/css/channel/newAgent.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${basePath}/static/js/channel/newAgent.js"></script>
</head>
<body class="page-container-bg-solid">
	<div class="page-wrapper">
		<%@include file="/WEB-INF/jsp/common/head.jsp"%>
		<div class="page-wrapper-row full-height">
			<div class="page-wrapper-middle">
				<div class="container">
					<div class="panel panel-default">
						<div class="panel-heading"><div style="vertical-align:middle"><a href="${basePath}/channelApp/agentOperate/${id}"><i  class='glyphicon glyphicon-circle-arrow-left' ></i>返回分发列表</a><label style='top:0px;line-height:14px;position:relative;margin-bottom:0px'>&nbsp;|&nbsp;</label>${channelName}</div></div>
						<div class="panel-heading"><h4>新增分发</h4></div>
						<div class="panel-body">
							<div id="toolbar">
								<div class="search-inpt-dv-left">
									<input placeholder="请输入应用名称搜索" class="input-search" type="text" id="app-search-text">
								</div>
								<div class="search-btn-dv-left">
									<button class="btn btn-default" id="app-refresh-btn" type="button"	name="refresh" aria-label="refresh" title="刷新">
										<i class="glyphicon glyphicon-refresh icon-refresh"></i>
									</button>
								</div>
								<div class="search-btn-dv">
									<button class="btn btn-default" id="app-agent-btn" type="button"
										name="app-agent" aria-label="app-agent" title="请选择应用投放">
										请选择应用投放
									</button>
								</div>
							</div>
							<table id="table" data-toolbar="#toolbar" data-search="true"></table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@include file="/WEB-INF/jsp/common/footer.jsp"%>
	
	<!-- 应用投放模态窗 -->
	<div class="modal fade" id="appAgentSettingModal" tabindex="-1" aria-labelledby="appAgentSetTitle" aria-hidden="false" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="appAgentSetTitle">应用投放</h5>
				</div>
				<div class="modal-body">
					<form id="appAgentSaveForm" class="form-horizontal" role="form">
						<div class="form-group">
							<label class="col-md-2 control-label" >推广类型</label>
							<div class="col-md-4">
								<select id="agent-type-sel" name="agentType" class="form-control">
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-2 control-label">单价</label>
							<div class="col-md-4">
								<input type="text" id="unit-price" name="unitPrice" class="form-control" style="display:inline-block">
							</div>
							<label style="padding-top:7px;">(天)</label>
						</div>
						<div class="form-group">
							<label class="col-md-2 control-label">回调地址</label>
							<div class="col-md-4">
								<input type="text" id="callback-url" name="callbackUrl" class="form-control">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" id="save-app-agent" class="btn blue">确定</button>
					<button type="button"  style="margin-left:5px"  id="close-app-agent" class="btn grey-salsa btn-outline" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		basePath = '${basePath}';
		channelName = '${channelName}';
		id = '${id}';
	</script>
</body>

</html>