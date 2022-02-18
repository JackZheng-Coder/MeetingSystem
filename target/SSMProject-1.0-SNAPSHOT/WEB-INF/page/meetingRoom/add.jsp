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
<div class="layui-form layuimini-form">
    <input type="hidden" id="imgs" name="img">
    <div class="layui-form-item">
        <label class="layui-form-label required">会议室名称</label>
        <div class="layui-input-block">
            <input type="text" name="name" lay-verify="required" lay-reqtext="会议室名称不能为空" placeholder="请输入会议室名称" value="" class="layui-input">
            <tip>填写会议室名称。</tip>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">上传图片</label>
        <div class="layui-input-block">
            <div class="layui-upload-drag" id="test10">
                <i class="layui-icon"></i>
                <p>点击上传，或将文件拖拽到此处</p>
                <div class="layui-hide" id="uploadDemoView">
                    <hr>
                    <img src="" alt="上传成功后渲染" style="max-width: 196px">
                </div>
            </div>
        </div>
    </div>



    <div class="layui-form-item">
        <label class="layui-form-label required">是否支持投影</label>
        <div class="layui-input-block">
            <input type="radio" name="isProjector" value="1" title="是" checked="">
            <input type="radio" name="isProjector" value="0" title="否">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">内置笔记本</label>
        <div class="layui-input-block">
            <input type="radio" name="isPc" value="1" title="是" checked="">
            <input type="radio" name="isPc" value="0" title="否">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">支持电话会议</label>
        <div class="layui-input-block">
            <input type="radio" name="isTel" value="1" title="是" checked="">
            <input type="radio" name="isTel" value="0" title="否">
        </div>
    </div>


    <div class="layui-form-item">
        <label class="layui-form-label required">支持视频会议</label>
        <div class="layui-input-block">
            <input type="radio" name="isVidio" value="1" title="是" checked="">
            <input type="radio" name="isVidio" value="0" title="否">
        </div>
    </div>


    <div class="layui-form-item">
        <label class="layui-form-label required">容纳人数</label>
        <div class="layui-input-block">
            <input type="text" name="counts"   class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">状态</label>
        <div class="layui-input-block">
            <input type="checkbox" checked="" name="status" lay-skin="switch" lay-filter="switchTest" lay-text="正常|禁用">
        </div>
    </div>


    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">确认保存</button>
        </div>
    </div>
</div>
<script src="<%=basePath%>lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script src="<%=basePath%>js/lay-config.js?v=2.0.0" charset="utf-8"></script>
<script>
    layui.use(['upload','treeSelect','form'], function () {
        var form = layui.form,
            layer = layui.layer,
            $ = layui.$;
        upload = layui.upload;

        //拖拽上传
        upload.render({
             elem: '#test10'
            ,url: '<%=basePath%>/fileUpload' //此处用的是第三方的 http 请求演示，实际使用时改成您自己的上传接口即可。
            ,field:'file'
            ,done: function(res){
                debugger
                console.log(res)
                layer.msg('上传成功');
                layui.$('#uploadDemoView').removeClass('layui-hide').find('img').attr('src', res.msg);
                //塞入到input
                $("#imgs").val(res.msg);
                console.log(res)
            }
        });



        //监听提交
        form.on('submit(saveBtn)', function (data) {
            var data=data.field;
            if(data.status=='on'){
                data.status=1;
            }else{
                data.status=0;
            }
            debugger
            $.ajax({
                url:"<%=basePath%>meetingRoom/addInfo",
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