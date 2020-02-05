<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<!-- BEGIN HEAD -->

<head>
    <%@include file="/WEB-INF/jsp/common/common.jsp" %>
    <script src="${basePath}/static/js/resource/edit.js"></script>
</head>
<!-- END HEAD -->

<body class="page-container-bg-solid">
<div class="page-wrapper">
    <%@include file="/WEB-INF/jsp/common/head.jsp" %>
    <div class="page-wrapper-row full-height">
        <div class="page-wrapper-middle">
            <div class="container">
                <div class="panel panel-default">
                    <div class="panel-heading"><h4>资源管理</h4></div>
                    <div class="panel-body">
                        <form class="form-horizontal resource-edit" role="form" action="${basePath}/resource/save"
                              method="post">
                            <input type="hidden" name="id" value="${resource.id}">
                            <div class="form-group">
                                <label class="col-md-2 control-label">名称</label>
                                <div class="col-md-4">
                                    <input name="name" value="${resource.name}" type="text" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label">类型</label>
                                <div class="col-md-4">
                                    <input name="type" value="${resource.type}" type="text" class="form-control"></div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label">链接</label>
                                <div class="col-md-4">
                                    <input name="url" value="${resource.url}" type="text" class="form-control"></div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label">父级ID</label>
                                <div class="col-md-4">
                                    <input name="parentId" value="${resource.parentId}" type="text"
                                           class="form-control"></div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label">权限</label>
                                <div class="col-md-4">
                                    <input name="permission" value="${resource.permission}" type="text"
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
    <%@include file="/WEB-INF/jsp/common/footer.jsp" %>
</div>
</body>
</html>