<%@ page contentType="text/html;charset=UTF-8" language="java"
	isELIgnored="false"%>
<!DOCTYPE HTML>
<html lang="zh-CN">
<head>
<title>渠道管理</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@include file="/WEB-INF/jsp/common/common.jsp"%>
<link href="${basePath}/static/assets/pages/css/login.min.css" rel="stylesheet" type="text/css" />
<link href="${basePath}/static/css/channel/edit.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${basePath}/static/js/channel/channelEdit.js"></script>
</head>
<body class="page-container-bg-solid">
	<div class="page-wrapper">
		<%@include file="/WEB-INF/jsp/common/head.jsp"%>
		<div class="page-wrapper-row full-height">
		        <div class="page-wrapper-middle">
		            <div class="container">
		                <div class="panel panel-default">
		                	<div class="panel-heading"><h4>渠道管理</h4></div>
		                	<div class="panel-body">
								<form class="form-horizontal channelEdit" role="form" method="post">
									<input type="hidden" name="id" value="${channelEdit.id}"> 
									<div class="form-group">
										<label class="col-md-2 control-label">渠道名称<span class="required" aria-required="true"> * </span></label>
										<div class="col-md-4">
											<input type="text" id="channelName" name="channelName" class="form-control" value="${channelEdit.name}" placeholder="">
										</div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">渠道URL</label>
										<div class="col-md-4">
											<input type="text" id="channelUrl" name="channelUrl" class="form-control" value="${channelEdit.url}"  placeholder="">
										</div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">账号<span class="required" aria-required="true"> * </span></label>
										<div class="col-md-4">
											<input type="text" id="accountNum" name="accountNum" class="form-control" value="${channelEdit.user.phone}"  placeholder="">
										</div>
									</div>
									<div class="form-group">
										<label id="secretCode" class="col-md-2 control-label">密码<span class="required" aria-required="true"> * </span></label>
										<div class="col-md-4">
											<input type="password" id="accountSecret" name="accountSecret" class="form-control" value="${channelEdit.user.password}"   placeholder="">
										</div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">结算周期</label>
										<div class="col-md-4">
											<input type="text" id="settlePeriod" name="settlePeriod" class="form-control" value="${channelEdit.settlePeriod}"  placeholder="">
										</div>
										<label style="padding-top:7px;">(天)</label>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">入账账户</label>
										<div class="col-md-4">
											<input type="text" id="billingAccount" name="billingAccount" class="form-control" value="${channelEdit.billingAccount}" placeholder="支付宝/微信/银行卡姓名">
										</div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">入账账号</label>
										<div class="col-md-4">
											<input type="text" id="billingNumber" name="billingNumber" class="form-control" value="${channelEdit.billingNumber}" placeholder="支付宝账号/微信账号/银行卡号">
										</div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">入账银行</label>
										<div class="col-md-4">
											<input type="text" id="billingBank" name="billingBank" class="form-control" value="${channelEdit.billingBank}" placeholder="银行卡所在银行名称">
										</div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">入账支行</label>
										<div class="col-md-4">
											<input type="text" id="billingSubbranch" name="billingSubbranch" class="form-control" value="${channelEdit.billingSubbranch}" placeholder="银行卡所在银行支行名称">
										</div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">联系人</label>
										<div class="col-md-4">
											<input type="text" id="linkman" name="linkman" class="form-control" value="${channelEdit.linkman}"  placeholder="">
										</div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">电子邮箱</label>
										<div class="col-md-4">
											<input type="text" id="email" name="email" class="form-control" value="${channelEdit.email}" placeholder="">
										</div>
									</div>
									<div class="form-group">
										<div class="col-md-offset-2 col-md-10">
											<button type="submit" id="submit" class="btn blue">提交</button>
											<button type="button" onclick="back()"  style="margin-left:5px;" class="btn grey-salsa btn-outline">取消</button>
										</div>
									</div>
								</form>
							</div>
		                </div>
		            </div>
		       </div>
	     </div>    
    </div> 
	<%@include file="/WEB-INF/jsp/common/footer.jsp"%>
	<script type="text/javascript">
		basePath = '${basePath}';
		id = '${channelEdit.id}';
		console.log(id);
		$.validator.addMethod("secretEmptyValidate", function(value) {
			if(id == ''){
				if(value.trim() == ''){
					return false;
				}
				return true;
			}else{
				return true;
			}
		}, '请输入密码');
	</script>
</body>

</html>