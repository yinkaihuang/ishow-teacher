<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="page-wrapper-row">
    <div class="page-wrapper-top">
        <!-- BEGIN HEADER -->
        <div class="page-header">
            <!-- BEGIN HEADER TOP -->
            <div class="page-header-top">
                <div class="container">
                    <!-- BEGIN LOGO -->
                    <div class="page-logo">
                        <a href="/home/index">
                            <img src="${basePath}/static/assets/layouts/layout3/img/logo-default.jpg" alt="logo"
                                 class="logo-default">
                        </a>
                    </div>
                    <!-- END LOGO -->
                    <!-- BEGIN RESPONSIVE MENU TOGGLER -->
                    <a href="javascript:;" class="menu-toggler"></a>
                    <!-- END RESPONSIVE MENU TOGGLER -->
                    <!-- BEGIN TOP NAVIGATION MENU -->
                    <div class="top-menu">
                        <ul class="nav navbar-nav pull-right">
                            <!-- BEGIN USER LOGIN DROPDOWN -->
                            <li class="dropdown dropdown-user dropdown-dark">
                                <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown"
                                   data-hover="dropdown" data-close-others="true">
                                    <span class="username username-hide-mobile">${currentUser.phone}</span>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-default">
                                    <li>
                                        <a href="/user/logout">
                                            <i class="icon-key"></i>退出</a>
                                    </li>
                                </ul>
                            </li>
                            <!-- END USER LOGIN DROPDOWN -->
                            <!-- BEGIN QUICK SIDEBAR TOGGLER -->
                            <li class="dropdown dropdown-extended quick-sidebar-toggler">
                                <span class="sr-only">Toggle Quick Sidebar</span>
                                <i class="icon-logout" onclick="logout()"></i>
                            </li>
                            <!-- END QUICK SIDEBAR TOGGLER -->
                        </ul>
                    </div>
                    <!-- END TOP NAVIGATION MENU -->
                </div>
            </div>
            <!-- END HEADER TOP -->
            <!-- BEGIN HEADER MENU -->
            <div class="page-header-menu">
                <div class="container">
                    <!-- BEGIN MEGA MENU -->
                    <!-- DOC: Apply "hor-menu-light" class after the "hor-menu" class below to have a horizontal menu with white background -->
                    <!-- DOC: Remove data-hover="dropdown" and data-close-others="true" attributes below to disable the dropdown opening on mouse hover -->
                    <div class="hor-menu  ">
                        <ul class="nav navbar-nav">
                            <li aria-haspopup="true" class="menu-dropdown classic-menu-dropdown ">
                                <a href="javascript:;"> 系统管理
                                    <span class="arrow"></span>
                                </a>
                                <ul class="dropdown-menu pull-left">
                                    <li aria-haspopup="true" class=" ">
                                        <a href="${basePath}/user/teacher" class="nav-link  ">
                                            <i class="fa fa-user"></i> 教师管理
                                        </a>
                                    </li>
                                    <li aria-haspopup="true" class=" ">
                                        <a href="${basePath}/user/student" class="nav-link  ">
                                            <i class="fa fa-cloud"></i> 学生管理
                                        </a>
                                    </li>
                                </ul>
                            </li>

                            <li aria-haspopup="true" class="menu-dropdown classic-menu-dropdown">
                                <a href="javascript:;"> 教学管理
                                    <span class="arrow"></span>
                                </a>
                                <ul class="dropdown-menu pull-left">
                                    <li aria-haspopup="true" class="nav-link  ">
                                        <a href="${basePath }/course/listPage" class="nav-link"> 视频列表 </a>
                                    </li>
                                </ul>
                            </li>

                            <li aria-haspopup="true" class="menu-dropdown classic-menu-dropdown ">
                                <a href="javascript:;"> 报表管理
                                    <span class="arrow"></span>
                                </a>
                                <ul class="dropdown-menu pull-left">
                                    <li aria-haspopup="true" class=" ">
                                        <a href="${basePath}/chart/user/addUI" class="nav-link  ">
                                            <i class="fa fa-user"></i> 实时统计
                                        </a>
                                    </li>
                                    <li aria-haspopup="true" class=" ">
                                        <a href="${basePath}/overall/chart" class="nav-link  ">
                                            <i class="fa fa-user-secret"></i> 整体趋势 </a>
                                    </li>
                                    <li aria-haspopup="true" class=" ">
                                        <a href="${basePath}/chart/region" class="nav-link  ">
                                            <i class="fa fa-cloud"></i> 地域
                                        </a>
                                    </li>
                                    <li aria-haspopup="true" class=" ">
                                        <a href="${basePath}/chart/userKeep" class="nav-link  ">
                                            <i class="fa fa-cloud"></i> 留存分析
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <li aria-haspopup="true" class="menu-dropdown classic-menu-dropdown ">
                                <a href="javascript:;"> 财务
                                    <span class="arrow"></span>
                                </a>
                                <ul class="dropdown-menu pull-left">

                                    <li aria-haspopup="true" class="admin">
                                        <a href="${basePath }/system/settlement/settlement.do" class="nav-link">
                                            财务结算 </a>
                                    </li>
                                    <li aria-haspopup="true">
                                        <a href="${basePath }/settlement/gotoSettleList.do" class="nav-link  "> 财务报表
                                        </a>
                                    </li>
                                    <li aria-haspopup="true">
                                        <a href="${basePath }/system/settlement/commissionSettle.do" class="nav-link  ">
                                            佣金
                                        </a>
                                    </li>
                                </ul>
                            </li>

                        </ul>
                    </div>
                    <!-- END MEGA MENU -->
                </div>
            </div>
            <!-- END HEADER MENU -->
        </div>
        <!-- END HEADER -->
    </div>
</div>

<script>
    function logout() {
        $.ajax({
            type: "POST",
            url: "${basePath}/user/logout",
            success: function (result) {
                if (result.code == 200) {
                    window.location.href="/index"
                } else {
                    layer.msg(result.msg);
                }
            }
        });
    }
</script>