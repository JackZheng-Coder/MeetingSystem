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
    <input type="hidden" value="${id}" name="id" id="id">
    <div class="layuimini-main">

        <fieldset class="table-search-fieldset">
            <legend>搜索信息</legend>
            <div style="margin: 10px 10px 10px 10px">
                <form class="layui-form layui-form-pane" action="">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">用户姓名</label>
                            <div class="layui-input-inline">
                                <input type="text" name="username" autocomplete="off" class="layui-input">
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
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"> 关联当前会议 </button>

            </div>
        </script>
        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>


    </div>
</div>
<script src="<%=basePath%>lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table;
        //获取到id信息
        var id=$("#id").val();
        table.render({
            elem: '#currentTableId',
            url: '<%=basePath%>user/queryUserListByMeetId',
            toolbar: '#toolbarDemo',
            cols: [[
                {type: "checkbox", width: 50},
                {field: 'username', width: 120, title: '用户名'},
                {field: 'dname', width: 120, title: '部门'},
                {field: 'tel', width: 200, title: '电话'},
                {field: 'email', width: 350, title: '邮箱'}
            ]],
            limits: [10, 15, 20, 25, 50, 100],
            limit: 15,
            page: true,
            skin: 'line',
            where:{
                mid:id
            }
        });

        // 监听搜索操作
        // 监听搜索操作
        form.on('submit(data-search-btn)', function (data) {
            var username=data.field.username;

            //执行搜索重载
            table.reload('currentTableId', {
                page: {
                    curr: 1
                }
                , where: {
                    username: username

                }
            }, 'data');

            return false;
        });

        /**
         * toolbar监听事件
         */
        table.on('toolbar(currentTableFilter)', function (obj) {
           if (obj.event === 'add') {  // 监听关联事件
                /*
                     1、提示内容，必须删除大于0条
                     2、获取要删除记录的id信息
                     3、提交删除功能 ajax
                   */
                //获取选中的记录信息
                var checkStatus=table.checkStatus(obj.config.id);
                var data=checkStatus.data;
                if(data.length==0){//如果没有选中信息
                    layer.msg("请选择要关联的人员记录信息");
                }else{
                    //获取记录信息的id集合
                    var ids=getCheackId(data);
                    layer.confirm('确定关联这些用户么', function (index) {
                        //调用
                        setInfoByIds(ids, id,index);
                        layer.close(index);
                    });
                }
            }

        });
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


        /**
         * 关联会议人员
         */
        function setInfoByIds(ids ,meetId,index){
            //向后台发送请求
            $.ajax({
                url: "<%=basePath%>meetUser/setingUserIds",
                type: "POST",
                data: {ids: ids,meetId:meetId},
                success: function (result) {
                    if (result.code == 0) {//如果成功
                        layer.msg('关联成功', {
                            icon: 6,
                            time: 500
                        }, function () {
                            parent.window.location.reload();
                            var iframeIndex = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(iframeIndex);
                        });
                    } else {
                        layer.msg("关联失败");
                    }
                }
            })
        };

        //监听表格复选框选择
        table.on('checkbox(currentTableFilter)', function (obj) {
            console.log(obj)
        });


    });
</script>

</body>
</html>