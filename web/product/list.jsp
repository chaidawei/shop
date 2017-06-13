<!DOCTYPE html>
<%@ page import="com.lppz.index.ShowCate" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>大卫商城</title>
    <link rel="stylesheet" href="../css/layout.css">
    <script src="../js/jquery.min.js"></script>
    <script src="../js/common.js"></script>
    <![endif]-->
<body class="product-detail">
<!-- header include -->
<script type="text/javascript">
    $(function () {
        var $headerLogin = $("#headerLogin");
        var $headerRegister = $("#headerRegister");
        var $headerUsername = $("#headerUsername");
        var $headerLogout = $("#headerLogout");
        var $productSearchForm = $("#productSearchForm");
        var username = $('#uname').val()
        if (username != "null") {
            $('#divlogin').html("<a class=\"nick\" href=\"../user/user.jsp\" id=\"username\">" + username + "</a>").show();
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

        }
        //搜索
        var $keyword = $("#productSearchForm input");
        var defaultKeyword = "商品搜索";
        //搜索框进入
        $keyword.focus(function () {
            if ($keyword.val() == defaultKeyword) {
                $keyword.val("");
            }
        });
        //搜索框离开
        $keyword.blur(function () {
            if ($keyword.val() == "") {
                $keyword.val(defaultKeyword);
            }
        });
        //查询购物车数量
        if ($('#user').val() != "null") {
            $.ajax({
                type: "GET",
                url: "../car",
                data: {action: "count", username: $('#user').val()},
                dataType: "text",
                success: function (count) {
                    $('.cart-cache-num').html("<b>" + count + "</b>")
                }
            });
        }
        //商品
        var $goodName = $('#name');
        if ($goodName.val() != "null") {
            $.ajax({
                type: "POST",
                url: "../showgood",
                data: {id: $goodName.val()},
                dataType: "json",
                async: false,
                success: function (goodinfo) {
                    for (i = 0; i < goodinfo.length; i++) {
                        $('.p-title').html(goodinfo[i].gname);
                        $('.p-exp').html(goodinfo[i].gname);
                        $('#priceShow').html("￥<span>" + goodinfo[i].gprice + "</span>");
                        $('#gid').html(goodinfo[i].id);
                    }
                }
            })
        } else {
            location.href = "../index.jsp";
        }

        //商品图片

        function showGoodsPic(id) {
            $.ajax({
                type: "POST",
                url: "../showpic",
                data: {action: "img", gid: id.html()},
                dataType: "text",
                async: false,
                success: function (pic) {
                    $('.dlist').html(pic);
                }
            });

            $.ajax({
                type: "POST",
                url: "../showpic",
                data: {action: "bigimg", gid: id.html()},
                dataType: "text",
                async: false,
                success: function (pic) {
                    $('.smallimg').attr("src", pic);
                    $('.smallimg').attr("jqimg", pic);
                    $('.bigimg').attr("src", pic);
                }
            })
        }


        showGoodsPic($('#gid'));
    });
</script>
<!-- header -->
<input type="hidden" name="username" id="uname" value="<%=session.getAttribute("username")%>">
<input type="hidden" name="goods_name" id="name" value="<%=request.getParameter("id")%>">
<div class="toolbar">
    <div class="toolbar-cont wide">
        <ul class="fl">
            <li id="headerUsername" class="headerUsername"></li>
            <li>欢迎来到大卫商城官方商城！</li>
            <li id="headerLogin" class="headerLogin none" style="display: list-item;"><a class="log" href="../login/login.html">[登录]</a></li>
            <li id="headerRegister" class="headerRegister none" style="display: list-item;"><a class="reg" href="../register/register.html">[注册]</a></li>
            <li id="headerLogout" class="headerLogout none" style="display: none;"><a class="log" href="../loginOut">[退出]</a></li>
        </ul>
        <ul class="fr">
            <li class="thover ">
                <div class="top-user-info">
                    <a class="my-lppz dorp-title">我的良品<i class="arrow"></i></a>
                    <div class="my-lppz-layer">
                        <div class="dorp-spacer"></div>
                        <div class="user-info">
                            <div class="m-pic">
                                <img id="avatarImg" src="../images/head/avatar.png" alt="用户头像">
                            </div>
                            <div class="m-name" id="divlogin" style="display: none;">
                                <a class="nick" href="../user/user.jsp" id="username"></a>
                                <a class="level" href="../user/user.jsp" title="" id="levelName"></a>
                            </div>
                            <div class="m-name" id="divnologin">
                                <a href="../login/login.html">您好，请登录</a>
                            </div>
                        </div>
                        <div class="menu-list">
                            <div class="m-nav">
                                <div class="item"><a target="_blank" href="../user/user.jsp">我的订单</a></div>
                                <div class="item"><a target="_blank" href="../user/user.jsp">我的关注</a></div>
                            </div>
                        </div>
                        <div class="view-list">
                            <div class="vl-title"><h4>最近浏览</h4><a class="more" href="../user/user.jsp" target="_blank">更多&nbsp;&gt;</a></div>
                            <ul class="vl-cont" id="ulHistory"></ul>
                        </div>
                    </div>
                </div>
            </li>
            <li class="tspacer">|</li>
            <li><a class="tlink" target="_blank" href="../index.jsp">官方网站</a></li>
            <li class="tspacer">|</li>
            <li><span class="tel">全国订购热线：<em>400-1177-517</em></span></li>

        </ul>
    </div>
</div>
<div class="header">
    <div class="head-main wide clearfix">
        <div class="logo"><a href="../index.jsp">大卫商城</a><span>官方商城</span></div>
        <div class="hd-search">
            <div class="search-area">
                <form id="productSearchForm" action="../search.jsp" method="get" target="_blank">
                    <input class="sch-key" type="text" name="keyword" id="keyword" value="商品搜索">
                    <input type="hidden" name="tkeyword" value="">
                    <input type="hidden" name="ckeyword"  value="">
                    <input class="sch-btn" type="submit" value="搜 索">
                </form>
            </div>
        </div>
        <div class="hd-user">
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
                        <a class="settle" href="#">去购物车结算</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="menu clearfix">
        <div class="menu-main wrap">
            <div class="goods-sort">
                <a class="goods-sort-btn" href="#"><span>商品分类</span><i class="icon"></i></a>
                <div class="goods-sort-nav" style="display: none;">
                    <ul>
                        <%=ShowCate.show()%>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- content -->
<div class="container wrap">
    <div class="place-site">
        <a>首页</a>
        <span>&gt;</span><a>坚果炒货</a>
        <span>&gt;</span><a>嗑壳坚果</a>
    </div>
    <div class="details">
        <div class="detail-top clearfix">
            <div id="product_show" class="product-preview">
                <div class="product-pic">
                    <div class="duct-zoom jqzoom">
                        <img width="400" height="400" src="" jqimg="" class="smallimg"><!--图片-->
                        <div class="jqZoomPup" style="top: 198px; left: 0px; width: 200px; height: 200px; display: none;"></div>
                    </div>
                    <div class="zoomdiv" style="width: 400px; height: 400px; display: none;">
                        <img class="bigimg" src=""><!--图片-->
                    </div>
                    <div id="duct-list">
                        <a href="javascript:;" class="duct-control" id="duct_prev"></a>
                        <a href="javascript:;" class="duct-control" id="duct_next"></a>
                        <div class="duct-items">
                            <!-- 放大镜-->
                            <div class="tempWrap" style="overflow:hidden; position:relative; width:360px">
                                <ul class="dlist" style="width: 360px; left: 0px; position: relative; overflow: hidden; padding: 0px; margin: 0px;">

                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="product-share clearfix">
                    <div class="coding">商品：<span id="gid"></span></div>
                </div>
            </div>
            <div class="product-param">
                <div class="primary">
                    <div class="p-title"><strong></strong></div>
                    <div class="p-exp"></div>
                    <div class="p-price" id="isscoreProduct" style="display:none;">
                        <div class="mall basic">
                            <div class="lb">价格：</div>
                            <span><del>￥<span>7</span>.90</del></span>
                        </div>
                    </div>

                    <div class="p-price" id="commonProduct">
                        <div class="promotion">
                            <div class="lb">价格：</div>
                            <div id="priceShow" class="cost">￥<span class="price"></span></div>
                        </div>
                    </div>

                    <div class="p-price" id="isscoreProduct1" style="display:none;">
                        <div class="promotion">
                            <div class="lb">兑换价：</div>
                            <div id="pointShowTbar" class="cost"><span></span>积分</div>
                        </div>
                    </div>

                    <div class="p-sales">
                        <div class="lb">月销量：</div>
                        <span class="mon-sales">137</span>
                    </div>
                    <div class="p-grade pim">
                        <div class="dt">商品评分：</div>
                        <div class="dd"><span class="score-star "><i class="star05">分</i></span></div>
                        <span class="sum-sales">（累计评价：<a class="all-comment-num sum-sales-nums" href="#">0</a>）</span>
                    </div>
                </div>
                <div class="choose">
                    <div class="p-favor pim">
                        <div class="dt">优惠信息：</div>
                        <div class="dd">
                            <a class="fold" href="javascript:;">收起</a>
                            <ul class="pim-plus fav-info">
                                <li>PC官方商城单笔实付满198元送棉麻抱枕</li>
                                <li>全场满68元包邮</li>
                            </ul>
                        </div>
                    </div>

                    <div class="p-favor pim none">
                        <div class="dt">赠品：</div>
                        <div class="dd">
                            <a class="fold" href="javascript:;">收起</a>
                            <div class="\&quot;gift-txt\&quot;">购满该商品可获得以下赠品</div>
                            <div id="productGifts11"></div>
                        </div>
                    </div>

                    <div class="c-taste pim">

                    </div>
                    <div class="c-num pim">
                        <div class="dt">数量：</div>
                        <div class="dd">
								<span class="num-btn">
									<a id="decrease" class="decrease disabled">-</a>
									<input class="quantity" type="text" onpaste="return false;" id="stockNumSelect" max="99" min="1" maxlength="4" value="1" name="quantity">
									<a id="increase" class="increase">+</a>
								</span>
                            <span class="num-unit">件<small style="display:none;">库存<span id="stockNum">100</span>件</small></span>
                        </div>
                    </div>
                    <div class="join-buy">
                        <a class="add-cart addToCart" href="javascript:;">加入购物车</a>
                        <a id="favorite" class="follow addFavorite" href="javascript:;">加关注</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="productGroup11" class="fitting-suit" style="display: none;"></div>
    <div class="content mgt">
        <div class="introduce" id="intro_top">
            <%--<div class="intro-tit int-fixed">--%>
            <%--<!--  <ul class="intro-tabs" id="intro_tabs">--%>
            <%--<li class="active"><a class="js" href="http://item.lppz.com/11000311.html#intro_top">商品介绍</a></li>--%>
            <%--<li><a class="wd" href="http://item.lppz.com/11000311.html#intro_top">你问我答</a></li>--%>
            <%--<li><a class="xz" href="http://item.lppz.com/11000311.html#intro_top">购买须知</a></li>--%>
            <%--<li><a class="fw" href="http://item.lppz.com/11000311.html#intro_top">售后服务</a></li>--%>
            <%--</ul>--%>
            <%--<div class="add-cart ">--%>
            <%--<span id="priceShowTbar" class="price">￥<i>7</i>.90</span>--%>
            <%--<a class="shoping addToCart" href="javascript:;">加入购物车</a>--%>
            <%--</div>-->--%>
            <%--</div>--%>
            <div class="intro-area">
                <div class="intro-item intr">
                    <div class="param">
                        <!--  &lt;!&ndash;-->
                    </div>
                    <div class="description">
                        <div class="title">
                            <strong>商品介绍</strong>
                        </div>

                    </div>

                </div>
                <div class="intro-item ask">
                    <!-- <div class="consult">
                         <div class="hint">提示：因厂家更改产品包装、产地或者更换随机附件等没有任何提前通知，且每位咨询者购买情况、提问时间等不同， 为此以下回复信息仅供参考！若由此给您带来不便请多多谅解，谢谢！</div>
                         <div class="con-btn"><a href="http://www.lppz.com/consultation/content/103c1ec3305311e5a454005056a25157.jhtml">我要咨询</a></div>
                     </div>-->

                    <div id="showControlPage2"></div>
                    <div id="loadingMessage2"></div>
                    <div id="pageBar2" class="pages"></div>
                </div>
            </div>
        </div>
        <div class="recbar">
            <div class="recbar-box">
                <h2>为您推荐</h2>
                <div class="rec-area">
                    <ul class="recbar-list">
                    </ul>
                </div>
            </div>
            <%-- <div class="recbar-box">
                 <h2>大家还购买了</h2>
                 <div class="rec-area">
                     <ul class="recbar-list">
                         <li>
                             <a href="http://item.lppz.com/11000682.html" title="香卤铁蛋（香辣味）（128g)" class="pic" target="_blank"><img src="image/f996fb0c-3739-41e7-a4aa-e27b3cdc231f-medium.jpg" alt="" class="lazy" data-original="http://img.lppz.com/upload/image/201704/f996fb0c-3739-41e7-a4aa-e27b3cdc231f-medium.jpg" style="display: block;"></a>
                             <a href="http://item.lppz.com/11000682.html" class="tit" target="_blank">香卤铁蛋（香辣味）（128g)</a>
                             <p><span class="price">价格 ￥12.9</span></p>
                         </li>
                         <li>
                             <a href="http://item.lppz.com/11000690.html" title="黑糖沙琪玛（270g）" class="pic" target="_blank"><img src="image/CghmzVdL7HGABdMSAABKiU0c3i0131.jpg" alt="" class="lazy" data-original="http://img.lppz.com/group1/M00/01/FD/CghmzVdL7HGABdMSAABKiU0c3i0131.jpg" style="display: block;"></a>
                             <a href="http://item.lppz.com/11000690.html" class="tit" target="_blank">黑糖沙琪玛（270g）</a>
                             <p><span class="price">价格 ￥9.9</span></p>
                         </li>
                         <li>
                             <a href="http://item.lppz.com/11000426.html" title="Tipo牛奶味奶蛋酥脆面包干" class="pic" target="_blank"><img src="image/CghmzFe6eHeAKLkSAAA2WP0rr6k852.jpg" alt="" class="lazy" data-original="http://img.lppz.com/group1/M00/02/4F/CghmzFe6eHeAKLkSAAA2WP0rr6k852.jpg" style="display: block;"></a>
                             <a href="http://item.lppz.com/11000426.html" class="tit" target="_blank">Tipo牛奶味奶蛋酥脆面包干</a>
                             <p><span class="price">价格 ￥11.9</span></p>
                         </li>
                     </ul>
                 </div>
             </div>--%>
        </div>
    </div>

    <%--<div class="give-like">
        <div class="gl-tit"><h3>浏览记录</h3></div>
        <div class="gl-cont">
            <div class="gl-scroll">
                <ul class="gl-list"><li><a href="index.html" title="葵花籽(奶油味)（190g)" class="pic">
                    <img src="image/CghmzVdJDQeAbiG7AAART-YBYtI732.jpg" alt="" class="lazy" data-original="image/CghmzVdJDQeAbiG7AAART-YBYtI732.jpg" style="display: block;"></a>
                    <a href="./葵花籽（奶油味）190g - 良品铺子_files/葵花籽（奶油味）190g - 良品铺子.html" class="tit">葵花籽(奶油味)（190g)</a><p><span class="price">￥7.90</span></p></li>
                </ul>
            </div>
            <a class="gl-prev" href="javascript:;"></a>
            <a class="gl-next" href="javascript:;"></a>
        </div>
    </div>--%>
</div>

<!--通知弹窗-->
<div class="msg-popups" id="aogMessage" style="width:460px">
    <div class="msg-wrap">
        <div class="msg-tit"><span><i class="icon"></i>到货通知</span><a href="javascript:;" class="shut-btn close">关闭</a></div>
        <div class="msg-cont">
            <div class="msg-aog">
                <div class="aog-cue">一旦商品在30日内到货，您将收到邮件<!--、短信和手机-->推送消息！<!--通过手机客户端消息提醒，购买更便捷~--></div>
                <ul class="msg-form">
                    <!--<li><span class="lb-txt">手机号码：</span><input class="tx-ipt" type="text" name="" id="" /></li>-->
                    <li><span class="lb-txt">邮箱地址：</span><input class="tx-ipt" type="text" name="" id="notifyEmail"><!--<b class="red">*</b><label for="" class="fieldError">邮箱格式不对</label>--></li>
                </ul>
            </div>
        </div>
        <div class="msg-btn">
            <input class="confirm" type="button" value="确 定">
            <input class="shut-btn cancel" type="button" value="取 消">
        </div>
    </div>
</div>
<!-- 右侧功能菜单 -->
<!-- 右侧功能菜单 -->
<div class="right-navbar">
    <ul class="rnb-list">
        <li class="kf"><a class="hvr" id="ntkf_chat_entrance" onclick="initCustomer()" href="javascript:;"><span>客服咨询</span><i class="icon">▪</i></a></li>
        <li class="gw indexcart"><a href="../buycar/carlist.jsp"><i class="icon">▪</i><span>购物车</span>
            <small class="sum" id="cartcount">0</small>
        </a></li>
        <li class="hy"><a class="hvr" target="_blank" href="../user/user.jsp"><span>会员中心</span><i class="icon">▪</i></a></li>
        <li class="sc"><a class="hvr" target="_blank" href="../user/user.jsp"><span>我的关注</span><i class="icon">▪</i></a></li>
        <li class="jl"><a class="hvr" target="_blank" href="../user/user.jsp"><span>我的订单</span><i class="icon">▪</i></a></li>
    </ul>
    <ul class="rnb-link">
        <li class="goback"><a class="hvr" href="../index.jsp"><span>返回顶部</span><i class="icon">▪</i></a></li>
    </ul>
</div>
<!-- footer -->
<!-- footer -->
<div class="footer">
    <div class="foot-service">
        <ul>
            <li class="zp"><em>100%</em>
                <p>正品保证</p></li>
            <li class="th"><em>10天</em>
                <p>无理由退换货</p></li>
            <li class="by"><em>满68元</em>
                <p>全场包邮</p></li>
            <li class="jf"><em>积分抵现金</em>
                <p>100积分=1元</p></li>
            <li class="yh"><em>开箱验货</em>
                <p>先验货再签收</p></li>
            <li class="sd"><em>多仓就近发货</em>
                <p>快速直达</p></li>
        </ul>
    </div>
    <div class="foot-area">
        <div class="foot-cont clearfix">
            <div class="fc-contact">
                <div class="ctt-icon">热线</div>
                <div class="ctt-txt">
                    <p><strong>400-1177-517</strong></p>
                    <p>良品铺子客服热线<br>
                        周一至周日：9：00-22：00</p>
                    <p>招商热线<br>
                        400-1177-517</p>
                </div>
            </div>
            <div class="fc-link">
                <dl>
                    <dt><strong>购物指南</strong></dt>
                    <dd>
                        <a target="_blank">安全账户</a>
                        <a target="_blank">购物流程</a>
                        <a target="_blank">老顾客重置密码</a>
                        <a target="_blank">生日礼购物流程</a>
                        <a target="_blank">找回密码</a>
                    </dd>

                </dl>
                <dl>
                    <dt><strong>物流配送</strong></dt>
                    <dd>
                        <a target="_blank">配送说明</a>
                        <a target="_blank">签收与验货</a>
                    </dd>

                </dl>
                <dl>
                    <dt><strong>付款说明</strong></dt>
                    <dd>
                        <a target="_blank">发票制度</a>
                        <a target="_blank">公司转账</a>
                        <a target="_blank">在线支付</a>
                    </dd>

                </dl>
                <dl>
                    <dt><strong>客户服务</strong></dt>
                    <dd>
                        <a target="_blank">退换货服务</a>
                        <a target="_blank">联系我们</a>
                        <a target="_blank">退款说明</a>
                    </dd>

                </dl>
                <dl>
                    <dt><strong>会员专区</strong></dt>
                    <dd>
                        <a target="_blank">优惠券使用规则</a>
                        <a target="_blank">积分制度</a>
                        <a target="_blank">会员须知</a>
                    </dd>

                </dl>
            </div>
            <div class="fc-follow">
                <div class="qr-code"><img src="image/ft_qrcode.png" alt=""><span>微信二维码</span></div>
            </div>
        </div>
    </div>

    <div class="foot-nav">
        <ul>
            <li>
                <a>关于我们</a>
                |
            </li>
            <li>
                <a>联系我们</a>
                |
            </li>
            <li>
                <a>客户服务</a>
                |
            </li>
            <li>
                <a>诚聘英才</a>
                |
            </li>
            <li>
                <a>商务合作</a>
                |
            </li>
            <li>
                <a>媒体报道</a>
                |
            </li>
            <li>
                <a>网站地图</a>
                |
            </li>
            <li>
                <a>站长招募</a>

            </li>
        </ul>
    </div>
    <div class="foot-copyright">
        Copyright@2006-2017 湖北良品铺子电子商务有限公司 All rights Reserved<br><a target="_blank" href="http://www.miibeian.gov.cn/publish/query/indexFirst.action">鄂ICP备15022981号</a><br>
        <a href="http://wljg.egs.gov.cn/iciaicweb/dzbscheck.do?method=change&id=E2015081800082726"><img alt="网络经济主体信息" border="0" dragover="true" src="../images/gslogo.png"></a>
    </div>
</div>
<input type="hidden" name="user" id="user" value="<%=session.getAttribute("u")%>">
<script type="text/javascript">
    $(function () {
        var $addCart = $('.addToCart');
        var $addFavorite = $('.addFavorite');
        // 加入购物车
        $addCart.click(function () {
            //加入购物车
            if ($('#user').val() == "null") {
                alert("请先登录");
                location.href = "../login/login.html";
                return;
            }
            var quantity = $('.quantity').val();
            var $id = $('#gid').html();
            quantity -= 0;
            if (/^\d*[1-9]\d*$/.test(quantity) && parseInt(quantity) > 0) {
                $.ajax({
                    url: "../car",
                    type: "GET",
                    data: {action: "add", id: $id, num: quantity, user: $('#user').val()},
                    dataType: "text",
                    cache: false,
                    success: function (message) {
                        alert(message);
                    }
                });
            } else {
                $.message("warn", "购买数量必须为正整数");
            }
        });


    });
</script>
<script type="text/javascript" src="js/o_code.js"></script>
<script type="text/javascript">
    var _gtc = _gtc || [];
    $(document).on('afterloadmember', function (o, username) {
        //聚合
        var _mvq = window._mvq || [];
        window._mvq = _mvq;
        _mvq.push(['$setAccount', 'm-28592-0']);

        _mvq.push(['$setGeneral', 'goodsdetail', '', /*用户名*/ username, /*用户id*/ '']);
        _mvq.push(['$logConversion']);

        _mvq.push(['setPageUrl', /*单品着陆页url*/ window.location.href]);	//如果不需要特意指定单品着陆页url请将此语句删掉
        _mvq.push(['$addGoods', /*分类id*/ 'c51fe57124aa44978e9f0eec46240c0b', /*品牌id*/ '', /*商品名称*/ '葵花籽(奶油味)（190g)', /*商品ID*/ '11000311', /*商品售价*/ '7.9', /*商品图片url*/ 'http://img.lppz.com/group1/M00/01/FA/CghmzVdJDPGAdeqrAAAl5_eqLos072.jpg', /*分类名*/ '嗑壳坚果', /*品牌名*/ '', /*商品库存状态1或是0*/ '', /*网络价*/ '', /*收藏人数*/ '', /*商品下架时间*/ '']);
        _mvq.push(['$addPricing', /*价格描述*/ '']);
        _mvq.push(['$logData']);

        //爱投
        var _aitgoodsData = [{
            "pName": "葵花籽(奶油味)（190g)", //商品名称 (必填)
            "price": '7.9', //商品售价 (必填)
            "clickUrl": window.location.href, //商品URL地址  (必填)
            "pid": "11000311", //商品唯一标识（ID） (必填)
            "imgUrl": "http://img.lppz.com/group1/M00/01/FA/CghmzVdJDPGAdeqrAAAl5_eqLos072.jpg", //商品预览图URL地址 (必填)
            "bName": "", //商品品牌名称
            "bNameUrl": "", //品牌页URL地址
            "cName": "",  //一级分类名称
            "subCategory": "嗑壳坚果", //二级分类名称
            "cPageUrl": "", //一级分类页url
            "startTime": "", //商品上架时间(13位或10位时间戳e.g.1441504971067)
            "invalidTime": "", //商品下架时间
            "originalPrice": "7.9", //商品原价
            "inventoryNum": "", //商品库存数量
            "star": "", //收藏人数
            "score": ""  //商品评分
        }];

        _gtc.push(["fnSetAccount", "1009"]);
        _gtc.push(["v", "1"]);
        _gtc.push(["fnGeneral", "arrived"]); //到达
        _gtc.push(["fnGeneral", "addGoods", _aitgoodsData]); //商品
        var nGtc = document.createElement("script");
        nGtc.type = "text/javascript";
        nGtc.async = true;
        nGtc.src = ("https:" == document.location.protocol ? "https://sslcdn.istreamsche.com" : "http://ga.istreamsche.com") + "/stat/gtc.js";
        document.getElementsByTagName("head")[0].appendChild(nGtc);
    });
</script>
<script src="../js/base.js"></script>
</body>
</html>