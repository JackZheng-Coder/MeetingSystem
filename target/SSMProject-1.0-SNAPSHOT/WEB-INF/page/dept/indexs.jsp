<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String path=request.getContextPath();
    String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>menu</title>
    <link rel="stylesheet" href="<%=basePath%>lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="stylesheet" href="<%=basePath%>css/public.css" media="all">
    <style>
        .layui-btn:not(.layui-btn-lg ):not(.layui-btn-sm):not(.layui-btn-xs) {
            height: 34px;
            line-height: 34px;
            padding: 0 8px;
        }
    </style>
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">
        <div>
            <div class="layui-btn-group">
                <button class="layui-btn" id="btn-expand">全部展开</button>
                <button class="layui-btn layui-btn-normal" id="btn-fold">全部折叠</button>
            </div>
            <table id="munu-table" class="layui-table" lay-filter="munu-table"></table>
        </div>
    </div>
</div>
<!-- 操作列 -->
<script type="text/html" id="auth-state">
    {{#  if(d.type=='0'){ }}
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="edit">修改</a>
    <a class="layui-badge layui-bg-blue" lay-event="add">添加</a>
    {{#  }else if(d.type=='1'){ }}
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="edit">修改</a>
    <a class="layui-badge layui-bg-blue" lay-event="add">添加</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    {{# }else{ }}
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="edit">修改</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    {{# } }}

</script>

<script src="<%=basePath%>lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script src="<%=basePath%>js/lay-config.js?v=1.0.4" charset="utf-8"></script>
<script>
    layui.use(['table', 'treetable'], function () {
        var $ = layui.jquery;
        var table = layui.table;
        var treetable = layui.treetable;

        // 渲染表格
        layer.load(2);
        treetable.render({
            treeColIndex: 1,
            treeSpid: -1,
            treeIdName: 'authorityId',
            treePidName: 'parentId',
            elem: '#munu-table',
            url: '<%=basePath%>dept/deptIndex',
            page: false,
            cols: [[
                {type: 'numbers'},
                {field: 'name', width: 400, title: '部门名称'},
                {
                    field: 'type', width: 80, align: 'center', templet: function (d) {
                        if (d.type == 0) {
                            return '<span class="layui-badge layui-bg-gray">公司</span>';
                        }
                        if (d.type == 1) {
                            return '<span class="layui-badge layui-bg-blue">部门</span>';
                        } else {
                            return '<span class="layui-badge layui-bg-orange">子部门</span>';
                        }
                    }, title: '类型'
                },
                {field: 'sort',  width:100,title: '排序号'},
                {
                    field: 'status', width: 80, align: 'center', templet: function (d) {
                        if (d.status == 0) {
                            return '<span class="layui-badge layui-bg-gray">禁用</span>';
                        }
                       else {
                            return '<span class="layui-badge layui-bg-blue">正常</span>';
                        }
                    }, title: '状态'
                },
                {templet: '#auth-state', minWidth: 250, align: 'center', title: '操作'}
            ]],
            done: function () {
                layer.closeAll('loading');
            }
        });

        $('#btn-expand').click(function () {
            treetable.expandAll('#munu-table');
        });

        $('#btn-fold').click(function () {
            treetable.foldAll('#munu-table');
        });

        //监听工具条
        table.on('tool(munu-table)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            if (layEvent === 'del') {
                $.ajax({
                    url:"<%=basePath%>dept/deleteInfo",
                    type:"post",
                    data: {id:data.id},
                    success:function (result) {
                        if(result.code==0){
                            layer.msg("删除成功");
                            window.location.reload();
                        }else{
                            layer.msg("删除失败")
                        }

                    }
                });


            } else if (layEvent === 'edit') {
                var index = layer.open({
                    title: '修改部门',
                    type: 2,
                    shade: 0.2,
                    shadeClose: true,
                    area: ['60%', '60%'],
                    content: 'dept/update?id='+data.id,
                    end:function () {
                        window.location.reload();
                    }
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            }else if (layEvent === 'add') {
                var index = layer.open({
                    title: '添加部门',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['60%', '60%'],
                    content: 'dept/add?fname='+data.name+'&type='+data.type+'&id='+data.id,
                    end:function () {
                      window.location.reload();
                    }
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            }
        });
    });
</script>
</body>
</html>