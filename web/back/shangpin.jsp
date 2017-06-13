<%@ page import="com.lppz.back.db.Dbutil" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>商品管理</title>
    <link href="layui/css/layui.css" rel="stylesheet">
    <script src="layui/layui.js"></script>
    <style>
        .layui-table th, .layui-table td {
            text-align: center;
        }

        a:hover {
            color: red;
        }


    </style>
</head>
<body>
<fieldset class="layui-elem-field">
    <legend><b>商品管理</b></legend>
    <div class="layui-field-box">
        <table class="layui-table">
            <thead>
            <tr>
                <th>商品编号</th>
                <th>商品名称</th>
                <th>商品重量</th>
                <th>所属分类</th>
                <th>价格</th>
                <th>剩余数量</th>
                <th>商品状态</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <%
                Dbutil db = new Dbutil();
                int sum = db.getcount("goods") % 5 == 0 ? db.getcount("goods") / 5 : db.getcount("goods") / 5 + 1;
                // System.out.print(sum);
                //接收删除传过来的那个id
                String os = request.getParameter("ok");
                if (os != null) {
                    db.delete("goods", "id='" + os + "'");
                }
                int k = request.getParameter("m") == null ? 1 : Integer.parseInt(request.getParameter("m"));
                int start = 1;
                int end = 10;
                if (sum <= 10) {
                    start = 1;
                    end = sum;
                }
                if (k >= 7 && sum > 10) {
                    start = k - 5;
                    end = k + 4;
                    if (end > sum) {
                        end = sum;
                        start = end - 9;
                    }
                }
                if (k > sum) {
                    k = sum;
                }
                if (k < 1) {
                    k = 1;
                }

                List<Map<String, Object>> list = db.limit("goods", 5, k, "1=1 order by id desc");

                if (list != null) {
                    for (Map<String, Object> map : list) {
            %>
            <tr>
                <td><%=map.get("id")%>
                </td>
                <td><%=map.get("gname")%>
                </td>
                <td><%=map.get("spec")%>&nbsp;g
                </td>
                <td><%
                    List<Map<String, Object>> st = db.querya("cate", "cname", "id='" + map.get("c_id") + "'");
                    if (st != null) {
                        for (Map<String, Object> ss : st) {
                            out.print(ss.get("cname"));
                        }
                    } else {
                        out.print("null");
                    }


                %></td>

                <td><%=map.get("gprice")%>
                </td>
                <td><%=map.get("gnum")%>
                </td>
                    <%
                   if(1==(int)map.get("statu")){
               %>
                <td>正常</td>
                    <%
                   }else {
                %>
                <td>下架</td>
                    <%
                   }
               %>
                <td><a onclick="return confirm('确定删除  <%=map.get("gname")%>?')" href="?ok=<%=map.get("id")%>&&m=<%=k%>">删除</a><a href="xiugai.jsp?ok=<%=map.get("id")%>" style="margin-left: 10px">修改</a></td>
            </tr>
            <%
                }
            } else {
            %><h2 style="position: absolute;top: 200px;left: 300px">请添加商品</h2><%
                }
            %>
            <tr>
                <td colspan="10"><a href="?m=<%=k-1%>">上一页</a>
                    <%
                        for (int i = start; i <= end; i++) {

                            if (i == k) {
                    %><span class="dd"><a href="?m=<%=i%>">&nbsp;<%=i%>&nbsp;</a></span><%
                    } else {
                    %><span class="cc"><a href="?m=<%=i%>">&nbsp;<%=i%>&nbsp;</a></span><%
                            }
                        }
                    %>
                    <a href="?m=<%=k+1%>">下一页</a></td>
            </tr>
            <tr>
                <td colspan="10"><a href="?m=1">首页&nbsp;&nbsp;</a>
                    <a href="?m=<%=sum%>"> 末页</a></td>
            </tr>
            </tbody>
        </table>
        <%--<div style="position:absolute;top: 350px;left: 450px">
            <a href="?m=<%=k-1%>">上一页</a>
            <%
                for(int i=start;i<=end;i++){

                    if(i==k){
            %><span class="dd"><a href="?m=<%=i%>"><%=i%></a></span><%
        }else{
        %><span class="cc"><a href="?m=<%=i%>"><%=i%></a></span><%
                }
            }
        %>
            <a href="?m=<%=k+1%>" >下一页</a>
        </div>
        <div style="position:absolute;top: 380px;left: 480px">
            <a href="?m=1">首页</a>
            <a href="?m=<%=sum%>"> 末页</a>
        </div>--%>
        <%
        %>
        <a href="add_shangpin.jsp">
            <button class="layui-btn layui-btn-normal" style="float: right ;margin-bottom: 10px">添加商品</button>
        </a>
    </div>
</fieldset>


</body>
</html>
