<%@ page import="com.lppz.back.db.MyUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %><%--
  Created by IntelliJ IDEA.
  User: webrx
  Date: 2017/5/23
  Time: 9:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>添加小分类</title>
    <script src="js/jquery-3.2.0.js"></script>
    <link rel="stylesheet" href="layui/css/layui.css">
    <script src="layui/layui.js"></script>
    <style>
        .layui-form-label{
            width: 260px;
            font-size: 16px;
            font-weight: bold;
        }
    </style>
    <script>
        layui.use('form',function () {
            var form=layui.form();
        })

    </script>
</head>
<body>
<fieldset class="layui-elem-field">
    <legend><b>添加小分类</b></legend>
    <div class="layui-field-box layui-form">
        <div class="layui-form-item">
            <label class="layui-form-label">商品类别名称(*)：</label>
            <div class="layui-inline">
                <input type="text" name="nam" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">所属大分类：</label>
            <div class="layui-input-inline">
                <select id="s">
                    <%
                        MyUtil mu = new MyUtil();
                        List<Map<String, Object>> list = mu.query("bigcate", "id,bname", "", "order by id desc", "");
                        for (Map<String, Object> m : list) {
                    %>
                    <option value="<%=m.get("id")%>"><%=m.get("bname")%></option>
                    <%
                        }
                    %>
                </select>
            </div>
        </div>

        　　　　　　　　　　　　　　　　  　　　　<input type="button" id="bt" class="layui-btn layui-btn-normal" value="确认添加">&nbsp;&nbsp;
        <a href="cate.jsp"><input type="button" value="返回" class="layui-btn layui-btn-normal"></a>
    </div>
    </div>
</fieldset>

<script>
    $(function () {
        $('#bt').click(function () {
            var a = $('#s option:selected').val();
            var n = $('input[type=text]').val();
            if(""==n){
                alert("商品别名不能为空");
                return;
            }
            $.ajax({
                type:"POST",
                url:"../addcate.action",
                data:{i:a,nam:n},
                dataType:"text",
                success:function (cateInfo) {
                    if(!confirm(cateInfo)){
                        location.href="cate.jsp"
                    }
                }

            })

        })
    })
</script>
</body>
</html>
