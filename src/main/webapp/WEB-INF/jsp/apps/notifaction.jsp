<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="/WEB-INF/jsp/common/common.jsp"%>
<script type="text/javascript" src="${basePath}/static/js/app/common-app.js"></script>
</head>

<body class="page-container-bg-solid">
	<div class="page-wrapper">
    <%@include file="/WEB-INF/jsp/common/head.jsp" %>
    <div class="page-wrapper-row full-height">
        <div class="panel panel-default">
            <div class="panel-heading"><a href="#" id="rebackApp">
                        <i class="glyphicon glyphicon-share-alt"></i>返回应用管理
                     </a>| 通知</div>
            <div class="panel-body">
                <div id="toolbar">
                    <a href="#" id="delBtn" class="btn btn-primary" role="button">
                        <i class="glyphicon glyphicon-trash"></i>删除
                    </a> 
                </div>
                <table id="table" data-toolbar="#toolbar">
                </table>
            </div>
        </div>
    </div>
    
    <%@include file="/WEB-INF/jsp/common/footer.jsp"%>
  </div>
  <script type="text/javascript">
  var $table = $('#table');
	$table.bootstrapTable({  
      url: '${basePath}/app/listNotifications.do?appsId=${appsId}',  
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
      	  checkbox:true
      	},
          {
              title: '#',//表的列名  
              field: 'id',//json数据中rows数组中的属性名  
              align: 'center'//水平居中 
          },
          {
              title: '通知内容',
              field: 'content',
              align: 'center'
          },  
          {
              title: '设备ID',  
              field: 'deviceId',  
              align: 'center'  
          },  
          {
              title: '用户标识',
              field: 'userSign',  
              align: 'center'
          },
          {
              title: '次数',
              field: 'frequency',
              align: 'center'
          },
          {
              title: '状态',
              field: 'status',
              align: 'center',
              formatter:function(value,row,index){
            	  if(value==1)
            		  return "成功";
            	  else if(value==2)
            		  return "失败";
              }
          },
          {
              title: '日志',
              field: 'id',
              align: 'center',
              formatter: function (value, row, index) {
              	return '<a href="${basePath}/app/gotoLogPage.do?notificationsId='+value+'" >查看</a>';
              }  
          },
          {
              title: '操作',
              field: 'id',
              align: 'center',
              formatter:function(value,row,index){
            	  return '<a href="#" onclick="deleteNotifaction('+value+')">删除</a>';
              }
          }
      ]
  });
	
	//隐藏id列
	$table.bootstrapTable('hideColumn', 'id');
	
	//删除通知
	function deleteNotifaction(id){
		layer.confirm("确定删除操作吗?",function(){
			$.post("${basePath}/app/deleteNotification.do",{"id":id},function(result){
				
				if(result.code==200){
					layer.msg(result.msg);
					$table.bootstrapTable("refresh");
				}else{
					layer.msg("错误,"+result.msg);
				}
			});
		});
	}
	
	//显示所有被选着的数据row数组
	function showSelect(){
		var a= $table.bootstrapTable('getSelections');
		return a;
	}
	
	function reback(){
		window.location.href = document.referrer;
	}
	
	$("#rebackApp").bind("click",reback);
	
	//批量删除
	$("#delBtn").bind("click",function(){
		var tempData = showSelect();
		if(tempData==null||tempData.length==0){
			layer.msg("请选择数据");
			return;
		}
		layer.confirm("确定要删除下面勾选数据吗?",function(){
			var ids = new Array();
			$.each(tempData,function(i,value){
				 ids.push(value.id);
			});
			$.ajax({
	               url:"${basePath}/app/batchDeleteNotifiactions.do",
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
  </script>
 </body>
</html>