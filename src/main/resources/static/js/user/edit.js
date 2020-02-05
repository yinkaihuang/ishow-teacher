$(function () {
    $(".userEdit").validate({
        rules: {
            phoneNumber: {
                required: true,
                rangelength: [11, 11]

            },
            name: {
                required: true
            },
            password: {
                required: true,
                rangelength: [6, 12]
            }
        },
        messages: {
            phoneNumber: {
                required: "请输入手机号",
                rangelength: "请输入11位手机号"
            },
            name: {
                required: "请选择角色"
            },
            password: {
                required: "请输入密码",
                rangelength: "请输入6到12位密码"
            }
        }
    });
});
