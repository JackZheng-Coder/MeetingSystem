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
<div class="layui-form layuimini-form"  lay-filter="updateBtn">
    <input type="hidden"  name ="id" value="${dept.id}"/>
    <input type="hidden"  name ="parentId" value="${dept.parentId}"/>
    <input type="hidden"  name ="type" value="${dept.type}"/>
<%--    <div class="layui-form-item">--%>
<%--        <label class="layui-form-label required">上级部门</label>--%>
<%--        <div class="layui-input-block">--%>
<%--            <input type="text"  lay-verify="required"  value="${fname}" class="layui-input">--%>
<%--        </div>--%>
<%--    </div>--%>
    <div class="layui-form-item">
        <label class="layui-form-label">部门名称</label>
        <div class="layui-input-block">
            <input type="text" name="name" placeholder="请输入部门名称" value="${dept.name}" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">排序号</label>
        <div class="layui-input-block">
            <input type="text" name="sort"  value="${dept.sort}" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">状态</label>
        <div class="layui-input-block">
            <input type="checkbox"   ${dept.status eq "1" ?"checked='checked'":''}  name="status" lay-skin="switch" lay-filter="switchTest" lay-text="正常|禁用">
        </div>
    </div>


    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn layui-btn-normal" lay-submit lay-filter="updateBtn">确认修改</button>
        </div>
    </div>
</div>
<script src="<%=basePath%>lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form'], function () {
        var form = layui.form,
            layer = layui.layer,
            $ = layui.$;
        //监听提交
        form.on('submit(updateBtn)', function (data) {
            //获取到输入框内填入数据
            var data=data.field;
            if(data.status=='on'){
                data.status=1;
            }else{
                data.status=0;
            }
            debugger
            $.ajax({
                url:"<%=basePath%>dept/updateInfo",
                type:"post",
                contentType:"application/json",
                data:JSON.stringify(data),
                success:function (result) {
                   if(result.code==0){
                       layer.msg("修改成功");
                       //关闭弹出框
                       var iframeIndex = parent.layer.getFrameIndex(window.name);
                       parent.layer.close(iframeIndex);
                   }else{
                       layer.msg("修改失败")
                   }
                }


            });


            return false;
        });

    });
</script>
</body>
</html>