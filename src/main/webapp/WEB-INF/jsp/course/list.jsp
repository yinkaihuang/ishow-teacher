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
                            <a href="${basePath}/course/addPage" class="btn btn-primary" role="button">
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
                               data-url="/course/list?pusher=${pusher_name}"
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
        var $table = $('#table');
        $table.bootstrapTable({
            url: '/course/list?pusher=${pusher_name}',
            columns: [
                {
                    checkbox: true
                },
                {
                    title: '课程封面',
                    field: 'imageId',
                    align: 'center',
                    formatter: function (value, row, index) {//自定义显示可以写标签哦~
                        return '<img src="${basePath}/file/show?id=' + value + '" style="wdith:50px;height:50px"/>';
                    }
                },
                {
                    field: 'id',
                    title: 'ID',
                    visible: false
                }
                , {
                    field: 'name',
                    title: '名称',
                    align: 'center'
                }, {
                    field: 'author',
                    title: '讲师',
                    align: 'center'
                }, {
                    field: 'pusher',
                    title: '发布者',
                    align: 'center'
                }, {
                    field: 'type',
                    title: '类型',
                    align: 'center',
                    formatter: function (value, row, index) {
                        if (value == 1)
                            return "数学";
                        else if (value == 2)
                            return "英语";
                        else if (value == 3)
                            return "物理";
                        else if (value == 4)
                            return "语文";
                        else if (value == 5)
                            return "化学";
                    }
                }, {
                    field: 'level',
                    title: '级别',
                    align: 'center',
                    formatter: function (value, row, index) {
                        if (value == 1) {
                            return "基础";
                        } else if (value == 2) {
                            return "进阶";
                        } else if (value == 3) {
                            return "拔高";
                        }
                    }
                }, {
                    field: 'updateDate',
                    title: '发布时间',
                    align: 'center'
                }, {
                    field: 'price',
                    title: '价格',
                    align: 'center'
                }, {
                    field: 'description',
                    title: '描述',
                    align: 'center'
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
                '<button type="button" class="btn btn-primary btn-sm" onclick="remove(' + value + ')">删除</a>',
            ].join('');
        }

        //删除教师
        function remove(id) {
            layer.confirm("删除后将无法撤销，确定执行操作吗?", function () {
                $.post("${basePath}/course/deleteCourse", {"id": id}, function (result) {
                    if (result.code == 200) {
                        layer.msg(result.msg);
                        $table.bootstrapTable("refresh");//重新加载数据
                    } else {
                        layer.msg("错误！" + result.msg);
                    }
                });
            });
        }
    </script>
</div>
</body>
</html>