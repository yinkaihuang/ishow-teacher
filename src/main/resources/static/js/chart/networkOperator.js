var mode;//记录当前选择维度，网络制式还是运营商，1网络2运营商
var index;//记录当前统计维度，是新增用户还是启动次数，1新增2启动次数
var networkTableInit;//记录网络制式表格是否初始化，1初始化0未初始化
var operatorTableInit;//记录运营商表格是否初始化，1初始化0未初始化
$(function() {
		$.datetimepicker.setLocale('ch');//设置中文
		var date = new Date();
		date.setDate(date.getDate() - 1);
		$('#search-start-date').datetimepicker({
			timepicker:false,
			format:"Y-m-d",
			maxDate:new Date(),
			value:date,
			dayOfWeekStart:1
		});
		$('#search-end-date').datetimepicker({
			timepicker:false,
			format:"Y-m-d",
			maxDate:new Date(),
			value:date,
			dayOfWeekStart:1
		});
		mode = 1;
		index = 1;
		networkTableInit = 0;
		operatorTableInit = 0;
		$('#search-select-id-1').bind("click",networkClick);
		$('#search-select-id-2').bind("click",operatorClick);
		$('#search-select-id-3').bind("click",analysisNewUser);
		$('#search-select-id-4').bind("click",analysisStartTimes);
		
		$('#network-operator-search-btn').bind('click',tableRefresh);
		networkInit();
		$('#operator-table-id').hide();
		myChart = echarts.init(document.getElementById('canvasDiv'));
});

function tableRefresh(){
	if(mode == 1){
		networkTableRefresh();
	}else{
		operatorTableRefresh();
	}
}

function getOption(title,name,legendData,seriesData){
	var option = {
		    title : {
		        text: title
		    },
		    tooltip : {
		        trigger: 'item',
		        showDelay:20
		    },
		    legend: {
		        data:[name],
		        orient: 'horizontal',
		        y: 'top'
		    },
		    toolbox: {
		        show : false,
		        feature : {
		            mark : {show: true},
		            dataView : {show: true, readOnly: false},
		            magicType : {show: true, type: ['line', 'bar']},
		            restore : {show: true},
		            saveAsImage : {show: true}
		        }
		    },
		    calculable : true,
		    xAxis : [
		        {
		            type : 'value'
		        }
		    ],
		    yAxis : [
		        {
		            type: 'category',
		            data: legendData
		        }
		    ],
		    series :[
		        {
		            name: name,
		            type: 'bar',
		            data: seriesData,
		            barMaxWidth:20,
		            itemStyle:{normal:{color:'#4096B5'}}  
		        }
		    ]
		};
	return option;
}

function networkClick(){
	if(mode == 1){
		return;
	}
	changeAnalysisType(1);
	$('#operator-table-id').hide();
	$('#network-table-id').show();
	if(networkTableInit == 0){
		networkInit();
	}else{
		networkTableRefresh();
	}
}

function operatorClick(){
	if(mode == 2){
		return;
	}
	changeAnalysisType(2);
	$('#network-table-id').hide();
	$('#operator-table-id').show();
	if(operatorTableInit == 0){//未初始化表格就先初始化
		operatorInit();
	}else{
		operatorTableRefresh();
	}
}

function operatorTableRefresh(){
	$('#operator-table').bootstrapTable('refresh', {
		url : basePath+'/terminal/listDetailData',
		query : {
			appsId : appId,
			startTime: $('#search-start-date').val(),
			endTime: $('#search-end-date').val(),
			dataType: 4
		}
	});
}

function networkTableRefresh(){
	$('#network-table').bootstrapTable('refresh', {
		url : basePath+'/terminal/listDetailData',
		query : {
			appsId : appId,
			startTime: $('#search-start-date').val(),
			endTime: $('#search-end-date').val(),
			dataType: 3
		}
	});
}

/*
 * 点击新增按新增用户统计按钮触发事件
 */
function analysisNewUser(){
	changeAnalysisType(3);
	if(mode == 1){//网络
		var tableData = $('#network-table').bootstrapTable('getData');
		loadChart(tableData,mode,index);
	}else{//运营商
		var tableData = $('#operator-table').bootstrapTable('getData');
		loadChart(tableData,mode,index);
	}
	
}

/*
 * 点击按启动次数统计触发事件
 */
function analysisStartTimes(){
	changeAnalysisType(4);
	if(mode == 1){//网络
		var tableData = $('#network-table').bootstrapTable('getData');
		loadChart(tableData,mode,index);
	}else{//运营商
		var tableData = $('#operator-table').bootstrapTable('getData');
		loadChart(tableData,mode,index);
	}
}

function changeAnalysisType(i){
	if(i == 1){//联网方式
		$('#search-select-id-2').css('color','#333333');
		$('#search-select-id-2').css('font-weight','normal');
		$('#search-select-id-2').css('background-color','#DDDDDD');

		$('#search-select-id-1').css('color','#3EC7F5');
		$('#search-select-id-1').css('font-weight','bold');
		$('#search-select-id-1').css('background-color','#FFFFFF');
		$('#network-operator-label').text('联网方式');
		mode = 1;
	}
	
	if(i == 2){//运营商
		$('#search-select-id-1').css('color','#333333');
		$('#search-select-id-1').css('font-weight','normal');
		$('#search-select-id-1').css('background-color','#DDDDDD');

		$('#search-select-id-2').css('color','#3EC7F5');
		$('#search-select-id-2').css('font-weight','bold');
		$('#search-select-id-2').css('background-color','#FFFFFF');
		$('#network-operator-label').text('运营商');
		mode = 2;
	}
	
	if(i == 3){//新增用户
		$('#search-select-id-4').css('color','#333333');
		$('#search-select-id-4').css('font-weight','normal');
		$('#search-select-id-4').css('background-color','#DDDDDD');

		$('#search-select-id-3').css('color','#3EC7F5');
		$('#search-select-id-3').css('font-weight','bold');
		$('#search-select-id-3').css('background-color','#FFFFFF');
		index = 1;
	}
	
	if(i == 4){//启动次数
		$('#search-select-id-3').css('color','#333333');
		$('#search-select-id-3').css('font-weight','normal');
		$('#search-select-id-3').css('background-color','#DDDDDD');

		$('#search-select-id-4').css('color','#3EC7F5');
		$('#search-select-id-4').css('font-weight','bold');
		$('#search-select-id-4').css('background-color','#FFFFFF');
		index = 2;
	}
}

function operatorInit(){
	operatorTableInit = 1;
	$('#operator-table').bootstrapTable({
		url : basePath+'/terminal/listDetailData', //请求后台的URL（*）
		method : 'post', //请求方式（*）
		contentType : "application/x-www-form-urlencoded",
		striped : true, //是否显示行间隔色
		cache : false, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
		pagination : true, //是否显示分页（*）
		sortable : false, //是否启用排序
		sortOrder : "asc", //排序方式
		sidePagination : "server", //分页方式：client客户端分页，server服务端分页（*）
		pageNumber : 1, //初始化加载第一页，默认第一页
		pageSize : 10, //每页的记录行数（*）
		pageList : [ 10, 20], //可供选择的每页的行数（*）
		search : false, //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
		strictSearch : false, //设置为 true启用 全匹配搜索，否则为模糊搜索
		showColumns : false, //是否显示所有的列
		showRefresh : false, //是否显示刷新按钮
		searchOnEnterKey : true, //是否按回车显示搜索结果，否则自动搜索
		minimumCountColumns : 2, //最少允许的列数
		clickToSelect : true, //是否启用点击选中行
		showToggle : false, //是否显示详细视图和列表视图的切换按钮
		cardView : false, //是否显示详细视图
		detailView : false, //是否显示父子表
		queryParams : function(params) {//自定义参数，这里的参数是传给后台的，我这是是分页用的  
			var param = myPage(params);
			param.appsId = appId;
			param.startTime = $('#search-start-date').val();
			param.endTime = $('#search-end-date').val();
			param.dataType = 4;
			return param;
		},
		columns : [
				{
					field : 'name',
					title : '运营商',
					align : 'center'
				}, {
					field : 'newUsersNum',
					title : '新增用户',
					align : 'center'
				},
				{
					field : 'newUsersRate',
					title : '新增占比',
					align : 'center',
					formatter : function(value, row,index) {//自定义显示可以写标签哦~  
						return ''+ value+'%';
					}
				}, {
					field : 'startNum',
					title : '启动次数',
					align : 'center'
				} , {
					field : 'startRate',
					title : '启动占比',
					align : 'center',
					formatter : function(value, row,index) {//自定义显示可以写标签哦~  
						return ''+ value+'%';
					}
				}   
		]
	});
	$('#operator-table').on('load-success.bs.table',function (e, data) {
		loadChart(data.rows,mode,index);
	})
}

function networkInit(){
	networkTableInit = 1;
	$('#network-table').bootstrapTable({
				url : basePath+'/terminal/listDetailData', //请求后台的URL（*）
				method : 'post', //请求方式（*）
				contentType : "application/x-www-form-urlencoded",
				striped : true, //是否显示行间隔色
				cache : false, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
				pagination : true, //是否显示分页（*）
				sortable : false, //是否启用排序
				sortOrder : "asc", //排序方式
				sidePagination : "server", //分页方式：client客户端分页，server服务端分页（*）
				pageNumber : 1, //初始化加载第一页，默认第一页
				pageSize : 10, //每页的记录行数（*）
				pageList : [ 10, 20], //可供选择的每页的行数（*）
				search : false, //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
				strictSearch : false, //设置为 true启用 全匹配搜索，否则为模糊搜索
				showColumns : false, //是否显示所有的列
				showRefresh : false, //是否显示刷新按钮
				searchOnEnterKey : true, //是否按回车显示搜索结果，否则自动搜索
				minimumCountColumns : 2, //最少允许的列数
				clickToSelect : true, //是否启用点击选中行
				showToggle : false, //是否显示详细视图和列表视图的切换按钮
				cardView : false, //是否显示详细视图
				detailView : false, //是否显示父子表
				queryParams : function(params) {//自定义参数，这里的参数是传给后台的，我这是是分页用的  
					var param = myPage(params);
					param.appsId = appId;
					param.startTime = $('#search-start-date').val();
					param.endTime = $('#search-end-date').val();
					param.dataType = 3;
					return param;
				},
				columns : [
						{
							field : 'name',
							title : '联网方式',
							align : 'center'
						}, {
							field : 'newUsersNum',
							title : '新增用户',
							align : 'center'
						},
						{
							field : 'newUsersRate',
							title : '新增占比',
							align : 'center',
							formatter : function(value, row,index) {//自定义显示可以写标签哦~  
								return ''+ value+'%';
							}
						}, {
							field : 'startNum',
							title : '启动次数',
							align : 'center'
						} , {
							field : 'startRate',
							title : '启动占比',
							align : 'center',
							formatter : function(value, row,index) {//自定义显示可以写标签哦~  
								return ''+ value+'%';
							}
						}   
				]
	});
	$('#network-table').on('load-success.bs.table',function (e, data) {
		loadChart(data.rows,mode,index);
    })
    
}


function loadChart(resultData,modeParam,indexParam){
	var legendData = new Array();
	var length = resultData.length;
	var seriesData = [];
	if(length>0){
		for(var i=0;i<length;i++){
			legendData[i] = resultData[i].name;
			if(indexParam == 1){//取新增用户
				seriesData[i] = resultData[i].newUsersNum;
			}else{//取启动次数
				seriesData[i] = resultData[i].startNum;
			}
		}
	}
	var startTime = $('#search-start-date').val();
	var endTime = $('#search-end-date').val();
	var name;
	var suffix;
	if(index == 1){
		suffix = '新增用户量';
	}else{
		suffix = '启动次数';
	}
	if(startTime == endTime){
		name = startTime+suffix;
	}else{
		name = startTime+'至'+endTime+suffix;
	}
	
	var option = getOption('',name,legendData, seriesData);
	myChart.setOption(option);
	window.onresize = myChart.resize;
}