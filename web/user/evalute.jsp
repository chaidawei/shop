<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>我的评价</title>
    <script src="../js/jquery.min.js"></script>
    <link rel="stylesheet" href="../css/lp_member.css">
<body>
<!-- header -->

<script type="text/javascript" src="../js/base.js"></script>
<script type="text/javascript">
    $(function() {
        var $headerLogin = $("#headerLogin");
        var $headerRegister = $("#headerRegister");
        var $headerUsername = $("#headerUsername");
        var $headerLogout = $("#headerLogout");
        var $productSearchForm = $("#productSearchForm");
        var username =  $('#uname').val()
        if (username !="null") {
            $('#divlogin').html("<a class=\"nick\" href=\"../user/user.jsp\" id=\"username\">"+username+"</a>").show();
            $('#divnologin').hide();
            $headerUsername.html("您好 <a href=\"#\" class=\"user\">" + username + "</a>，").show();
            $headerLogout.show();
            $headerLogin.hide();
            $headerRegister.hide();
        } else {
            $('#divlogin').html("").hide();
            $('#divnologin').show();
            $headerLogout.hide();
            $headerLogin.show();
            $headerRegister.show();
            location.href="../login/login.html";

        }

        });

</script>

<!-- header -->
<input type="hidden" name="username" id="uname" value="<%=session.getAttribute("username")%>">
<div class="toolbar">
    <div class="toolbar-cont wrap">
        <ul class="fl">
            <li id="headerUsername" class="headerUsername"></li>
            <li>欢迎来到良品铺子官方商城！</li>
            <li id="headerLogin" class="headerLogin none" style="display: list-item;"><a class="log" href="../login/login.html">[登录]</a></li>
            <li id="headerRegister" class="headerRegister none" style="display: list-item;"><a class="reg" href="../register/register.html">[注册]</a></li>
            <li id="headerLogout" class="headerLogout none" style="display: none;"><a class="log" href="../loginOut">[退出]</a></li>
        </ul>
        <ul class="fr">
            <li>
                <a class="" target="_blank" href="../index.jsp">官方网站</a>&nbsp;&nbsp;|
            </li>
            <li><span class="tel">全国订购热线：<em>400-1177-517</em></span></li>
        </ul>
    </div>
</div>
<div class="header">
    <div class="head-main wrap clearfix">
        <div class="logo"><a href="../index.jsp">良品铺子-BESTORE</a><span>官方商城</span></div>
        <div class="hd-user-nav">
            <ul>
                <li><a href="../user/user.jsp">会员中心</a></li>
                <li><a href="javascript:void (0)">安全中心</a></li>
            </ul>
        </div>
        <div class="hd-user">
            <div class="user-search">
                <form id="productSearchForm" action="../search.jsp" method="get" target="_blank">
                    <input class="sch-key" type="text" name="keyword" id="keyword" value="商品搜索" >
                    <input class="sch-btn" type="submit" value="">
                </form>
            </div>
            <div class="user-shoping">
                <a class="us-btn indexcart" href="../buycar/carlist.jsp">购物车</a>
                <span class="us-num cart-cache-num"><b>0</b></span>
                <div class="cart-list cart-list-body">
                    <span class="tit">最新加入的商品</span>
                    <div class="cart-roll">
                        <ul class="goods"></ul>
                    </div>
                    <div class="total">
                        <p>共<span class="red">0</span>件商品，共计<span class="sum">￥0.00</span></p>
                        <a class="us-btn indexcart" href="../buycar/carlist.jsp">购物车</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="../js/jquery.cookie.js"></script>
<script type="text/javascript">
    $(function() {
        var $keyword = $("#productSearchForm input");
        var defaultKeyword = "商品搜索";
        //搜索框进入
        $keyword.focus(function() {
            if ($keyword.val() == defaultKeyword) {
                $keyword.val("");
            }
        });
        //搜索框离开
        $keyword.blur(function() {
            if ($keyword.val() == "") {
                $keyword.val(defaultKeyword);
            }
        });

    });
</script>
<div class="user-main clearfix">
    <div class="user-side">
        <dl class="sn-list">
            <dt>订单中心</dt>
            <dd><a href="../user/order.jsp">我的订单</a></dd>
            <dd><a href="../user/evalute.jsp">我的评价</a></dd>
        </dl>
        <dl class="sn-list">
            <dt>资产中心</dt>
            <dd><a href="../user/order.jsp">我的储值余额</a></dd>
        </dl>
        <dl class="sn-list">
            <dt>关注中心</dt>
            <dd><a href="../user/order.jsp">关注的商品</a></dd>
            <dd><a href="../user/order.jsp">浏览历史</a></dd>
        </dl>
        <dl class="sn-list">
            <dt>我的设置</dt>
            <dd><a href="../user/person_data.jsp">个人资料</a></dd>
            <dd><a href="../user/address.jsp">收货地址</a></dd>
        </dl>
    </div>
    <div class="user-content">
        <div class="uc-recently">
            <div class="uc-recently-top"><h3>我的评价</h3></div>
            <div class="uc-recently-box">
                <div class="recent-type">
                    <a class="current" href="../user/evalute.jsp">所有评价</a>
                    <a class="no-pay" href="#">待评价（0）</a>
                    <a class="no-pay" href="h#">已评价（0）</a>
                </div>
                <table class="user-comm-tab">
                    <tbody>
                    <tr>
                        <th width="70">&nbsp;</th>
                        <th width="300">商品信息</th>
                        <th>购买时间</th>
                        <th>评价状态</th>
                    </tr>

                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- footer include -->
<!-- footer -->
<div class="footer">
    <div class="foot-service">
        <ul>
            <li class="zp"><em>100%</em><p>正品保证</p></li>
            <li class="th"><em>10天</em><p>无理由退换货</p></li>
            <li class="by"><em>满包邮</em><p>全程包邮</p></li>
            <li class="jf"><em>积分抵现金</em><p>100积分=1元</p></li>
            <li class="yh"><em>开箱验货</em><p>先验货再签收</p></li>
            <li class="sd"><em>多仓就近发货</em><p>快速直达</p></li>
        </ul>
    </div>
    <div class="foot-area">
        <div class="foot-cont clearfix">
            <div class="fc-contact">
                <div class="ctt-icon">热线</div>
                <div class="ctt-txt">
                    <p><strong>400-1177-517</strong></p>
                    <p>良品铺子客服热线<br>
                        周一至周日：9：00-23：00</p>
                    <p>招商热线<br>
                        400-1177-517</p>
                </div>
            </div>
            <div class="fc-link">
                <dl>
                    <dt><strong>购物指南</strong></dt>
                    <dd>
                        <a target="_blank" href="#">安全账户</a>
                        <a target="_blank" href="#">购物流程</a>
                        <a target="_blank" href="#">老顾客重置密码</a>
                        <a target="_blank" href="#">生日礼购物流程</a>
                        <a target="_blank" href="#">找回密码</a>
                    </dd>

                </dl>
                <dl>
                    <dt><strong>物流配送</strong></dt>
                    <dd>
                        <a target="_blank" href="#">配送说明</a>
                        <a target="_blank" href="#">签收与验货</a>
                    </dd>

                </dl>
                <dl>
                    <dt><strong>付款说明</strong></dt>
                    <dd>
                        <a target="_blank" href="#">发票制度</a>
                        <a target="_blank" href="#">公司转账</a>
                        <a target="_blank" href="#">在线支付</a>
                    </dd>

                </dl>
                <dl>
                    <dt><strong>客户服务</strong></dt>
                    <dd>
                        <a target="_blank" href="#">退换货服务</a>
                        <a target="_blank" href="#">联系我们</a>
                        <a target="_blank" href="#">退款说明</a>
                    </dd>

                </dl>
                <dl>
                    <dt><strong>会员专区</strong></dt>
                    <dd>
                        <a target="_blank" href="#">积分制度</a>
                        <a target="_blank" href="#">会员须知</a>
                    </dd>

                </dl>
            </div>
            <div class="fc-follow">
                <!--
                <div class="qr-code"><img src="./images/ft_qrcode.png" alt=""><span>微信二维码</span></div>
                -->
            </div>
        </div>

        <div class="foot-nav">
            <ul>
                <li>
                    <a href="#" target="_blank">关于我们</a>
                    |
                </li>
                <li>
                    <a href="#" target="_blank">联系我们</a>
                    |
                </li>
                <li>
                    <a href="#" target="_blank">客户服务</a>
                    |
                </li>
                <li>
                    <a href="#" target="_blank">诚聘英才</a>
                    |
                </li>
                <li>
                    <a href="#" target="_blank">商务合作</a>
                    |
                </li>
                <li>
                    <a href="#" target="_blank">媒体报道</a>
                    |
                </li>
                <li>
                    <a href="#" target="_blank">网站地图</a>
                    |
                </li>
                <li>
                    <a href="#" target="_blank">站长招募</a>

                </li>
            </ul>
        </div>
        <div class="foot-copyright">
            Copyright@2006-2017 湖北良品铺子电子商务有限公司 All rights Reserved<br><a target="_blank" href="#">鄂ICP备15022981号</a>
        </div>
    </div>
</div>
<!-- 公用JS -->
<script src="../js/basic.js"></script>

</body>
</html>