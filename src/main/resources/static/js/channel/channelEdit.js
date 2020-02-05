$(function(){
    $(".channelEdit").validate({
    	submitHandler:function(){
    		$("#submit").attr("disabled",true);
    		var submitData={    //请求后台数据
	            url:basePath+'/channel/saveChannel',
	            resetForm: false, 
	            type:'POST',
	            dataType : 'json',
	            beforeSubmit: function(){
	            },
	            success:function(result){
	            	$("#submit").attr("disabled",false);
	            	console.log(result);
	            	if(result.code==200){
	            		$("input[name='id']").val(result.data.id);
                        layer.msg("操作成功！",{icon: 1});
	            	}else{
	            		layer.msg("操作失败，原因："+result.msg,{icon: 2})
	            	}
	            },
	            error:function(result){
	            	$("#submit").attr("disabled",false);
	            }
    	    }; 
    		$(".channelEdit").ajaxSubmit(submitData);
		},
        rules: {
        	channelName: {
                required: true
            },
            accountNum: {
                required: true
            },
            accountSecret: {
            	secretEmptyValidate: true,
            	rangelength:[6,12]
            },
            settlePeriod:{
            	number:true
            }
        },
        messages: {
        	channelName: {
                required: "请输入渠道名称"
            },
            accountNum: {
                required: "请输入渠道商账号"
            },
            accountSecret: {
            	rangelength: "输入密码长度必须为6到12位"
            },
            settlePeriod:{
            	number:"请输入数字的结算周期"
            }
        }
    });
    if(id.length>0){
    	$('#secretCode').text("密码");
    }
});

function back(){
	window.location.href=basePath+"/channel/list";
}
