<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">



        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">修改密码</a>
        </script>

    </div>
</div>
<script src="<%=basePath%>lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table;

        table.render({
            elem: '#currentTableId',
            url: '<%=basePath%>user/queryAll3',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "checkbox", width: 50},
                {field: 'id', width: 80, title: 'ID', sort: true},
                {field: 'username', width: 80, title: '用户名'},
                {field: 'sex', width: 80, title: '性别'},
                // {field: 'roleName', width: 80, title: '用户类型'},
                {field: 'roleName',width: 80, title: '角色',templet:function(d){
                        if(d.roleName==0){
                            return '<span class="layui-badge layui-bg-green" >职工</span>';
                        }else{
                            return '<span class="layui-badge  layui-bg-blue">管理员</span>';
                        }
                    }},
                {templet:'<div>{{d.dept.name}}</div>',title: '部门', minWidth: 100},
                // {field: 'deptId', title: '科室', minWidth: 150},
                {field: 'tel', width: 120, title: '电话'},
                {field: 'email', width: 120, title: '邮箱'},
                {title: '操作', minWidth: 150, toolbar: '#currentTableBar', align: "center"}
            ]],
            limits: [10, 15, 20, 25, 50, 100],
            limit: 15,
            page: true,
            skin: 'line'
        });


        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            if (obj.event === 'edit') {
                var index = layer.open({
                    title: '编辑用户',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: '<%=basePath%>user/update?id='+data.id,
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
                    // deleteInfoByIds(data.id,index);
                    layer.close(index);
                });
            }
        });

    });
</script>

</body>
</html>