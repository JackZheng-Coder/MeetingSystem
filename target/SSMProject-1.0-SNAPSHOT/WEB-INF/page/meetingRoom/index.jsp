<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String path=request.getContextPath();
    String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <meta charset="utf-8">
    <title>layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%=basePath%>lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="stylesheet" href="<%=basePath%>css/public.css" media="all">
    <style>
        .layui-icon{
            margin-top: 15px;
        }
        .layui-table-cell .layui-form-checkbox[lay-skin="primary"]{
            transform: translateY(-30%);
        }
    </style>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <fieldset class="table-search-fieldset">
            <legend>搜索信息</legend>
            <div style="margin: 10px 10px 10px 10px">
                <form class="layui-form layui-form-pane" action="">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">会议室名称</label>
                            <div class="layui-input-inline">
                                <input type="text" name="name" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">人数</label>
                            <div class="layui-input-inline">
                                <input type="text" name="counts" autocomplete="off" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-inline">
                            <button type="submit" class="layui-btn layui-btn-primary"  lay-submit lay-filter="data-search-btn"><i class="layui-icon"></i> 搜 索</button>
                        </div>
                    </div>
                </form>
            </div>
        </fieldset>

        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"> 添加 </button>
                <button class="layui-btn layui-btn-sm layui-btn-danger data-delete-btn" lay-event="delete"> 删除 </button>
            </div>
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">删除</a>
        </script>

    </div>
</div>
<script type="text/html" id="imgTpl">
   <img src="http://localhost:8080/{{ d.img }}" style="height: 45px;width: 45px">
</script>
<script src="<%=basePath%>lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table;

        table.render({
            elem: '#currentTableId',
            url: '<%=basePath%>meetingRoom/queryMeetingRoomAll',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "checkbox", width: 50},
                // {field: 'id', width: 80, title: 'ID', sort: true},
                {field: 'name', width: 100, title: '会议室名称'},
                {field: 'counts', width: 80, title: '人数', sort: true},
                {field: 'img', width: 80, title: '图片', templet:'#imgTpl'},
                {
                    field: 'isPc', width: 100, align: 'center', templet: function (d) {//是否内置笔记本
                        if (d.isPc == 0) {
                            return '<span class="layui-badge layui-bg-green">无笔记本s</span>';
                        }
                        else {
                            return '<span class="layui-badge layui-bg-blue">内置笔记本</span>';
                        }
                    }, title: '内置笔记本'
                },


                {
                    field: 'isProjector', width: 100, align: 'center', templet: function (d) {//是否内置投影
                        if (d.isProjector == 0) {
                            return '<span class="layui-badge layui-bg-green">无投影</span>';
                        }
                        else {
                            return '<span class="layui-badge layui-bg-blue">内置投影</span>';
                        }
                    }, title: '内置投影'
                },

                {
                    field: 'isTel', width: 100, align: 'center', templet: function (d) {//是否支持电话会议
                        if (d.isTel == 0) {
                            return '<span class="layui-badge layui-bg-green">不支持</span>';
                        }
                        else {
                            return '<span class="layui-badge layui-bg-blue">支持</span>';
                        }
                    }, title: '支持电话会议'
                },
                {
                    field: 'status', width: 100, align: 'center', templet: function (d) {
                        if (d.status == 0) {
                            return '<span class="layui-badge layui-bg-green">已被预定</span>';
                        }
                        else {
                            return '<span class="layui-badge layui-bg-blue">可预订</span>';
                        }
                    }, title: '状态'
                },
                // {field: 'deptId', title: '部门', minWidth: 150},
                // {templet:'<div>{{d.dept.name}}</div>' ,title: '部门', width: 150},
                // {field: 'tel', width: 150, title: '电话'},
                // {field: 'email', width: 150, title: '邮箱'},
                {title: '操作', minWidth: 150, toolbar: '#currentTableBar', align: "center"}
            ]],
            limits: [10, 15, 20, 25, 50, 100],
            limit: 15,
            page: true,
            skin: 'line'
        });

        // 监听搜索操作
        form.on('submit(data-search-btn)', function (data) {
            var name=data.field.name;
            var counts=data.field.counts;
            //执行搜索重载
            table.reload('currentTableId', {
                page: {
                    curr: 1
                }
                , where: {
                    name:name,
                    counts:counts
                }
            }, 'data');

            return false;
        });

        /**
         * toolbar监听事件
         */
        table.on('toolbar(currentTableFilter)', function (obj) {
            if (obj.event === 'add') {  // 监听添加操作
                var index = layer.open({
                    title: '添加会议室',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: 'meetingRoom/add',
                    end:function () {
                        window.location.reload();
                    }
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });

            } else if (obj.event === 'delete') {  // 监听删除操作
                /*
                     1、提示内容，必须删除大于0条
                     2、获取要删除记录的id信息
                     3、提交删除功能 ajax
                   */
                //获取选中的记录信息
                var checkStatus=table.checkStatus(obj.config.id);
                var data=checkStatus.data;
                if(data.length==0){//如果没有选中信息
                    layer.msg("请选择要删除的记录信息");
                }else{
                    //获取记录信息的id集合
                    var ids=getCheackId(data);
                    layer.confirm('真的删除行么', function (index) {
                        //调用删除功能
                        deleteInfoByIds(ids,index);
                        layer.close(index);
                    });
                }
            }

        });

        /**
         * 提交删除功能
         */
        function deleteInfoByIds(ids ,index){
            //向后台发送请求
            $.ajax({
                url: "<%=basePath%>meetingRoom/deleteByIds",
                type: "POST",
                data: {ids: ids},
                success: function (result) {
                    if (result.code == 0) {//如果成功
                        layer.msg('删除成功', {
                            icon: 6,
                            time: 500
                        }, function () {
                            parent.window.location.reload();
                            var iframeIndex = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(iframeIndex);
                        });
                    } else {
                        layer.msg("删除失败");
                    }
                }
            })
        };


        /**
         * 获取记录信息的id
         */
        function getCheackId(data){
            var arr=new Array();
            for(var i=0;i<data.length;i++){
                arr.push(data[i].id);
            }
            return arr.join(",");
        }


        //监听表格复选框选择
        table.on('checkbox(currentTableFilter)', function (obj) {
            console.log(obj)
        });

        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            if (obj.event === 'edit') {
                var index = layer.open({
                    title: '编辑会议室',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: '<%=basePath%>meetingRoom/update?id='+data.id,
                    end:function () {
                        window.location.reload();
                    }
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            } else if (obj.event === 'delete') {
                layer.confirm('真的删除行么', function (index) {
                    deleteInfoByIds(data.id,index);
                    layer.close(index);
                });
            }
        });

    });
</script>

</body>
