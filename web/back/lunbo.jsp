<%@ page import="com.lppz.back.servlet.Lunbo" %>
<%--
  Created by IntelliJ IDEA.
  User: webrx
  Date: 2017/5/19
  Time: 10:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>轮播广告</title>
    <script src="js/jquery-3.2.0.js"></script>
    <link rel="stylesheet" href="css/base.css">
    <link rel="stylesheet" href="layui/css/layui.css">
    <script>
        $(function () {
            var p = $('#p').val();
            $.ajax({
                type:"POST",
                url:"../lunbo",
                data:{pa:p},
                dataType:"text",
                success:function (lunboInfo) {
                    $('#dd').html(lunboInfo);
                }
            })
        })
    </script>
</head>
<body>
<fieldset class="layui-elem-field">
    <legend><b>轮播管理</b></legend>
    <div class="layui-field-box">
        <input type="hidden" name="p" id="p" value="<%=request.getParameter("p")%>">
        <table id="dd" class="layui-table" >
        </table>
        <a href="addlunbo.jsp"><input class="layui-btn layui-btn-normal" type="button" value="添加轮播广告" style="float: right;margin-bottom: 8px"></a>
    </div>

</fieldset>




</body>
</html>
