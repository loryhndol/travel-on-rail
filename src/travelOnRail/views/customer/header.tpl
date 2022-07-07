<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <title>Travel On Rail</title>
    <script src="/static/js/d3.v5.js"></script>
    <link rel="stylesheet" href="/static/layui-v2.6.8/css/layui.css" />
    <script src="/static/layui-v2.6.8/layui.js"></script>
    <script>
        //注意：导航 依赖 element 模块，否则无法进行功能性操作
        layui.use('element', function() {
            var element = layui.element;

            //…
        });
    </script>
</head>

<body>
    <div class="layui-layout layui-layout-admin">

        <div class="layui-header layui-bg-cyan">
            <div class="layui-logo layui-hide-xs layui-bg-blue"> Travel On Rail </div>
            <!-- 头部区域（可配合layui 已有的水平导航） -->
            <ul class="layui-nav layui-layout-left" lay-filter="">
                <li class="layui-nav-item">
                    <a href="javascript:;">车票购买</a>
                    <dl class="layui-nav-child">
                        <!-- 二级菜单 -->
                        <dd><a href="leftTicket">单程票</a></dd>
                        <dd><a href="interchange">中转票</a></dd>
                        <dd><a href="leftTicket">往返票</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">车票变更</a>
                    <dl class="layui-nav-child">
                        <!-- 二级菜单 -->
                        <dd><a href="">退票</a></dd>
                        <dd><a href="">改签</a></dd>
                        <dd><a href="">变更到站</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">信息服务</a>
                    <dl class="layui-nav-child">
                        <!-- 二级菜单 -->
                        <dd><a href="">车站时刻表</a></dd>
                        <dd><a href="">正晚点查询</a></dd>
                        <dd><a href="">车站风采</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">出行指南</a>
                    <dl class="layui-nav-child">
                        <!-- 二级菜单 -->
                        <dd><a href="">常见问题</a></dd>
                        <dd><a href="">旅客须知</a></dd>
                        <dd><a href="">相关规定</a></dd>
                    </dl>
                </li>
            </ul>


            <ul class="layui-nav layui-layout-right" lay-filter="">
                <li class="layui-nav-item">
                    <a href="">个人中心<span class="layui-badge-dot"></span></a>
                </li>
                <li class="layui-nav-item">
                    <a href=""><img src="" class="layui-nav-img">我</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;">修改信息</a></dd>
                        <dd><a href="javascript:;">安全管理</a></dd>
                        <dd><a href="javascript:;">退出登录</a></dd>
                    </dl>
                </li>
            </ul>

</div>