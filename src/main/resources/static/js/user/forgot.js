$(function () {
    //点击获取手机验证码
    $(".getCode").click(function () {
        var phone = $(".phone").val();
        if (phone.trim() == "") {
            layer.msg("请填写手机号");
            $(".phone").focus();
            return false;
        }
        if (!verifyPhone(phone)) {
            layer.msg("请填写11位手机号");
            $(".phone").focus();
            return false;
        }
        var imageCode = $(".imageCode").val();
        if (imageCode.trim() == "") {
            layer.msg("请填写图片验证码");
            $(".imageCode").focus();
            return false;
        }
        //检查图片验证码
        $.ajax({
            type: "get",
            url: "/verifyImageCode",
            data: "type=forgot&imageCode=" + imageCode + "&phone=" + phone,
            success: function (result) {
                if (result.data == 7) {
                    layer.msg("手机验证码获取成功");
                    countDown(60);
                    return false;
                }
                if (result.data == 2) {
                    layer.msg("图片验证码错误");
                    return false;
                }
                if (result.data == 10) {
                    layer.msg("手机号码不存在");
                    return false;
                }
                if (result.data == 8) {
                    layer.msg("手机验证码发送失败");
                    return false;
                }
            }
        });
    });
    //点击注册按钮
    $(".forgotSubmit").click(function () {
        var phone = $(".phone").val();
        if (phone.trim() == "") {
            layer.msg("请填写手机号");
            $(".phone").focus();
            return false;
        }
        if (!verifyPhone(phone)) {
            layer.msg("请填写11位手机号");
            $(".phone").focus();
            return false;
        }
        var imageCode = $(".imageCode").val();
        if (imageCode.trim() == "") {
            layer.msg("请填写图片验证码");
            $(".imageCode").focus();
            return false;
        }
        var phoneCode = $(".phoneCode").val();
        if (phoneCode.trim() == "") {
            layer.msg("请填写手机验证码");
            $(".phoneCode").focus();
            return false;
        }
        var password = $(".password").val();
        if (password.trim() == "") {
            layer.msg("请填写密码");
            $(".password").focus();
            return false;
        }
        var data = $(".forgotForm").serialize();
        //注册
        $.ajax({
            type: "post",
            url: "/forgot",
            data: data,
            success: function (result) {
                if (result.data == 11) {
                    layer.msg("操作成功");
                    setTimeout(function () {
                        window.location.href = "/user/login";
                    }, 1000);
                }
                if (result.data == 2) {
                    layer.msg("图片验证码错误");
                    return false;
                }
                if (result.data == 10) {
                    layer.msg("手机号码不存在");
                    return false;
                }
                if (result.data == 3) {
                    layer.msg("手机验证码错误");
                    return false;
                }
            }
        });
    });
});