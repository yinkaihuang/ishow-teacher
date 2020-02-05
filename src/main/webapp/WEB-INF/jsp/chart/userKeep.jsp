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
    <script src="${basePath}/static/js/chart/userKeep.js"></script>
</head>
<!-- END HEAD -->
<body class="page-container-bg-solid">
<div class="page-wrapper">
    <%@include file="/WEB-INF/jsp/common/head.jsp" %>
    <div class="page-wrapper-row full-height">
        <div class="page-wrapper-middle">
            <div class="container">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4>留存分析</h4>
                    </div>
                    <div class="panel-body">
                        <table id="region-table"
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
</div>
<%@include file="/WEB-INF/jsp/common/footer.jsp" %>
</div>
</body>
</html>