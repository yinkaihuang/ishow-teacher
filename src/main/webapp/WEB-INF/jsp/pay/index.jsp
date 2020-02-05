<%@ page import="java.util.UUID" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>创建订单</title>
    <%@include file="/WEB-INF/jsp/common/common.jsp" %>
</head>
<body>
<div class="container">
    <div class="panel panel-primary">
        <div class="panel-heading">提交订单</div>
        <div class="panel-body">
            <form class="form-horizontal" method="post" action="/api/payOrder/create">
                <div class="form-group">
                    <label class="col-sm-2 control-label">订单号：</label>
                    <div class="col-sm-10">
                        <input name="orderNum" value="<%=UUID.randomUUID().toString().replaceAll("-","")%>" type="text"
                               class="form-control" placeholder="订单号" required="required">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">金额：</label>
                    <div class="col-sm-10">
                        <input name="price" value="0.01" type="text" class="form-control" placeholder="金额"
                               required="required">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">用户ID：</label>
                    <div class="col-sm-10">
                        <input name="userId" value="1001" type="text" class="form-control" placeholder="用户ID"
                               required="required">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">备注：</label>
                    <div class="col-sm-10">
                        <input name="remarks" value="订单备注" type="text" class="form-control" placeholder="备注"
                               required="required">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">手机号：</label>
                    <div class="col-sm-10">
                        <input name="phone" value="13128267222" type="text" class="form-control" placeholder="手机号"
                               required="required">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">版本：</label>
                    <div class="col-sm-10">
                        <input name="version" value="1.0" type="text" class="form-control" placeholder="版本"
                               required="required">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">支付类型：</label>
                    <div class="col-sm-10">
                        <input name="payType" value="android" type="text" class="form-control" placeholder="支付类型"
                               required="required">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="submit" class="btn btn-success">提交</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
