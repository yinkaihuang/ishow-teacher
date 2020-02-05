<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<!-- BEGIN HEAD -->

<head>
    <%@include file="/templates/common/common.jsp" %>
    <script src="${basePath}/static/js/role/edit.js"></script>
</head>
<!-- END HEAD -->

<body class="page-container-bg-solid">
<div class="page-wrapper">
    <%@include file="/templates/common/head.jsp" %>
    <div class="page-wrapper-row full-height">
        <div class="page-wrapper-middle">
            <div class="container">
                <div class="panel panel-default">
                    <div class="panel-heading"><h4>角色管理</h4></div>
                    <div class="panel-body">
                        <form class="form-horizontal role-edit" role="form" action="${basePath}/role/save"
                              method="post">
                            <input type="hidden" name="id" value="${role.id}">
                            <div class="form-group">
                                <label class="col-md-2 control-label">角色名称</label>
                                <div class="col-md-4">
                                    <input name="name" value="${role.name}" type="text" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label">角色描述</label>
                                <div class="col-md-4">
                                    <input name="description" value="${role.description}" type="text"
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
    <%@include file="/templates/common/footer.jsp" %>
</div>
</body>
</html>