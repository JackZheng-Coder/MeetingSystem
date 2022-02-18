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
    <input type="hidden" name="id" value="${user.id}">
    <div class="layui-form-item">
        <label class="layui-form-label required">用户名</label>
        <div class="layui-input-block">
            <input type="text" name="username" lay-verify="required" lay-reqtext="用户名不能为空" value="${user.username}" class="layui-input">
            <tip>填写自己管理账号的名称。</tip>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label required">密码</label>
        <div class="layui-input-block">
            <input type="password" name="password" lay-verify="required" lay-reqtext="密码不能为空" value="${user.password}" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">所在部门</label>
        <div class="layui-input-block">
            <input type="text" id="tree"  value="${user.deptId}" name="deptId" lay-filter="tree" class="layui-input">
        </div>
    </div>


    <div class="layui-form-item">
        <label class="layui-form-label">角色类型</label>
        <div class="layui-input-block">
            <select name="roleName" >
                <option value="">请选择</option>
               <option value="0" <c:if test="${'0' eq user.roleName}">selected</c:if>>职员</option>

                <option value="1" <c:if test="${'1' eq user.roleName}">selected</c:if> >管理员</option>
            </select>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">性别</label>
        <div class="layui-input-block">
            <input type="radio" name="sex" value="男" title="男"  ${'男' eq user.sex ? "checked=checked":""} >
            <input type="radio" name="sex" value="女" title="女" ${'女' eq user.sex ? "checked=checked":""}>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label required">手机</label>
        <div class="layui-input-block">
            <input type="number" name="tel" lay-verify="required"  value="${user.tel}"  class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">邮箱</label>
        <div class="layui-input-block">
            <input type="email" name="email"  value="${user.email}"  class="layui-input">
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">个人介绍</label>
        <div class="layui-input-block">
            <textarea name="info" class="layui-textarea" placeholder="请输入介绍信息">${user.info}</textarea>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn layui-btn-normal" lay-submit lay-filter="updateBtn">确认保存</button>
        </div>
    </div>
</div>

<script src="<%=basePath%>lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script src="<%=basePath%>js/lay-config.js?v=2.0.0" charset="utf-8"></script>
<script>
    layui.use(['treeSelect','form'], function () {
        var form = layui.form,
            layer = layui.layer,
            $ = layui.$;
        var treeSelect= layui.treeSelect;


        //获取部门值信息
        treeSelect.render({
            // 选择器
            elem: '#tree',
            // 数据
            data: '<%=basePath%>queryDeptTree',
            // 异步加载方式：get/post，默认get
            type: 'get',
            // 占位符
            placeholder: '修改默认提示信息',
            // 是否开启搜索功能：true/false，默认false
            search: true,
            // 点击回调
            click: function(d){
                console.log(d);
                $("#tree").val(d.current.id);
            },
            // 加载完成后的回调函数
            success: function (d) {
                console.log(d);
                var values=$("#tree").val();
                treeSelect.checkNode('tree',values);
            }
        });

        //监听提交
        form.on('submit(updateBtn)', function (data) {
            var data=data.field;
            debugger
            $.ajax({
                url:"<%=basePath%>user/updateInfo",
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