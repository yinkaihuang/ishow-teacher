<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<!-- BEGIN HEAD -->

<head>
    <%@include file="../common/common.jsp" %>
    <script src="${basePath}/static/js/user/edit.js"></script>
</head>
<!-- END HEAD -->

<body class="page-container-bg-solid">
<div class="page-wrapper">
    <%@include file="../common/head.jsp" %>
    <div class="page-wrapper-row full-height">
        <div class="page-wrapper-middle">
            <div class="container">
                <div class="panel panel-default">
                    <div class="panel-heading"><h4>用户管理</h4></div>
                    <div class="panel-body">
                        <form class="form-horizontal userEdit" role="form" action="${basePath}/user/edit" method="post">
                            <input type="hidden" name="id" value="${userEdit.id}">
                            <input type="hidden" name="role" value="${userEdit.role}">
                            <input type="hidden" name="enable" value="${userEdit.enable}">
                            <div class="form-group">
                                <label class="col-md-2 control-label">手机号</label>
                                <div class="col-md-4">
                                    <input name="phoneNumber" value="${userEdit.phoneNumber}" type="text"
                                           class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label">姓名</label>
                                <div class="col-md-4">
                                    <input name="name" value="${userEdit.name}" type="text"
                                           class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label">性别</label>
                                <div class="col-md-4">
                                    <select class="form-control" name="gender" data-value="${userEdit.gender}">
                                        <option value='1'>男</option>
                                        <option value='2'>女</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label">生日</label>
                                <div class="col-md-4">
                                    <input id="birthDay" name="birthDay"  type="text" value="${userEdit.birthDayStr}"
                                           class="form-control"></div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label">常住地址</label>
                                <div class="col-md-4">
                                    <input name="address" value="${userEdit.address}" type="text"
                                           class="form-control"></div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label">身份证</label>
                                <div class="col-md-4">
                                    <input name="idCard" value="${userEdit.idCard}" type="text"
                                           class="form-control"></div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label">密码</label>
                                <div class="col-md-4">
                                    <input name="password" value="${userEdit.password}" type="text"
                                           class="form-control"></div>
                            </div>

                            <div class="form-group">
                                <div class="col-md-offset-2 col-md-10">
                                    <button type="submit" class="btn blue">提交</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@include file="../common/footer.jsp" %>
    <script type="text/javascript">
        $.datetimepicker.setLocale('ch');//设置中文
        $('#birthDay').datetimepicker({
            format: "Y-m-d"
        });
    </script>
</div>
</body>
</html>