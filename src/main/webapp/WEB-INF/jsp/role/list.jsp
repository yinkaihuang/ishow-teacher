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
</head>
<!-- END HEAD -->

<body class="page-container-bg-solid">
<div class="page-wrapper">
    <%@include file="/WEB-INF/jsp/common/head.jsp" %>
    <div class="page-wrapper-row full-height">
        <div class="page-wrapper-middle">
            <div class="container">
                <div class="panel panel-default">
                    <div class="panel-heading"><h4>角色管理</h4></div>
                    <div class="panel-body">
                        <div id="toolbar">
                            <a href="${basePath}/role/edit" class="btn btn-primary" role="button">
                                <i class="glyphicon glyphicon-plus"></i> 添加
                            </a>
                        </div>
                        <table id="table"
                               data-toolbar="#toolbar"
                               data-search="true"
                               data-show-refresh="true"
                               data-show-toggle="true"
                               data-show-columns="true"
                               data-show-export="true"
                               data-show-pagination-switch="true"
                               data-pagination="true"
                               data-id-field="id"
                               data-show-footer="false"
                               data-url="listData"
                               data-striped="true"
                               data-query-params="myPage"
                               data-side-pagination="server">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@include file="/templates/common/footer.jsp" %>
    <script>
        $('#table').bootstrapTable({
            url: 'listData',
            columns: [
                {
                    field: 'id',
                    title: 'ID',
                    visible: false
                }, {
                    field: 'name',
                    title: '角色名称'
                }, {
                    field: 'description',
                    title: '角色描述'
                }, {
                    field: 'id',
                    title: '操作',
                    align: 'center',
                    formatter: operateFormatter
                }
            ]
        });

        function operateFormatter(value, row, index) {
            return [
                '<a role="button" class="btn btn-primary btn-sm" href="${basePath}/role/edit/' + value + '">修改</a>',
                '<button type="button" class="btn btn-primary btn-sm" onclick="remove(' + value + ')">删除</button>',
                '<a role="button" class="btn btn-primary btn-sm" href="${basePath}/role/authorize/' + value + '">授权</a>'
            ].join('');
        }

        /**
         * 询问框
         * @param url
         */
        function remove(value) {
            //询问框
            layer.confirm('确定要删除吗？', {
                btn: ['确定', '取消'] //按钮
            }, function () {
                window.location.href = '/role/delete/' + value;
            });
        }
    </script>
</div>
</body>
</html>