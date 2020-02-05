$(function () {
    var url = $(".chart-url").val();
    initChart(url);
});

function initChart(url) {
    // 基于准备好的dom，初始化echarts实例
    echarts.dispose(document.getElementById("my-chart"));
    var myChart = echarts.init(document.getElementById("my-chart"));
    // 异步加载数据
    $.get(url).done(function (data) {
        myChart.setOption({
            title: {
                text: data.title,
                left: 'center'
            },
            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b} : {c}'
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: {
                type: 'category',
                name: data.xName,
                splitLine: {show: false},
                data: data.xData
            },
            yAxis: {
                type: 'value',
                name: data.yName
            },
            series: [
                {
                    name: '数量',
                    type: 'line',
                    data: data.yData
                }
            ]
        });
    });
}