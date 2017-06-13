<%@ page import="com.lppz.back.db.MyUtil" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>订单中心</title>
    <script src="../js/jquery.min.js"></script>
    <link rel="stylesheet" href="../css/lp_member.css">
    <style>
        table{
            text-align: center;
        }
    </style>
    <script type="text/javascript">
        function orderDialogClose() {
            $('.order-cancel-confirm .confirm').off();
            $(".order-cancel-confirm textarea").off();
            $('.order-cancel-confirm').remove();
            $('.order-overlays').remove();
        }

        function cancelOrder(orderId) {
            var templete = [];
            templete.push('<div class="order-overlays"><iframe src="about:blank"></iframe></div>');
            templete.push('<div class="order-cancel-confirm">');
            templete.push('	<div class="occ-head">确认订单取消</div>');
            templete.push('	<div class="occ-main">');
            templete.push('		<div class="occ-title">您为什么要取消呢？</div>');
            templete.push('		<ul>');
            templete.push('			<li><label><input type="radio" value="现在不想购买" name="occ-reason" />现在不想购买</label></li>');
            templete.push('			<li><label><input type="radio" value="价格波动" name="occ-reason" />价格波动</label></li>');
            templete.push('			<li><label><input type="radio" value="添加或删除商品" name="occ-reason" />添加或删除商品</label></li>');
            templete.push('			<li><label><input type="radio" value="送货时间过长" name="occ-reason" />送货时间过长</label></li>');
            templete.push('			<li><label><input type="radio" value="商品价格较贵" name="occ-reason" />商品价格较贵</label></li>');
            templete.push('			<li><label><input type="radio" value="重复下单" name="occ-reason" />重复下单</label></li>');
            templete.push('			<li><label><input type="radio" value="无法支付订单" name="occ-reason" />无法支付订单</label></li>');
            templete.push('			<li><label><input type="radio" value="收货人信息有误" name="occ-reason" />收货人信息有误</label></li>');
            templete.push('			<li class="row2"><label><input value="发票信息有误/发票未开" type="radio" name="occ-reason" />发票信息有误/发票未开</label></li>');
            templete.push('			<li><label><input type="radio" value="商品缺货" name="occ-reason" />商品缺货</label></li>');
            templete.push('			<li><label><input type="radio" value="其他原因" name="occ-reason" checked />其他原因</label></li>');
            templete.push('		</ul>');
            templete.push('		<div class="occ-explain">');
            templete.push('			<textarea name="occ-explain">请填写取消订单的原因</textarea>');
            templete.push('		</div>');
            templete.push('		<dl>');
            templete.push('			<dt>温馨提示：</dt>');
            templete.push('			<dd>● 订单成功取消后无法恢复</dd>');
            templete.push('			<dd>● 订单已付金额将返还至银行卡/支付宝账户</dd>');
            templete.push('			<dd>● 订单已用将根据退回商品实付金额与订单金额的比例进行返还</dd>');
            templete.push('		</dl>');
            templete.push('	</div>');
            templete.push('	<div class="occ-foot">');
            templete.push('		<span class="button confirm">取消订单</span>');
            templete.push('		<span class="button cancel" onclick="orderDialogClose();">暂不取消</span>');
            templete.push('	</div>');
            templete.push('	<div class="occ-close" onclick="orderDialogClose()">×</div>');
            templete.push('</div>');

            $('body').append(templete.join(''));
            var $ipt =  $('.order-cancel-confirm textarea');
            $ipt.on({
                focus: function() {
                    if ($(this).val() == '请填写取消订单的原因') {
                        $(this).val('');
                    }
                },
                blur: function() {
                    if ($(this).val() == '') {
                        $(this).val('请填写取消订单的原因');
                    }
                }
            });
            $('.order-cancel-confirm .confirm').on('click', function() {
                var val = $('.occ-main input[name="occ-reason"]:checked').val();
                var mydata = {
                    orderCode: orderId,
                    reason: val
                }
                if (val === '其他原因' && ($ipt.val() == '' || $ipt.val() == '请填写取消订单的原因')) {
                    alert('请填写取消订单的原因');
                    return;
                }
                mydata.reason = val === '其他原因' ? $ipt.val() : val;
                //$(this).attr({"disabled":"disabled"});
                $(this).unbind("click");
                $(this).attr("class","button cancel");
                $.ajax({
                    url: 'http://home.lppz.com/member/order/cancelOrder.jhtml',
                    type: 'post',
                    data: mydata,
                    headers: {token: $.cookie('token')},
                    success: function(message) {
                        orderDialogClose();
                        $.message(message);
                        if (message.type == 'success') {
                            window.location.reload();
                        }
                        // location.href = 'user_order_cancel.html';
                    }

                });
            });
        }


        function confirmOrder(orderCode,orderId){
            alertModal(
                "确认收货",
                "确定确认收货吗？",
                function(){
                    $(".alert-modal .confirm").on("click",function(){
                        $.ajax('http://home.lppz.com/member/order/confirmOrder.jhtml', {
                            type: 'post',
                            data: {orderCode:orderCode,orderId:orderId},
                            headers: {token: $.cookie('token')},
                            success: function(message) {
                                if (message.type == 'success') {
                                    window.location.reload();
                                }
                                alertModalClose();
                            }
                        });
                    });
                });
        }

        $(function() {
            var alreadyGet = {};
            $('.order-logistics').on('mouseenter', function() {
                var _me = $(this);
                var orderId = _me.attr('orderid');
                if (!alreadyGet[orderId]) {
                    $.get(
                        '#',
                        {
                            orderId: orderId
                        },
                        function(result) {
                            if (!!result.code) {
                                var _html = '<span class="arrows"></span>';
                                _html += '<div class="logis-list">';
                                _html += '<div class="courier-num"><span>'+result.name+'</span>单号：'+result.code+'</div>';
                                _html += '</div>';
                                _me.find('.logis-info').html(_html);
                                alreadyGet[orderId] = true;
                            }
                        }
                    );
                }
            });
        });


    </script>
<body>
<!-- header -->
<input type="hidden" name="username" id="uname" value="<%=session.getAttribute("username")%>">
<script type="text/javascript" src="../js/base.js"></script>
<script type="text/javascript">
    var username;
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
<div class="toolbar">
    <div class="toolbar-cont wrap">
        <ul class="fl">
            <li id="headerUsername" class="headerUsername"></li>
            <li>欢迎来到大卫商城官方商城！</li>
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
<input type="hidden" name="hi" value="<%=session.getAttribute("u")%>">
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
                    <input class="sch-key" type="text" name="keyword" id="keyword" value="商品搜索">
                    <input type="hidden" name="tkeyword" value="">
                    <input type="hidden" name="ckeyword"  value="">
                    <input class="sch-btn" type="submit" value="搜 索">
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
            <div class="uc-recently-top"><h3>我的订单</h3></div>
            <div class="uc-recently-box">
                <div class="recent-type">
                    <a href="#" class="current" id="all" onclick="all()">所有订单（<%=new MyUtil().count("order_info","where us_id="+new MyUtil().queryBy("user_info","id","where username='"+session.getAttribute("u")+"'"))%>）</a>
                    <a class="current" href="javascript:;" id="m" onclick="m()">待付款（<%=new MyUtil().count("order_info","where statu=1 and us_id="+new MyUtil().queryBy("user_info","id","where username='"+session.getAttribute("u")+"'"))%>）</a>
                    <a class="current" href="#" id="w" onclick="w()">待收货（<%=new MyUtil().count("order_info","where statu=2 and us_id="+new MyUtil().queryBy("user_info","id","where username='"+session.getAttribute("u")+"'"))%>）</a>
                    <a class="current" href="#" id="d" onclick="d()">已完成（<%=new MyUtil().count("order_info","where statu=3 and us_id="+new MyUtil().queryBy("user_info","id","where username='"+session.getAttribute("u")+"'"))%>）</a>
                </div>
              <!--提交查询结果-->
                    <table class="order-list my-order">
                        <tbody>

                        </tbody>
                    </table>
            </div>
        </div>
    </div>
</div>
<script>

    var a =  $('input[name=hi]').val()
    $(function () {
        $('#m').removeClass("current");
        $('#w').removeClass("current");
        $('#d').removeClass("current");
            $.ajax({
            type:"POST",
            url:"../ordershow.action",
            data:{"action":"all","name":a},
            dataType:"text",
            success:function (orders) {
                $('.my-order tbody').html(orders)
            }
        })
    })

function all() {
    window.location.reload();
}
  function m() {
       $('#all').removeClass("current");
       $('#w').removeClass("current");
       $('#d').removeClass("current");
        $('#m').addClass("current");
        $.ajax({
            type:"POST",
            url:"../ordershow.action",
            data:{"action":"m","name":a},
            dataType:"text",
            success:function (orders) {
                $('.my-order tbody').html(orders)
            }
        })
  }
    function w() {
        $('#all').removeClass("current");
        $('#m').removeClass("current");
        $('#d').removeClass("current");
        $('#w').addClass("current");
        $.ajax({
            type:"POST",
            url:"../ordershow.action",
            data:{"action":"w","name":a},
            dataType:"text",
            success:function (orders) {
                $('.my-order tbody').html(orders)

            }
        })

    }

    function d() {
        $('#all').removeClass("current");
        $('#w').removeClass("current");
        $('#m').removeClass("current");
        $('#d').addClass("current");
        $.ajax({
            type:"POST",
            url:"../ordershow.action",
            data:{"action":"d","name":a},
            dataType:"text",
            success:function (orders) {
                $('.my-order tbody').html(orders)

            }
        })
    }


</script>
<!-- footer -->
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
                <div class="qr-code"><img src="../images/us_qr_code.png" alt=""><span>微信二维码</span></div>
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
<script type="text/javascript">
    function selectValue(){
        $('#form1').submit();
    }

    //查看订单物流
/*    $(".order-logistics").hover(function(){
        var orderId = $(this).find(".courier-num").attr("orderId");//orderId='GW160528001946325';
        if(orderId!=''){
            var obj =$(this);
            $.ajax({
                url:'http://home.lppz.com/member/order/viewDelivery.jhtml',
                type: 'GET',
                dataType: 'json',
                data:{"expressCode": orderId},
                cache: false,
                success: function(data) {//alert(data.name);alert(data.message.type);
                    if (data.message.type == "success") {//alert(1);
                        obj.find(".courier-num").html("<span>物流公司</span>"+data.name+"快递");
                        obj.find(".courier-cont").html("物流单号："+data.code);
                        obj.find(".logis-info").show();
                        if(obj.find(".courier-cont").height() >300){
                            obj.find(".courier-cont").css({"height":"300px"})
                        };
                    }else{
                        obj.find(".courier-num").html("<span>"+data.name+"</span>");
                        obj.find(".courier-cont").html("此处物流信息");
                    }
                }
            });
        }else{
            $(this).find(".logis-info").stop().show();
            if($(this).find(".courier-cont").height() >300){
                $(this).find(".courier-cont").css({"height":"300px"})
            };
        }
    },function(){
        $(this).find(".logis-info").hide();
    });*/
</script>
<script src="../js/basic.js"></script>

</body></html>