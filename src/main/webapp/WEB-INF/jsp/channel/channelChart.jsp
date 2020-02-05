<%@ page contentType="text/html;charset=UTF-8" language="java"
	isELIgnored="false"%>
<!DOCTYPE HTML>
<html lang="zh-CN">
<head>
<title>应用渠道统计报表</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@include file="/WEB-INF/jsp/common/common.jsp"%>
<script type="text/javascript" src="/static/echarts/echarts.common.min.js"></script>
<script type="text/javascript" src="/static/js/channel/channelChart.js?ver=11"></script>
<link href="${basePath}/static/css/channel/channelChart.css?ver=10" rel="stylesheet" type="text/css"/>
</head>
<body>
<%@include file="/WEB-INF/jsp/common/head.jsp"%>
<div class="channel-report-search-div">
	<div class="search-inpt-dv-left">
		<input placeholder="请输入渠道名称搜索" class="input-search" type="text"	id="channel-report-search-txt">
	</div>
	<div class="search-date-dv-right">
		<input placeholder="起始日期" id="search-start-date" name="startDate" type="text" >
		<input placeholder="结束日期" id="search-end-date" name="endDate" type="text">
	</div>
	<div class="search-btn-dv-left">
		<button class="btn btn-default" id="channel-report-search-btn" type="button" name="refresh" aria-label="refresh" title="刷新">
			<i class="glyphicon glyphicon-refresh icon-refresh"></i>
		</button>
	</div>
</div>
<div class="channel-analysis-title-div"><label class="channel-analysis-title">渠道分析</label></div>
<div id ="canvasDiv"  style ="width: 1200px;height:400px;"></div>
<div class="channel-report-table-div"><div class="channel-report-title-div"><label class="channel-report-title">数据明细</label></div><table id = "table"></table></div>
<%@include file="/WEB-INF/jsp/common/footer.jsp"%>
<script type="text/javascript">
	appId = '${appId}';
	basePath = '${basePath}';
</script>
</body>
</html>