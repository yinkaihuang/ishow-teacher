$(function(){
	if(typeof(sysDict) == 'undefined' || sysDict == ''){
        $.ajax({
            url:basePath+"/dict/getSystemDict",
            dataType:'json',
            type:"post",
            traditional:true,
            data:{
            },
         	success:function(result){
         		sysDict = result;
         		initAgentSelect(sysDict);
         	}
      	});
    }else{
    	initAgentSelect(sysDict);
    }
	$('#submit').bind('click',saveEditAgent);
});		



function initAgentSelect(sysDict){
	var agentDict = sysDict.agentTypeDict;
	$('#agentType').empty();
	$.each(agentDict,function(i,value){
		var code = i;
		var text = agentDict[i];
		var option = $("<option>").val(code).text(text);
		$('#agentType').append(option);
	});

	$('#enableStatus').empty();
	var enableStatusDict = sysDict.enableStatusDict;
	$.each(enableStatusDict,function(i,value){
		var code = i;
		var text = enableStatusDict[i];
		var option = $("<option>").val(code).text(text);
		$('#enableStatus').append(option);
	});
	var appTypeDict = sysDict.appTypeDict;
	if(appType != ''){
		$('#appType').val(appTypeDict[appType]);
	}
	if(agentType != ''){
		$('#agentType').val(agentType);
	}
	if(enableStatus != ''){
		$('#enableStatus').val(enableStatus);
	}
}


function saveEditAgent(){
	if(!checkEditParams()){
		return;
	}
	$("#submit").unbind("click");
	var submitData={    //请求后台数据
        url:basePath+'/channelApp/saveChanelApp',
        resetForm: false, 
        type:'POST',
        dataType : 'json',
        beforeSubmit: function(){
        },
        success:function(result){
        	$("#submit").bind("click",saveEditAgent);
        	if(result.code==200){
                layer.msg("操作成功！",{icon:1});
        	}else{
        		layer.msg("操作失败，原因："+result.msg,{icon:2});
        	}
        },
        error:function(result){
        	$("#submit").bind("click",saveEditAgent);
        }
    }; 
	$(".channelAppEdit").ajaxSubmit(submitData);
}


function checkEditParams(){
	if($('#agentType').val() == ''){
		layer.msg("推广类型不能为空!");
		return false;
	}
	if($('#unitPrice').val() == ''){
		layer.msg("单价不能为空!");
		return false;
	}
	var reg = /^([0]\.[0-9]{1,2}|[1-9][0-9]*\.?[0-9]{0,2})$/;
	if(!reg.test($('#unitPrice').val())){
		layer.msg("单价请录入整数或包含2位小数的金额！");
		return false;
	}
	if($('#callbackUrl').val() == ''){
		layer.msg("回调地址不能为空!");
		return false;
	}
	return true;
}

function back(){
	window.location.href=basePath+"/channelApp/agentOperate/"+channelId;
}

