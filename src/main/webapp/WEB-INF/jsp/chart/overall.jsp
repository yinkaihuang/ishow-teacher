<%--
  Created by IntelliJ IDEA.
  User: CIKE
  Date: 2017/10/11
  Time: 9:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>图表</title>
    <%@include file="/WEB-INF/jsp/common/common.jsp" %>
    <link rel="stylesheet" href="${basePath}/static/css/chart/overall.css">
    <script src="${basePath}/static/echarts/echarts.common.min.js"></script>
    <script src="${basePath}/static/js/chart/lineChart.js"></script>
    <script src="${basePath}/static/js/chart/overall.js"></script>
</head>
<body class="page-container-bg-solid">
<div class="page-wrapper">
    <%@include file="/WEB-INF/jsp/common/head.jsp" %>
    <div class="page-wrapper-row full-height">
        <div class="page-wrapper-middle">
            <div class="container">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4>应用概况</h4>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-sm-6">
                                <input type="hidden" value="${basePath}/overall/queryNewUserByDate" class="chart-url">
                                <div class="alert alert-success" role="alert">累计用户：${cumulative}</div>
                                <div class="alert alert-info" role="alert">7天活跃用户：${sevenDaysActive}
                                    <span class="glyphicon glyphicon-arrow-up pull-right" aria-hidden="true"><fmt:formatNumber pattern="0.00%" value="${sevenDaysActiveRate}" maxFractionDigits="2"/></span>
                                </div>
                                <div class="alert alert-warning" role="alert">30天活跃用户：${thirtyDaysActive}
                                    <span class="glyphicon glyphicon-arrow-up pull-right"
                                          aria-hidden="true"><fmt:formatNumber pattern="0.00%" value="${thirtyDaysActiveRate}" maxFractionDigits="2"/></span>
                                </div>
                                <div class="alert alert-danger" role="alert">7天平均日使用时长（分）：${sevenAverageTime}
                                    <span class="glyphicon glyphicon-arrow-up pull-right" aria-hidden="true"><fmt:formatNumber pattern="0.00%" value="${sevenAverageTimeRate}" maxFractionDigits="2"/></span>
                                </div>
                                <div class="alert alert-success" role="alert">平均单次使用时长（分）：${averageTime}
                                    <span class="glyphicon glyphicon-arrow-up pull-right"
                                          aria-hidden="true"><fmt:formatNumber pattern="0.00%" value="${averageTimeRate}" maxFractionDigits="2"/></span>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="alert alert-success" role="alert">累计付费用户：${paymentUser}</div>
                                <div class="alert alert-info" role="alert">累计付费金额：<fmt:formatNumber pattern="0.00" value="${paymentMoney}" maxFractionDigits="2"/></div>
                                <div class="alert alert-warning" role="alert">付费率：<fmt:formatNumber pattern="0.00%" value="${paymentRate}" maxFractionDigits="2"/></div>
                                <div class="alert alert-danger" role="alert">ARPU：<fmt:formatNumber pattern="0.00%" value="${arpu}" maxFractionDigits="2"/></div>
                                <div class="alert alert-success" role="alert">ARPPU：<fmt:formatNumber pattern="0.00%" value="${arppu}" maxFractionDigits="2"/></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4>整体趋势</h4>
                    </div>
                    <div class="panel-body">
                        <div class="btn-group btn-group-justified" role="group">
                            <div class="btn-group" role="group">
                                <button type="button" class="btn btn-default" onclick="changeLine('${basePath}/overall/queryNewUserByDate')">新增用户</button>
                            </div>
                            <div class="btn-group" role="group">
                                <button type="button" class="btn btn-default" onclick="changeLine('${basePath}/overall/activeUserByDate')">活跃用户</button>
                            </div>
                            <div class="btn-group" role="group">
                                <button type="button" class="btn btn-default" onclick="changeLine('${basePath}/overall/startUserByDate')">启动次数</button>
                            </div>
                            <div class="btn-group" role="group">
                                <button type="button" class="btn btn-default" onclick="changeLineColumn('${basePath}/overall/activeUserComposition')">活跃用户构成</button>
                            </div>
                            <div class="btn-group" role="group">
                                <button type="button" class="btn btn-default" onclick="changeLine('${basePath}/overall/useTimeMonth')">平均日使用时长</button>
                            </div>
                        </div>
                        <div id="my-chart"></div>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="/WEB-INF/jsp/common/footer.jsp" %>
    </div>
</body>
</html>
