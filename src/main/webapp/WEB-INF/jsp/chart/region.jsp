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
    <script src="${basePath}/static/echarts/echarts.common.min.js"></script>
    <script src="${basePath}/static/js/chart/horizontalLineChart.js"></script>
    <script src="${basePath}/static/js/common/date.js"></script>
    <script src="${basePath}/static/js/chart/region.js"></script>
</head>
<!-- END HEAD -->
<body class="page-container-bg-solid">
<div class="page-wrapper">
    <%@include file="/WEB-INF/jsp/common/head.jsp" %>
    <div class="page-wrapper-row full-height">
        <div class="page-wrapper-middle">
            <div class="container">
                <div>
                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs" role="tablist">
                        <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab"
                                                                  data-toggle="tab" class="my-tab" data-type="province">省份</a>
                        </li>
                        <li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab"
                                                   class="my-tab" data-type="area">区域</a>
                        </li>
                        <li role="presentation"><a href="#messages" aria-controls="messages" role="tab"
                                                   data-toggle="tab" class="my-tab" data-type="city">城市</a>
                        </li>
                    </ul>
                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4>区域</h4>
                            </div>
                            <div class="panel-body">
                                <input type="hidden" class="addOrStart" value="add">
                                <input type="hidden" class="dateType" value="1">
                                <input type="hidden" class="region" value="province">
                                <div class="row">
                                    <div class="col-sm-3">
                                        <div class="btn-group statistics-parent" role="group">
                                            <button type="button" class="btn btn-default active statistics"
                                                    data-statistics="add">新增用户
                                            </button>
                                            <button type="button" class="btn btn-default statistics"
                                                    data-statistics="startUp">启动次数
                                            </button>
                                        </div>
                                    </div>
                                    <div class="col-sm-9">
                                        <div class="row">
                                            <div class="col-sm-5">
                                                <div class="btn-group dateType-parent" role="group">
                                                    <button type="button" class="btn btn-default active dateType"
                                                            data-date="1">全部
                                                    </button>
                                                    <button type="button" class="btn btn-default dateType"
                                                            data-date="2">今天
                                                    </button>
                                                    <button type="button" class="btn btn-default dateType"
                                                            data-date="3">7日
                                                    </button>
                                                    <button type="button" class="btn btn-default dateType"
                                                            data-date="4">14日
                                                    </button>
                                                    <button type="button" class="btn btn-default dateType"
                                                            data-date="5">30日
                                                    </button>
                                                </div>
                                            </div>
                                            <div class="col-sm-5">
                                                <div class="input-group input-large date-picker input-daterange"
                                                     data-date="10/11/2012"
                                                     data-date-format="mm/dd/yyyy">
                                                    <input placeholder="开始日期" type="text"
                                                           class="form-control beginDate my-date">
                                                    <span class="input-group-addon"> 至 </span>
                                                    <input placeholder="结束日期" type="text"
                                                           class="form-control endDate my-date">
                                                </div>
                                            </div>
                                            <div class="col-sm-2">
                                                <button type="button" class="btn btn-primary myQuery">查询</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="chart" class="my-chart"></div>
                            </div>
                        </div>
                        <div role="tabpanel" class="tab-pane active" id="home"></div>
                        <div role="tabpanel" class="tab-pane" id="profile"></div>
                        <div role="tabpanel" class="tab-pane" id="messages"></div>
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4>数据明细</h4>
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
    </div>
</div>
<%@include file="/WEB-INF/jsp/common/footer.jsp" %>
</div>
</body>
</html>