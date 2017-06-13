<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="com.lppz.back.db.Dbutil" %>
<%@ page import="com.lppz.back.db.MyUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>商品添加</title>
    <script src="js/jquery-3.2.0.js"></script>
    <link rel="stylesheet" href="layui/css/layui.css">
    <script src="layui/layui.js"></script>

    <script>
        $(function () {
                if("ok"=="<%=request.getParameter("ok")%>"){
                    if(!confirm("添加成功，是否继续添加？")){
                        location.href="shangpin.jsp";
                    }
                }
        })
    </script>

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

        .layui-field-box {
            width: 750px;
        }

        .layui-form-label {
            font-weight: bold;
            font-size: 16px;
        }
    </style>
    <script>
        layui.use('form', function () {
            var form = layui.form();
        });
    </script>

</head>
<body>
<input type="hidden" name="ok" value="<%=request.getParameter("ok")%>">
<fieldset class="layui-elem-field">
    <legend><b>商品添加</b></legend>
    <div class="layui-field-box layui-form">
        <form action="/aa.action" enctype="multipart/form-data" method="post">
            <div class="layui-form-item">
                <label class="layui-form-label">商品名称:</label>
                <div class="layui-input-inline">
                    <input type="text" name="spname" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">商品图片：</label>
                <div class="layui-input-inline">
                    <a href="javascript:;" class="file">选择图片(800*800)
                        <input type="file" name="file" multiple>
                    </a>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label"> 商品价格:</label>
                <div class="layui-input-inline">
                    <input type="tel" name="pric" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">商品重量:</label>
                    <div class="layui-input-inline">
                        <input type="text" name="spec" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">产源地:</label>
                    <div class="layui-input-block">
                        <select name="cy">
                            <%
                                MyUtil mu = new MyUtil();
                                List<Map<String, Object>> list = mu.query("source", "*", "where 1=1", "", "");
                                for (Map<String,Object> m : list) {
                            %>
                                <option value="<%=m.get("id")%>"><%=m.get("soname")%></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">商品评分:</label>
                    <div class="layui-input-inline">
                        <input type="text" name="pscore" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">包装形式:</label>
                    <div class="layui-input-block">
                        <select name="bz">
                            <%
                                MyUtil mu1 = new MyUtil();
                                List<Map<String, Object>> list2 = mu1.query("pack", "*", "where 1=1", "", "");
                                for (Map<String,Object> m : list2) {
                            %>
                            <option value="<%=m.get("id")%>"><%=m.get("paname")%></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">商品数量:</label>
                    <div class="layui-input-inline">
                        <input type="text" name="pnum" class="layui-input"><br>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">所属分类:</label>
                    <div class="layui-input-block">
                        <select name="modules">
                            <%
                                Dbutil db = new Dbutil();
                                List<Map<String, Object>> list1 = db.query("cate", "1=1");
                                //List<Map<String,Object>> list1=db.query("cate","1=1");
                                if (list1 != null) {
                                    for (Map<String, Object> ll : list1) {
                            %>
                            <option value="<%=ll.get("id")%>"><%=ll.get("cname")%>
                            </option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>
                </div>
            </div>
            　　　　　　　　　　　<input type="submit" class="layui-btn-normal layui-btn" value="提交">&nbsp;&nbsp;
            <a href="shangpin.jsp"><input type="button" class="layui-btn-normal layui-btn" value="返回"></a>
        </form>
    </div>
</fieldset>





</body>
</html>