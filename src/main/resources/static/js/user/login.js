$(function () {
    $(".login-submit").click(function () {
        var phone = $(".phone").val();
        if (phone.trim() == "") {
            layer.msg("请填写手机号");
            $(".phone").focus();
            return false;
        }
        /*if (!verifyPhone(phone)){
            layer.msg("请填写11位手机号");
            $(".phone").focus();
            return false;
        }*/
        var password = $(".password").val();
        if (password.trim() == "") {
            layer.msg("请填写密码");
            $(".password").focus();
            return false;
        }
        var imageCode = $(".imageCode").val();
        if (imageCode.trim() == "") {
            layer.msg("请填写验证码");
            $(".imageCode").focus();
            return false;
        }
        var data = $(".login-form").serialize();
        $.ajax({
            type: "POST",
            url: "/login",
            data: data,
            success: function (result) {
                console.log(result);
                if (result.data == 2) {
                    layer.msg("验证码错误");
                    return false;
                }
                if (result.data == 4) {
                    layer.msg("手机号或密码错误");
                    return false;
                }
                if (result.data == 1) {
                    window.location.href = "/home/index";
                }
            }
        });
    });
})
