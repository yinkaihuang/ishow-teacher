<%@ page contentType="text/html;charset=UTF-8" language="java"
	isELIgnored="false"%>
<!DOCTYPE HTML>
<html lang="zh-CN">
<head>
<title>渠道管理</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@include file="/WEB-INF/jsp/common/common.jsp"%>
<link href="${basePath}/static/assets/pages/css/login.min.css"
	rel="stylesheet" type="text/css" />
<link href="${basePath}/static/css/channel/channel.css?ver=5" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${basePath}/static/js/channel/channel.js"></script>
</head>
<body class="page-container-bg-solid">
	<div class="page-wrapper">
		<%@include file="/WEB-INF/jsp/common/head.jsp"%>
		<div class="page-wrapper-row full-height">
		        <div class="page-wrapper-middle">
		            <div class="container">
		                <div class="panel panel-default">
		                	<div class="panel-heading"><h4>渠道管理</h4></div>
		                	<div class="panel-body">
			                	<div id="toolbar">
							  		<a href="${basePath}/channel/edit" id="add-btn" class="btn btn-primary" role="button">
					                	<i class="glyphicon glyphicon-plus"></i>新增
					                </a>	
					                <a href="#" id="del-btn" class="btn btn-primary" role="button">
					                    <i class="glyphicon glyphicon-trash"></i>删除
					                </a>
					               	<div class="search-btn-dv">
										<button class="btn btn-default" id="refresh-btn" type="button" name="refresh" aria-label="refresh" title="刷新"><i class="glyphicon glyphicon-refresh icon-refresh"></i></button>
					               	</div>
					               	<div class="search-inpt-dv">
										<input placeholder="请输入渠道名称、联系人搜索" class="input-search" type="text" id="search-text">
					               	</div>
						  		</div>
						  		<table id="table"   data-toolbar="#toolbar"   data-search="true"></table>
					  		</div>
		                </div>
		            </div>
		       </div>
	     </div>    
    </div> 
	<%@include file="/WEB-INF/jsp/common/footer.jsp"%>
	<script type="text/javascript">
		basePath = '${basePath}';
	</script>
</body>
</html>