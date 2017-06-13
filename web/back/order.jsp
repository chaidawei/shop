<%--
  Created by IntelliJ IDEA.
  User: webrx
  Date: 2017/5/25
  Time: 10:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf8">
    <title>订单管理</title>
    <link rel="stylesheet" href="layui/css/layui.css">
    <script src="js/jquery-3.2.0.js"></script>
    <script src="layui/layui.js"></script>
    <script>
        layui.use('form',function () {
            var form = layui.form();
        })

        $(function () {
            var p = $('input[name=hi]').val();
            $.ajax({
                type:"POST",
                url:"../order.action",
                data:{page:p,action:"all"},
                dataType:"text",
                success:function (orderInfo) {
                    $('#dd').html(orderInfo);
                }

            })
        })


    </script>

    <style>
        #dd td,#dd th{
            text-align: center;
        }
    </style>
</head>
<body>
<fieldset class="layui-elem-field">
    <legend><b>订单管理</b></legend>
    <div class="layui-field-box">
        <input type="hidden" name="hi" value="<%=request.getParameter("p")%>">
            <table id="dd" class="layui-table">

            </table>
    </div>
</fieldset>

</body>
</html>
