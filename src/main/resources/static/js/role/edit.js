$(function () {
    $(".role-edit").validate({
        rules: {
            name: {
                required: true

            }
        },
        messages: {
            name: {
                required: "请填写角色名称"
            }
        }
    });
});
