<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="/WEB-INF/jsp/common/common.jsp"%>
<script type="text/javascript" src="${basePath}/static/js/app/common-app.js"></script>
<style type="text/css">
 #headTable td{
	font-weight:300; 
	font-size:16px;
	text-align:left
}

.fixed-table-toolbar .bs-bars{
    width:100%;
}

</style>
</head>


<body class="page-container-bg-solid">
	<div class="page-wrapper">
		<%@include file="/WEB-INF/jsp/common/head.jsp"%>
		<div class="page-wrapper-row full-height">
			<div class="panel panel-default">
				<div class="panel-heading">
                                             <font style="font-size:20px"> 佣金</font></div>
				<div class="panel-body">
				<div id="toolbar">
				<div style="float:right">
				  佣金总金额:￥<label id="totalSum" style="font-size:18px;color:red"></label>&nbsp&nbsp
                    开始日期&nbsp<input id="startTime" name="startTime" type="text" style="height:30px;width:150px">
                    结束日期&nbsp<input id="endTime" name="endTime" type="text" style="height:30px;width:150px">
                    
                   <a href="#" id="searchBtn" class="btn btn-primary" role="button" style="height:30px;margin-bottom:5px">
                        <i class="glyphicon glyphicon-zoom-in"></i>搜索
                    </a>
                  </div> 
                </div>
               
                    
					<table id="table" data-toolbar="#toolbar">
					</table>
					
				</div>
			</div>
		</div>

		<%@include file="/WEB-INF/jsp/common/footer.jsp"%>
	</div>
	<script type="text/javascript">
	$.datetimepicker.setLocale('ch');//设置中文
	$('#startTime').datetimepicker({
		 timepicker:false,
	      format:"Y-m-d"
	      });
	$('#endTime').datetimepicker({
		timepicker:false,
		format:"Y-m-d"
		});
	
	//加载佣金总数量
	$.post("${basePath}/settlement/queryCommissionTotalSum.do",{},function(result){
		if(result.code==200){
			$("#totalSum").text(result.data/100);
		}else{
			layer.msg(result.msg);
		}
	});
	
    var $table = $('#table');
	$table.bootstrapTable({  
     url: '${basePath}/settlement/listCommissionSettle.do',  
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
     idField:"id",//指定主键列  
     columns:[
         {
             title: '#',//表的列名  
             field: 'id',//json数据中rows数组中的属性名  
             align: 'center'//水平居中 
         }, 
         {
             title: '日期',  
             field: 'dateTime',  
             align: 'center',
             formatter:function(value,row,index){
            	 return value;
             }
         },  
         {
             title: '收入',  
             field: 'income',  
             align: 'center',
             formatter:function(value,row,index){
            	 if(value==null||value=="")
            		 return '￥0.00';
            	 return "￥"+(value/100.0);
             }
         }
     	]
 	});
	
	//隐藏id列
	$table.bootstrapTable('hideColumn', 'id');
	
	function formatMyData(str){
		if(str==null||str=="")
			return "";
		var index = str.lastIndexOf("\.");
		return str.substring(0,index);
	}
	
	
	function reloadData(){
		var startTimeText = $("#startTime").val();
		var endTimeText = $("#endTime").val();
		
		$('#table').bootstrapTable('refresh',{
			url:'${basePath}/settlement/listCommissionSettle.do',
			query:{
				startTime:startTimeText,
				endTime:endTimeText
			}
	    });
		
	}
	
	$("#searchBtn").click("click",reloadData);
   </script>

</body>
</html>