$(function(){
		var appTable =new appTableInit();
		appTable.Init();
		$('#app-refresh-btn').bind('click',tableRefresh);
		$('#app-search-text').keydown(appEnterEvent);
		$('#app-agent-btn').bind('click',appAgent);
		$('#save-app-agent').bind('click',saveAppAgent);
});

var appEnterEvent = function(event) {
	if (event.keyCode == 13) {
		$('#app-refresh-btn').click();
	}
}

function tableRefresh() {
	$('#table').bootstrapTable('refresh', {
		url : basePath+'/channelApp/listAgentApps',
		query : {
			channelId : id,
			search : $('#app-search-text').val()
		}
	});
}

function appAgent(){
	var selection = showSelect();
	if(selection.length == 0){
		layer.msg("请选择应用投放！");
		return;
	}
	$('#appAgentSettingModal').modal({
		keyboard:true,
		backdrop:"static"
	});
	var agentDict = sysDict.agentTypeDict;
	$('#agent-type-sel').empty();
	$.each(agentDict,function(i,value){
		var code = i;
		var text = agentDict[i];
		var option = $("<option>").val(code).text(text);
		$('#agent-type-sel').append(option);
	});
}


function saveAppAgent(){
	var selection = showSelect();
	var ids = '';
	for(var i=0;i<selection.length;i++){
		if(i<selection.length-1){
			ids += selection[i].id+',';
		}else{
			ids += selection[i].id;
		}
	}
	
	if(!checkAddParams()){
		return;
	}
	$("#save-app-agent").unbind("click");
	var submitData={    //请求后台数据
            url:basePath+'/channelApp/saveChanelApp?channelId='+id+'&appId='+ids,
            resetForm: true, 
            type:'POST',
            dataType : 'json',
            beforeSubmit: function(){
            },
            success:function(result){
            	$("#save-app-agent").bind("click",saveAppAgent);
            	if(result.code==200){
                    layer.msg("操作成功！",{icon: 1});
                    tableRefresh();
            	}else{
            		layer.msg("操作失败，原因："+result.msg,{icon: 2})
            	}
            },
            error:function(result){
            	$("#save-app-agent").bind("click",saveAppAgent);
            }
    }; 
	$("#appAgentSaveForm").ajaxSubmit(submitData);
}

function checkAddParams(){//检查上传Channel的参数
	if($('#agent-type-sel').val() == ''){
		layer.msg("推广类型不能为空!");
		return false;
	}
	if($('#unit-price').val() == ''){
		layer.msg("单价不能为空!");
		return false;
	}
	var reg = /^([0]\.[0-9]{1,2}|[1-9][0-9]*\.?[0-9]{0,2})$/;
	if(!reg.test($('#unit-price').val())){
		layer.msg("单价必须录入数字类型！");
		return false;
	}
	if($('#callback-url').val() == ''){
		layer.msg("回调地址不能为空!");
		return false;
	}
	return true;
}

function showSelect() {
	var a = $('#table').bootstrapTable('getSelections');
	return a;
}

var appTableInit = function() {
		var oTableInit = new Object();
		oTableInit.Init = function() {
			$('#table').bootstrapTable(
				{
					url : basePath+'/channelApp/listAgentApps', //请求后台的URL（*）
					method : 'post', //请求方式（*）
					contentType : "application/x-www-form-urlencoded",
					toolbar : '#app-toolbar', //工具按钮用哪个容器
					striped : true, //是否显示行间隔色
					cache : false, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
					pagination : true, //是否显示分页（*）
					sortable : false, //是否启用排序
					sortOrder : "asc", //排序方式
					sidePagination : "server", //分页方式：client客户端分页，server服务端分页（*）
					pageNumber : 1, //初始化加载第一页，默认第一页
					pageSize : 10, //每页的记录行数（*）
					pageList : [ 10, 25, 50, 100 ], //可供选择的每页的行数（*）
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
						param.channelId = id;
						return param;
					},
					columns : [
							{
								checkbox : true,
								align : 'center'
							},
							{
								field : 'appImageUrl',
								title : '应用图标',
								align : 'center',
								width : '20%',
								formatter : function(value, row,
										index) {//自定义显示可以写标签哦~  
									return '<img src='+basePath+'"/system/showAppImage.do?path='
											+ value
											+ '" style="wdith:50px;height:50px"/>';
								}
							}, {
								field : 'appName',
								title : '应用名称',
								align : 'center'
							}, {
								field : 'appTypeName',
								title : '类型',
								align : 'center'
							} ]
				});
		};
		return oTableInit;
	}