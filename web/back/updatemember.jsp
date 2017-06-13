<%@ page import="com.lppz.back.db.MyUtil" %><%--
  Created by IntelliJ IDEA.
  User: webrx
  Date: 2017/5/24
  Time: 7:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf8">
    <title>会员信息修改</title>
    <script src="js/jquery-3.2.0.js"></script>
    <link rel="stylesheet" href="layui/css/layui.css">
    <script src="layui/layui.js"></script>
    <style>
        .layui-form-label {
            width: 160px;
            font-size: 16px;
        }

        .layui-input {
            width: 150px;
        }
    </style>
    <script>
        layui.use(['laydate', 'form'], function () {
            var laydate = layui.laydate();
            var form = layui.form();
        })

        $(function () {
            $('input:radio[value=<%=new MyUtil().queryBy("user_info","gender","where id="+request.getParameter("id"))%>]').attr("checked", "true");

            <%
            if(1 == (int)(new MyUtil().queryBy("user_info", "statu", "where id=" + request.getParameter("id")))){
                %>
              $('#statu option[value=1]').attr("selected","true");
            <%
           }else {
                %>
            $('#statu option[value=2]').attr("selected","true");

            <%
           }
           %>


            $('#btn').click(function () {
                var i = $('input[name=usernameid]').val();
                var n = $('input[name=realname]').val();
                var un = $('input[name=uname]').val();
                if ("".trim() == n || "".trim() == un) {
                    alert("名字不能为空")
                    return
                }
                var b = $('input[name=birth]').val();
                var g = $('input[type=radio]:checked').val();
                var s =$('#statu option:selected').val();
                $.ajax({
                    type: "POST",
                    url: "../updatemember.action",
                    data: {action: "member", id: i, rn: n, una: un, birth: b, gender: g,statu:s},
                    dataType: "text",
                    success: function (memberInfo) {
                        if(!confirm(memberInfo)){
                            location.href="member.jsp";
                        }
                    }
                })
            })
        })
    </script>

</head>
<body>
<fieldset class="layui-elem-field">
    <legend><b>会员信息修改</b></legend>
    <div class="layui-field-box layui-form">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">要修改会员的编号：</label>
                <input type="text" disabled name="usernameid" id="ui" class="layui-input" value="<%=request.getParameter("id")%>">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">用户真实姓名：</label>
                <input type="text" name="realname" class="layui-input" id="real" value="<%=new MyUtil().queryBy("user_info","realname","where id="+request.getParameter("id"))%>">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">用户昵称：</label>
                <input type="text" name="uname" class="layui-input" id="uname" value="<%=new MyUtil().queryBy("user_info","uname","where id="+request.getParameter("id"))%>">
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">出生日期：</label>
                <input type="text" name="birth" class="layui-input" onclick="layui.laydate({elem: this,max:laydate.now()})" id="birth" value="<%=new MyUtil().queryBy("user_info","birthday","where id="+request.getParameter("id"))%>">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">状态：</label>
            <div class="layui-inline">
                <select name="interest" lay-filter="aihao" id="statu">
                    <option value="1">活跃</option>
                    <option value="2">冻结</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">性别：</label>
            <div class="layui-input-block">
                <input type="radio" name="sex" value="男" title="男">
                <input type="radio" name="sex" value="女" title="女">
                <input type="radio" name="sex" value="保密" title="保密" checked>
            </div>
        </div>

        　　　　 　　　　　　　　　<input type="button" id="btn" class="layui-btn layui-btn-normal" value="确认修改">&nbsp;&nbsp;
        <a href="member.jsp"><input type="button" class="layui-btn layui-btn-normal" value="返回"></a>
    </div>
</fieldset>
</body>
</html>
