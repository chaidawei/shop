<%--
  Created by IntelliJ IDEA.
  User: webrx
  Date: 2017/5/19
  Time: 15:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>添加轮播广告</title>
    <link rel="stylesheet" href="css/base.css">
    <script src="js/jquery-3.2.0.js"></script>
    <link rel="stylesheet" href="layui/css/layui.css">
    <script src="layui/layui.js"></script>
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

        .layui-form-label {
            padding-top: 5px;
            font-size: 16px;
        }

        .layui-input {
            width: 150px;
        }

        .layui-elem-field {
            width: 400px;
            padding: 20px;
        }
    </style>
    <script>
        layui.use('form',function () {
            var form = layui.form();
        });
        $(function () {

            if ("null" != "<%=session.getAttribute("aa")%>") {
                <%--alert("<%=session.getAttribute("aa")%>");--%>

                /*confirm("")*/
                if (confirm("<%=session.getAttribute("aa")%>")) {
                    //alert("继续添加")
                    <%
               session.removeAttribute("aa");
               %>
                } else {
                    location.href = "lunbo.jsp";
                }
            }
        })
    </script>
    <style>
        .layui-form-label{
            width: 120px;
            font-size: 16px;
        }
    </style>
</head>
<body>
<fieldset class="layui-elem-field">
    <legend><b>添加轮播广告</b></legend>
    <div class="layui-field-box">
        <form action="../addlunbo.action" method="post" enctype="multipart/form-data" class="layui-form">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">名称：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="name" class="layui-input" size="15px">
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">别名：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="byname" class="layui-input" size="15px">
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">上传轮播图片：</label>
                <div class="layui-input-block">
                    <a href="javascript:;" class="file">选择图片(800*440)
                        <input type="file" name="file" id="">
                    </a>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">状态：</label>
                <div class="layui-inline">
                    <select name="statu" id="statu" lay-filter="aihao">
                        <option value="0">显示</option>
                        <option value="1">不显示</option>
                    </select>
                </div>
            </div>

           　　　　　　　 　　<input type="submit" value="添加" class="layui-btn layui-btn-normal">
            <a href="lunbo.jsp"><input type="button" class="layui-btn layui-btn-normal" value="返回"></a><br>
        </form>
    </div>

</fieldset>

</body>
</html>
