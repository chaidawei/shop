<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <title>订单信息 - 良品铺子</title>

    <link rel="stylesheet" href="../css/layout.css">
    <link rel="stylesheet" href="../css/global.css">
    <link rel="stylesheet" href="../css/common.css">
    <link rel="stylesheet" href="../css/order.css">
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="../js/common.js"></script>
    <script type="text/javascript" src="../js/base.js"></script>
    <script type="text/javascript" src="../js/basic.js"></script>
    <script type="text/javascript" src="../js/jsAddress.js"></script>
    <script type="text/javascript">
        $().ready(function () {
            var couponsHtml = "";
            var $couponNum = 0;
            var $dialogOverlay = $("#dialogOverlay");
            var $receiverForm = $("#receiverForm");
            var $coupon = $("#coupon ul");
            var $otherCouponButton = $("#otherCouponButton");
            var $newReceiverButton = $("#newReceiverButton");
            var $newReceiver = $("#newReceiver");
            var $pathAddress = $("#pathAddress");
            var $areaId = $("#areaId");
            var $newReceiverSubmit = $("#newReceiverSubmit");
            var $newReceiverCancelButton = $("#newReceiverCancelButton");
            var $orderForm = $("#orderForm");
            var $receiverId = $("#receiverId");
            var $paymentMethodId = $("#paymentMethod :radio");
            var $invoiceTitleTr = $("#invoiceTitleTr");
            var $invoiceTitle = $("#invoiceTitle");
            var $code = $("#code");
            var $couponCode = $("#couponCode");
            var $couponName = $("#couponName");
            var $couponButton = $("#couponButton");
            var $couponCancel = $("#couponCancel");
            var $score = $("#score");
            var $scoreButton = $("#scoreButton");
            var $invoiceButton = $("#invoiceButton");
            var $freight = $("#freight");
            var $discountFreight = $("#discountFreight");
            var $totalPay = $("#totalPay");
            var $promotionDiscount = $("#promotionDiscount");
            var $couponDiscount = $("#couponDiscount");
            var $tax = $("#tax");
            var $amountPayableSmall = $("#amountPayableSmall");
            var $amountPayableBig = $("#amountPayableBig");
            var $amountPay = $("#amountPay");
            var $memberPoint = $("#memberPoint");
            var $scoreCurrency = $("#scoreCurrency");
            var $isInvoice = $("#isInvoice");
            var $invoiceTitle = $("#invoiceTitle");
            var $receiptType = $("#receiptType:radio");
            var $receiptType1 = $("#receiptType1");
            var $receiptType2 = $("#receiptType2");
            var $receiptInfoForm = $("#receiptInfoForm");
            var $submit = $("#submit");
            var $payPassword = $('.pay-password');
            var $payPaswordInput = $('#payPaswordInput');
            var shippingMethodIds = {};


            //加载商品清单
            $.ajax({
                url: "../loadlist",
                type: "POST",
                data: {ids: "<%=request.getParameter("cartItems")%>"},
                dataType: "text",
                async: false,
                success: function (listdata) {
                    $('.goods-info').html(listdata);
                }

            });
            // 新收货地址取消
            $newReceiverCancelButton.click(function () {
                $pathAddress.hide();
            });

            if ($receiverId.val() != "") {
                $pathAddress.hide();
            }


            if ($(".invoice dd.hide").css("display") == "none") {
                $isInvoice.val(false);
            } else {
                if ($(".cho .rd-ipt").is(":checked")) {
                    $isInvoice.val(true);
                }
            }
            var hasLoadCoupon = false;
            $(".strategy dl .direction").click(function () {
                $(this).toggleClass("fold");
                $(this).next("dd").toggle();
                if ($(".invoice dd.hide").css("display") == "none") {
                    $isInvoice.val(false);
                } else {
                    $isInvoice.val(true);
                }
            });

            if ($(".rd-com").is(":checked")) {
                $(".tinput").show();
            }


            $(".pick-bill .cho").click(function () {
                $(this).find("input:radio").attr('checked', 'true');
                if ($(".rd-com").is(":checked")) {
                    $(".tinput").show();
                    $receiptType1.val('');
                    $receiptType2.val('company');
                } else {
                    $(".tinput").hide();
                    $receiptType2.val('');
                    $receiptType1.val('person');
                }
                $isInvoice.val(true);
            })

            $(".without").click(function () {
                $(this).parent().parent("dd").hide().prev("dt.direction").removeClass("fold");
                $isInvoice.val(false);
            })

            //收货地址
            $("#order_path ul li").hover(function () {
                $(this).addClass("on");
            }, function () {
                $(this).removeClass("on");
            });

            $("#order_path ul .myadd").click(function () {
                $(this).addClass("current").siblings().removeClass("current");
                $receiverId.val($(this).attr("receiverId"));

                var showReceiver = $(this).attr("showReceiver");
                var showConsignee = $(this).attr("showConsignee");
                $(".order-delivery").html("寄送至：" + showReceiver + "<br />" + "收货人：" + showConsignee);
                calculate();
            });

            $("#order_path ul b.def").live('click', function () {
                var reId = $(this).parent().parent().attr("name");
                $.ajax({
                    url: "http://home.lppz.com/member/receiver/setDefault.jhtml",
                    type: "get",
                    data: {
                        receiverId: reId,
                        is_default: 1
                    },
                    dataType: 'jsonp',
                    cache: false,
                    success: function (data) {
                        calculate();
                    }
                });
                $(this).parent().parent().find('span.def').remove();
                $(this).parent().parent().find('dt').append("<span class='def' name='isDefault'>默认地址</span>");
                $(this).parent().parent().parent().siblings().find('span.def').remove();

                $(this).parent().parent().parent().siblings().find('b.def').remove();
                $(this).parent().parent().parent().siblings().find('dd.ubtn').append('<b class="def">设为默认</b>');
                $(this).remove();
            });

            $("#order_path .more-path").click(function () {
                $(this).find("i").toggleClass("up");
                $(this).parent().prev(".path-exp-list").toggleClass("path-exp-fold");
                if ($(this).find("i").hasClass("up")) {
                    $(this).find("b").text("收起")
                } else {
                    $(this).find("b").text("查看更多地址")
                }
                ;
            });
            $("#pathAddress .close-path").click(function () {
                $("#pathAddress,#newReceiver").hide();
                $(".mask-layer").hide();
            });
            $("#newReceiverCancelButton").click(function () {
                $("#pathAddress,#newReceiver").hide();
                $(".mask-layer").hide();
            });

            //订单提交
            $submit.click(function () {
                if ($("#receiverId").val() == '') {
                    $.message("warn", "收货地址未选择");
                    return false;
                }
                var submitData = $orderForm.serialize();
                $.ajax({
                    url: "../create",
                    type: "POST",
                    data: submitData,
                    dataType: "json",
                    cache: false,
                    success: function (message) {
                        if (message.type == "success") {
                            alert("提交成功");
                            location.href = "../user/order.jsp";
                        } else {
                            alert("提交失败");
                            location.href = "../buycar/cartlist.jsp";
                        }
                    }
                });
            });
            var delivery = $('.order-delivery');
            //查询地址
            $.ajax({
                type: "POST",
                url: "../showaddr",
                data: {action: "oaddr", username: $('#user').val()},
                dataType: "json",
                success: function (d) {
                    for (i = 0; i < d.length; i++) {
                        $('.path-exp-list').html(d[i].addrInfo);
                        $('#receiverId').val(d[i].id);
                        $('#userId').val(d[i].user);
                        delivery.html("寄送至：" + d[i].receiverAddr + "<br> 收货人：" + d[i].showconsignee);
                    }
                }
            })

        });
    </script>
</head>

<body>
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
            location.href = "../login/login.html";

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

    });

</script>

<!-- header -->
<input type="hidden" name="username" id="user" value="<%=session.getAttribute("u")%>">
<input type="hidden" name="uname" id="uname" value="<%=session.getAttribute("username")%>">
<div class="toolbar">
    <div class="toolbar-cont wide">
        <ul class="fl">
            <li id="headerUsername" class="headerUsername"></li>
            <li>欢迎来到良品铺子官方商城！</li>
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
                                <a href="login/login.html">您好，请登录</a>
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
    <div class="head-main wrap clearfix">
        <div class="logo"><a href="../index.jsp">良品铺子-BESTORE</a><span>官方商城</span></div>
        <div class="hd-search">
            <div class="search-area">
                <form id="productSearchForm" action="../search.jsp" method="get" target="_blank">
                    <input class="sch-key" type="text" name="keyword" id="keyword" value="商品搜索">
                    <input type="hidden" name="tkeyword" value="">
                    <input type="hidden" name="ckeyword" value="">
                    <input class="sch-btn" type="submit" value="搜 索">
                </form>
            </div>
        </div>
        <div class="hd-user">
            <div class="user-shoping">
                <a class="us-btn indexcart" href="carlist.jsp">购物车</a>
                <span class="us-num cart-cache-num"><b>0</b></span>
            </div>
        </div>
    </div>
    <div class="menu">
        <div class="menu-main wrap">
            <ul class="menu-list">
                <li><a href="../index.jsp">首页</a></li>
                <li><a href="#">上新尝鲜</a></li>
            </ul>
        </div>
    </div>
</div>
<div class="order-wrap">
    <div class="order-cont">
        <div class="step step2">
            <ul>
                <li>查看购物车</li>
                <li class="current">确认订单信息</li>
                <li>完成订单</li>
            </ul>
        </div>

        <div class="my-address">
            <div class="order-title">收货地址<a class="view-btn add-new-receiver" href="javascript:;" id="add">新增收货地址</a></div>
            <form id="receiverForm" action="#" method="post" novalidate="novalidate">
                <input type="hidden" id="id" name="id" value="866393fedc574705bdf9014107f86d9b">
                <div class="odr-path">
                    <div id="order_path" class="path-exp">
                        <ul class="path-exp-list">

                        </ul>
                    </div>
                    <!--  地址弹层  -->
                    <div class="path-address" id="pathAddress" style="display: none;">
                        <a class="close-path" href="javascript:void(0);">×</a><table class="new-receiver">
                        <caption>创建收货地址</caption>
                        <tbody>
                        <tr>
                            <th width="100"><span class="lb-name"><b class="requiredField">*</b>收货人姓名:</span></th>
                            <td><input type="text" id="consignee" name="consignee" class="text" maxlength="200"></td>
                        </tr>
                        <tr>
                            <th><span class="lb-name"><b class="requiredField">*</b>所在地区:</span></th>
                            <td>
                <span class="fieldSet">
                    <!--级联-->
                    <div>
                        <select id="cmbProvince"></select>
                        <select id="cmbCity"></select>
                        <select id="cmbArea"></select>
                        <script type="text/javascript">
                            addressInit('cmbProvince', 'cmbCity', 'cmbArea', '北京', '北京市', '朝阳区');
                            addressInit('Select1', 'Select2', 'Select3');
                        </script>
                    </div>
                </span>
                            </td>
                        </tr>
                        <tr>
                            <th><span class="lb-name"><b class="requiredField">*</b>详细地址:</span></th>
                            <td>
                                <input type="text" id="address" name="address" class="text" maxlength="200">
                                <span class="cue">请直接填写街道等详细地址，省/市/区不用填写</span>
                            </td>
                        </tr>
                        <tr>
                            <th><span class="lb-name"><b class="requiredField">*</b>手机号码/电话:</span></th>
                            <td>
                                <input type="text" id="phone" name="phone" class="text" maxlength="200">
                                <span class="cue">用于接受订单短信或送货前确认</span>
                            </td>
                        </tr>
                        <tr>
                            <th>&nbsp;</th>
                            <td>
                                <input type="button"  class="confirm save-receiver button" value="确  定">
                                <input type="button"  class="cancel mlt button" value="取  消">
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    </div>
                    <%--<div class="path-address" id="pathAddress" style="display: none;">--%>
                        <%--<a class="close-path" href="javascript:;">×</a>--%>
                        <%--<table class="newReceiver">--%>
                            <%--<caption><span id="aaaaaaa">创建收货地址</span></caption>--%>
                            <%--<tbody>--%>
                            <%--<tr>--%>
                                <%--<th width="100">--%>
                                    <%--<span class="lb-name"><b class="requiredField">*</b>收货人:</span>--%>
                                <%--</th>--%>
                                <%--<td>--%>
                                    <%--<input type="text" id="consignee" name="consignee" class="text" maxlength="200">--%>
                                <%--</td>--%>
                            <%--</tr>--%>
                            <%--<tr>--%>
                                <%--<th>--%>
                                    <%--<span class="lb-name"><b class="requiredField">*</b>地区:</span>--%>
                                <%--</th>--%>
                                <%--<td>--%>
										<%--<span class="fieldSet">--%>
											<%--<div>--%>
												<%--<select id="cmbProvince"></select>--%>
												<%--<select id="cmbCity"></select>--%>
												<%--<select id="cmbArea"></select>--%>
												<%--<script type="text/javascript">--%>
													<%--addressInit('cmbProvince', 'cmbCity', 'cmbArea', '北京', '北京市', '朝阳区');--%>
                                                    <%--addressInit('Select1', 'Select2', 'Select3');--%>
												<%--</script>--%>
											<%--</div>--%>
										<%--</span>--%>
                                <%--</td>--%>
                            <%--</tr>--%>
                            <%--<tr>--%>
                                <%--<th>--%>
                                    <%--<span class="lb-name"><b class="requiredField">*</b>地址:</span>--%>
                                <%--</th>--%>
                                <%--<td>--%>
                                    <%--<input type="text" id="address" name="address" class="text" maxlength="200">--%>
                                    <%--<span class="cue">请直接填写街道等详细地址，省/市/区不用填写</span>--%>
                                <%--</td>--%>
                            <%--</tr>--%>
                            <%--<!----%>
                            <%--<tr>--%>
                                <%--<th>--%>
                                    <%--<span class="lb-name">邮编:</span>--%>
                                <%--</th>--%>
                                <%--<td>--%>
                                    <%--<input type="text" id="zipCode" name="zipCode" class="text" maxlength="200" />--%>
                                    <%--<input type="hidden" id="zip_code" name="zip_code"  />--%>
                                <%--</td>--%>
                            <%--</tr>--%>
                            <%---->--%>
                            <%--<tr>--%>
                                <%--<th>--%>
                                    <%--<span class="lb-name"><b class="requiredField">*</b>手机/电话:</span>--%>
                                <%--</th>--%>
                                <%--<td>--%>
                                    <%--<input type="text" id="phone" name="phone" class="text" maxlength="200">--%>
                                    <%--<span class="cue">用于接受订单短信或送货前确认</span>--%>
                                <%--</td>--%>
                            <%--</tr>--%>
                            <%--<tr>--%>
                                <%--<th>--%>
                                    <%--<span class="lb-name">默认:</span>--%>
                                <%--</th>--%>
                                <%--<td>--%>
                                    <%--<input type="checkbox" name="isDefault" id="isDefault">--%>
                                    <%--<input type="hidden" id="is_default" name="is_default">--%>
                                    <%--<input type="hidden" name="_isDefault" value="false">--%>
                                <%--</td>--%>
                            <%--</tr>--%>
                            <%--<tr>--%>
                                <%--<th>&nbsp;--%>

                                <%--</th>--%>
                                <%--<td>--%>
                                    <%--<input type="submit" id="newReceiverSubmit" class="button" value="确  定">--%>
                                    <%--<input type="button" id="newReceiverCancelButton" class="button" value="取  消">--%>
                                <%--</td>--%>
                            <%--</tr>--%>
                            <%--</tbody>--%>

                        <%--</table>--%>
                    <%--</div>--%>

                    <script>
                        $(function () {
                            $('.add-new-receiver').click(function () {
                                pathUpOn($('#pathAddress'));
                            })
                        })
                    </script>
                </div>
            </form>
        </div>
        <div class="my-order">
            <form id="orderForm" action="../create" method="get" novalidate="novalidate">
                <div class="item">
                    <div class="order-title">支付方式</div>
                    <div class="payment-list">
                        <ul id="paymentMethod">
                            <li>
                                <label for="paymentMethod_1">
                                    <input type="radio" id="paymentMethod_1" name="paymentMethodId" value="1" checked="checked">
                                    <span class="check">网上支付<i></i></span>
                                    <span>支持支付宝、财付通、以及大多数网上银行支付</span>
                                </label>
                            </li>
                        </ul>
                    </div>
                    <input type="hidden" id="userId" name="userId" value="">
                    <input type="hidden" id="receiverId" name="receiverId" value=""/>
                    <input type="hidden" id="cartItems" name="cartItems" value="<%=request.getParameter("cartItems")%>"/>
                </div>
                <div class="item">
                    <div class="order-title">商品清单</div>
                    <div class="goods-title">
                        <a href="carlist.jsp" class="back">返回购物车</a>
                        <span>以下商品由良品商城发出，预计3-5天内送达</span>
                    </div>
                    <div class="goods-list">
                        <table>
                            <thead>
                            <tr>
                                <th width="80">&nbsp;</th>
                                <th class="tl">商品</th>
                                <th></th>
                                <th>价格</th>
                                <th>数量</th>
                                <th>小计</th>
                            </tr>
                            </thead>
                            <tbody class="goods-info">
                            <!-- 商品清单 -->

                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="item">
                    <div class="order-title">买家留言：</div>
                    <div class="buyer-msg">
                        <input class="ipt" name="memo" id="buyerMessage" maxlength="50" value="限50个字">
                        <span class="tips">提示：请勿填写有关支付、收货、发票方面的信息</span>
                    </div>
                </div>

                <div class="item">
                    <div class="order-title">发票信息</div>
                    <div class="invoice-info">
                        <div class="title">普通发票（纸质） <b>个人</b></div>
                        <input type="hidden" id="isInvoice" name="isInvoice" value="true">
                        <input type="hidden" id="invoiceType" name="invoiceType" value="1">
                        <input type="hidden" id="invoiceTitle" name="invoiceTitle" value="个人">
                    </div>
                </div>
            </form>
        </div>
    </div>
    <div class="order-total">
        <ul>
            <li><span class="gs-num"></span></li>
            <li>运费：<span><b>￥<em id="freight">10.00</em></b></span></li>
            <li>应付总额：<span class="amount" id="amountPayableSmall"></span></li>
        </ul>
    </div>
    <div class="order-delivery"></div>
    <div class="order-submit">
        <span class="total-sum" id="amountPayableBig"></span>
        <button id="submit" class="submit" type="button">提交订单</button>
    </div>
</div>
    <script>
        $(function () {
                var price = $('input[name=productPrice]');
                var num = $('input[name=quantitys]');
                var amount = $('.amount');
                var totalmoney = 0;
                var totalNum = 0;
                for (i = 0; i < price.length; i++) {
                    totalmoney += parseFloat(price[i].value).toFixed(2) * parseFloat(num[i].value).toFixed(2);
                    totalNum += parseInt(num[i].value);
                }
                $('.gs-num').html(totalNum).after("件商品，商品金额：<span><b>￥" + totalmoney + "</b></span>");
                var payMoney = parseInt($('#freight').html()) + parseFloat(totalmoney);
                amount.html("￥" + payMoney);
                $('.total-sum').html("应付总额：<b>¥</b><em>" + payMoney + "</em>");

            }
        )
    </script>
    <!-- footer -->
    <div class="footer">
        <div class="foot-service">
            <ul>
                <li class="zp"><em>100%</em>
                    <p>正品保证</p></li>
                <li class="th"><em>10天</em>
                    <p>无理由退换货</p></li>
                <li class="by"><em>满68元</em>
                    <p>全程包邮</p></li>
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
                            <a target="_blank" href="#">优惠券使用规则</a>
                            <a target="_blank" href="#">积分制度</a>
                            <a target="_blank" href="#">会员须知</a>
                        </dd>

                    </dl>
                </div>
                <div class="fc-follow">

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
                    Copyright@2006-2017 湖北良品铺子电子商务有限公司 All rights Reserved<br><a target="_blank" href="http://www.miibeian.gov.cn/publish/query/indexFirst.action">鄂ICP备15022981号</a>
                </div>
            </div>
        </div>
        <script language="javascript" type="text/javascript">
            $(function () {
                // 买家留言
                var buyerMsgCont = function () {
                    var $tareaId = $("#buyerMessage");
                    var $curLength = $tareaId.val().length;
                    var reMain = 200 - $tareaId.val().length;
                    var num = $tareaId.val().substr(0, 200);
                    if ($curLength > 200) {
                        $tareaId.val(num);
                        $tareaId.next(".tx-hint").addClass("red");
                    } else {
                        $tareaId.next(".tx-hint").removeClass("red").find(".num").text(reMain);
                    }
                }
                buyerMsgCont();

                $(".buyer-msg textarea").on({
                    focus: function () {
                        $(this).css({"height": 80});
                        if ($(this).val() === "选填") {
                            $(this).val("").css({"height": 80})
                        }
                    },
                    blur: function () {
                        if ($(this).val() === "") {
                            $(this).val("选填").css({"height": 20})
                        }
                    },
                    input: function () {
                        buyerMsgCont();
                    },
                    keyup: function () {
                        buyerMsgCont();
                    }
                });
            });

            NTKF_PARAM = {
                siteid: "kf_9893",
                settingid: "kf_9893_1407138307993",
                uid: username || '',
                uname: username || '',
                isvip: '',
                userlevel: '',
                ntalkerparam: {
                    cartprice: "",
                    items: [
                        {id: '', count: '0'}
                    ]
                }
            }
        </script>
        <script type="text/javascript">
            $(function() {
                var pathAddress = $('#pathAddress');
                $('#add').click(function () {
                    pathUp(pathAddress);
                });
//        <select id="cmbProvince"></select>
//            <select id="cmbCity"></select>
//            <select id="cmbArea"></select>

                var $province = $('#cmbProvince');
                var $city = $('#cmbCity');
                var $Area = $('#cmbArea');
                var $address = $('#address');
                var $phone = $('#phone');
                var $consignee = $('#consignee');


                $('.save-receiver').die().live('click', function() {

                    var consignee = $consignee.val();
                    if (!consignee) {
                        $consignee.focus();
                        alert('请填写收货人');
                        return;
                    }
                    if (!/^([\u4E00-\uFA29]|[\uE7C7-\uE7F3]|[a-zA-Z0-9])*$/.test(consignee)) {
                        $consignee.focus();
                        alert('收货人名称不能填写特殊字符！');
                        return;
                    }
                    var address = $address.val();
                    if (!address) {
                        $address.focus();
                        alert('请填写地址');
                        return;
                    }
                    if (!/^([\u4E00-\uFA29]|[\uE7C7-\uE7F3]|[a-zA-Z0-9])*$/.test(address)) {
                        $address.focus();
                        alert('收货地址不能填写特殊字符！');
                        return;
                    }
                    var phone = $phone.val();
                    if (!phone) {
                        $phone.focus();
                        alert('请填写电话号码');
                        return;
                    }
                    if (!/^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/.test(phone)){
                        $phone.focus();
                        alert('请填写正确的电话号码');
                        return;
                    }


//            var $province = $('#cmbProvince');
//            var $city = $('#cmbCity');
//            var $Area = $('#cmbArea');
//            var $address = $('#address');
//            var $phone = $('#phone');

                    //添加收货地址
                    $.ajax({
                        type:"POST",
                        url:"../saveaddr",
                        data:{username:$('#user').val(),consignee:$consignee.val(),province:$province.val(),city:$city.val(),area:$Area.val(),address:$address.val(),phone:$phone.val()},
                        dataType:"text",
                        success:function (message) {
                            alert(message);
                            $("#pathAddress").hide()
                            $(".mask-layer").remove();
                            showAddr();
                        }
                    })
                });
                //删除收货地址
                var addrId = $('#addr-del');
                addrId.click(function () {
                    if(confirm("是否删除该地址?")){
                        $.ajax({
                            url:"../deladdr",
                            type:"GET",
                            data:{id:addrId.attr("receiverId")},
                            dataType:"text",
                            success:function (message) {
                                alert(message);
                                showAddr();
                            }
                        })
                    }else{
                        return;
                    }

                });

            });
        </script>
</body>
</html>