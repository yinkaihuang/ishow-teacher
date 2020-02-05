function createChart(beginDate, endDate, dateType, region, addOrStart) {
    // 基于准备好的dom，初始化echarts实例
    echarts.dispose(document.getElementById("chart"));
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('chart'));
    // 异步加载数据
    var url = "/reportArea/top?beginDate="+beginDate+"&endDate="+endDate+"&dateType="+dateType+"&region="+region+"&addOrStart="+addOrStart;
    $.get(url).done(function (data) {
        myChart.setOption(
            {
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                        type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                    }
                },
                xAxis: [
                    {
                        type: 'value'
                    }
                ],
                yAxis: [
                    {
                        type: 'category',
                        axisTick: {show: false},
                        data: data.xData
                    }
                ],
                series: [
                    {
                        name: '数量',
                        type: 'bar',
                        label: {
                            normal: {
                                show: true,
                                position: 'inside'
                            }
                        },
                        data: data.yData,
                        barMaxWidth:30
                    }
                ]
            }
        );
    });
}