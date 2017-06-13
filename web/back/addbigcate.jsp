<%--
  Created by IntelliJ IDEA.
  User: webrx
  Date: 2017/5/20
  Time: 14:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>添加大分类</title>
    <link rel="stylesheet" href="css/base.css">
    <script src="js/jquery-3.2.0.js"></script>
    <script src="layui/lay/modules/layer.js"></script>
    <script src="layui/layui.js"></script>
    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="layui/css/modules/layer/default/layer.css">
    <style>
        .file {
            position: relative;
            display: inline-block;
            background: #D0EEFF;
            border: 1px solid #99D3F5;
            border-radius: 4px;
            padding: 4px 12px;
            overflow: hidden;
            color: #1E88C7;
            text-decoration: none;
            text-indent: 0;
            line-height: 20px;
        }
        .file input {
            position: absolute;
            font-size: 100px;
            right: 0;
            top: 0;
            opacity: 0;
        }
        .file:hover {
            background: #AADFFD;
            border-color: #78C3F3;
            color: #004974;
            text-decoration: none;
        }
        .layui-form-label{
            padding-top:5px;
            font-size:16px;
        }
        .layui-input{
            width: 150px;
        }
        .layui-elem-field{
            width: 400px;
            padding: 20px;
        }
    </style>
</head>
<script>
    layui.use('form',function () {
        var form = layui.form();
    })
</script>
<body>
<fieldset class="layui-elem-field">
    <legend><b>添加大分类</b></legend>
    <div class="layui-field-box">
        <form action="../addbigcate" method="post" enctype="multipart/form-data" class="layui-form">
            <div class="layui-form-item">
                <label class="layui-form-label">分类名称：</label>
                <div class="layui-input-block">
                    <input type="text" name="name" id="t" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">分类样图：</label>
                <div class="layui-input-block">
                    <a href="javascript:;" class="file">选择文件
                        <input type="file" name="file" id="">
                    </a>

                </div>
            </div>

            　　　　　　　　<input type="submit" value="添加" id="su" class="layui-btn layui-btn-normal">&nbsp;&nbsp;
            <a href="bigcate.jsp"><input type="button" value="返回" class="layui-btn layui-btn-normal"></a>
        </form>
    </div>
</fieldset>
<script>
    <%
    request.setCharacterEncoding("utf8");
    String s = (String) session.getAttribute("bigcate");
    if("ok".equals(s)){
        %>
    if (!confirm("添加成功，是否继续添加？")) {
        location.href = "bigcate.jsp"
    }
    <%
    session.removeAttribute("bigcate");
    }else if("no".equals(s)){
        %>
    if (!confirm("添加失败，是否继续添加？")) {
        location.href = "bigcate.jsp"
    }
    <%
     session.removeAttribute("bigcate");
    }else if ("empty".equals(s)){
         %>
    if (!confirm("添加失败，分类名不能为空，是否继续添加？")) {
        location.href = "bigcate.jsp"
    }
    <%
     session.removeAttribute("bigcate");
    }else if("fempty".equals(s)){
        %>

    if(!layer.confirm("添加失败，上传文件不能为空，是否继续添加？")){
        location.href = "bigcate.jsp"
    }
    <%
     session.removeAttribute("bigcate");
    }else if("wrong".equals(s)){
        %>
    if(!confirm("添加失败，上传文件格式有误，是否继续添加？")){
        location.href = "bigcate.jsp"
    }
    <%
    session.removeAttribute("bigcate");
    }
    %>

</script>

</body>
</html>
