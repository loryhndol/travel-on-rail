<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <title>Travel On Rail - Admin</title>
    <script src="/static/js/d3.v5.js"></script>
    <link rel="stylesheet" href="/static/layui-v2.6.8/css/layui.css" />
    <script src="/static/layui-v2.6.8/layui.js"></script>
</head>

<body>
    <div class="layui-layout layui-layout-admin">
        <div class="layui-header">
            <div class="layui-logo layui-hide-xs layui-bg-black" href="/admin/index.html"> 管理员页面 </div>
            <!-- 头部区域（可配合layui 已有的水平导航） -->
            <ul class="layui-nav layui-layout-left">
                <!-- 移动端显示 -->
                <li class="layui-nav-item layui-show-xs-inline-block layui-hide-sm" lay-header-event="menuLeft">
                    <i class="layui-icon layui-icon-spread-left"></i>
                </li>

                <li class="layui-nav-item layui-hide-xs"><a href="/admin/index.html">返回首页</a></li>
                <li class="layui-nav-item layui-hide-xs"><a href="">nav 1</a></li>
                <li class="layui-nav-item layui-hide-xs"><a href="">nav 2</a></li>
                <li class="layui-nav-item layui-hide-xs"><a href="">nav 3</a></li>
                <li class="layui-nav-item">
                    <a href="javascript:;">nav groups</a>
                    <dl class="layui-nav-child">
                        <dd><a href="">menu 11</a></dd>
                        <dd><a href="">menu 22</a></dd>
                        <dd><a href="">menu 33</a></dd>
                    </dl>
                </li>
            </ul>
            <ul class="layui-nav layui-layout-right">
                <li class="layui-nav-item layui-hide layui-show-md-inline-block">
                    <a href="javascript:;">
                        <img src="" class="layui-nav-img" />
                        admin
                    </a>
                    <dl class="layui-nav-child">
                        <dd><a href="">个人信息</a></dd>
                        <dd><a href="">设置</a></dd>
                        <dd><a href="">退出登录</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item" lay-header-event="menuRight" lay-unselect>
                    <a href="javascript:;">
                        <i class="layui-icon layui-icon-more-vertical"></i>
                    </a>
                </li>
            </ul>
        </div>

        <div class="layui-side layui-bg-black">
            <div class="layui-side-scroll">
                <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
                <ul class="layui-nav layui-nav-tree" lay-filter="test">
                    <li class="layui-nav-item layui-nav-itemed">
                        <a class="" href="javascript:;">图形监视器</a>
                        <dl class="layui-nav-child">
                            <dd><a href="/admin/train/index.html">列车</a></dd>
                            <dd><a href="/admin/ticket/index.html">票务</a></dd>
                            <dd><a href="/admin/orders/index.html">订单</a></dd>
                        </dl>
                    </li>
                    <li class="layui-nav-item layui-nav-itemed">
                        <a href="javascript:;">表格数据</a>
                        <dl class="layui-nav-child">
                            <dd><a href="/admin/ticket/all.html">车票</a></dd>
                            <dd><a href="/admin/users/all.html">用户余额</a></dd>
                        </dl>
                    </li>
                </ul>
            </div>
</div>