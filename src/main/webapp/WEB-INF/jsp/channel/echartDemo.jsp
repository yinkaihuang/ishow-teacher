<%@ page contentType="text/html;charset=UTF-8" language="java"
	isELIgnored="false"%>
<!DOCTYPE HTML>
<html lang="zh-CN">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@include file="/WEB-INF/jsp/common/common.jsp"%>
<link href="${basePath}/static/assets/pages/css/login.min.css"
	rel="stylesheet" type="text/css" />
<link href="${basePath}/static/css/channel.css" rel="stylesheet" type="text/css"/>
<style type="text/css">
	.table th, .table td {  
		text-align: center;  
		vertical-align: middle!important;  
	}  
</style>
</head>
<body class="">
	<%@include file="/WEB-INF/jsp/common/head.jsp"%>
	<div id="main" style ="width: 600px;height:400px;">
	
	</div>
<script type="text/javascript">
	var myChart = echarts.init(document.getElementById('main'));

	// 指定图表的配置项和数据
	var option = {
	    title: {
	        text: 'ECharts 入门示例'
	    },
	    tooltip: {},
	    legend: {
	        data:['销量']
	    },
	    xAxis: {
	        data: ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子"]
	    },
	    yAxis: {},
	    series: [{
	        name: '销量',
	        type: 'bar',
	        data: [5, 20, 36, 10, 10, 20]
	    }]
	};

	// 使用刚指定的配置项和数据显示图表。
	myChart.setOption(option);
</script>
</body>

</html>