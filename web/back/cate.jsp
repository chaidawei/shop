<%--
  Created by IntelliJ IDEA.
  User: webrx
  Date: 2017/5/23
  Time: 10:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>小分类管理</title>
    <script src="js/jquery-3.2.0.js"></script>
    <link rel="stylesheet" href="css/base.css">
    <link rel="stylesheet" href="layui/css/layui.css">
    <script>
        $(function () {
            var page = $('input[type=hidden]').val();
            $.ajax({
                type:"POST",
                url:"../cateshow.action",
                data:{param:page},
                dataType:"text",
                success:function (cateInfo) {
                    $('#dd').html(cateInfo);

                }
            })
        })

    </script>
</head>
<body>
<input type="hidden" name="p" id="p" value="<%=request.getParameter("p")%>">
<fieldset class="layui-elem-field">
    <legend><b>管理小分类</b></legend>
    <div class="layui-field-box" style="height: 200px">
        <table id="dd"  class="layui-table">

        </table>
        <a href="addcate.jsp"><input type="button" value="添加小分类" class="layui-btn layui-btn-normal" style="float: right;margin-bottom: 8px"></a>
    </div>
</fieldset>




</body>
</html>
