<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="/WEB-INF/jsp/common/common.jsp"%>
<script type="text/javascript" src="${basePath}/static/js/app/common-app.js"></script>
<style type="text/css">
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
            <div class="panel-heading">应用管理</div>
            <div class="panel-body">
                <div id="toolbar">
                    <a href="#" id="addBtn" class="btn btn-primary" role="button">
                        <i class="glyphicon glyphicon-plus"></i>添加
                    </a>
                    <a href="#" id="delBtn" class="btn btn-primary" role="button">
                        <i class="glyphicon glyphicon-trash"></i>删除
                    </a>
                    
                     <a href="#" id="searchBtn" class="btn btn-primary" role="button" style="margin-top: 6px;float:right;height:30px">
                        <i class="glyphicon glyphicon-zoom-in"></i>搜索
                    </a>
                    <input type="text" id="searchText" placeholder="请输入内容" style="margin-top: 6px;margin-right:10px;float:right;height:30px"/>
                </div>
                <table id="table"
                       data-toolbar="#toolbar"
                        >
                </table>
            </div>
        </div>
    </div>
    
    <%@include file="/WEB-INF/jsp/common/footer.jsp"%>
  </div>
  
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
   aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"
               aria-hidden="true">×
            </button>
            <h4 class="modal-title" id="myModalLabel">
                                          
            </h4>
         </div>
         <div class="modal-body">
          <form id="addAppForm" method="post" enctype="multipart/form-data">
             <input type="hidden" name="id" id="id"/>
   			   <table border="0" width="100%" cellpadding="3" style="border-collapse:separate; border-spacing:0px 10px;">
   			  <tr>
   			     <td colspan="1">应用图标:</td>
      			<td colspan="2"><input type="file" name="appImage" id="appImage" onchange="showSelectImage(this)" style="display:none" /><img id="showImage" src="${basePath}/static/image/add.png" style="width:100px;height:100px" onclick="openBrowse('appImage')"/></td>
      		   </tr> 
      		   <tr>
      		     <td colspan="1">应用名称</td>
      		     <td colspan="2"><input type="text" id="appName" name="appName" style="width: 150px;"/></td>
      		   </tr>
      		    <tr>
      		     <td rowspan="3" colspan="1">应用类型</td>
      		     <td rowspan="3" colspan="2">
      		       <input type="radio" id="H5Type" name="appType" value="1" onclick="showAppTypeDiv(1)"/>H5&nbsp&nbsp<input type="text" id="h5Url" name="h5DownloadUrl" style="width:200px;" placeholder="请输入H5下载地址"></br>
      		       <input type="radio"  id="APPType" name="appType" value="2" onclick="showAppTypeDiv(2)"/>APP<input type="text" id="androidUrl" name="androidDownloadUrl" style="width:200px;" placeholder="请输入android下载地址"></br>
      		       &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="text" id="iosUrl" name="iosDownloadUrl" style="width:200px;" placeholder="请输入IOS下载地址">
      		     </td>
      		   </tr>
               </table>
           </form>
   		 <div style="width:100%;text-align:right" >
   		  <button type="button" id="submitAddAPP" class="btn btn-primary"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span>提交</button><button type="button" class="btn btn-primary" data-dismiss="modal" ><span class="glyphicon glyphicon-remove" aria-hidden="true"></span> 关闭</button>
		 </div>
		
         </div>
      </div>
   </div>
</div>

<script type="text/javascript">
   
     //上一次查询框中的内容
     var lastSearch = null;
     //上一次选择的类型
     var lastAppType = null;
     var cache = new HashMap();
     cache.put("nice",1);
     cache.put("good",2);
     console.log(cache.get("good"));
 
	  var $table = $('#table');
		$table.bootstrapTable({  
	        url: '${basePath}/app/listApps.do',  
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
	        idField:"idStr",//指定主键列  
	        columns:[
	        	{
	        	  checkbox:true
	        	},
	            {
	                title: '#',//表的列名  
	                field: 'id',//json数据中rows数组中的属性名  
	                align: 'center'//水平居中 
	            },
	            {
	                title: '应用图标',
	                field: 'appImageUrl',
	                align: 'center',
	                formatter: function (value, row, index) {//自定义显示可以写标签哦~  
	                    return '<img src="${basePath}/system/showAppImage.do?path='+value+'" style="wdith:50px;height:50px"/>';  
	                } 
	            },  
	            {
	                title: '应用名称',  
	                field: 'appName',  
	                align: 'center'
	            },  
	            {
	                title: '类型&nbsp&nbsp<select class="selectpicker" id="appTypeSelect" onchange="reloadData()"><option value="" selected="selected">全部</option><option value="1" >H5</option><option value="2">APP</option></select>',  
	                field: 'appType',  
	                align: 'center',
	                formatter:function(value,row,index){
	                	if(value==null){
	                		return '空';
	                	}else if(value==1){
	                		return 'H5';
	                	}else if(value==2){
	                		return 'APP'
	                	}
	                }
	            },
	            {
	                title: 'APPID',
	                field: 'appId',
	                align: 'center'
	            },
	            {
	                title: '秘钥',
	                field: 'secret',
	                align: 'center'
	            },
	            {
	                title: 'SDK下载',
	                field: 'appType',
	                align: 'center',
	                formatter: function (value, row, index) {
	                	if(value==null)
	                		return "空"
	                    if(value==1){
	                	return '<img src="${basePath}/static/image/h5.png" style="width:25px;height:25px" onclick="openNewBrower(\''+row.h5DownloadUrl+'\')"></img> ';
	                    }else if(value==2){
	                        if(row.androidDownloadUrl!=null&&row.androidDownloadUrl!=""&&row.iosDownloadUrl!=null&&row.iosDownloadUrl!=""){
	                    	    return '<img src="${basePath}/static/image/android.png" style="width:25px;height:25px" onclick="openNewBrower(\''+row.androidDownloadUrl+'\')"></img>&nbsp&nbsp<img src="${basePath}/static/image/iOS.png" style="width:25px;height:25px" onclick="openNewBrower(\''+row.iosDownloadUrl+'\')"></img> ';
                            }else if(row.androidDownloadUrl!=null&&row.androidDownloadUrl!=""&&(row.iosDownloadUrl==null||row.iosDownloadUrl=="")){
                                return '<img src="${basePath}/static/image/android.png" style="width:25px;height:25px" onclick="openNewBrower(\''+row.androidDownloadUrl+'\')"></img> ';
                            }else if(row.iosDownloadUrl!=null&&row.iosDownloadUrl!=""&&(row.androidDownloadUrl==null||row.androidDownloadUrl=="")){
                                return '<img src="${basePath}/static/image/iOS.png" style="width:25px;height:25px" onclick="openNewBrower(\''+row.iosDownloadUrl+'\')"></img> ';
                            }
	                    }
	                	
	                }  
	            },
	            {
	                title: '通知',
	                field: 'id',
	                align: 'center',
	                formatter: function (value, row, index) {//自定义显示，这三个参数分别是：value该行的属性，row该行记录，index该行下标  
	                    return '<a href="${basePath}/app/gotoNotifactionPage.do?appsId='+value+'" >查看</a>';
	                }
	            },
	            {
	                title: '管理',
	                field: 'id',
	                align: 'center',
	                formatter: function (value, row, index) {//自定义显示，这三个参数分别是：value该行的属性，row该行记录，index该行下标  
	                    return '<a href="${basePath}/payDay/gotoPage.do?appId='+value+'" >数据</a> <a href="${basePath}/app/gotoAppChannelList.do?appsId='+value+'" >渠道</a> <a href="#" onclick="editApp(\''+value+'\',\''+row.appName+'\',\''+row.appImageUrl+'\','+row.appType+',\''+row.h5DownloadUrl+'\',\''+row.androidDownloadUrl+'\',\''+row.iosDownloadUrl+'\')">修改</a> <a href="#" onclick="deleteApp(\''+value+'\')">删除</a>';  
	                }
	            }
	        ]
	    });
		
		//隐藏id列
		$table.bootstrapTable('hideColumn', 'id');
		
	//显示所有被选着的数据row数组
	function showSelect(){
		var a= $table.bootstrapTable('getSelections');
		return a;
	}
	
	
	//打开新的浏览器
	function openNewBrower(url){
		if(url==null||url==""){
			layer.msg("目前没提供下载地址");
			return;
		}
		var newwindow = window.open(url);
	}
	
	//显示输入框
	function showAppTypeDiv(type){
		if(type==1){
			$("#h5Url").css("visibility","visible");
			$("#androidUrl").css("visibility","hidden");
			$("#iosUrl").css("visibility","hidden");
		}else if(type==2){
			$("#h5Url").css("visibility","hidden");
			$("#androidUrl").css("visibility","visible");
			$("#iosUrl").css("visibility","visible");
		}
	}
	
	//编辑APP
	function editApp(id,appName,imageUrl,appType,h5DownloadUrl,androidDownloadUrl,iosDownloadUrl){
		clearAddView();
		$("#id").val(id);
		$("#myModalLabel").text("编辑应用");
		$("#appName").val(appName);
		$("#showImage").attr("src","${basePath}/system/showAppImage.do?path="+imageUrl);
		if(appType==1){
			$("#H5Type").prop("checked",true);
			$("#APPType").prop("checked",false);
			$("#h5Url").val(h5DownloadUrl)
			$("#h5Url").css("visibility","visible");
			$("#androidUrl").val("");
			$("#iosUrl").val("");
			$("#androidUrl").css("visibility","hidden");
			$("#iosUrl").css("visibility","hidden");
		}else if(appType==2){
			$("#H5Type").prop("checked",false);
			$("#APPType").prop("checked",true);
			$("#androidUrl").val(androidDownloadUrl);
			$("#iosUrl").val(iosDownloadUrl);
			$("#androidUrl").css("visibility","visible");
			$("#iosUrl").css("visibility","visible");
			$("#h5Url").val("");
			$("#h5Url").css("visibility","hidden");
		}
		$('#myModal').modal({keyboard: true,backdrop:'static'})
	}
	
	//添加app
	$("#addBtn").click(function(){
		$("#myModalLabel").text("添加应用");
		clearAddView();
		$('#myModal').modal({
			keyboard: true,
			backdrop:'static'
		});
	});
	
	//清空添加应用
	function clearAddView(){
		$("#id").val("");
		$("#appName").val("");
		$("#APPType").removeAttr("checked");
		$("#H5Type").removeAttr("checked");
		$("#androidUrl").val("");
		$("#iosUrl").val("");
		$("#h5Url").val("");
		$("#h5Url").css("visibility","hidden")
		$("#androidUrl").css("visibility","hidden")
		$("#iosUrl").css("visibility","hidden");
		$("#showImage").attr("src","${basePath}/static/image/add.png");
	}
	
	//关闭模态框
	function closeAddView(){
		$('#myModal').modal('hide');
	}
	
    //删除app
	function deleteApp(id){
	layer.confirm("删除后将无法撤销，确定执行操作吗?",function(){
		$.post("${basePath}/app/deleteApp.do",{"id":id},function(result){
			if(result.code==200){
				layer.msg(result.msg);
				$table.bootstrapTable("refresh");//重新加载数据
			}else{
				layer.msg("错误！"+result.msg);
			}
		});
	  });
	}
	
    //回显图片
	function showSelectImage(file){
		previewImage(file,"showImage");
	}
	
	var addAPPFunction = function(){
		if(!checkAddParams()){
			return;
		}
		
		$("#submitAddAPP").unbind("click");
		//请求后台数据
		var appData={    
	            url:'${basePath}/app/modifyApp.do',
	            type:'POST',
	            dataType : 'json',
	            success:function(result){
	            	$("#submitAddAPP").bind("click",addAPPFunction);
	            	if(result.code==200){
	            		closeAddView();
	            		$table.bootstrapTable('refresh');
	            	}else{
	            		layer.msg("错误!"+result.msg)
	            	}
	            },
	            error:function(result){
	            	$("#submitAddAPP").bind("click",addAPPFunction);
	            }
	        }; 
	
		
	$("#addAppForm").ajaxSubmit(appData);
	}
	
	function checkIsNull(id,msg){
		var value = $("#"+id).val();
		if(isEmpty(value)){
			layer.msg(msg)
			return true;
		}
		return false;
	}
	
	//检查上传app的参数
	function checkAddParams(){
		
		//判断APP上传图片与否
		if(($("#appImage").val()==null||$("#appImage").val()=="")&&$("#showImage").attr("src").indexOf("add.png")>0)
			return false;
		if(($("#appImage").val()==null||$("#appImage").val()=="")&&$("#showImage").attr("src").indexOf("add.png")<0){
			    $('#appImage').removeAttr("name");
		}
		
		if($("#appImage").val()!=null&&$("#appImage").val()!=""){
			$("#appImage").attr("name","appImage");
		}
		
		
		if(checkIsNull("appName","请输入APP名称!"))
			return false;
		
		
	    if($("#H5Type").is(':checked')){
			if(checkIsNull("h5Url","请输入H5下载地址!")){
				$("#submitAddAPP").bind("click",addAPPFunction);
				return false;
			}
			
		}else if($("#APPType").is(':checked')){
			if(isInputTextNullById("iosUrl")&&isInputTextNullById("androidUrl")){
				layer.msg("请输入APP下载地址");
				return false;
			}
		}else{
			layer.msg("请选择SDK类型及输入下载地址");
			$("#submitAddAPP").bind("click",addAPPFunction);
			return false;
		}
		
		return true;
	}
	
	function isInputTextNullById(id){
		var value = $("#"+id).val();
		if(value==null||value=="")
			return true;
	}
	
	$("#submitAddAPP").bind("click",addAPPFunction);
	
	//批量删除
	$("#delBtn").bind("click",function(){
		var tempData = showSelect();
		if(tempData.length==0){
			layer.msg("请选择数据");
			return;
		}
		
	    layer.confirm("是否确定要删除勾选数据吗?",function(){
	    	var ids = new Array();
			$.each(tempData,function(i,value){
				 ids.push(value.id);
			});
			
			$.ajax({
	               url:"${basePath}/app/batchDeleteApps.do",
	               dataType:'json',
	               type:"post",
	               traditional:true,
	               data:{
	            	   "ids":ids       
	               },
	            success:function(result){
	            	if(result.code==200){
	            		layer.msg(result.msg);
	    				$table.bootstrapTable("refresh");//重新加载数据
	    			}else{
	    				layer.msg("错误！"+result.msg);
	    			}
	            }
	         });
	    });
		
	});
	
	
	//批量启动
	$("#openBtn").bind("click",function(){
		var tempData = showSelect();
		if(tempData.length==0){
			layer.msg("请选择数据");
			return;
		}
		layer.confirm("确定启动下面数据吗?",function(){
			var ids = new Array();
			$.each(tempData,function(i,value){
				 ids.push(value.id);
			});
			
			$.ajax({
	               url:"${basePath}/app/batchStartApps.do",
	               dataType:'json',
	               type:"post",
	               traditional:true,
	               data:{
	            	   "ids":ids       
	               },
	            success:function(result){
	            	if(result.code==200){
	            		layer.msg(result.msg);
	    				$table.bootstrapTable("refresh");//重新加载数据
	    			}else{
	    				layer.msg("错误！"+result.msg);
	    			}
	            }
	         });
		});
	});
	
	
	//批量停止
	$("#stopBtn").bind("click",function(){
		var tempData = showSelect();
		if(tempData.length==0){
			layer.msg("请选择数据");
			return;
		}
		layer.confirm("确定停止下面数据吗?",function(){
			var ids = new Array();
			$.each(tempData,function(i,value){
				 ids.push(value.id);
			});
			
			$.ajax({
	               url:"${basePath}/app/batchStopApps.do",
	               dataType:'json',
	               type:"post",
	               traditional:true,
	               data:{
	            	   "ids":ids       
	               },
	            success:function(result){
	            	if(result.code==200){
	            		layer.msg(result.msg);
	    				$table.bootstrapTable("refresh");//重新加载数据
	    			}else{
	    				layer.msg("错误！"+result.msg);
	    			}
	            }
	         });
		});
	});
  
	function reloadData(){
		var searchWorld = $("#searchText").val();
		var statusText = $("#appTypeSelect").val();
		
		$('#table').bootstrapTable('refresh',{
			url:'${basePath}/app/listApps.do',
			query:{
				search:searchWorld,
				appType:statusText,
			}
	    });
	}
	
	$("#searchBtn").bind("click",reloadData);
  
  </script> 
  

</body>
</html>