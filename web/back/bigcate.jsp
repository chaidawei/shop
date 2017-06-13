<%--
  Created by IntelliJ IDEA.
  User: webrx
  Date: 2017/5/20
  Time: 10:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>大分类管理</title>
    <link rel="stylesheet" href="css/base.css">
    <script src="js/jquery-3.2.0.js"></script>
    <link rel="stylesheet" href="layui/css/layui.css">
    <script src="layui/layui.js"></script>
    <script>
        $(function () {
            var p = $('#p').val();
            $.ajax({
                type:"POST",
                url:"../showbigcate",
                data:{param:p},
                dataType:"text",
                success:function (bigcateIngo) {
                    $('#dd').html(bigcateIngo);
                }

            })
        })
    </script>
</head>
<body>
<fieldset class="layui-elem-field">
    <legend><b>大分类管理</b></legend>
    <div class="layui-field-box">
        <input type="hidden" name="p" id="p" value="<%=request.getParameter("p")%>">
        <table id="dd" class="layui-table">

        </table>
        <a href="addbigcate.jsp"><input type="button" value="添加大分类" class="layui-btn layui-btn-normal" style="float: right;margin: 8px"></a>

    </div>
</fieldset>

</body>
</html>
