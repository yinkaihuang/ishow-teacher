<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<!-- BEGIN HEAD -->

<head>
    <%@include file="../common/common.jsp" %>
</head>
<!-- END HEAD -->

<body class="page-container-bg-solid">
<div class="page-wrapper">
    <%@include file="../common/head.jsp" %>
    <div class="page-wrapper-row full-height">
        <div class="page-wrapper-middle">
            <div class="container">
                <div class="panel panel-default">
                    <div class="panel-heading"><h4>上传课程视频</h4></div>
                    <div class="panel-body">
                        <form class="form-horizontal " id="addCourse" >
                            <div class="form-group">
                                <label class="col-md-2 control-label">课程名称</label>
                                <div class="col-md-4">
                                    <input name="name" type="text"
                                           class="form-control">
                                </div>
                                <label class="col-md-2 control-label">讲师</label>
                                <div class="col-md-4">
                                    <input name="author" type="text"
                                           class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label">类型</label>
                                <div class="col-md-4">
                                    <select class="form-control" name="type">
                                        <option value=''>-请选择-</option>
                                        <option value='1'>-数 学-</option>
                                        <option value='2'>-英 语-</option>
                                        <option value='3'>-物 理-</option>
                                        <option value='4'>-语 文-</option>
                                        <option value='5'>-化 学-</option>
                                    </select>
                                </div>
                                <label class="col-md-2 control-label">级别</label>
                                <div class="col-md-4">
                                    <select class="form-control" name="level">
                                        <option value=''>-请选择-</option>
                                        <option value='1'>-基 础-</option>
                                        <option value='2'>-进 阶-</option>
                                        <option value='3'>-拔 高-</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label">标签</label>
                                <div class="col-md-4">
                                    <input name="tag" type="text"
                                           class="form-control"></div>
                                <label class="col-md-2 control-label">价格</label>
                                <div class="col-md-4">
                                    <input name="price" type="number"
                                           class="form-control"></div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label">封面</label>
                                <div class="col-md-4">
                                    <input type="text" hidden="true" id="imageId" name="imageId" value="">
                                    <input type="file"
                                           onchange="fileUpload('imageId',this,'ImageProgress')"
                                           class="form-control">
                                    <progress id="ImageProgress" max="100" value="0"></progress>
                                </div>
                                <label class="col-md-2 control-label">视频</label>
                                <div class="col-md-4">
                                    <input id="videoId" name="videoId" hidden="true" value="">
                                    <input type="file"
                                           onchange="fileUpload('videoId',this,'videoProgress')"
                                           class="form-control">
                                    <progress id="videoProgress" max="100" value="0"></progress>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label">描述</label>
                                <div class="col-md-4">
                                    <input name="description" type="text" value=""
                                           class="form-control"></div>
                            </div>

                            <div class="form-group">
                                <div class="col-md-offset-2 col-md-10">
                                    <button type="button" onclick="addCourse()" class="btn blue">提交</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@include file="../common/footer.jsp" %>
    <script type="text/javascript">
        function fileUpload(textId, value, processId) {
            var fileObj = value.files[0];
            var md5 = hex_md5(fileObj.lastModified + "-" + fileObj.name + "-" + fileObj.size + "-" + fileObj.type);
            var fileName = fileObj.name;
            var length = fileObj.size;
            $.ajax({
                type: "POST",
                url: "/file/obtainPosition",
                data: {"md5": md5, "name": fileName, "length": length},
                success: function (result) {
                    if (result.code == 200) {
                        var id = result.data.id;
                        var position = result.data.startPosition;
                        //进行真正上传文件
                        beginUploadFile(id, textId, position, fileObj, processId)
                    } else {
                        layer.msg(result.msg);
                    }
                }
            });
        }


        function beginUploadFile(id, textId, position, fileObj, processId) {
            var xhr = new XMLHttpRequest();
            //进度条部分
            xhr.upload.onprogress = function (evt) {
                if (evt.lengthComputable) {
                    var percentComplete = Math.round(evt.loaded * 100 / evt.total);
                    document.getElementById(processId).value = percentComplete;
                }
            };
            xhr.open("POST", "../file/uploadFile");
            xhr.setRequestHeader("id", parseInt(id));
            xhr.setRequestHeader("position", parseInt(position))
            xhr.overrideMimeType("application/octet-stream");
            fileObj = fileObj.slice(position)
            xhr.send(fileObj);
            xhr.onreadystatechange = function () {
                var result = xhr.responseText;
                var json = JSON.parse(result);
                if (json.code == 200) {
                    document.getElementById(textId).setAttribute("value", id);
                    document.getElementById(processId).value = 100;
                    layer.msg("上传成功");
                }
            }

        }


        function addCourse() {
            var data = $("#addCourse").serialize();
            $.ajax({
                type: "POST",
                url: "/course/addCourse",
                data: data,
                success: function (result) {
                    if (result.code == 200) {
                        window.location.href = "${basePath}/course/listPage";
                    } else if (result.code == 401) {
                        window.location.href = "${basePath}/login";
                    } else {
                        layer.msg(result.msg);
                    }
                }
            });
            return false;
        }

    </script>
</div>
</body>
</html>