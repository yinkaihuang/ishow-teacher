$(function () {
        //表格
        $('#region-table').bootstrapTable({
            url: "/reportUserKeep/list",
            columns: [
                [
                    {
                        title: "",
                        valign: "middle",
                        align: "center",
                        colspan: 2,
                        rowspan: 1
                    },
                    {
                        title: "留存率",
                        valign: "middle",
                        align: "center",
                        colspan: 10,
                        rowspan: 1
                    }
                ],
                [
                    {
                        field: 'id',
                        title: 'ID',
                        visible: false
                    }, {
                    field: 'createTime',
                    title: '首次使用时间',
                    formatter: formatDate
                }, {
                    field: 'num',
                    title: '新增用户'
                }, {
                    field: 'one',
                    title: '1天后',
                    formatter: percentage
                }, {
                    field: 'two',
                    title: '2天后',
                    formatter: percentage
                }, {
                    field: 'three',
                    title: '3天后',
                    formatter: percentage
                }, {
                    field: 'four',
                    title: '4天后',
                    formatter: percentage
                }, {
                    field: 'five',
                    title: '5天后',
                    formatter: percentage
                }, {
                    field: 'six',
                    title: '6天后',
                    formatter: percentage
                }, {
                    field: 'seven',
                    title: '7天后',
                    formatter: percentage
                }, {
                    field: 'fourteen',
                    title: '14天后',
                    formatter: percentage
                }, {
                    field: 'thirty',
                    title: '30天后',
                    formatter: percentage
                }
                ]
            ]
        });
    }
)
;