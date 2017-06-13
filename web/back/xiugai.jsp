<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="com.lppz.back.db.MyUtil" %>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>商品修改</title>
    <script src="js/jquery-3.2.0.js"></script>
    <link rel="stylesheet" href="layui/css/layui.css">
    <script src="layui/layui.js"></script>
    <style>
        .cc{
            line-height: 30px;
        }
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
            font-size: 16px;
            font-weight: bold;
        }

    </style>
    <script>
        layui.use('form',function () {
            var form = layui.form();
            form.render();
        })
        $(function () {
            $('#st').val(<%=new MyUtil().queryBy("goods","statu","where id="+request.getParameter("ok"))%>);
        })
    </script>

</head>
<body>

<fieldset class="layui-elem-field">
    <legend><b>商品修改</b></legend>
    <div class="layui-field-box">
        <%
            MyUtil mu = new MyUtil();
            String sss=request.getParameter("ok");
            session.setAttribute( "my",request.getParameter("ok"));
        %>
        <form action="../Xg.action" method="post" enctype="multipart/form-data" class="cc layui-form">

            <div class="layui-form-item">
                <label class="layui-form-label">商品名称</label>
                <div class="layui-input-inline">
                    <input type="text" name="pname" id="n" class="layui-input" value="<%=new MyUtil().queryBy("goods","gname","where id="+request.getParameter("ok"))%>">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">所属分类</label>
                <div class="layui-input-inline">
                    <select name="cc" id="s">
                        <%

                            Object obj = mu.queryBy("cate,goods","cate.cname","where goods.c_id=cate.id and goods.id="+request.getParameter("ok"));
                            mu=new MyUtil();
                            List<Map<String,Object>> list1=mu.query("cate","1=1");
                            if(list1!=null){
                                for(Map<String,Object> ll:list1){
                                    if(ll.get("cname").toString().equals(obj.toString())){
                        %>
                        <option value="<%=ll.get("id")%>" selected><%=ll.get("cname")%></option>
                        <%
                        }else{
                        %>
                        <option value="<%=ll.get("id")%>"><%=ll.get("cname")%></option>
                        <%
                                    }
                                }
                            }
                        %>
                    </select>
                </div>

            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">价格</label>
                <div class="layui-input-inline">
                    <input type="text" name="pric" class="layui-input" value="<%=new MyUtil().queryBy("goods","gprice","where id="+request.getParameter("ok"))%>">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label"> 剩余数量</label>
                <div class="layui-input-inline">
                    <input type="text" name="num" class="layui-input" value="<%=new MyUtil().queryBy("goods","gnum","where id="+request.getParameter("ok"))%>">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">商品状态：</label>
                <div class="layui-input-inline">
                    <select name="st" id="st">
                      <option value="1">正常</option>
                      <option value="2">下架</option>
                    </select>
                </div>
            </div>

            <input type="submit" value="修改" style="position: relative;left: 130px" class="layui-btn layui-btn-normal">
            <input type="button" value="返回" style="position: relative;left: 140px" class="layui-btn layui-btn-normal" onclick="location.href='shangpin.jsp'">
        </form>
    </div>
</fieldset>
</body>
</html>
