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
        body {
            background-color: #ffffff;
        }
    </style>
</head>
<body>
<div class="layui-form layuimini-form" lay-filter="updateBtn">
    <input type="hidden"  name="id" value="${info.id}">
    <input type="hidden"  id="roomIds" value="${info.roomId}">
    <div class="layui-form-item">
        <label class="layui-form-label required">会议主题</label>
        <div class="layui-input-block">
            <input type="text" name="subject" lay-verify="required" value="${info.subject}" class="layui-input">
            <tip>填写会议主题。</tip>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">会议室</label>
        <div class="layui-input-block">
            <select name="roomId" id="roomId" lay-verify="required" lay-search="">
                <option value="">请选择会议室</option>
            </select>
        </div>
    </div>


    <div class="layui-form-item">
        <label class="layui-form-label">开始时间</label>
        <div class="layui-input-inline">
            <input type="text" name="startTime" class="layui-input" id="test" placeholder="yyyy-MM-dd HH:mm:ss"
                   value="<fmt:formatDate value="${info.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/> ">
        </div>
    </div>


    <div class="layui-form-item">
        <label class="layui-form-label">结束时间</label>
        <div class="layui-input-inline">
            <input type="text" name="endTime" class="layui-input" id="test2" placeholder="yyyy-MM-dd HH:mm:ss"
                   value="<fmt:formatDate value="${info.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/> ">
        </div>
    </div>


    <div class="layui-form-item">
        <label class="layui-form-label required">是否支持投影</label>
        <div class="layui-input-block">
            <input type="radio" name="isProjector" value="1" title="是"  ${'1' eq info.isProjector ? "checked=checked":""}>
            <input type="radio" name="isProjector" value="0" title="否"  ${'0' eq info.isProjector ? "checked=checked":""}>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">内置笔记本</label>
        <div class="layui-input-block">
            <input type="radio" name="isPc" value="1" title="是"  ${'1' eq info.isPc ? "checked=checked":""}>
            <input type="radio" name="isPc" value="0" title="否"  ${'0' eq info.isPc ? "checked=checked":""}>
        </div>
    </div>

<%--    <div class="layui-form-item">--%>
<%--        <label class="layui-form-label required">支持电话会议</label>--%>
<%--        <div class="layui-input-block">--%>
<%--            <input type="radio" name="isTel" value="1" title="是"  ${'1' eq info.isTel ? "checked=checked":""}>--%>
<%--            <input type="radio" name="isTel" value="0" title="否"  ${'0' eq info.isTel ? "checked=checked":""}>--%>
<%--        </div>--%>
<%--    </div>--%>


   <%-- <div class="layui-form-item">
        <label class="layui-form-label required">支持视频会议</label>
        <div class="layui-input-block">
            <input type="radio" name="isVidio" value="1" title="是"  ${'1' eq info.isVidio ? "checked=checked":""}>
            <input type="radio" name="isVidio" value="0" title="否"  ${'0' eq info.isVidio ? "checked=checked":""}>
        </div>
    </div>--%>


    <div class="layui-form-item">
        <label class="layui-form-label required">容纳人数</label>
        <div class="layui-input-block">
            <input type="text" name="counts"  value="${info.counts}"  class="layui-input">
        </div>
    </div>

<%--    <div class="layui-form-item">--%>
<%--        <label class="layui-form-label">状态</label>--%>
<%--        <div class="layui-input-block">--%>
<%--            <input type="checkbox"  ${info.status eq "1" ?"checked='checked'":''} name="status" lay-skin="switch" lay-filter="switchTest" lay-text="正常|禁用">--%>
<%--        </div>--%>
<%--    </div>--%>


    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn layui-btn-normal" lay-submit lay-filter="updateBtn">确认修改</button>
        </div>
    </div>
</div>
<script src="<%=basePath%>lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script src="<%=basePath%>js/lay-config.js?v=2.0.0" charset="utf-8"></script>
<script>
    layui.use(['form','upload', 'table','layarea','laydate'], function () {
        var form = layui.form,
            layer = layui.layer,
            laydate=layui.laydate,
            layarea=layui.layarea,
            $ = layui.$,upload = layui.upload;
        form.render();


        //时间选择器
        laydate.render({
            elem: '#test'
            ,type: 'datetime'
        });
        //时间选择器
        laydate.render({
            elem: '#test2'
            ,type: 'datetime'
        });

        //获取id为roomIds的值
        var values=document.getElementById("roomIds").value;
        //渲染选择会议室
        $.get("<%=basePath%>meetroom/roomList",{},function(data){
            var list=data;
            var select=document.getElementById("roomId");

            if(list!=null || list.size()>0){
                for(var c in list){
                    var option=document.createElement("option");
                    option.setAttribute("value",list[c].id);
                    option.innerText=list[c].name;
                    select.appendChild(option);
                    if(list[c].id==values){
                        option.setAttribute("selected","selected");
                        layui.form.render('select');
                    }
                }
            }
            form.render('select');
        },"json");



        //监听提交
        form.on('submit(updateBtn)', function (data) {
            var data=data.field;
            if(data.status=='on'){
                data.status=1;
            }else{
                data.status=0;
            }
            debugger
            $.ajax({
                url:"<%=basePath%>meeting/updateInfo",
                type:"post",
                contentType:"application/json",
                data:JSON.stringify(data),
                success:function (result) {
                    if(result.code==0){
                        layer.msg("添加成功");
                        //关闭弹出框
                        var iframeIndex = parent.layer.getFrameIndex(window.name);
                        parent.layer.close(iframeIndex);
                    }else{
                        layer.msg("添加失败")
                    }
                }


            });
            return false;
        });

    });
</script>
</body>
</html>