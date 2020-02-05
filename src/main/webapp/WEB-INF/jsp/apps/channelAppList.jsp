<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="/WEB-INF/jsp/common/common.jsp"%>
<script type="text/javascript" src="${basePath}/static/js/app/common-app.js"></script>
<style>
.table th, .table td { 
	text-align: center;
	vertical-align: middle!important;
} 

.fixed-table-toolbar .bs-bars{
    width:100%;
}
</style>
</head>

<body class="page-container-bg-solid">
	<div class="page-wrapper">
    <%@include file="/WEB-INF/jsp/common/head.jsp" %>
    <div class="page-wrapper-row full-height">
        <div class="panel panel-default">
            <div class="panel-heading"><a href="#" id="rebackApp">
                        <i class="glyphicon glyphicon-share-alt"></i>返回应用管理
                     </a>| 查看渠道</div>
            <div class="panel-body">
                <div id="toolbar">
                    <a href="#" id="searchBtn" class="btn btn-primary" role="button" style="margin-top: 6px;float:right;height:30px">
                        <i class="glyphicon glyphicon-zoom-in"></i>搜索
                    </a>
                    <input type="text" id="searchText" placeholder="请输入内容" style="margin-top: 6px;margin-right:10px;float:right;height:30px"/>
                </div>
                <table id="table" data-toolbar="#toolbar">
                </table>
            </div>
        </div>
    </div>
    
    <%@include file="/WEB-INF/jsp/common/footer.jsp"%>
  </div>
  <script type="text/javascript">
  var $table = $('#table');
	$table.bootstrapTable({  
      url: '${basePath}/app/listAppChannelDetail.do?appsId=${appsId}',  
      method: 'post',
      contentType: "application/x-www-form-urlencoded",
      dataType: "json",  
      striped: true,//设置为 true 会有隔行变色效果  
      undefinedText: "空",//当数据为 undefined 时显示的字符  
      pagination:true, //分页 
      pageNumber:1,//如果设置了分页，首页页码   
      pageSize:10,//如果设置了分页，页面数据条数  
      pageList:[10, 20, 30, 40],  //如果设置了分页，设置可供选择的页面数据条数。设置为All 则显示所有记录。  
      paginationPreText:'‹',//指定分页条中上一页按钮的图标或文字,这里是<  
      paginationNextText:'›',//指定分页条中下一页按钮的图标或文字,这里是>  
      singleSelect:false,//设置True 将禁止多选  
      data_local:"zh-US",//表格汉化  
      cache:false,
      sidePagination:"server", //服务端处理分页  
      queryParams:myPage,   
      columns:[
          {
              title: '渠道名称',
              field: 'name',
              align: 'center'
          },  
          {
              title: '平台UR',  
              field: 'url',  
              align: 'center'  
          },  
          {
              title: '账号',  
              field: 'phone',  
              align: 'center'
          },
          {
        	  title: '密码',  
              field: 'password',  
              align: 'center'
          },
          {
              title: '结算周期',
              field: 'settle_period',
              align: 'center'
          },
          {
              title: '联系人',
              field: 'linkman',
              align: 'center'
          },
          {
              title: '电子邮箱',
              field: 'email',
              align: 'center'
          }
      ]
  });
	
	
	
	function reback(){
		window.history.back(-1);
	}
	
	$("#rebackApp").bind("click",reback);
	
	function reloadData(){
		var searchWorld = $("#searchText").val();
		
		$('#table').bootstrapTable('refresh',{
			url:'${basePath}/app/listAppChannelDetail.do?appsId=${appsId}',
			query:{
				search:searchWorld,
			}
	    });
	}
	
	$("#searchBtn").bind("click",reloadData);
  
	
  </script>
 </body>
</html>