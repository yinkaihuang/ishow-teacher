<%--
  Created by IntelliJ IDEA.
  User: CIKE
  Date: 2017/10/11
  Time: 9:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>图表</title>
<%@include file="/WEB-INF/jsp/common/common.jsp"%>
<script type="text/javascript" src="${basePath }/static/js/common/ichart.1.2.min.js"></script>
<style type="text/css">
  .label{
   background-color:white
  }
</style>
</head>
<body class="page-container-bg-solid">
	<div class="page-wrapper">
		<%@include file="/WEB-INF/jsp/common/head.jsp"%>
		<div class="page-wrapper-row full-height">
			<div class="page-wrapper-middle">
			<div style="font-size:18px;margin-left:10px;width:100%"><strong><label id="brand"  onclick="changeDataType(0)">品牌&nbsp</label>|<label id="system" onclick="changeDataType(1)">系统&nbsp</label>|<label id="ratio" onclick="changeDataType(2)">分辨率&nbsp</label></strong>  
			<div style="float:right;margin-right:10px">开始时间&nbsp<input id="startTime" name="startTime" type="text" style="height:30px" placeholder="请选开始时间">
                           结束时间&nbsp<input id="endTime" name="endTime" type="text" style="height:30px;width:150px" placeholder="选择截止时间">
             <a href="#" onclick="reload()" class="btn btn-primary" role="button" style="height:30px">
                        <i class="glyphicon glyphicon-zoom-in"></i>搜索
             </a>
            </div>
            </div>
			<hr color=#987cb9 SIZE=3>
			<div style="font-size:20px;background-color:#DDDD;margin-left: 10px">TOP 10 记录统计图</div>
			<hr color=#987cb9 SIZE=3>
			<div style="font-size:15px;margin-left:10px "><strong><label id="userNum" onclick="chageType(0)">新增用户&nbsp</label>|<label id="startNum" onclick="chageType(1)">启动次数&nbsp</label></strong></div>
				<div id="canvasDiv"></div>
				<font style="font-size:18px;margin-left: 10px"><strong>数据明细：</strong></font>
				<table id="table" data-toolbar="#toolbar"></table>
			</div>
			</div>
			<%@include file="/WEB-INF/jsp/common/footer.jsp"%>
		</div>
		
		<script type="text/javascript">
		var dataType = 0;
		var type = 0;
		var startTime ="";
		var endTime = "";
		
		$.datetimepicker.setLocale('ch');//设置中文
		$('#startTime').datetimepicker({timepicker:false,format:"Y-m-d"});
		$('#endTime').datetimepicker({timepicker:false,format:"Y-m-d"});
		
		function changeDataType(param){
			dataType = param;
			if(param==0){
				$("#brand").css("backgroundColor","red");
				$("#system").css("backgroundColor","white");
				$("#ratio").css("backgroundColor","white");
			}else if(param==1){
				$("#brand").css("backgroundColor","white");
				$("#system").css("backgroundColor","red");
				$("#ratio").css("backgroundColor","white");
			}else if(param==2){
				$("#brand").css("backgroundColor","white");
				$("#system").css("backgroundColor","white");
				$("#ratio").css("backgroundColor","red");
			}
			post();
			$('#table').bootstrapTable('refresh',{
				url:'${basePath}/terminal/listDetailData.do?appsId=${appId}',
				query:{
					"type":type,
					"dataType":dataType,
					"startTime":startTime,
					"endTime":endTime
				}
			});
		}
		
		function reload(){
			startTime = $("#startTime").val();
			endTime = $("#endTime").val();
			post();
			$('#table').bootstrapTable('refresh',{
				url:'${basePath}/terminal/listDetailData.do?appsId=${appId}',
				query:{
					"type":type,
					"dataType":dataType,
					"startTime":startTime,
					"endTime":endTime
				}
			});
		}
		
		function chageType(param){
			if(param==0){
				$("#userNum").css("backgroundColor","red");
				$("#startNum").css("backgroundColor","white");
			}else if(param==1){
				$("#userNum").css("backgroundColor","white");
				$("#startNum").css("backgroundColor","red");
			}
			type = param;
			post();
		}
		
		//重新加载统计图形
		function post(){
	    	$.post("${basePath}/terminal/listTopTenData.do?appsId=${appId}",{"dataType":dataType,"type":type,"startTime":startTime,"endTime":endTime},function(result){
	    		if(result.code==200){
	    			loadData(result.data)
	    		}else{
	    			layer.msg("错误："+result.msg)
	    		}
	    	});
		}
		
		function loadData(data){
			if(data==null||data.length==0){
				data = [{name : '',value : 0,color:'#97b3bc'}];
			}
			 new iChart.Bar2D({
					render : 'canvasDiv',
					background_color : '#EEEEEE',
					data: data,
					title : '',
					footnote : '数据来源：深圳爱秀科技有限公司',
					width : 800,
					height : 400,
					coordinate:{
						width:640,
						height:260,
						scale:[{
							 position:'bottom',	
							 start_scale:0
						}]
					},
					sub_option:{
						border:{
							enable : false
						},
						label:{color:'#333333'}
					},
					shadow:true,
					shadow_color:'#8d8d8d',
					shadow_blur:1,
					shadow_offsety:1,
					shadow_offsetx:1,
					legend:{enable:false}
				}).draw();
		}
		
		
		var $table = $('#table');
		$table.bootstrapTable({  
	     url: '${basePath}/terminal/listDetailData.do?appsId=${appId}',  
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
	             title: '名称',
	             field: 'name',
	             align: 'center'
	         },  
	         {
	             title: '新增用户',  
	             field: 'newUsersNum',  
	             align: 'center'
	         },  
	         {
	             title: '新增用户比例',  
	             field: 'newUsersRate',  
	             align: 'center',
	             formatter:function(value,row,index){
	            	 return value+"%";
	             }
	         },
	         {
	             title: '启动次数',
	             field: 'startNum',
	             align: 'center'
	         },
	         {
	             title: '启动占比',
	             field: 'startRate',
	             align: 'center',
	             formatter:function(value,row,index){
	            	 return value+"%";
	             }
	         }
	     	]
	 	});
		
		//隐藏id列
		$table.bootstrapTable('hideColumn', 'id');
		
		post();
		$("#brand").css("backgroundColor","red");
		$("#userNum").css("backgroundColor","red");
</script>
</body>
</html>
