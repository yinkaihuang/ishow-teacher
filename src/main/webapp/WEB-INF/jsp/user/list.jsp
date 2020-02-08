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
</head>
<!-- END HEAD -->

<body class="page-container-bg-solid">
<div class="page-wrapper">
    <%@include file="/WEB-INF/jsp/common/head.jsp" %>
    <div class="page-wrapper-row full-height">
        <div class="page-wrapper-middle">
            <div class="container">
                <div class="panel panel-default">
                    <div class="panel-heading"><h4>${roleName}</h4></div>
                    <div class="panel-body">
                        <div id="toolbar">
                            <a href="#" class="btn btn-primary" role="button">
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
                               data-url="/user/list?roleType=${roleType}"
                               data-striped="true"
                               data-query-params="myPage"
                               data-side-pagination="server">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@include file="../common/footer.jsp" %>
    <script>
        $('#table').bootstrapTable({
            url: '/user/list?roleType=${roleType}',
            columns: [
                {
                    field: 'id',
                    title: 'ID',
                    visible: false
                }, {
                    field: 'loginAccount',
                    title: '账号',
                    align: 'center'
                }
                , {
                    field: 'name',
                    title: '名称',
                    align: 'center'
                }, {
                    field: 'phoneNumber',
                    title: '手机号',
                    align: 'center'
                }, {
                    field: 'gender',
                    title: '性别',
                    align: 'center',
                    formatter: function (value, row, index) {
                        if (value == 1)
                            return "男";
                        else if (value == 2)
                            return "女";
                    }
                }, {
                    field: 'birthDay',
                    title: '生日',
                    align: 'center'
                }, {
                    field: 'address',
                    title: '常住地址',
                    align: 'center'
                }, {
                    field: 'idCard',
                    title: '身份证号码',
                    align: 'center'
                }, {
                    field: 'enable',
                    title: '审批状态',
                    align: 'center',
                    formatter: function (value, row, index) {
                        if (value == 1)
                            return "完成";
                        else
                            return "等待";
                    }
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
                '<a role="button" class="btn btn-primary btn-sm" href="${basePath}/user/editPage?id=' + value + '">修改</a>',
                '<a role="button" class="btn btn-primary btn-sm" href="${basePath}/user/approval?id=' + value + '">审批</a>',
                '<button type="button" class="btn btn-primary btn-sm" onclick="remove(' + value + ')">删除</a>',
            ].join('');
        }

        //删除教师
        function remove(id){
            layer.confirm("删除后将无法撤销，确定执行操作吗?",function(){
                $.post("${basePath}/user/delete",{"id":id},function(result){
                    if(result.code==200){
                        layer.msg(result.msg);
                        $table.bootstrapTable("refresh");//重新加载数据
                    }else{
                        layer.msg("错误！"+result.msg);
                    }
                });
            });
        }
    </script>
</div>
</body>
</html>