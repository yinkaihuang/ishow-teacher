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
    <link rel="stylesheet" href="${basePath}/static/jstree/themes/default/style.min.css"/>
    <script src="${basePath}/static/jstree/jstree.min.js"></script>
</head>
<!-- END HEAD -->

<body class="page-container-bg-solid">
<div class="page-wrapper">
    <%@include file="/WEB-INF/jsp/common/head.jsp" %>
    <div class="page-wrapper-row full-height">
        <div class="page-wrapper-middle">
            <div class="container">
                <div class="panel panel-default">
                    <div class="panel-heading"><h4>资源树</h4></div>
                    <div class="panel-body">
                        <div id="tree"></div>
                    </div>
                    <div class="panel-footer">
                        <button type="button" class="btn btn-primary btn-lg btn-block submit">提交</button>
                    </div>
                </div>
                <form id="authorizeSave" method="post" action="${basePath}/role/authorizeSave">
                    <input type="hidden" value="${id}" name="id">
                    <input type="hidden" name="resourceIds" class="resourceIds">
                </form>
            </div>
        </div>
    </div>
</div>
</div>

</div>
<%@include file="/templates/common/footer.jsp" %>
<script>
    // ajax demo
    $('#tree').jstree({
        'core': {
            'data': {
                "url": "${basePath}/resource/treeData?id=${id}",
                "dataType": "json" // needed only if you do not supply JSON headers , "plugins": ["checkbox"]
            }
        }, "plugins": ["checkbox"]
    });
    $('#tree')
        .on('changed.jstree', function (e, data) {
            var i, j, r = [];
            for (i = 0, j = data.selected.length; i < j; i++) {
                r.push(data.instance.get_node(data.selected[i]).id);
            }
            $('.resourceIds').val(r.join('#'));
        })
        .jstree();
    $(".submit").click(function () {
        $("#authorizeSave").submit();
    });
</script>
</div>
</body>
</html>