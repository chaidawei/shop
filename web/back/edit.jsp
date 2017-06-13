
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.lppz.back.db.MyDbUtil" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>留言</title>
    <script src="js/jquery-3.2.0.js"></script>
    <link rel="stylesheet" href="layui/css/layui.css" media="all">
    <script>
        $(function () {
            if("ok"==<%=request.getParameter("do")%>){
                if(confirm("留言成功，是否返回？")){
                    location.href="message.jsp";
                }
            }
            if("no"==<%=request.getParameter("do")%>){
                if(confirm("留言失败，是否返回？")){
                    location.href="message.jsp";
                }
            }
        })
    </script>


</head>
<body>
<fieldset class="layui-elem-field">
    <legend style="font-size: 30px">留言</legend>
    <div class="layui-field-box">
        <%--插入数据部分--%>
        <form method="post" action="../message.action" id="dd">
            　<input type="hidden" name="na" value="<%=session.getAttribute("account")%>" ><br>
           <input type="hidden" value="<%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())%>" name="date"><br>
            <script id="container" name="content" type="text/plain"></script>
            <!--配置文件-->
            <script type="text/javascript" src="ueditor/ueditor.config.js"></script>
            <!--    编辑器源码文件-->
            <script type="text/javascript" src="ueditor/ueditor.all.min.js"></script>
            <script type="text/javascript" charset="utf-8" src="ueditor/lang/zh-cn/zh-cn.js"></script>
            <!--   实力化编辑器-->
            <script type="text/javascript">
                var cfg = {
                    lang:'zh-cn',
                    autoHeight:true,//自动宽度
//                    initialFrameWidth:'50%',
                    initialFrameHeight: 150,
                    maximumWords:600,//限定的字符
                    tabSize:1,
                    toolbars:[[
                        'undo', 'redo', '|',
                        'bold', 'italic', 'forecolor', 'backcolor', 'insertunorderedlist',
                        ,'fontfamily','|','directionalityltr', 'directionalityrtl', 'indent', '|','justifyleft', 'justifycenter', 'justifyright', 'justifyjustify','|',
                        'emotion', '|','help'
                    ]],

                };
                var ue = UE.getEditor('container',cfg);
            </script>

     <button class="layui-btn  layui-btn-normal" style="margin: 10px;float: right">提交</button>
        </form>

</fieldset>

</body>
</html>
