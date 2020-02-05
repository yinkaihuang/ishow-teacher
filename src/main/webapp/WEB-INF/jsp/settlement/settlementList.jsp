<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="/WEB-INF/jsp/common/common.jsp"%>
<script type="text/javascript"
	src="${basePath}/static/js/app/common-app.js"></script>
	
<style type="text/css">
  .fixed-table-toolbar .bs-bars{
    width:100%;
}
.table th, .table td { 
	text-align: center;
	vertical-align: middle!important;
} 
</style>
</head>


<body class="page-container-bg-solid">
	<div class="page-wrapper">
		<%@include file="/WEB-INF/jsp/common/head.jsp"%>
		<div class="page-wrapper-row full-height">
			<div class="panel panel-default">
				<div class="panel-heading"><a href="#" id="rebackApp">
                    <a href="${basePath}/system/settlement/settlement.do" style="color:black;font-size:18px">未结算汇总</a>|<a href="#" style="color:red;font-size:18px">结算报表</a></div>
				<div class="panel-body">
				<div id="toolbar">
                     <a href="#"  class="btn btn-primary" role="button" style="display:none">
                        <i class="glyphicon glyphicon-plus"></i>
                    </a>
                   开始时间&nbsp<input id="startTime" name="startTime" type="text" style="height:30px">
                   结束时间&nbsp<input id="endTime" name="endTime" type="text" style="height:30px">
                   
                   <a href="#" id="searchBtn" class="btn btn-primary" role="button" style="margin-top: 6px;float:right;height:30px">
                        <i class="glyphicon glyphicon-zoom-in"></i>搜索
                    </a>
                    <input type="text" id="searchText" placeholder="请输入内容" style="margin-top: 6px;margin-right:10px;float:right;height:30px"/>
                </div>
                
					<table id="table" data-toolbar="#toolbar">
					</table>
					
				</div>
			</div>
		</div>

		<%@include file="/WEB-INF/jsp/common/footer.jsp"%>
	</div>
	
	<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
   aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog" style="width:300px">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"
               aria-hidden="true">×
            </button>
                  	请输入驳回原因                        
         </div>
         <div class="modal-body" style="text-align:center">
         <form id="refundForm">
            <input type="hidden" id="id" name="id" style="width:0px"/>
            <input type="text" name="refundReason" id="refundReason" style="width:260px"/>
         </form>
   		 <div style="width:100%;text-align:center;margin-top:5px" >
   		  <button type="button" id="submitSettle" class="btn btn-primary"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span>提交</button>&nbsp&nbsp<button type="button" class="btn btn-primary" data-dismiss="modal" ><span class="glyphicon glyphicon-remove" aria-hidden="true"></span> 关闭</button>
		 </div>
		
         </div>
      </div>
   </div>
</div>
	
	
	<script type="text/javascript">
	$.datetimepicker.setLocale('ch');//设置中文
	$('#startTime').datetimepicker({format:"Y-m-d H:m:s"});
	$('#endTime').datetimepicker({format:"Y-m-d H:m:s"});
	
	
    var $table = $('#table');
	$table.bootstrapTable({  
     url: '${basePath}/settlement/listApproved.do',  
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
             title: '渠道商',
             field: 'channelName',
             align: 'center'
         },  
         {
             title: '结算周期',  
             field: 'id',  
             align: 'center' ,
             formatter:function(value,row,index){
            	 return formatMyData(row.begainSettleTime)+"~"+formatMyData(row.endSettleTime);
             }
         },  
         {
             title: '本期金额',  
             field: 'sum',  
             align: 'center',
             formatter:function(value,row,index){
                 return formateMoney(value);
             }
         },
         {
        	 title: '结算结果&nbsp<select class="ss" id="statusId" onchange="reloadData()"><option value="" selected="selected">全部</option><option value="0" >失败</option><option value="1">成功</option></select>',
             field: 'status',
             align: 'center',
             formatter:function(value,row,index){
            	if(value==0)
            		return "失败";
            	else if(value==1)
            		return "成功";
             } 
         },
         {
        	 title: '银行回执单',
             field: 'bankReceipt',
             align: 'center'
         },
         {
             title: '操作',
             field: 'id',
             align: 'center',
             formatter:function(value,row,index){
            	 if(row.status==0)
            		 return '<a href="${basePath}/settlement/gotoDetailPage.do?settlementId='+value+'">查看明细</a>';
            	 else if(row.status==1)
            		 return '<a href="#" onclick="refundSettle(\''+value+'\')">退款</a>|<a href="${basePath}/settlement/gotoDetailPage.do?settlementId='+value+'">查看明细</a>';
             }
         }
     	]
 	});
	
	
	//隐藏id列
	$table.bootstrapTable('hideColumn', 'id');
	
	function refundSettle(id){
		$("#id").val(id);
		$("#refundReason").val("");
		$('#myModal').modal({
			keyboard: true,
			backdrop:'static'
		});
	}
	
	function refundSettleData(){
		$("#submitSettle").unbind("click",refundSettleData);
		 //请求后台数据
		var appData={    
			  url:'${basePath}/settlement/refund.do',
			  resetForm: true, 
			  type:'POST',
			  dataType : 'json',
			  beforeSubmit: function(){
			       return checkParams();
			   },
			  success:function(result){
				  if(result.code==200){
					  layer.msg("退款成功");
					  $('#myModal').modal("hide");
					  $table.bootstrapTable('refresh');
				  }else{
					  layer.msg(result.msg);
				  }
				  $("#submitSettle").bind("click",refundSettleData);   	
			   },
			  error:function(result){
				  $("#submitSettle").bind("click",refundSettleData);    
			   }
		}; 
			
				
		$("#refundForm").ajaxSubmit(appData);


		function checkParams(){
		    if($("#refundReason").val()==null||$("#refundReason").val()==""){
		    	layer.msg("请输入退款原因");
		    	$("#submitSettle").bind("click",refundSettleData);
		    	return false;
		    } 	
		    return true;
		}
	}
	
	$("#submitSettle").bind("click",refundSettleData);
	
	function reloadData(){
		var searchWorld = $("#searchText").val();
		var startTimeText = $("#startTime").val();
		var endTimeText = $("#endTime").val();
		var statusText = $("#statusId").val();
		
		$('#table').bootstrapTable('refresh',{
			url:'${basePath}/settlement/listApproved.do',
			query:{
				search:searchWorld,
				startTime:startTimeText,
				endTime:endTimeText,
				status:statusText
			}
	    });
	}
	
	$("#searchBtn").bind("click",reloadData);
	
	function formatMyData(str){
		if(str==null||str=="")
			return "";
		var index = str.lastIndexOf(" ");
		return str.substring(0,index);
	}

    //格式化金钱
    function formateMoney(value){
        if(value==null||value=="")
            return "￥0.00";
        var temp = (value/100.0)+"";
        if(temp.lastIndexOf(".")<=0){
            temp = temp+".00";
            return "￥"+temp;
        }

        var index = temp.indexOf(".");
        var length = temp.length;
        var zooCount = index+3-length;
        for(var i=0;i<zooCount;i++){
            temp+="0";
        }
        return "￥"+temp;
    }
   </script>

</body>
</html>