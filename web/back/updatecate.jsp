<%@ page import="com.lppz.back.db.MyUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %><%--
  Created by IntelliJ IDEA.
  User: webrx
  Date: 2017/5/23
  Time: 11:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>修改小分类</title>
    <script src="js/jquery-3.2.0.js"></script>
    <link rel="stylesheet" href="layui/css/layui.css">
    <script src="layui/layui.js"></script>
    <script>
        layui.use('form',function () {
            var form = layui.form();
        })
    </script>
    <style>
        .layui-form-label{
            width: 220px;
            font-size: 16px;
            font-weight: bold;
        }
    </style>
</head>
<body>
<fieldset class="layui-elem-field">
    <legend><b>修改小分类</b></legend>
    <div class="layui-field-box layui-form">
        <input type="hidden" name="hi" value="<%=request.getParameter("id")%>">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">修改前小分类名称：</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input"  disabled value="<%=new MyUtil().queryBy("cate","cname","where id="+request.getParameter("id"))%>"><br>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">修改前小分类所属大分类：</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" disabled value="<%=new MyUtil().queryBy("bigcate","bname","where id="+request.getParameter("b_id"))%>"><br>
                </div>
            </div>
        　　　 <div class="layui-inline">
                <label class="layui-form-label">修改后小分类名称：</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="new_name"><br>
                </div>
            </div>
        　　　<div class="layui-form-item">
            <label class="layui-form-label">  修改后小分类所属大分类：</label>
            <div class="layui-input-inline">
                <select name="select" id="s" >
                    <%
                        List<Map<String, Object>> list = new MyUtil().query("bigcate", "id,bname", "where 1=1", "order by id desc", "");
                        for (Map<String, Object> m : list) {
                    %>
                    <option value="<%=m.get("id")%>"><%=m.get("bname")%></option>
                    <%
                        }
                    %>
                </select><br>
            </div>
        </div>
        　　　　　　　　　　　　　　　　　<input type="button" id="bt" class="layui-btn layui-btn-normal" value="确认修改">&nbsp;&nbsp;
            <a href="cate.jsp"><input type="button" value="返回" class="layui-btn layui-btn-normal"></a>

</fieldset>


<script>
    $(function () {
        $('#bt').click(function () {
            var b = $('#s option:selected').val();
            var c = $('#new_name').val();
            if("".trim()==c){
                alert("小分类名不能为空");
                return;
            }
            var ci=$('input[type=hidden]').val()
            $.ajax({
                type:"POST",
                url:"../updatecate.action",
                data:{action:"cate",bi:b,cid:ci,cn:c},
                dataType:"text",
                success:function (cateInfo) {
                    if(confirm(cateInfo)){
                        location.href="cate.jsp"
                    }
                }
            })
        })
    })
</script>
</body>
</html>
