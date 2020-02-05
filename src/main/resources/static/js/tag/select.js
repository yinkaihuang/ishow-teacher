//查询子下拉列表
function querySon(result) {
	// 得到当前下拉框的key值
	var key = $(result).attr("key");
	// parentKey等于key的下拉框即为子下拉框
	var son = $("select[parentkey='" + key + "']");
	return son;
}

// 递归删除子下拉框
function clearSon(result) {
	if ($(result).length > 0) {
		var son = querySon(result);
		// 清除子下拉列表的值
		$(son).children().remove();
		clearSon(son);
	}
}

// 查询子下拉数据并填充
function cascade(result) {
	clearSon(result);
	// 得到选中的value值
	var value = $(result).val();
	if (value == 0) {
		return;
	}
	var son = querySon(result);
	var code = $(son).attr("code");
	var url = "${basePath}/dict/select";
	$.ajax({
		type : "GET",
		url : url,
		success : function(result) {
			var opt = "<option value='0'>==请选择==</option>";
			for (var i = 0; i < result.length; i++) {
				opt += "<option value='" + result[i].id + "'>" + result[i].text
						+ "</option>";
			}
			$(son).append(opt);
		}
	});
}
