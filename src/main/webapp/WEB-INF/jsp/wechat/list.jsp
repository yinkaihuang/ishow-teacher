<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="../common/common.jsp" %>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <style type="text/css">
        * {
            margin: 0;
            padding: 0;
        }

        .wrap {
            width: 500px;
            margin: 0px auto;

        }

        .menu {
            width: 500px;
            height: 30px;
            background: cornflowerblue;
            position: sticky;
            top: 0px;
        }

        .menu ul li {
            float: left;
            list-style-type: none;
            padding: 0 40px;
        }

        .content ul li img:hover {
            transform: scale(1.2); /*当鼠标移动到图片上时实现放大功能*/
        }

        .content ul li {
            height: 100px;
            overflow: hidden;
            border-bottom: 1px solid lavender;
            background: white;
            list-style-type: none;
            transition-duration: 0.5s;
            margin: 10px 10px 5px 0;

        }

        .content ul li:hover {
            background-color: lavender;
            transition-duration: 0.5s;
        }

        .content .left {
            /*overflow: hidden; !*隐藏溢出图片内容*!*/
            /*transition-duration: 0.5s;*/
            width: 140px;
            height: 80px;
            /*background: green;*/
            float: left;
            margin-right: 20px;
        }

        .content .right {
            width: 300px;
            float: left;
            /*background: pink;*/
        }

        .right_top {
            height: 60px;
        }

        .right_bottom {
            margin_top: 50px;
        }

        .right_bottom_left span {
            color: darkgray;
            font-size: 13px;
        }
    </style>
</head>
<body>
<div class="wrap">
    <div class="menu">
        <ul>
            <li onclick="loadCourse()">最新视频</li>
            <li onclick="loadCourse()">全部视频</li>
            <li>个人中心</li>
        </ul>
    </div>
    <div class="content">
        <ul id="course_list_ul">
            <%--            <li>--%>
            <%--                <div class="left"><img src="../img/new1.png" alt=""></div>--%>
            <%--                <div class="right">--%>
            <%--                    <div class="right_top">--%>
            <%--                        <h3>世界杯最强门卫+门锋！不耍两下你真以为我是门将？</h3>--%>
            <%--                    </div>--%>
            <%--                    <div class="right_bottom">--%>
            <%--                        <div class="right_bottom_left">--%>
            <%--                            <span>诺伊尔</span> <span>世界杯</span> <span>德国</span> <span>|</span> <span>7小时前</span>--%>
            <%--                        </div>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--            </li>--%>

        </ul>
    </div>
</div>
</body>
<script>
    function loadCourse() {
        $.ajax({
            type: "POST",
            url: "/course/listActiveCourse",
            data: {},
            success: function (result) {
                if (result.code == 200) {
                    var records = result.data;
                    if (records == null) {
                        return;
                    }
                    $("#course_list_ul").empty();
                    for (var i = 0; i < records.length; i++) {
                        var id = "video_" + i;
                        var trs = ' <li onclick="play(\'' + id + '\')"><div class="left"><video id=' + id + ' src="${basePath}/file/showVideo?id=' + records[i].videoId + '" controls="controls" enableProgressGesture = "true" controlslist="nodownload" width="140px" height="100px"></video></div> <div class="right"><div class="right_top"><h3>' + records[i].name + '</h3></div><div class="right_bottom"><div class="right_bottom_left"><span>' + records[i].author + '</span> <span>' + records[i].tag + '</span> <span>' + records[i].levelStr + '</span> <span> </span> <span>' + records[i].typeStr + '</span> <span>￥:' + records[i].price + '元</span></div></div></div></li>';
                        $("#course_list_ul").append(trs);
                    }
                } else {
                    layer.msg(result.msg);
                }
            }
        });
    }

    function test() {
        screen.orientation.lock('landscape');
    }

    window.onload = loadCourse();


    function play(v) {
        var video = document.getElementById(v);
        if (video.paused) {
            if (video.requestFullscreen) {
                video.requestFullscreen();
            } else if (video.mozRequestFullScreen) {
                video.mozRequestFullScreen();
            } else if (video.webkitRequestFullScreen) {
                video.webkitRequestFullScreen();
            }
            video.play();
        } else {
            if (video.exitFullscreen) {
                video.exitFullscreen();
            } else if (video.mozCancelFullScreen) {
                video.mozCancelFullScreen();
            } else if (video.webkitCancelFullScreen) {
                video.webkitCancelFullScreen();
            }
            video.pause();
        }
    }

</script>
</html>