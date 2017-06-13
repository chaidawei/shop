
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8"/>
    <title>后台管理</title>
    <script src="js/jquery-3.2.0.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/custom.js"></script>
    <link href="css/bootstrap.css" rel="stylesheet"/>
    <link href="css/font-awesome.css" rel="stylesheet"/>
    <link href="css/custom.css" rel="stylesheet"/>
    <link rel="stylesheet" href="css/base.css">
    <script>
        function hours() {
            var date = new Date();
            var y = date.getFullYear();
            var mo = date.getMonth() + 1;
            var d = date.getDate();
            var h = date.getHours();
            var mi = date.getMinutes();
            var s = date.getSeconds();
            mo = mo < 10 ? "0" + mo : mo;
            d = d < 10 ? "0" + d : d;
            h = h < 10 ? "0" + h : h;
            mi = mi < 10 ? "0" + mi : mi;
            s = s < 10 ? "0" + s : s;

            document.getElementById("hours").innerHTML =
                y + "年" + mo + "月" + d + "日" + h + "点" + mi + "分" + s + "秒";
            setTimeout("hours()", 1000);
        }
    </script>
</head>
<body onload="hours()">
<div id="wrapper">
    <div class="navbar navbar-inverse navbar-fixed-top">
        <div class="adjust-nav">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">
                    <img src="img/logo.png"/>
                </a>
            </div>
            <span class="logout-spn">
                  <a href="#" style="color:#fff;">大卫商城</a>
            </span>
        </div>
    </div>
    <!-- /. NAV TOP  -->
    <nav class="navbar-default navbar-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav" id="main-menu">
                <li class="active-link">
                    <a href="member.jsp" target="mm"><i class="fa fa-desktop "></i>会员信息</a>
                </li>
                <li>
                    <a href="shangpin.jsp" target="mm"><i class="fa fa-table "></i>商品管理</a>
                </li>
                <li>
                    <a href="bigcate.jsp" target="mm"><i class="fa fa-edit "></i>管理大分类</a>
                </li>
                <li>
                    <a href="cate.jsp" target="mm"><i class="fa fa-qrcode "></i>管理小分类</a>
                </li>
                <li>
                    <a href="lunbo.jsp" target="mm"><i class="fa fa-bar-chart-o"></i>轮播广告</a>
                </li>
                <li>
                    <a href="order.jsp" target="mm"><i class="fa fa-edit "></i>订单处理 </a>
                </li>
                <li>
                    <a href="message.jsp" target="mm"><i class="fa fa-table "></i>留言管理</a>
                </li>
                <li>
                    <a href="and.jsp" target="mm"><i class="fa fa-edit "></i>统计分析 </a>
                </li>

            </ul>
        </div>

    </nav>
    <!-- /. NAV SIDE  -->
    <div id="page-wrapper">
        <div id="page-inner">
            <div class="row">
                <div class="col-lg-12">
                    <Strong class="welcom">欢迎进入后台管理系统</Strong>
                    <span class="welcom_s">&nbsp;&nbsp;<a href="../loginout.action">[退出]</a></span>
                </div>
            </div>
            <!-- /. ROW  -->
            <div id="page_right"></div>
            <div class="row">
                <div class="col-lg-12 ">
                    <div class="alert alert-info">
                        <span class="alert_span"><%=session.getAttribute("account")%></span>您好，现在的时间是<span id="hours"></span>
                    </div>
                </div>
            </div>
            <div class="page_right_foot">
                <iframe name="mm" frameborder="0"scrolling="no" style="height:700px;width: 80% ;margin: 5% 10%" src="message.jsp"></iframe>
            </div>
        </div>
    </div>
</div>
</body>
</html>
