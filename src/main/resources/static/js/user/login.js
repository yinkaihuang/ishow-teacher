$(function () {
    $(".login-submit").click(function () {
        var account = $(".account").val();
        if (account.trim() == "") {
            layer.msg("请填写登录账号");
            $(".account").focus();
            return false;
        }
        var password = $(".password").val();
        if (password.trim() == "") {
            layer.msg("请填写密码");
            $(".password").focus();
            return false;
        }
        var data = $(".login-form").serialize();
        $.ajax({
            type: "POST",
            url: "/user/login",
            data: data,
            success: function (result) {
                if (result.code == 200) {
                    window.location.href = "/index";
                } else {
                    layer.msg(result.msg);
                    return false;
                }
            }
        });
    });
})
