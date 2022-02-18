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
            margin-top: 0px;
        }
        .layui-table-cell .layui-form-checkbox[lay-skin="primary"]{
            transform: translateY(-30%);
        }
    </style>
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
            <legend>我的会议列表</legend>
        </fieldset>
        <c:forEach var="data" items="${info}" varStatus="status">

            <li class="layui-timeline-item">
                <i class="layui-icon layui-timeline-axis"></i>
                <div class="layui-timeline-content layui-text">
                    <h3 class="layui-timeline-title">${data.meetingInfo.subject}</h3>
                    <p>
                        开始时间：<fmt:formatDate value="${data.meetingInfo.startTime}" pattern="yyyy年MM月dd日HH点mm分ss秒" />
                        <br>结束时间：<fmt:formatDate value="${data.meetingInfo.endTime}" pattern="yyyy年MM月dd日HH点mm分ss秒" />。
                        <br>所在会议室： ${data.meetingInfo.meetingRoom.name}<i class="layui-icon"></i>
                        <br>组织人： ${data.meetingInfo.meetingRoom.name}<i class="layui-icon"></i>
                    </p>
                </div>
            </li>
        </c:forEach>
    <div>
            <li class="layui-timeline-item">
                <i class="layui-icon layui-timeline-axis"></i>
                <div class="layui-timeline-content layui-text">
                    <div class="layui-timeline-title">过去</div>
                </div>
            </li>
        </ul>

</div>
<script src="<%=basePath%>lib/layui-v2.6.3/layui.js" charset="utf-8"></script>

</html>