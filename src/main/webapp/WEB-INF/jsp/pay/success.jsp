<%--
  Created by IntelliJ IDEA.
  User: CIKE
  Date: 2017/8/24
  Time: 11:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>支付成功</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/static/weui/weui.css">
    <script src="<%=request.getContextPath()%>/static/js/common/common.js"></script>
</head>
<body>
<div class="page">
    <div class="bd">
        <div class="weui_msg">
            <div class="weui_icon_area"><i class="weui_icon_success weui_icon_msg"></i></div>
            <div class="weui_text_area">
                <h2 class="weui_msg_title">支付成功</h2>
                <p class="weui_msg_desc">您已支付成功</p>
            </div>
            <div class="weui_opr_area">
                <p class="weui_btn_area">
                    <a href="javascript:;" class="weui_btn weui_btn_primary" onclick="andriodLoginClick(this)">确定</a>
                    <a href="javascript:;" class="weui_btn weui_btn_default" onclick="andriodLoginClick(this)">取消</a>
                </p>
            </div>
            <div class="weui_extra_area">
                <a href="">查看详情</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
