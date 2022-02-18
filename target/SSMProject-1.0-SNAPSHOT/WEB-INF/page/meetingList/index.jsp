<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String path=request.getContextPath();
    String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8' />
    <link href='<%=basePath%>lib/main.css' rel='stylesheet' />
    <script src='<%=basePath%>lib/main.js'></script>
    <script>

        document.addEventListener('DOMContentLoaded', function() {
            var calendarEl = document.getElementById('calendar');
            var myDate = new Date();
            myDate.toLocaleDateString();                //获取当前日期
            var calendar = new FullCalendar.Calendar(calendarEl, {//使用FullCalendar插件
                headerToolbar: {
                    left: 'prevYear,prev,next,nextYear today',
                    center: 'title',
                    right: 'dayGridMonth,dayGridWeek,dayGridDay'
                },
                initialDate: myDate,
                locale: 'zh-cn',
                navLinks: true, // can click day/week names to navigate views
                editable: true,
                dayMaxEvents: true,
                eventSources: [
                    {
                        events:${info},//info保存由后端传来的数据

                        color: 'red',     // an option!
                        textColor: 'blue' // an option!
                    }
                ]
            });
            calendar.render();
        });

    </script>
    <style>

        body {
            margin: 40px 10px;
            padding: 0;
            font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
            font-size: 14px;
        }

        #calendar {
            max-width: 1000px;
            margin: 0 auto;
        }

    </style>
</head>
<body>

<div id='calendar'></div>

</body>
</html>
