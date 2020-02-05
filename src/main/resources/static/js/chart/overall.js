function changeLineColumn(url) {
    // 基于准备好的dom，初始化echarts实例
    echarts.dispose(document.getElementById("my-chart"));
    var myChart = echarts.init(document.getElementById('my-chart'));
    // 异步加载数据
    $.get(url).done(function (data) {
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption({
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: 'shadow'
                }
            },
            legend: {
                data: ['新用户', '老用户', '新用户占比']
            },
            xAxis: [
                {
                    type: 'category',
                    data: data.xData
                }
            ],
            yAxis: [
                {
                    type: 'value'
                },
                {
                    type: 'value',
                    name: '新用户占比',
                    min: 0,
                    max: 100,
                    interval: 5,
                    axisLabel: {
                        formatter: '{value} %'
                    }
                }
            ],
            series: [
                {
                    name: '新用户',
                    type: 'bar',
                    stack: '广告',
                    data: data.yData1
                },
                {
                    name: '老用户',
                    type: 'bar',
                    stack: '广告',
                    data: data.yData2
                },
                {
                    name: '新用户占比',
                    type: 'line',
                    yAxisIndex: 1,
                    data: data.yData
                }
            ]
        });
    });
}

function changeLine(url) {
    initChart(url);
}