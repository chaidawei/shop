<%@ page import="com.lppz.back.db.MyUtil" %><%--
  Created by IntelliJ IDEA.
  User: webrx
  Date: 2017/5/22
  Time: 7:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>修改轮播广告</title>
    <script src="js/jquery-3.2.0.js"></script>
    <link rel="stylesheet" href="layui/css/layui.css">
    <script src="layui/layui.js"></script>
    <script>
        layui.use('form',function () {
            var form = layui.form();
            form.render();
        })
        $(function () {
            $('#s').val(<%=new MyUtil().queryBy("lunbo","statu","where id="+request.getParameter("id"))%>)
        })
    </script>
    <style>
        .layui-form-label{
            width: 200px;
            font-size: 16px;
        }
    </style>
</head>
<body>
<fieldset class="layui-elem-field">
    <legend><b>修改轮播广告</b></legend>
    <div class="layui-field-box layui-form">
        <div class="layui-form-item">
            <label class="layui-form-label">要修改广告的编号：</label>
            <div class="layui-inline">
                <input type="text" class="layui-input" disabled id="num" value="<%=request.getParameter("id")%>"><br><br>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">请选择修改广告的状态：</label>
            <div class="layui-input-inline">
                <select name="interest" id="s">
                    <option value="0">显示</option>
                    <option value="1">不显示</option>
                </select>
            </div>
        </div>

        　　　　　　　　　　　　<input type="button" value="确认修改" id="but" class="layui-btn layui-btn-normal" >
        　<a href="lunbo.jsp"><input type="button" value="返回" class="layui-btn layui-btn-normal"></a>



    </div>
</fieldset>



<script>
    $(function () {
        var i = $('#num');
        $('#but').click(function () {
            var t = $("#s option:selected").val();
            $.ajax({
                type: "POST",
                url: "../updatelunbo.action",
                data: {select: t, id: i.val(), action: "updatelunbo"},
                dataType: "text",
                success: function (updataInfo) {
                    if (!confirm(updataInfo)) {
                        location.href = "lunbo.jsp"
                    }
                }
            })
        })

    })

</script>
</body>
</html>
