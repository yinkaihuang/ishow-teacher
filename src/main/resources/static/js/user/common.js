/**
 * 倒计时
 * @param count
 */
function countDown(count) {
    count--;
    if (count <= 0) {
        $(".getCode").text("获取验证码");
        $(".getCode").attr("disabled", false);
    } else {
        $(".getCode").text(count + "秒后可再次获取验证码");
        $(".getCode").attr("disabled", true);
        t = setTimeout("countDown(" + count + ")", 1000);
    }
}

/**
 * 检查手机号
 * @returns {boolean}
 */
function verifyPhone(phone) {
    if (!(/^1[34578]\d{9}$/.test(phone))) {
        return false;
    }
    return true;
}

/**
 * 检查手机验证码
 * @returns {boolean}
 */
function chechCode() {
    var code = $(".code").val();
    if (code == "") {
        layer.msg("请填写验证码");
        $(".code").focus();
        return false;
    }
    return true;
}

/**
 * 检查图片验证码
 * @returns {boolean}
 */
function chechCode() {
    var imageCode = $(".imageCode").val();
    if (imageCode == "") {
        layer.msg("请填写图片验证码");
        $(".imageCode").focus();
        return false;
    }
    return true;
}

/**
 * 检查密码
 */
function checkPassword() {
    var password = $(".password").val();
    if (password == "") {
        layer.msg("请填写密码");
        $(".password").focus();
        return false;
    }
    return true;
}