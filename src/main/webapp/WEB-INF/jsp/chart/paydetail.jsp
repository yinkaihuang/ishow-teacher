<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="/WEB-INF/jsp/common/common.jsp"%>
<script type="text/javascript" src="${basePath }/static/echarts/echarts.common.min.js"></script>
</head>


<body class="page-container-bg-solid">
	<div class="page-wrapper">
		<%@include file="/WEB-INF/jsp/common/head.jsp"%>
		<div class="page-wrapper-row full-height">
			<div class="panel panel-default">
				<div width="100%">
					<div style="float: right; margin-right: 10px">
						开始时间&nbsp<input id="startTime" name="startTime" type="text"
							style="height: 30px;width:120px" placeholder="选择开始时间"> 结束时间&nbsp<input id="endTime"
							name="endTime" type="text" style="height: 30px;width:120px" placeholder="选择截止时间"> <a
							href="#" onclick="reloadAll()" class="btn btn-primary" role="button"
							style="height: 30px"> <i class="glyphicon glyphicon-zoom-in"></i>搜索
						</a>
					</div>
				</div>
				<br/>
				<br/>
				<br/>
                 <div style="width:100%;height:400px;text-align: center">
                 <div  id="canvasDiv" style="height:100%;width:50%;float:left"></div>
                 <div  id="canvasDiv2" style="height:100%;width:50%;float:left"></div>
                 </div>

				<table id="table" ></table>
			</div>
		</div>

		<%@include file="/WEB-INF/jsp/common/footer.jsp"%>
	</div>
	<script type="text/javascript">
	var startTime ="";
	var endTime = "";
	
	$.datetimepicker.setLocale('ch');//设置中文
	$('#startTime').datetimepicker({timepicker:false,format:"Y-m-d"});
	$('#endTime').datetimepicker({timepicker:false,format:"Y-m-d"});
	
	 // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('canvasDiv'));
    var myChart2 = echarts.init(document.getElementById('canvasDiv2'));
    
    function reloadAll(){
    	startTime = $("#startTime").val();
    	endTime = $("#endTime").val();
    	loadGridData();
    	$('#table').bootstrapTable('refresh',{
    		url:'${basePath}/payDay/listDetail.do?appId=${appId}',
    		query:{
    			'startTime':startTime,
    			'endTime':endTime
    		}
       });
    }
    
    function loadGridData(){
    	$.post("${basePath}/payDay/listGridData.do?appId=${appId}",{"startTime":startTime,"endTime":endTime},function(result){
    		if(result.code==200){
    			var data1 = new Array();
    			var data2 = new Array();
    			var temp = result.data;
    			data1.push(temp["totalUserNum"]);
    			data1.push(temp["currentUserNum"]);
    			data2.push(temp["totalMoney"]);
    			data2.push(temp["currentMoney"]);
    			showUserNum(data1);
    			showMoney(data2);
    		}else{
    		   layer.msg(result.msg);
    		}
    	});
    }
    
    function showUserNum(temp){
    	if(temp==null||temp.length==0)
    		temp =[0,0];
    	option = {
    		   title: {
    	                text: '支付用户数量'
    	         },
        	    color: ['#3398DB'],
        	    tooltip : {
        	        trigger: 'axis',
        	        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
        	            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
        	        }
        	    },
        	    grid: {
        	        left: '3%',
        	        right: '4%',
        	        bottom: '3%',
        	        containLabel: true
        	    },
        	    xAxis : [
        	        {
        	            type : 'category',
        	            data : ['付费总用户', '新付费用户'],
        	            axisTick: {
        	                alignWithLabel: true
        	            }
        	        }
        	    ],
        	    yAxis : [
        	        {
        	            type : 'value'
        	        }
        	    ],
        	    series : [
        	        {
        	            name:'数量',
        	            type:'bar',
        	            barMaxWidth:50,
        	            label: {//控制其在顶部显示数据
    		                normal: {
    		                    show: true,
    		                    position: 'outside',
    		                    formatter: '{c}人' // {d}是其横坐标的数据{c}是其值  这里是数据展示的时候显示的数据
    		                }
    		            },
        	            data:temp
        	        }
        	    ]
        	};
    	 // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    }
    
    loadGridData();
    
    function showMoney(temp){
    	if(temp==null||temp.length==0)
    		temp=[0,0]
    	option = {
    			title: {
	                text: '支付金额'
	            },
        	    color: ['#3398DB'],
        	    tooltip : {
        	        trigger: 'axis',
        	        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
        	            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
        	        }
        	    },
        	    grid: {
        	        left: '3%',
        	        right: '4%',
        	        bottom: '3%',
        	        containLabel: true
        	    },
        	    xAxis : [
        	        {
        	            type : 'category',
        	            data : ['总付费金额', '新增付费金额'],
        	            axisTick: {
        	                alignWithLabel: true
        	            }
        	        }
        	    ],
        	    yAxis : [
        	        {
        	            type : 'value'
        	        }
        	    ],
        	    series : [
        	        {
        	            name:'金额',
        	            type:'bar',
        	            barMaxWidth:50,
        	            label: {//控制其在顶部显示数据
    		                normal: {
    		                    show: true,
    		                    position: 'outside',
    		                    formatter: '￥{c}' // {d}是其横坐标的数据{c}是其值  这里是数据展示的时候显示的数据
    		                }
    		            },
        	            data:temp
        	        }
        	    ]
        	};
    	 // 使用刚指定的配置项和数据显示图表。
        myChart2.setOption(option);
    }

   
	
	//加载统计图表的数据
	function loadData(){
		$.post("${basePath}/payDay/listGridData.do?appId=${appId}",{"startTime":startTime,"endTime":endTime},function(result){
			if(result.code==200){
				var data = result.data;
				console.log(data);
			}else{
				layer.msg(result.msg);
			}
		});
		
	}
	
		var $table = $('#table');
		$table.bootstrapTable({
					url : '${basePath}/payDay/listDetail.do?appId=${appId}',
					method : 'post',
					contentType : "application/x-www-form-urlencoded",
					dataType : "json",
					striped : true,//设置为 true 会有隔行变色效果  
					undefinedText : "空",//当数据为 undefined 时显示的字符  
					pagination : true, //分页 
					pageNumber : 1,//如果设置了分页，首页页码   
					pageSize : 10,//如果设置了分页，页面数据条数  
					pageList : [ 10, 20, 30, 40 ], //如果设置了分页，设置可供选择的页面数据条数。设置为All 则显示所有记录。  
					paginationPreText : '‹',//指定分页条中上一页按钮的图标或文字,这里是<  
                    paginationNextText:'›',//指定分页条中下一页按钮的图标或文字,这里是>  
					singleSelect : false,//设置True 将禁止多选  
					data_local : "zh-US",//表格汉化  
					cache : false,
					sidePagination : "server", //服务端处理分页  
					queryParams : myPage,
					idField : "id",//指定主键列  
					columns : [ {
						title : '#',//表的列名  
						field : 'id',//json数据中rows数组中的属性名  
						align : 'center'//水平居中 
					}, {
						title : '日期',
						field : 'dateTime',
						align : 'center'
					}, {
						title : '新增用户',
						field : 'newUserNum',
						align : 'center'
					}, {
						title : '新增占比',
						field : 'newUserRate',
						align : 'center',
						formatter:function(value,row,index){
							return value+"%";
						}
					},{
						title : '启动次数',
						field : 'startNum',
						align : 'center'
					},{
						title : '启动占比',
						field : 'startRate',
						align : 'center',
						formatter:function(value,row,index){
							return value+"%";
						}
					} ]
				});

		//隐藏id列
		$table.bootstrapTable('hideColumn', 'id');

	</script>

</body>
</html>