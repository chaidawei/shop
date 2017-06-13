<%--
  Created by IntelliJ IDEA.
  User: webrx
  Date: 2017/5/23
  Time: 20:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>会员信息管理</title>
    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="css/base.css">
    <script src="js/jquery-3.2.0.js"></script>
    <script>
        $(function () {
            var p =$('input[name=hi]').val();
            $.ajax({
                type:"POST",
                url:"../membershow.action",
                data:{page:p},
                dataType:"text",
                success:function (memberInfo) {
                    $("#dd").html(memberInfo)
                }
            })
        })
    </script>
</head>
<body>
<fieldset class="layui-elem-field">
    <legend><b>会员信息管理</b></legend>
    <div class="layui-field-box">
        <input type="hidden" name="hi" value="<%=request.getParameter("p")%>">
        <table id="dd" class="layui-table">

        </table>
    </div>
</fieldset>

</body>
</html>
