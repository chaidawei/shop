

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>登录</title>
    <link rel="stylesheet" href="layui/css/layui.css">
    <link rel="stylesheet" href="css/base.css">
    <script src="js/jquery-3.2.0.js"></script>
    <script src="layui/layui.js"></script>
    <script>

        layui.use('form', function () {
            var form = layui.form();
        });
    </script>
    <style>
        .layui-form-item{
            float: left;
            margin: 25px auto;
        }
        .layui-form-label{
            font-size: 20px;
        }
    </style>
</head>
<body class="body2">
<div class="login">
    <form action="../login.action" method="post" class="layui-form">
        <div class="layui-form-item">
            <label class="layui-form-label">账号</label>
            <div class="layui-input-inline">
                <input type="text" name="account" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">密码</label>
            <div class="layui-input-inline">
            <input type="password" name="pass" class="layui-input">
        </div>
        </div>
　　　<div class="layui-form-item">
        <label class="layui-form-label">　　</label>
        <button id="bt" class="layui-btn">登录</button>
    </div>
        <script>
            $(function () {
                alert('你还没登录，请先登录');
                $('#bt').click(function () {
                    var a = $('input[name=account]').val();
                    var p = $('input[name=pass]').val();
                   if(a==''){
                       alert("账号不能为空");
                       return;
                   }
                   if(p==''){
                       alert("密码不能为空");
                       return;
                   }

                })
            })
        </script>
</form>
</div>
</body>
</html>
