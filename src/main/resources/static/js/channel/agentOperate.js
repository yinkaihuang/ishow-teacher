$(function(){
		$('#channelName-id').html("<div style='vertical-align:middle'><a href='"+basePath+"/channel/list.do'><i  class='glyphicon glyphicon-circle-arrow-left' ></i>返回渠道列表</a><label style='top:0px;line-height:14px;position:relative;margin-bottom:0px'>&nbsp;|&nbsp;</label>"+channelName+"</div>");
		var oTable = new tableInit();
		oTable.Init();
		$('#add-btn').bind('click',openAgent);
		$('#refresh-btn').click(tableRefresh);
		$('#search-text').keydown(enterEvent);
		
		$('#del-btn').click(batchDelete);
		$('#stop-btn').bind('click',stopAgent);
		$('#start-btn').bind('click',startAgent);
	});
	
	
	function openAgent(){
		$('#addAgentModal').modal({
			keyboard: true,
			backdrop:"static"
		});
		$('#app-refresh-btn').click();
	}
	
	function stopAgent(){
		if(!checkStatusValid(0)){
			return;
		}
		var ids = getSelectAppId();
		if(ids.length == 0){
			layer.msg("请选择待停用的记录！");
			return;
		}
		$.ajax({
            url:basePath+"/channelApp/stopAgent",
            dataType:'json',
            type:"post",
            traditional:true,
            data:{
            	appIds:ids,
            	channelId:id
            },
         	success:function(result){
             	if(result.code==200){
             		tableRefresh();
	         		layer.msg("操作成功！",{icon:1});
	 			}else{
	 				layer.msg("操作失败,原因："+result.msg,{icon:2});
	 			}
         	}
      	});
	}
	
	function checkStatusValid(status){
		var selection = showChannelAppSelect();
		if(selection.length == 0){
			if(status == 1){
				layer.msg("请选择待启用的记录！");
			}else{
				layer.msg("请选择待停用的记录！");
			}
		}else{
			for(var i=0;i<selection.length;i++){
				if(selection[i].enableStatus != status){
					return true;
				}
			}
			if(status == 1){
				layer.msg("请选择待未启用的记录进行启用操作！");
			}else{
				layer.msg("请选择待未停用的记录进行停用操作！");
			}
		}
		return false;
	}

	
	function startAgent(){
		if(!checkStatusValid(1)){
			return;
		}
		var ids = getSelectAppId();
		if(ids.length == 0){
			layer.msg("请选择待启用的记录！");
			return;
		}
		$.ajax({
            url:basePath+"/channelApp/startAgent",
            dataType:'json',
            type:"post",
            traditional:true,
            data:{
            	appIds:ids,
            	channelId:id
            },
         	success:function(result){
            	if(result.code==200){
            		tableRefresh();
	         		layer.msg("操作成功！",{icon:1});
	 			}else{
	 				layer.msg("操作失败,原因："+result.msg,{icon:2});
	 			}
         	}
      	});
	}
	
	var batchDelete = function(){
		var ids = getSelectAppId();
		if(ids.length == 0){
			layer.msg("请选择待删除的记录！");
			return;
		}
		layer.confirm('确定删除选中的记录吗？', {
			btn : [ '确定', '取消' ]
		}, function() {
			batchDeleteExe(ids);
		}, function() {
			
		});
	}
	
	var batchDeleteExe = function(ids){
		$.ajax({
            url:basePath+"/channelApp/batchDeleteAppAgent",
            dataType:'json',
            type:"post",
            traditional:true,
            data:{
         	   "appIds":ids,
         	  	channelId:id
            },
         	success:function(result){
	         	if(result.code==200){
	         		tableRefresh();
	         		layer.msg("操作成功！",{icon:1});
	 			}else{
	 				layer.msg("操作失败,原因："+result.msg,{icon:2});
	 			}
         	}
      	});
	}
	var delRow = function(uniqueId){
		layer.confirm('确定删除当前记录吗？', {
			btn : [ '确定', '取消' ]
		}, function() {
			delRowExe(uniqueId);
		}, function() {
			
		});
	}
	
	var delRowExe = function(uniqueId){
		var select = $('#table').bootstrapTable('getRowByUniqueId', uniqueId);
		var appId = select['appId'];
		var channelId = select['channelId'];
		$.ajax({
			url : basePath+"/channelApp/batchDeleteAppAgent",
			dataType : 'json',
			type : "post",
			traditional : true,
			data : {
				"appIds" : appId,
				channelId : channelId
			},
			success : function(result) {
				if (result.code == 200) {
					tableRefresh();
					layer.msg("操作成功！",{icon:1});
				} else {
					layer.msg("操作失败，原因:" + result.msg,{icon:2});
				}
			}
		});

	}

	var editRow = function(uniqueId) {
		var select = $('#table').bootstrapTable('getRowByUniqueId', uniqueId);
		var appId = select['appId'];
		var channelId = select['channelId'];
		window.location.href=basePath+"/channelApp/editAgent/"+channelId+"/"+appId;
	}

	function showChannelAppSelect() {
		var a = $('#table').bootstrapTable('getSelections');
		return a;
	}

	function getSelectAppId() {
		var selectData = showChannelAppSelect();
		var ids = new Array();
		$.each(selectData, function(i, value) {
			ids.push(value.appId);
		});
		return ids;
	}

	function showSelect() {
		var a = $('#app-table').bootstrapTable('getSelections');
		return a;
	}

	var enterEvent = function(event) {
		if (event.keyCode == 13) {
			$('#refresh-btn').click();
		}
	}

	var tableRefresh = function() {
		$('#table').bootstrapTable('refresh', {
			url : basePath+'/channelApp/listAppsByChannel',
			query : {
				channelId : id,
				search : $('#search-text').val()
			}
		});
	}

	var tableInit = function() {
		var oTableInit = new Object();
		oTableInit.Init = function() {
			$('#table').bootstrapTable(
				{
					url : basePath+'/channelApp/listAppsByChannel?channelId='+id, //请求后台的URL（*）
					method : 'get', //请求方式（*）
					toolbar : '#toolbar', //工具按钮用哪个容器
					striped : true, //是否显示行间隔色
					cache : false, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
					pagination : true, //是否显示分页（*）
					sortable : false, //是否启用排序
					sortOrder : "asc", //排序方式
					queryParams : oTableInit.queryParams,//传递参数（*）
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
					uniqueId : "uniqueId",
					columns : [
							{
								checkbox : true,
								align : 'center'
							},
							{
								field : 'appImgUrl',
								title : '应用图标',
								align : 'center',
								width : '10%',
								formatter : function(value, row,
										index) {//自定义显示可以写标签哦~  
									return '<img src="'+basePath+'/system/showAppImage.do?path='
											+ value
											+ '" style="wdith:50px;height:50px"/>';
								}
							},
							{
								field : 'appName',
								title : '应用名称',
								align : 'center'
							},
							{
								field : 'appType',
								title : '类型',
								align : 'center',
								formatter : function(value, row,index) {//自定义显示可以写标签哦~  
									return sysDict.appTypeDict[value];
								}
							},
							{
								field : 'unitPrice',
								title : '单价',
								align : 'center'
							},
							{
								field : 'spreadType',
								title : '推广类型',
								align : 'center',
								formatter : function(value, row,index) {//自定义显示可以写标签哦~  
									return sysDict.agentTypeDict[value];
								}
							},
							{
								field : 'spreadUrl',
								title : '推广URL',
								align : 'center'
							},
							{
								field : 'callbackUrl',
								title : '回调地址',
								align : 'center'
							},
							{
								field : 'enableStatus',
								title : '状态',
								align : 'center',
								formatter : function(value, row,index) {//自定义显示可以写标签哦~  
									return sysDict.enableStatusDict[value];
								}
							},
							{
								field : 'uniqueId',
								title : '管理',
								align : 'center',
								formatter : function(value, row,
										index) {
									return '<a href="javascript:void(0)" onclick="editRow(\''
											+ value
											+ '\')">修改</a> <a href="javascript:void(0)" onclick="delRow(\''
											+ value + '\')">删除</a>';
								}

							} ]
				});
		};

		oTableInit.queryParams = function(params) {
			var param = myPage(params);
			param.channelId = id;
			return param;
		};
		return oTableInit;
	};

