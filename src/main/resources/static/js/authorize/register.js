$(function() {
//	var width = $('.content','.login').outerWidth();
//	var height = $('.content','.login').outerHeight();
//	var top = $('.content','.login').offset().top;
//	var left = $('.content','.login').offset().left;
//	offset_left = (left+width/2);
//	offset_top = top+height/2;
	$('#register-submit-btn').bind('click', register);
	$(".getCode").bind('click',getCode);
});

function getCode(){
	if($('#phone_num').val() == ''){
		layer.msg("请先输入手机号码再获取");
		return false;
	}		
	alert('getCode');
	$('.getCode').unbind('click');
	$.ajax({
	    type: "get",
	    url: "/game/sendSmsCode",
	    data: "type=register&phone=" + $('#phone_num').val(),
	    success: function (result) {
	    	$('.getCode').bind('click',getCode);
	        if (result.data == 7) {
	            layer.msg("手机验证码获取成功,验证码："+result.msg);
	            countDown(60);
	            return false;
	        }
	        if (result.data == 2) {
	        	layer.msg("验证码错误");
	            return false;
	        }
	        if (result.data == 5) {
	        	layer.msg("手机号码已被注册");
	            return false;
	        }
	        if (result.data == 8) {
	        	layer.msg("手机验证码发送失败");
	            return false;
	        }
	    },
	    error:function(result){
	    	$('.getCode').bind('click',getCode);
	    }
	});
}

function countDown(count) {
    count--;
    if (count <= 0) {
        $(".getCode").val("获取验证码");
        $(".getCode").attr("disabled", false);
    } else {
        $(".getCode").val(count + "秒后可再次获取");
        $(".getCode").attr("disabled", true);
        t = setTimeout("countDown(" + count + ")", 1000);
    }
}

function checkRegisterValid() {
	if ($('#phone_num').val() == '') {
		layer.msg("请输入手机号！");
		$('#phone_num').focus();
		return false;
	}

	if ($('#password_txt').val() == '') {
		layer.msg("请输入密码！");
		$('#password_txt').focus();
		return false;
	}

	if (!$('#user_deal_chx').is(':checked')) {
		layer.msg("请同意用户协议！");
		$('#user_deal_chx').focus();
		return false;
	}
	return true;
}

function register() {
	if (!checkRegisterValid()) {
		return;
	}
	$("#register-submit-btn").unbind("click");
	var appData = { //请求后台数据
		url : '/game/userRegister',
		resetForm : true,
		type : 'POST',
		dataType : 'json',
		timeout : 30000,
		async : false,
		beforeSubmit : function() {
		},
		success : function(result) {
			$("#register-submit-btn").bind("click", register);
			if (result.code == 200) {
				layer.msg("注册成功！");
			} else {
				layer.msg(result.msg);
			}
//			$(".getCode").val("获取验证码");
//		    $(".getCode").attr("disabled", false);
		},
		error : function(result) {
			$("#register-submit-btn").bind("click", register);
		}
	};
	$("#register-form-id").ajaxSubmit(appData);
}
