<%@ page import="com.lppz.db.DBOP" %>
<%@ page import="com.lppz.back.db.MyUtil" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
    <head>
    <meta charset="utf-8">
    <title>收货地址</title>
    <script src="../js/jquery.min.js"></script>
    <link rel="stylesheet" href="../css/lp_member.css">
    <script type="text/javascript" src="../js/jsAddress.js"></script>
</head>
<body>
<!-- header -->
<script type="text/javascript" src="../js/base.js"></script>
<script type="text/javascript" src="../js/basic.js"></script>
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
            location.href="../login/login.html";

        }
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

        showAddr();

    });

    //查询收货地址
    function showAddr() {
        $.ajax({
            type:"POST",
            url:"../showaddr",
            data:{username:$('#user').val()},
            dataType:"json",
            async:false,
            success:function (d) {
                for(i=0;i<d.length;i++){
                    $('.receive-addr-list').html(d[i].addrInfo);
                }
            }
        })
    }
</script>

<!-- header -->
<input type="hidden" name="username" id="user" value="<%=session.getAttribute("u")%>">
<input type="hidden" name="uname" id="uname" value="<%=session.getAttribute("username")%>">
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
            <div class="uc-recently-top"><h3>收货地址</h3></div>
            <div class="uc-recently-box">
                <div class="recent-wrap receive-addr-top clearfix">
                    <a class="view-btn add-new-receiver" href="javascript:;" id="add">新增收货地址</a>
                </div>
                <div class="receive-addr-list">

                </div>

            </div>
        </div>
    </div>
</div>

<!-- 新增修改地址 -->
    <!--收货地址隐藏  显示-->
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
                <input type="button"  class="confirm save-receiver" value="确  定">
                <input type="button"  class="cancel mlt" value="取  消">
            </td>
        </tr>
        </tbody>

    </table>
    </div>

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