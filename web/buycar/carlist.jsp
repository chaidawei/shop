<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
  <title>购物车</title>

  <link rel="stylesheet" href="../css/global.css">
  <link rel="stylesheet" href="../css/index.css">
  <link rel="stylesheet" href="../css/layout.css">
  <link rel="stylesheet" href="../css/common.css">
  <link rel="stylesheet" href="../css/cart.css">

  <script type="text/javascript" src="../js/jquery.min.js"></script>
  <script type="text/javascript" src="../js/common.js"></script>
</head>
<body class="cart-page">
<!-- header -->
<script type="text/javascript" src="../js/base.js"></script>
<script type="text/javascript">
    $(function () {
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
            alert("请先登录");
            location.href="../login/login.html";

        }

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
        //查询购物车数量
        if($('#user').val() != "null"){
            $.ajax({
                type:"GET",
                url:"../car",
                data:{action:"count",username:$('#user').val()},
                dataType:"text",
                success:function (count) {
                    $('.cart-cache-num').html("<b>"+count+"</b>")
                }
            });
        }
        //购物车详情
//        var $user = $('#user');
//        $.ajax({
//            type:"GET",
//            url:"../car",
//            data:{action:"query",username:$user.val()},
//            dataType:"text",
//            success:function (info) {
//                $('#cart-datas').html(info);
//            }
//        })
        reloadCart();
    });
</script>

<!-- header -->
<input type="hidden" name="username" id="user" value="<%=session.getAttribute("u")%>">
<input type="hidden" name="uname" id="uname" value="<%=session.getAttribute("username")%>">
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
      <!-- <div class="user-lppz"><a href="http://home.lppz.com/member/index.jhtml">我的良品</a></div> -->
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
<div class="container cart mgtop">
  <div class="span24">
    <div class="step step1">
      <ul>
        <li class="current">查看购物车</li>
        <li>确认订单信息</li>
        <li>完成订单</li>
      </ul>
    </div>
    <div id="cart-datas">

    </div>
  </div>
</div>
<!-- footer -->
<!-- footer -->
<div class="footer">
  <div class="foot-service">
    <ul>
      <li class="zp"><em>100%</em><p>正品保证</p></li>
      <li class="th"><em>10天</em><p>无理由退换货</p></li>
      <li class="by"><em>满68元</em><p>全程包邮</p></li>
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
            <a target="_blank" href="#">积分制度</a>
            <a target="_blank" href="#">会员须知</a>
          </dd>

        </dl>
      </div>
      <div class="fc-follow">
        <div class="qr-code"><img src="../images/us_qr_code.png" alt=""><span>微信二维码</span></div>
        <div class="weibo-mail">
          <div class="mail-rss" style="display:none;">
            <div class="rss-box"><input class="tx-ipt" type="text" name="" id="" value="输入邮箱或手机"><input class="rss-btn" type="button" value="订阅"></div>
            <div class="rss-cancel"><a href="">取消订阅</a></div>
          </div>
        </div>
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
<script type="text/javascript">
    $(function() {
        var $quantity = $("input[name='quantity']");
        var $increase = $("span.increase");
        var $decrease = $("span.decrease");
        var $delete = $("a.delete");
        var timeouts = {};
        // 初始数量
        $quantity.each(function () {
            var $this = $(this);
            $this.data("value", $this.val());
        });

        // 数量
        $quantity.die().live('keypress', function (event) {
            var key = event.keyCode ? event.keyCode : event.which;
            if ((key >= 48 && key <= 57) || key == 8) {
                return true;
            } else {
                return false;
            }
        });

        // 增加数量
        $increase.die().live('click', function () {
            var $quantity = $(this).siblings("input[name='quantity']");
            var quantity = $quantity.val();
            if (/^\d*[1-9]\d*$/.test(quantity)) {
                $quantity.val(parseInt(quantity) + 1);
            } else {
                $quantity.val(1);
            }
            edit($quantity);

        });

        // 减少数量
        $decrease.die().live('click', function () {
            var $quantity = $(this).siblings("input[name='quantity']");
            var quantity = $quantity.val();
            if (/^\d*[1-9]\d*$/.test(quantity) && parseInt(quantity) > 1) {
                $quantity.val(parseInt(quantity) - 1);
            } else {
                //$quantity.val(1);
                return;
            }
            edit($quantity);
        });

        // 编辑数量
        $quantity.die().live("input propertychange change", function (event) {
            if (event.type != "propertychange" || event.originalEvent.propertyName == "value") {
                if (test($(this).siblings("input[name='productCategory']"), parseInt($(this).val()))) {
                    $(this).val($(this).attr('oldvalue'));
                    return;
                }
                edit($(this));
            }
        });

        // 删除
        $delete.die().live('click', function () {
            var id = '';
            var $this = $(this);
            if ($this.attr('name') == 'deleteall') {
                if ($('table tr:gt(0)').find(':checkbox[checked]').size() == 0) {
                    $.message('warn', '请选择要删除的商品');
                    return;
                } else {
                    $('table tr:gt(0)').find(':checkbox[checked]').each(function (index, en) {
                        if (index == 0) {
                            id += $(en).val();
                        } else {
                            id += ',' + $(en).val();
                        }
                    });
                }
            } else {
                var $tr = $this.closest('tr');
                var val = $tr.find("input[name='id']").val();
                id = val;
            }
            if (!confirm("您确定要删除吗？")) {
                return false;
            }

            doDelete(id);
        });

        function doDelete(id, cb) {
            if (!cb) {
                cb = function (data) {
                    if (data.type == "success") {
                        reloadCart();
                    } else {
                        $.message(data);
                    }
                }
            }

            $.ajax({
                url: "../car",
                type: "POST",
                data: {action:"delete",id: id},
                dataType: "json",
                cache: false,
                success: cb
            });
        }


        // 编辑数量
        function edit($quantity) {
            var quantity = $quantity.val();
            if (/^\d*[1-9]\d*$/.test(quantity)) {
                //修改购物车数量
                var $tr = $quantity.closest("tr");
                var id = $tr.find("input[name='id']").val();
                clearTimeout(timeouts[id]);
                timeouts[id] = setTimeout(function () {
                    $.ajax({
                        url: "../car",
                        type: "GET",
                        data: {action:"total",id: id,quantity: quantity},
                        dataType: "json",
                        cache: false,
                        success: function (data) {
                            if (data.type != 'success') {
                                $quantity.val($quantity.attr('oldvalue'));
                            } else {
                                reloadCart();
                            }
                        }
                    });
                }, 300);
            } else {
                $quantity.val($quantity.attr('oldvalue'));
            }
        }

        //选择
        $(':checkbox[value]').die().live('click', function () {
            if ($(this).hasClass('allselect') || $(this).hasClass('grp-check-box')) {
                return;
            }
            if ($(this).attr("checked")) {
                var notDisableCount = 0;
                $('table tr:gt(0)').find(':checkbox').not(':checked').each(function () {
                    if (!$(this).hasClass('none')) {
                        notDisableCount++;
                    }
                });
                if (notDisableCount == 0) {
                    $('.allselect').attr("checked", true);
                }
            } else {
                $('.allselect').attr("checked", false);
            }
            reloadCart();
        });

        //全选
        $('.allselect').die().live('click', function () {
            if ($(this).attr("checked")) {
                $(':checkbox').attr("checked", true);
            } else {
                $(':checkbox').attr("checked", false);
            }
            reloadCart();
        });

        $('.grp-check-box').die().live('click', function () {
            var id = $(this).attr('id');
            if ($(this).attr("checked")) {
                $('.' + id).attr("checked", true);
            } else {
                $('.' + id).attr("checked", false);
            }
            reloadCart();
        });

        //提交订单
        $('#submit').die().live('click',function () {
            var ids = '';
            var allSelect = 'N';
            if ($('.allselect').attr("checked")) {
                allSelect = 'Y'
            }
            $(':checkbox').each(function(index, item) {
                var itemId = $(item).attr('itemId');
                if ($(item).attr("checked") && !!itemId) {
                    ids += (itemId + ',');
                }
            });
            if (ids.length > 0) {
                ids = ids.substring(0, ids.length - 1);
            }else{
                alert("请选择商品！");
                return;
            }
            location.href="orderinfo.jsp?allSelect="+allSelect+"&cartItems="+ids;
        })

    });
    //刷新购物车
    function reloadCart() {
        $.ajax({
            url: "../car",
            type: "GET",
            data: {action:"query",username:$('#user').val()},
            dataType:"text",
            cache: false,
            success: function(data) {
                $('#cart-datas').html(data);
            }
        });
    }

</script>

</body>
</html>