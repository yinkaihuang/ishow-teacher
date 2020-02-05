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
</head>
<body class="page-container-bg-solid">
<div class="page-wrapper">
    <%@include file="/WEB-INF/jsp/common/head.jsp" %>
    <div class="page-wrapper-row full-height">
        <div class="page-wrapper-middle">
            <div class="container">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4>当日基础数据</h4>
                    </div>
                    <div class="panel-body">
                        <input type="hidden" value="${url}" class="chart-url">
                        <ul class="nav nav-tabs nav-justified">
                            <li role="presentation" class="${active==1?"active":""}"><a
                                    href="${basePath}/chart/user/addUI">新增用户</a></li>
                            <li role="presentation" class="${active==2?"active":""}"><a
                                    href="${basePath}/chart/user/startUpUI">启动次数</a>
                            </li>
                            <%--<li role="presentation" class="${active==3?"active":""}"><a
                                    href="${basePath}/chart/user/activeUserUI">活跃用户数</a></li>--%>
                            <li role="presentation" class="${active==4?"active":""}"><a
                                    href="${basePath}/chart/user/payUserUI">付费用户数</a>
                            </li>
                            <li role="presentation" class="${active==5?"active":""}"><a
                                    href="${basePath}/chart/user/payMoneyUI">付费金额</a></li>
                            <%--<li role="presentation" class="${active==6?"active":""}"><a
                                    href="${basePath}/chart/user/addPayUserUI">新增付费用户数</a></li>--%>
                            <%--<li role="presentation" class="${active==7?"active":""}"><a
                                    href="${basePath}/chart/user/averageUI">平均使用时长（分）</a>
                            </li>--%>
                        </ul>
                        <div class="alert alert-info" role="alert">
                            ${countMap.count}
                            <span class="label label-default"><fmt:formatNumber pattern="0.00%" value="${countMap.percentage}" maxFractionDigits="2"/></span>
                        </div>
                        <div id="my-chart"></div>
                        <div class="btn-group" role="group" style="margin-left: 60px">
                            <button type="button" class="btn btn-default"
                                    onclick="initChart('${url}?queryDate=1')">今天
                            </button>
                            <button type="button" class="btn btn-default"
                                    onclick="initChart('${url}?queryDate=2')">昨天
                            </button>
                            <button type="button" class="btn btn-default"
                                    onclick="initChart('${url}?queryDate=3')">七天前
                            </button>
                            <button type="button" class="btn btn-default"
                                    onclick="initChart('${url}?queryDate=4')">三十天前
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="/WEB-INF/jsp/common/footer.jsp" %>
    </div>
</body>
</html>
