<%--
  Created by IntelliJ IDEA.
  User: webrx
  Date: 2017/5/26
  Time: 17:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>留言</title>
    <script src="layui/layui.js"></script>
    <script src="js/jquery-3.2.0.js"></script>
    <link rel="stylesheet" href="layui/css/layui.css">
    <style>
        #dd th{
            font-size: 16px;
        }
        #dd th ,#dd td{
            text-align: center;
        }
    </style>
</head>
<script>
    $(function () {
        var pa = $('#hi').val();
        $.ajax({
            type:"POST",
            data:{page:pa,action:"show"},
            dataType:"text",
            url:"../message.show",
            success:function (messageInfo) {
                $('#dd').html(messageInfo);
            }
        })
    })

</script>
<body>
<fieldset class="layui-elem-field">
    <legend><b>留言管理</b></legend>
    <div class="layui-field-box">
        <div class="layui-form">
            <input type="hidden" id="hi" value="<%=request.getParameter("p")%>">
            <table id="dd" class="layui-table">

            </table>
        </div>
    </div>
    <a href="edit.jsp"><input type="button" class="layui-btn layui-btn-normal" style="margin-bottom: 8px; margin-right: 10px;float: right" value="添加留言"></a>
</fieldset>
</body>
</html>
