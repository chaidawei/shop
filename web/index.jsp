<!DOCTYPE html>
<%@ page import="com.lppz.lunbo.Play" %>
<%@ page import="com.lppz.index.ShowCate" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>大卫商城官方商城</title>
    <link rel="stylesheet" href="css/index.css">
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <link rel="stylesheet" href="css/play.css">
</head>
<body>

<script type="text/javascript">
        //判断用户是否存在
       $(function () {
           var $headerLogin = $("#headerLogin");
           var $headerRegister = $("#headerRegister");
           var $headerUsername = $("#headerUsername");
           var $headerLogout = $("#headerLogout");
           var $productSearchForm = $("#productSearchForm");
           var username =  $('#uname').val()
            if (username !="null") {
                $('#divlogin').html("<a class=\"nick\" href=\"user/user.jsp\" id=\"username\">"+username+"</a>").show();
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
           if($('#user').val() != "null"){
               $.ajax({
                   type:"GET",
                   url:"car",
                   data:{action:"count",username:$('#user').val()},
                   dataType:"text",
                   success:function (count) {
                       $('.cart-cache-num').html("<b>"+count+"</b>")
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
            <li>欢迎来到大卫商城官方商城！</li>
            <li id="headerLogin" class="headerLogin none" style="display: list-item;"><a class="log" href="login/login.html">[登录]</a></li>
            <li id="headerRegister" class="headerRegister none" style="display: list-item;"><a class="reg" href="register/register.html">[注册]</a></li>
            <li id="headerLogout" class="headerLogout none" style="display: none;"><a class="log" href="loginOut">[退出]</a></li>
        </ul>
        <ul class="fr">
            <li class="thover ">
                <div class="top-user-info">
                    <a class="my-lppz dorp-title">我的良品<i class="arrow"></i></a>
                    <div class="my-lppz-layer">
                        <div class="dorp-spacer"></div>
                        <div class="user-info">
                            <div class="m-pic">
                                <img id="avatarImg" src="images/head/avatar.png" alt="用户头像">
                            </div>
                            <div class="m-name" id="divlogin" style="display: none;">
                                <a class="nick" href="user/user.jsp" id="username"></a>
                                <a class="level" href="user/user.jsp" title="" id="levelName"></a>
                            </div>
                            <div class="m-name" id="divnologin">
                                <a href="login/login.html">您好，请登录</a>
                            </div>
                        </div>
                        <div class="menu-list">
                            <div class="m-nav">
                                <div class="item"><a target="_blank" href="user/user.jsp">我的订单</a></div>
                                <div class="item"><a target="_blank" href="user/user.jsp">我的关注</a></div>
                            </div>
                        </div>
                        <div class="view-list">
                            <div class="vl-title"><h4>最近浏览</h4><a class="more" href="user/user.jsp" target="_blank">更多&nbsp;&gt;</a></div>
                            <ul class="vl-cont" id="ulHistory"></ul>
                        </div>
                    </div>
                </div>
            </li>
            <li class="tspacer">|</li>
            <li><a class="tlink" target="_blank" href="index.jsp">官方网站</a></li>
            <li class="tspacer">|</li>
            <li><span class="tel">全国订购热线：<em>400-1177-517</em></span></li>

        </ul>
    </div>
</div>
<div class="header">
<div class="head-main wide clearfix">
    <div class="logo"><a href="index.jsp">大卫商城</a><span>官方商城</span></div>
    <div class="hd-search">
        <div class="search-area">
            <form id="productSearchForm" action="search.jsp" method="get" target="_blank">
                <input class="sch-key" type="text" name="keyword" id="keyword" value="商品搜索">
                <input type="hidden" name="tkeyword" value="">
                <input type="hidden" name="ckeyword"  value="">
                <input class="sch-btn" type="submit" value="搜 索">
            </form>
        </div>
    </div>
    <div class="hd-user">
        <div class="user-shoping">
            <a class="us-btn indexcart" href="buycar/carlist.jsp">购物车</a>
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
<div class="menu">
    <div class="menu-main wide">
        <ul class="menu-list">
            <li><a href="#">上新尝鲜</a></li>
        </ul>
    </div>
</div>
</div>

<!-- 首页内容顶部 -->
<div class="idx-focus clearfix" style="background-color: rgb(254, 234, 242);">
    <!-- 分类   左侧楼层菜单-->
    <div class="focus-cont clearfix wide" style="background:#fedea5">
        <div class="all-sort">
            <a class="as-btn" href="#"><span>商品分类<i class="icon">▼</i></span></a>
            <div class="sort-nav">
                <ul>
                    <%=ShowCate.show()%>
                </ul>
            </div>
        </div>
        <!-- 轮播图 -->
        <div class="idx-slider">
            <div class="out">
                <ul class="img">
                    <%=Play.createPlay()%>
                </ul>
                <ul class="num">
                    <!--底部数字栏-->
                </ul>
            </div>
        </div>
        <script>
            $(function(){
                //初始化
                var size = $(".img li").size();  //获取图片的个数
                for(var i=1;i<=size;i++){	//创建图片个数相对应的底部数字个数
                    var li="<li>"+i+"</li>";	//创建li标签，并插入到页面中
                    $(".num").append(li);
                }

                //手动控制图片轮播
                $(".img li").eq(0).show();	//显示第一张图片
                $(".num li").eq(0).addClass("active");	//第一张图片底部相对应的数字列表添加active类
                $(".num li").mouseover(function(){
                    $(this).addClass("active").siblings().removeClass("active");  //鼠标在哪个数字上那个数字添加class为active
                    var index=$(this).index();  //定义底部数字索引值
                    i=index;  //底部数字索引值等于图片索引值
                    $(".img li").eq(index).stop().fadeIn(300).siblings().stop().fadeOut(300);	//鼠标移动到的数字上显示对应的图片
                })

                //自动控制图片轮播
                var i=0;  //初始i=0
                var t=setInterval(move,2500);  //设置定时器，2.5秒切换下一站轮播图
                //向左切换函数
                function moveL(){
                    i--;
                    if(i==-1){
                        i=size-1;  //如果这是第一张图片再按向左的按钮则切换到最后一张图
                    }
                    $(".num li").eq(i).addClass("active").siblings().removeClass("active");  //对应底部数字添加背景
                    $(".img li").eq(i).fadeIn(300).siblings().fadeOut(300);  //对应图片切换
                }
                //向右切换函数
                function move(){
                    i++;
                    if(i==size){
                        i=0;  //如果这是最后一张图片再按向右的按钮则切换到第一张图
                    }
                    $(".num li").eq(i).addClass("active").siblings().removeClass("active");  //对应底部数字添加背景
                    $(".img li").eq(i).fadeIn(300).siblings().fadeOut(300);  //对应图片切换
                }

                //定时器开始与结束
                $(".out").hover(function(){
                    clearInterval(t);	//鼠标放在轮播区域上时，清除定时器
                },function(){
                    t=setInterval(move,2500);  //鼠标移开时定时器继续
                })
            })
        </script>
    </div>
</div>
<!-- index content -->
<div class="index-main wide">
    <div class="star-sku">
        <div class="star-tit">
            <h2>活动精选</h2>
            <ul class="star-tabs">
                <li class="active"><a href="javascript:;">端午专区</a></li>
                <li><a href="javascript:;">儿童喜爱</a></li>
                <li><a href="javascript:;">新品尝鲜</a></li>
            </ul>
        </div>
        <div class="star-area">
            <ul class="star-area-list" style="display: block;">
                <li><a title="端午专区" href="#" target="_blank"><img class="lazy" data-original="http://img.lppz.com/upload/image/201705/5b479ec3-467a-4fd9-b295-fbe68d813938.jpg"
                                                                                                   src="./良品铺子官方商城-休闲零食网购首选（LPPZ.COM）- 品质保障、配送及时、放心服务、轻松购物!_files/5b479ec3-467a-4fd9-b295-fbe68d813938.jpg" alt="端午专区" style="display: block;"></a></li>
                <li><a title="端午专区" href="#" target="_blank"><img class="lazy" data-original="http://img.lppz.com/upload/image/201705/14b064a1-818c-4bac-8344-6d49094ef48d.jpg"
                                                                                                     src="./良品铺子官方商城-休闲零食网购首选（LPPZ.COM）- 品质保障、配送及时、放心服务、轻松购物!_files/14b064a1-818c-4bac-8344-6d49094ef48d.jpg" alt="端午专区" style="display: block;"></a></li>
                <li><a title="端午专区" href="#" target="_blank"><img class="lazy" data-original="http://img.lppz.com/upload/image/201705/64a3d0cd-bd84-4566-852b-b974a0e2d768.jpg"
                                                                                                   src="./良品铺子官方商城-休闲零食网购首选（LPPZ.COM）- 品质保障、配送及时、放心服务、轻松购物!_files/64a3d0cd-bd84-4566-852b-b974a0e2d768.jpg" alt="端午专区" style="display: block;"></a></li>
                <li><a title="端午专区" href="#" target="_blank"><img class="lazy" data-original="http://img.lppz.com/upload/image/201705/37e0a1ae-f6d2-401a-bb44-faa1c1a49adf.jpg"
                                                                                                   src="./良品铺子官方商城-休闲零食网购首选（LPPZ.COM）- 品质保障、配送及时、放心服务、轻松购物!_files/37e0a1ae-f6d2-401a-bb44-faa1c1a49adf.jpg" alt="端午专区" style="display: block;"></a></li>
                <li><a title="端午专区" href="#" target="_blank"><img class="lazy" data-original="http://img.lppz.com/upload/image/201705/192c299a-0f31-4c16-bdd4-5b8ffb72f29b.jpg"
                                                                                                     src="./良品铺子官方商城-休闲零食网购首选（LPPZ.COM）- 品质保障、配送及时、放心服务、轻松购物!_files/192c299a-0f31-4c16-bdd4-5b8ffb72f29b.jpg" alt="端午专区" style="display: block;"></a></li>
            </ul>
            <ul class="star-area-list" style="display: none;">
                <li><a title="儿童专区" href="#" target="_blank"><img class="lazy" data-original="http://img.lppz.com/upload/image/201705/39793a94-5acd-46b7-bd6a-106f1718e05a.jpg"
                                                                                                   src="./良品铺子官方商城-休闲零食网购首选（LPPZ.COM）- 品质保障、配送及时、放心服务、轻松购物!_files/39793a94-5acd-46b7-bd6a-106f1718e05a.jpg" alt="儿童专区" style="display: block;"></a></li>
                <li><a title="儿童专区" href="#" target="_blank"><img class="lazy" data-original="http://img.lppz.com/upload/image/201705/169caece-7472-43db-bc6a-32cceee4491f.jpg"
                                                                                                   src="./良品铺子官方商城-休闲零食网购首选（LPPZ.COM）- 品质保障、配送及时、放心服务、轻松购物!_files/169caece-7472-43db-bc6a-32cceee4491f.jpg" alt="儿童专区" style="display: block;"></a></li>
                <li><a title="儿童专区" href="#" target="_blank"><img class="lazy" data-original="http://img.lppz.com/upload/image/201705/3ad6cac6-c8d7-4796-8f9a-6f390e0bbc50.jpg"
                                                                                                   src="./良品铺子官方商城-休闲零食网购首选（LPPZ.COM）- 品质保障、配送及时、放心服务、轻松购物!_files/3ad6cac6-c8d7-4796-8f9a-6f390e0bbc50.jpg" alt="儿童专区" style="display: block;"></a></li>
                <li><a title="儿童专区" href="#" target="_blank"><img class="lazy" data-original="http://img.lppz.com/upload/image/201705/ec0faa74-7f49-4718-b44a-822bef342e9a.jpg"
                                                                                                   src="./良品铺子官方商城-休闲零食网购首选（LPPZ.COM）- 品质保障、配送及时、放心服务、轻松购物!_files/ec0faa74-7f49-4718-b44a-822bef342e9a.jpg" alt="儿童专区" style="display: block;"></a></li>
                <li><a title="儿童专区" href="#" target="_blank"><img class="lazy" data-original="http://img.lppz.com/upload/image/201705/d1b23eac-1d73-427d-9825-ee2c5af759fc.jpg"
                                                                                                   src="./良品铺子官方商城-休闲零食网购首选（LPPZ.COM）- 品质保障、配送及时、放心服务、轻松购物!_files/d1b23eac-1d73-427d-9825-ee2c5af759fc.jpg" alt="儿童专区" style="display: block;"></a></li>
            </ul>
            <ul class="star-area-list" style="display: none;">
                <li><a title="TOP" href="#" target="_blank"><img class="lazy" data-original="http://img.lppz.com/upload/image/201705/88a0efc6-77d8-42d0-9286-2fac55ac7491.jpg"
                                                                                                  src="./良品铺子官方商城-休闲零食网购首选（LPPZ.COM）- 品质保障、配送及时、放心服务、轻松购物!_files/88a0efc6-77d8-42d0-9286-2fac55ac7491.jpg" alt="TOP" style="display: block;"></a></li>
                <li><a title="TOP" href="#" target="_blank"><img class="lazy" data-original="http://img.lppz.com/upload/image/201705/f23eb2c7-4582-4bd1-8cc7-5534e9495806.jpg"
                                                                                                  src="./良品铺子官方商城-休闲零食网购首选（LPPZ.COM）- 品质保障、配送及时、放心服务、轻松购物!_files/f23eb2c7-4582-4bd1-8cc7-5534e9495806.jpg" alt="TOP" style="display: block;"></a></li>
                <li><a title="TOP" href="#" target="_blank"><img class="lazy" data-original="http://img.lppz.com/upload/image/201705/f8691e97-982a-4924-989d-019b8d96a691.jpg"
                                                                                                  src="./良品铺子官方商城-休闲零食网购首选（LPPZ.COM）- 品质保障、配送及时、放心服务、轻松购物!_files/f8691e97-982a-4924-989d-019b8d96a691.jpg" alt="TOP" style="display: block;"></a></li>
                <li><a title="TOP" href="#" target="_blank"><img class="lazy" data-original="http://img.lppz.com/upload/image/201705/2ff4b902-9c24-4ec6-a29b-d4f14781e75b.jpg"
                                                                                                  src="./良品铺子官方商城-休闲零食网购首选（LPPZ.COM）- 品质保障、配送及时、放心服务、轻松购物!_files/2ff4b902-9c24-4ec6-a29b-d4f14781e75b.jpg" alt="TOP" style="display: block;"></a></li>
                <li><a title="TOP" href="#" target="_blank"><img class="lazy" data-original="http://img.lppz.com/upload/image/201705/3f445545-692e-4033-aa11-ec264f5ad1e5.jpg"
                                                                                                  src="./良品铺子官方商城-休闲零食网购首选（LPPZ.COM）- 品质保障、配送及时、放心服务、轻松购物!_files/3f445545-692e-4033-aa11-ec264f5ad1e5.jpg" alt="TOP" style="display: block;"></a></li>
            </ul>
        </div>
    </div>
    <%=ShowCate.tabCate()%>
    <!-- 左侧楼层菜单 -->
    <div class="floor-nav" style="display: none;">
        <span class="fn-tit">商品分类</span>
        <ul class="fn-list">
            <li class="jk"><a rel="49" href="javascript:;"><i class="iconfont"></i><span>坚果炒货</span></a></li>
            <li class="jk"><a rel="50" href="javascript:;"><i class="iconfont"></i><span>肉脯鱼干</span></a></li>
            <li class="jk"><a rel="51" href="javascript:;"><i class="iconfont"></i><span>果干果脯</span></a></li>
            <li class="jk"><a rel="53" href="javascript:;"><i class="iconfont"></i><span>素食山珍</span></a></li>
            <li class="jk"><a rel="52" href="javascript:;"><i class="iconfont"></i><span>糕点糖果</span></a></li>
            <li class="jk"><a rel="54" href="javascript:;"><i class="iconfont"></i><span>花茶饮品</span></a></li>
        </ul>
    </div>

    <div id="Bing">
    </div>
    <div class="mask-layer" id="ceng" style="display:none"></div>


    <!-- 右侧功能菜单 -->
    <!-- 右侧功能菜单 -->
    <div class="right-navbar">
        <ul class="rnb-list">
            <li class="kf"><a class="hvr" id="ntkf_chat_entrance" onclick="initCustomer()" href="javascript:;"><span>客服咨询</span><i class="icon">▪</i></a></li>
            <li class="gw indexcart"><a href="buycar/carlist.jsp"><i class="icon">▪</i><span>购物车</span>
                <small class="sum" id="cartcount">0</small>
            </a></li>
            <li class="hy"><a class="hvr" target="_blank" href="user/user.jsp"><span>会员中心</span><i class="icon">▪</i></a></li>
            <li class="sc"><a class="hvr" target="_blank" href="user.jsp"><span>我的关注</span><i class="icon">▪</i></a></li>
            <li class="jl"><a class="hvr" target="_blank" href="user.jsp"><span>我的订单</span><i class="icon">▪</i></a></li>
        </ul>
        <ul class="rnb-link">
            <li class="goback"><a class="hvr" href="#"><span>返回顶部</span><i class="icon">▪</i></a></li>
        </ul>
    </div>

    <!-- footer include -->

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
                    <div class="qr-code"><img src="../images/us_qr_code.png " alt=""><span>微信二维码</span></div>
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
                Copyright@2006-2017 湖北良品铺子电子商务有限公司 All rights Reserved<br><a target="_blank" href="#">鄂ICP备15022981号</a><br>
                <a href="#"><img alt="网络经济主体信息" border="0" dragover="true" src="images/gslogo.png"></a>
            </div>
        </div>
    </div>
    <!-- 公用JS -->
    <script src="js/base.js"></script>
</body>
</html>