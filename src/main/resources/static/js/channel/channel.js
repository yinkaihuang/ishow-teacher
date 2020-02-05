$(function(){
		var oTable = new tableInit();
		oTable.Init();
		$('#refresh-btn').click(tableRefresh);
		$('#search-text').keydown(enterEvent);
		$('#del-btn').click(batchDelete);
	});
	
	
	var batchDelete = function(){
		var deleteData = showSelect();
		if(deleteData.length == 0){
			layer.msg("请选择要删除的记录！");
			return;
		}
		var ids = new Array();
		$.each(deleteData,function(i,value){
			 ids.push(value.id);
		});
		layer.confirm('确定要删除选中的记录吗？',{
			btn:['确定','取消']
		},function(){
			batchDeleteExe(ids);
		},function(){
			
		});	
	}
	
	var batchDeleteExe = function(ids){
		$.ajax({
            url:basePath+"/channel/deleteChannel",
            dataType:'json',
            type:"post",
            traditional:true,
            data:{
         	   "ids":ids       
            },
         	success:function(result){
         	if(result.code==200){
         		tableRefresh();
         		layer.msg("操作成功！",{icon:1});
 			}else{
 				layer.msg("操作失败，原因："+result.msg,{icon:2});
 			}
         }
      	});
	}
	
	var resetCode = function(uniqueId){
		layer.confirm('确定要重置密码吗？',{
			btn:['确定','取消']
		},function(){
			resetCodeExe(uniqueId);
		},function(){
			
		});	
	}
	
	var resetCodeExe = function(uniqueId){
		var select = $('#table').bootstrapTable('getRowByUniqueId', uniqueId);
		var id = select['id'];
		$.ajax({
			url:basePath+"/channel/resetPassword",
            dataType:'json',
            type:"post",
            traditional:true,
            data:{
         	   "id":id       
            },
         	success:function(result){
	         	if(result.code==200){
	         		layer.msg("操作成功！",{icon:1});
	 			}else{
	 				layer.msg("操作失败，失败原因："+result.msg,{icon:2});
	 			}
         	}
		});
	}
	
	
	var delRow = function(id){
		layer.confirm('确定删除该渠道商吗？', {
			btn : [ '确定', '取消' ]
		}, function() {
			delRowExe(id);
		}, function() {
			
		});
	}
	
	var delRowExe = function(id){
		var select = $('#table').bootstrapTable('getRowByUniqueId', id);
		var channelId = select['id'];
		$.ajax({
            url:basePath+"/channel/deleteChannel",
            dataType:'json',
            type:"post",
            traditional:true,
            data:{
         	   "ids":channelId       
            },
         	success:function(result){
	         	if(result.code==200){
	         		tableRefresh();
	         		layer.msg("操作成功！",{icon:1});
	 			}else{
	 				layer.msg("操作失败，原因："+result.msg,{icon:2});
	 			}
         	}
      	});
	}

	function showSelect(){
		var a= $('#table').bootstrapTable('getSelections');
		return a;
	}
	
	var enterEvent = function(event){
		if(event.keyCode == 13){
			$('#refresh-btn').click();
		}
	}
    
    var tableRefresh = function(){
		$('#table').bootstrapTable('refresh',{
			url:basePath+'/channel/listChannel',
			query:{
				search:$('#search-text').val()
			}
		});
    }
    
	var tableInit = function(){
		var oTableInit = new Object();
		oTableInit.Init = function(){
			$('#table').bootstrapTable({
			 	url: basePath+'/channel/listChannel',         //请求后台的URL（*）
	            method: 'get',                      //请求方式（*）
	            toolbar: '#toolbar',                //工具按钮用哪个容器
	            striped: true,                      //是否显示行间隔色
	            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
	            pagination: true,                   //是否显示分页（*）
	            sortable: false,                     //是否启用排序
	            sortOrder: "asc",                   //排序方式
	            queryParams: oTableInit.queryParams,//传递参数（*）
	            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
	            pageNumber:1,                       //初始化加载第一页，默认第一页
	            pageSize: 10,                       //每页的记录行数（*）
	            pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
	            search: false,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
	            strictSearch: false,				//设置为 true启用 全匹配搜索，否则为模糊搜索
	            showColumns: false,                  //是否显示所有的列
	            showRefresh: false,                  //是否显示刷新按钮
	            searchOnEnterKey:true,				//是否按回车显示搜索结果，否则自动搜索
	            minimumCountColumns: 2,             //最少允许的列数
	            clickToSelect: true,                //是否启用点击选中行
	            uniqueId: "id",                     //每一行的唯一标识，一般为主键列
	            showToggle:false,                    //是否显示详细视图和列表视图的切换按钮
	            cardView: false,                    //是否显示详细视图
	            detailView: false,                   //是否显示父子表
	            columns: [
		            {
		                checkbox: true,
		                align: 'center'
		            }, 
		            {
		                field: 'name',
		                title: '渠道名称',
		                align: 'center'
		            }, 
		            {
		                field: 'url',
		                title: '渠道URL',
		                align: 'center'
		            }, 
		            {
		                field: 'accountNum',
		                title: '账号',
		                align: 'center'
		            }, 
		            {
		                field: 'appCount',
		                title: '应用数',
		                align: 'center'
		            },
		            {
		                field: 'settlePeriod',
		                title: '结算周期',
		                align: 'center',
		                formatter:function(value,row,index){
		                	return value+'天';
		                }
		            },
		            {
		                field: 'linkman',
		                title: '联系人',
		                align: 'center'
		            },
		            {
		                field: 'email',
		                title: '电子邮箱',
		                align: 'center'
		            },
		            {
		                field: 'id',
		                title: '操作',
		                align: 'center',
		                formatter:function(value,row,index){
		                	 return '<a href="javascript:void(0)" onclick="resetCode(\''+value+'\')	">重置密码</a> <a href="'+basePath+'/channelApp/agentOperate/'+value+'">分发管理</a> <a href="'+basePath+'/channel/edit/'+value+'">修改</a> <a href="javascript:void(0)" onclick="delRow(\''+value+'\')">删除</a>';  
		                }
		            }
	            ]
			});
		};
		
	    oTableInit.queryParams = function (params) {
	    	var param = myPage(params);
	        return param;
	    };
	    return oTableInit;
	};