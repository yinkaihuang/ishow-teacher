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

		$('#channel-report-search-btn').bind('click',tableRefresh);
		$('#channel-report-search-txt').keydown(enterEvent);
		tableInit();
		myChart = echarts.init(document.getElementById('canvasDiv'));
});


function tableRefresh(){
	$('#table').bootstrapTable('refresh', {
		url : basePath+'/channelReport/listChannelReport',
		query : {
			appId : appId,
			search : $('#channel-report-search-txt').val(),
			startDate: $('#search-start-date').val(),
			endDate: $('#search-end-date').val()
		}
	});
}

function enterEvent(event) {
	if (event.keyCode == 13) {
		$('#channel-report-search-btn').click();
	}
}

function getOption(title,legendData,xAxisData,scanData,downloadData,registerData,loginData){
	var option = {
		    title : {
		        text: title
		    },
		    tooltip : {
		        trigger: 'item',
		        showDelay:20
		    },
		    legend: {
		    	orient:'horizontal',
		    	y:'bottom',
		        data:legendData
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
		            type : 'category',
		            data : xAxisData
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value'
		        }
		    ],
		    series : [
		        {
		            name:'浏览',
		            type:'bar',
		            barMaxWidth:50,
		            data:scanData
		        },
		        {
		            name:'下载',
		            type:'bar',
		            barMaxWidth:50,
		            data:downloadData
		        },
		        {
		            name:'注册',
		            type:'bar',
		            barMaxWidth:50,
		            data:registerData
		        },
		        {
		            name:'登录',
		            type:'bar',
		            barMaxWidth:50,
		            data:loginData
		        }
		    ]
		};
	return option;
}


function tableInit(){
	$('#table').bootstrapTable({
				url : basePath+'/channelReport/listChannelReport', //请求后台的URL（*）
				method : 'post', //请求方式（*）
				contentType : "application/x-www-form-urlencoded",
				striped : true, //是否显示行间隔色
				cache : false, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
				pagination : true, //是否显示分页（*）
				sortable : false, //是否启用排序
				sortOrder : "asc", //排序方式
				sidePagination : "server", //分页方式：client客户端分页，server服务端分页（*）
				pageNumber : 1, //初始化加载第一页，默认第一页
				pageSize : 20, //每页的记录行数（*）
				pageList : [ 10, 20, 50, 100 ], //可供选择的每页的行数（*）
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
					param.appId = appId;
					param.startDate = $('#search-start-date').val();
					param.endDate = $('#search-end-date').val();
					return param;
				},
				columns : [
						{
							field : 'channelName',
							title : '渠道名称',
							align : 'center'
						}, {
							field : 'date',
							title : '结算日期',
							align : 'center',
							formatter:function(value, row,index){
								var str = value.split(" ");
								console.log(str);
								return str[0];
							}
						},
						{
							field : 'addUserCount',
							title : '新增用户',
							align : 'center'
						}, {
							field : 'activeUserCount',
							title : '活跃用户',
							align : 'center'
						} , {
							field : 'payUserCount',
							title : '付费用户',
							align : 'center'
						} , {
							field : 'paySum',
							title : '付费金额',
							align : 'center'
						} , {
							field : 'arpu',
							title : 'ARPU（元）',
							align : 'center'
						} , {
							field : 'arppu',
							title : 'ARPPU（元）',
							align : 'center'
						},{
							field : 'payConverseRate',
							title : '付费转化率',
							align : 'center',
							formatter : function(value, row,index) {//自定义显示可以写标签哦~  
								return ''+ value+'%';
							}
						},{
							field : 'morrowStayRate',
							title : '次日留存率',
							align : 'center',
							formatter : function(value, row,index) {//自定义显示可以写标签哦~  
								return ''+ value+'%';
							}
						},{
							field : 'sevendayStayRate',
							title : '7日留存率',
							align : 'center',
							formatter : function(value, row,index) {//自定义显示可以写标签哦~  
								return ''+ value+'%';
							}
						},{
							field : 'thirtydayStayRate',
							title : '30日留存率',
							align : 'center',
							formatter : function(value, row,index) {//自定义显示可以写标签哦~  
								return ''+ value+'%';
							}
						} 
//						,{
//							field : 'totalUserRatio',
//							title : '累计用户占比',
//							align : 'center',
//							formatter : function(value, row,index) {//自定义显示可以写标签哦~  
//								return ''+ value+'%';
//							}
//						} ,{
//							field : 'channelRatio',
//							title : '渠道占比',
//							align : 'center',
//							formatter : function(value, row,index) {//自定义显示可以写标签哦~  
//								return ''+ value+'%';
//							}
//						} ,{
//							field : 'guideRatio',
//							title : '引流占比',
//							align : 'center',
//							formatter : function(value, row,index) {//自定义显示可以写标签哦~  
//								return ''+ value+'%';
//							}
//						}   
				]
	});
	$('#table').on('load-success.bs.table',function (e, data) {
		var legendData = new Array('浏览','下载','注册','登录');
		var xAxisData = new Array();
		var scanData = new Array();
		var downloadData = new Array();
		var registerData = new Array();
		var loginData = new Array();
		var resultData = data.rows
		var length = data.rows.length;
		if(length>0){
			for(var i=0;i<length;i++){
				xAxisData[i] = resultData[i].channelName;
				scanData[i] = resultData[i].scanCount;
				downloadData[i] = resultData[i].downloadCount;
				registerData[i] = resultData[i].registerCount;
				loginData[i] = resultData[i].loginCount;
			}
		}
		var option = getOption('',legendData,xAxisData,scanData,downloadData,registerData,loginData);
		myChart.setOption(option);
		window.onresize = myChart.resize;
    })
}





