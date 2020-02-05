$(function () {
    //生成柱形图
    updateAll();
    //点击新增用户或启动次数
    $(".statistics").click(function () {
        $(this).parent(".statistics-parent").find(".statistics").removeClass("active");
        $(this).addClass("active");
        var dataStatistics = $(this).attr("data-statistics");
        $(".addOrStart").val(dataStatistics);
        updateChart();
    });
    //点击时间
    $(".dateType").click(function () {
        $(this).parent(".dateType-parent").find(".dateType").removeClass("active");
        $(this).addClass("active");
        var dataDate = $(this).attr("data-date");
        $(".dateType").val(dataDate);
        updateAll();
    });
    //点击省市区
    $('.my-tab').click(function () {
        createChart();
        var region = $(this).attr("data-type");
        $(".region").val(region);
        updateAll();
    });
    //点击查询
    $(".myQuery").click(function () {
        var beginDate = $(".beginDate").val();
        if (beginDate == "") {
            layer.msg("开始日期不能为空");
            return;
        }
        var endDate = $(".endDate").val();
        if (endDate == "") {
            layer.msg("结束日期不能为空");
            return;
        }
        $(".dateType").val(0);
        updateAll();
    });

    //柱状图
    function updateChart() {
        var beginDate = $(".beginDate").val();
        var endDate = $(".endDate").val();
        var dateType = $(".dateType").val();
        var region = $(".region").val();
        var addOrStart = $(".addOrStart").val();
        createChart(beginDate, endDate, dateType, region, addOrStart);
    }

    //表格
    function updateTable(beginDate, endDate, dateType, region, addOrStart) {
        var url = "/reportArea/detail?beginDate=" + beginDate + "&endDate=" + endDate + "&dateType=" + dateType + "&region=" + region + "&addOrStart=" + addOrStart;
        if (region == "province") {
            $('#region-table').bootstrapTable("destroy");
            $('#region-table').bootstrapTable({
                url: url,
                columns: [
                    {
                        field: 'id',
                        title: 'ID',
                        visible: false
                    }, {
                        field: 'province',
                        title: '省份'
                    }, {
                        field: 'addUserNum',
                        title: '新增用户'
                    }, {
                        field: 'addRate',
                        title: '新增占比',
                        formatter: percentage
                    }, {
                        field: 'startUpNum',
                        title: '启动次数'
                    }, {
                        field: 'startRate',
                        title: '启动占比',
                        formatter: percentage
                    }
                ]
            });
        }
        if (region == "city") {
            $('#region-table').bootstrapTable("destroy");
            $('#region-table').bootstrapTable({
                url: url,
                columns: [
                    {
                        field: 'id',
                        title: 'ID',
                        visible: false
                    }, {
                        field: 'city',
                        title: '城市'
                    }, {
                        field: 'addUserNum',
                        title: '新增用户'
                    }, {
                        field: 'addRate',
                        title: '新增占比',
                        formatter: percentage
                    }, {
                        field: 'startUpNum',
                        title: '启动次数'
                    }, {
                        field: 'startRate',
                        title: '启动占比',
                        formatter: percentage
                    }
                ]
            });
        }
        if (region == "area") {
            $('#region-table').bootstrapTable("destroy");
            $('#region-table').bootstrapTable({
                url: url,
                columns: [
                    {
                        field: 'id',
                        title: 'ID',
                        visible: false
                    }, {
                        field: 'area',
                        title: '区域'
                    }, {
                        field: 'addUserNum',
                        title: '新增用户'
                    }, {
                        field: 'addRate',
                        title: '新增占比',
                        formatter: percentage
                    }, {
                        field: 'startUpNum',
                        title: '启动次数'
                    }, {
                        field: 'startRate',
                        title: '启动占比',
                        formatter: percentage
                    }
                ]
            });
        }
    }

    function updateAll() {
        var beginDate = $(".beginDate").val();
        var endDate = $(".endDate").val();
        var dateType = $(".dateType").val();
        var region = $(".region").val();
        var addOrStart = $(".addOrStart").val();
        createChart(beginDate, endDate, dateType, region, addOrStart);
        updateTable(beginDate, endDate, dateType, region, addOrStart);
    }

    //格式化百分比
    function percentage(rate) {
        var num = rate * 100;
        num = num.toFixed(2);
        return num + "%";
    }
});