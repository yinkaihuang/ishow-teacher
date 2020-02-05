<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="/WEB-INF/jsp/common/common.jsp"%>
<script type="text/javascript"
	src="${basePath}/static/js/app/common-app.js"></script>
</head>


<body class="page-container-bg-solid">
	<div class="page-wrapper">
		<%@include file="/WEB-INF/jsp/common/head.jsp"%>
		<div class="page-wrapper-row full-height">
			<div class="panel panel-default">
				<div class="panel-heading"><a href="#" id="rebackApp">
                         <i class="glyphicon glyphicon-share-alt"></i>返回应用管理
                         </a>|日志</div>
				<div class="panel-body">
					<div id="toolbar">
						<!-- <a href="#" id="delBtn" class="btn btn-primary" role="button">
							<i class="glyphicon glyphicon-trash"></i>删除
						</a> -->
					</div>
					<table id="table" data-toolbar="#toolbar">
					</table>
			</div>
		</div>

		<%@include file="/WEB-INF/jsp/common/footer.jsp"%>
	</div>
	<script type="text/javascript">
	
    var $table = $('#table');
	$table.bootstrapTable({  
     url: '${basePath}/app/listLogs.do?notificationsId=${notificationsId}',  
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
     search:true,
     showRefresh:true,
     sidePagination:"server", //服务端处理分页  
     queryParams:myPage,  
     idField:"id",//指定主键列  
     columns:[
         {
             title: '#',//表的列名  
             field: 'id',//json数据中rows数组中的属性名  
             align: 'center'//水平居中 
         },
         {
             title: '事件类型',
             field: 'eventType',
             align: 'center'
         },  
         {
             title: '状态',  
             field: 'status',  
             align: 'center' ,
             formatter:function(value,row,index){
            	 if(value==1)
            		 return "成功";
            	 else if(value==2)
            		 return "失败";
             }
         },  
         {
             title: '通知信息',  
             field: 'notifyMsg',  
             align: 'center'
         },
         {
             title: '返回信息',
             field: 'returnMsg',
             align: 'center'
         }
     	]
 	});
	
	//隐藏id列
	$table.bootstrapTable('hideColumn', 'id');
	
	function reback(){
		window.location.href = document.referrer;
	}
	
	$("#rebackApp").bind("click",reback);
   </script>

</body>
</html>