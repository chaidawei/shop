<%@ page import="com.lppz.back.db.MyUtil" %><%--
  Created by IntelliJ IDEA.
  User: webrx
  Date: 2017/5/22
  Time: 9:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>修改大分类</title>
    <script src="js/jquery-3.2.0.js"></script>
    <link rel="stylesheet" href="css/base.css">
    <link rel="stylesheet" href="layui/css/layui.css">
    <style>
        .layui-form-label {
            width: 260px;
            font-weight: bold;
            font-size: 16px;
        }
    </style>
</head>
<body>
<input type="hidden" name="id" value="<%=request.getParameter("id")%>">
<input type="hidden" name="action" value="<%=request.getParameter("do")%>">
<fieldset class="layui-elem-field">
    <legend><b>修改大分类</b></legend>
    <div class="layui-field-box">
        <table id="dd" class="layui-table" style="width: 500px;">
            <colgroup>
                <col width="80">
                <col>
            </colgroup>
            <thead>
            <tr>
                <th>编号</th>
                <th>大分类名称</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td><%=request.getParameter("id")%>
                </td>
                <td>
                    <%=
                    new MyUtil().queryBy("bigcate", "bname", "where id=" + request.getParameter("id"))
                    %>
                </td>
            </tr>
            </tbody>
        </table>
        <br><br>
        <div class="layui-form-item">
            <label class="layui-form-label">输入修改后大分类的名称：</label>
            <div class="layui-input-inline">
                <input type="text" id="name" size="10px" class="layui-input">
            </div>
        </div>
        　　　　　　　　　　　　　　　　　　　　　<input type="button" value="确认修改" id="but" class="layui-btn layui-btn-normal" style=" font-size: 16px">&nbsp;&nbsp;

        <a href="bigcate.jsp"><input type="button" value="返回" class="layui-btn layui-btn-normal" style=" font-size: 16px"></a>
    </div>
</fieldset>

<script>
    $(function () {
        $('#but').click(function () {
            var c = $('#name').val();
            if ("".trim() == c) {
                alert("分类名不能为空");
                return;
            }
            var i = $('input[name=id]').val();
            var a = $('input[name=action]').val();
            $.ajax({
                type: "POST",
                url: "../updatabigcate.action",
                data: {action: a, id: i, change: c},
                dataType: "text",
                success: function (bigcateInfo) {
                    if (confirm(bigcateInfo)) {
                        location.href = "bigcate.jsp"
                    }


                }
            })
        })
    })
</script>
</body>
</html>
