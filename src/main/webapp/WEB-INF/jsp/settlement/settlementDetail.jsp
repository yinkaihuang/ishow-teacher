<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="/WEB-INF/jsp/common/common.jsp"%>
<script type="text/javascript" src="${basePath}/static/js/app/common-app.js"></script>
<style type="text/css">
 #headTable td{
	font-weight:300; 
	font-size:16px;
	text-align:left
}

label{
 font-size:16px;
 font-color:black;
}
</style>
</head>


<body class="page-container-bg-solid">
	<div class="page-wrapper">
		<%@include file="/WEB-INF/jsp/common/head.jsp"%>
		<div class="page-wrapper-row full-height">
			<div class="panel panel-default">
				<div class="panel-heading"><a href="#" id="rebackApp">
                    <a href="#" onclick="goback()">返回结算汇总</a>|汇总明细</div>
				<div class="panel-body">
				<div id="toolbar">
                     <a href="#"  class="btn btn-primary" role="button" style="display:none">
                        <i class="glyphicon glyphicon-plus"></i>
                    </a>
                   
                </div>
                <div id="headDiv" style="width:100%;text-align:center;display:none">
                   <table id="headTable" style="width:80%;height:150px">
                     <tr>
                       <td>渠道商：<label id="channelName">未加载</label></td>
                       <td>结算周期:<label id="settleData">未加载</label></td>
                       <td>本期金额:<label id="sum">未加载</label></td>
                       <td>结算状态:<label id="checkStatus">未加载</label></td>
                     </tr>
                     <tr>
                      <td>结算结果:<label id="status">未加载</label></td>
                      <td>打款人:<label id="payer">未加载</label></td>
                      <td>打款时间:<label id="payDate">未加载</label></td>
                      <td>银行流水号:<label id="bankReceipt">未加载</label></td>
                     </tr>
                     <tr>
                        <td rowspan="4">
                                                        退款原因:<label id="refundReason">未加载</label>
                        </td>
                     </tr>
                   
                   </table>
              </div>
                    
					<table id="table" data-toolbar="#toolbar">
					</table>
					
				</div>
			</div>
		</div>

		<%@include file="/WEB-INF/jsp/common/footer.jsp"%>
	</div>
	<script type="text/javascript">
	
	$.get("${basePath}/settlement/findSettlement.do?id=${settlementId}",function(result){
		 if(result.code==200){
            var value = result.data;
			 setText('channelName',value.channelName);
			 setText('settleData',formatMyData(value.begainSettleTime)+"~"+formatMyData(value.endSettleTime));
			 setText('sum',value.sum);
			 var checkStatusStr = "";
			 if(value.checkStatus==0)
				 checkStatusStr="未结算";
			 else
				 checkStatusStr="已结算";
			 if(value.checkStatus==1)
				 $("#headDiv").show();
			 setText('checkStatus',checkStatusStr);
			 var statusStr ="";
			 if(value.status==0)
				 statusStr="失败";
			 else
				 statusStr="成功";
			 setText('status',statusStr);
			 setText('payer',value.payer);
			 setText('payDate',formatMyData(value.payDate));
			 setText('bankReceipt',value.bankReceipt);
			 setText('refundReason',value.refundReason);
		 }else{
			 layer.msg("详情数据加载失败")
		 }
	});
	
	function setText(id,value){
		if(value==null)
			value="无";
		$("#"+id).text(value);
	}
	
    var $table = $('#table');
	$table.bootstrapTable({  
     url: '${basePath}/settlement/listDetail.do?settlementId=${settlementId}',  
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
             title: '项目名称',
             field: 'item',
             align: 'center'
         },  
         {
             title: '日期',  
             field: 'dateTime',  
             align: 'center',
             formatter:function(value,row,index){
            	 return formatMyData(value);
             }
         },  
         {
             title: '收入',  
             field: 'income',  
             align: 'center',
             formatter:function(value,row,index){
            	 if(value==null||value=="")
            		 return '￥0.00';
            	 return "￥"+(value/100.0);
             }
         }
     	]
 	});
	
	//隐藏id列
	$table.bootstrapTable('hideColumn', 'id');
	
	
	//返回上一级
	function goback(){
		window.location.href = document.referrer;
	}
	
	function formatMyData(str){
		if(str==null||str=="")
			return "";
		var index = str.lastIndexOf("\.");
		return str.substring(0,index);
	}
   </script>

</body>
</html>