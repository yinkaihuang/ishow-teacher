<%@ page contentType="text/html;charset=UTF-8" language="java"
	isELIgnored="false"%>
<!DOCTYPE HTML>
<html lang="zh-CN">
<head>
<title>网络及运营商统计</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@include file="/WEB-INF/jsp/common/common.jsp"%>
<script type="text/javascript"	src="/static/echarts/echarts.common.min.js"></script>
<script type="text/javascript"	src="/static/js/chart/networkOperator.js?ver=14"></script>
<link href="${basePath}/static/css/chart/networkOperator.css?ver=6" rel="stylesheet" type="text/css" />
</head>
<body>
	<%@include file="/WEB-INF/jsp/common/head.jsp"%>
	<div class="network-operator-search-div">
		<div class="search-inpt-dv-left">
			<label id="search-select-id-1" class="search-cls-1">联网方式</label><label id="search-select-id-2" class="search-cls-2">运营商</label>
		</div>
		<div class="search-btn-dv-right">
			<button class="btn btn-default" id="network-operator-search-btn" type="button" name="refresh" aria-label="refresh" title="刷新">
				<i class="glyphicon glyphicon-refresh icon-refresh"></i>
			</button>
		</div>
		<div class="search-date-dv-right">
			<input placeholder="起始日期" id="search-start-date" name="startDate"	type="text"> 
			<input placeholder="结束日期" id="search-end-date" name="endDate" type="text">
		</div>
	</div>
	<div class="network-operator-title-div">
		<label id="network-operator-label" class="network-operator-title">联网方式</label>
	</div>
	<div id="analysis-type-div" class="analysis-type">
		<label id="search-select-id-3" class="search-cls-3">新增用户</label><label id="search-select-id-4" class="search-cls-4">启动次数</label>
	</div>
	<div id="canvasDiv" style="width: 1200px; height: 400px;"></div>
	<div id="network-table-id" class="network-operator-table-div">
		<div class="network-operator-title-div">
			<label class="network-operator-title">数据明细</label>
		</div>
		<table id="network-table"></table>
	</div>
	<div id="operator-table-id" class="network-operator-table-div">
		<div class="network-operator-title-div">
			<label class="network-operator-title">数据明细</label>
		</div>
		<table id="operator-table"></table>
	</div>
	<%@include file="/WEB-INF/jsp/common/footer.jsp"%>
	<script type="text/javascript">
		appId = '${appId}';
		basePath = '${basePath}';
	</script>
</body>
</html>