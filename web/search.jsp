<%@ page import="com.lppz.good.ShowType" %>
<%@ page import="com.lppz.good.ShowGood" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>商品搜索</title>
	<link rel="stylesheet" href="css/layout.css">
	<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript">
    $(function () {
        var $headerLogin = $("#headerLogin");
        var $headerRegister = $("#headerRegister");
        var $headerUsername = $("#headerUsername");
        var $headerLogout = $("#headerLogout");
        var $productSearchForm = $("#productSearchForm");
        var username = $('#uname').val()
        if (username != "null") {
            $('#divlogin').html("<a class=\"nick\" href=\"user/user.jsp\" id=\"username\">" + username + "</a>").show();
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
                url: "car",
                data: {action: "count", username: $('#user').val()},
                dataType: "text",
                success: function (count) {
                    $('.cart-cache-num').html("<b>" + count + "</b>")
                }
            });
        }

        //查询商品
        var $type = $('#k1').val();
        var $cate = $('#k2').val();
        var $key = $('#k3').val();
        var $keyword = $('#keyword');
        var tname = "";
        if ($type) {
            tname = "bigcate";
        }
        if ($cate) {
            tname = "cate";
        }
        if ($key) {
            tname = "goods";
        }
        if ($keyword.val() == "" || $keyword.val() == "商品搜索" || $keyword.val() == "商品关键字") {
            $('.no-result').show();
        } else {
            $('.no-result').hide();
            $.ajax({
                type: "GET",
                url: "/selectgood",
                data: {tablename: tname, name: $keyword.val()},
                dataType: "text",
                success: function (info) {
                    if(info !="empty"){
                        $('#showControlPage').html(info)
                    }else{
                        $('#content_ul').hide();
                        $('.no-result').show();
					}
                }
            })
        }
		//商品数量
		$.ajax({
			type:"GET",
			url:"/selectgood",
			data:{action:"count",tablename: tname, name: $keyword.val()},
			dataType:"text",
			success:function (count) {
				$('#count').html(count);
            }
		});
        //分页
            $.ajax({
                type:"GET",
                url:"/selectgood",
                data:{action:"page",tablename:tname,name:$keyword.val()},
                dataType:"text",
//                async:false,
                success:function (pageInfo) {
                    $('.page-num').html(pageInfo);
                }
            });
    });

</script>
</head>
<body class="listpage">
	<!-- header include -->
<script type="text/javascript" src="js/base.js"></script>

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
				<form id="productSearchForm" action="search.jsp"  method="get" target="_blank">
					<%
						List<String> list = new ArrayList<>();
						String type = request.getParameter("tkeyword");
						String cate = request.getParameter("ckeyword");
						String keyword = request.getParameter("keyword");

						list.add(type);
						list.add(cate);
						list.add(keyword);
					%>
					<%--<input class="sch-key" type="text" name="keyword" id="keyword" value="商品搜索">
					<input type="hidden" name="tkeyword" value="">
					<input type="hidden" name="ckeyword"  value="">
					<input class="sch-btn" type="submit" value="搜 索">--%>
					<input class="sch-key" type="text" name="keyword" id="keyword" value="<%=ShowGood.GetKey(list)%>" >
					<input type="hidden" name="tkeyword" id="k1" value="<%=type%>">
					<input type="hidden" name="ckeyword" id="k2" value="<%=cate%>">
					<input type="hidden" id="k3" value="<%=keyword%>">
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
		<div class="menu-main wrap">
			<ul class="menu-list">
				<li><a href="index.jsp">首页</a></li>
				<li><a href="#">上新尝鲜</a></li>
			</ul>
		</div>
	</div>
</div>
	<!-- list page ad -->
	<!-- content -->
	<div class="container wrap">
		<form id="productForm" action="search.jsp" method="get">
		<input type="hidden" id="keyword1" name="keyword">
		<div class="place-site">
			<a class="home" href="/">首页</a><span>&gt;</span><em>商品搜索</em>
		</div>
		<div class="filtrate">
			<div class="fitl-txt">
				<div class="ft-tit"><h2>良品铺子<span>搜索条件</span></h2><i class="icon">&gt;</i></div>&nbsp;&nbsp;&nbsp;共<span id="count"></span>个商品
			</div>
			<div class="sift-selected  clearfix">
				<div class="label">已选条件：</div>
				<ul id="condition"></ul>
				<div class="revoke"><a href="javascript:;">全部撤销</a></div>
			</div>
			<div class="filt-area" id="filter_all">
				<div id="attributeList">
				<div class="filt-cate" id="1">
					<span class="sort">品牌：</span>
					<ul>
						<li><a href="javascript:;">良品铺子</a></li>
					</ul>
				</div>
				<div class="filt-cate" id="2">
					<span class="sort">包装形式：</span>
					<ul>
						<%=ShowType.ShowPack()%>
					</ul>
				</div>
				<div class="filt-cate" id="3">
					<span class="sort">产源：</span>
					<ul>
						<%=ShowType.ShowSource()%>
					</ul>
				</div>
				<div class="filt-cate" id="99">
						<span class="sort">价格：</span>
						<ul>
							<li><a href="javascript:;">9.9元以下</a></li>   
							<li><a href="javascript:;">10-19.9元</a></li>      
							<li><a href="javascript:;">20-29.9元</a></li>      
							<li><a href="javascript:;">30-50元</a></li>     
							<li><a href="javascript:;">51-100元</a></li>     
							<li><a href="javascript:;">100元以上</a></li> 
						</ul>
				</div>
				</div>
			</div>
			<div class="filt-order">
				<div class="fo-txt">排序：</div>
				<ul class="fo-rank">
					<li class="curr" id="sort_page"><a class="zh" href="javascript:sort_page();">综合排序</a></li>
					<li id="sort_page_xl"><a class="xl" href="javascript:sort_page_xl();">销量<i class="icon"></i></a></li>
					<li id="sort_page_jg"><a class="jg" href="javascript:sort_page_jg();">价格<i class="icon"></i></a></li>
					<li id="sort_page_pl"><a class="pl" href="javascript:sort_page_pl();">评分<i class="icon"></i></a></li>
					<!--
					<li class="sj" id="sort_page_sj"><a href="javascript:sort_page_sj();">上架时间<i class="icon"></i></a></li>
					-->
				</ul>
				<input id="showStock" name="showStock" type="checkbox">仅显示有货的
			</div>
		</div>
		</form>
		
		<div class="content">
			<div id="showControlPage">
				<!-- 没有结果 -->
				<div class="no-result">
					<div class="nores-cont">
						<div class="nores-tit">
							<i class="icon"></i><strong>抱歉，没有找到与"<span>您搜索的关键字</span>"相关的商品</strong>
						</div>
						<div class="nores-info">
							<p><b>建议您：</b></p>
							<p>1、看看输入的搜索文字是否有误</p>
							<p>2、拆分要搜索的关键词，分成几个词语再次搜索</p>
							<div class="nores-search">
								<span>重新搜索：</span>
								<input class="tx-ipt" type="text" id="word" name="word" value="商品关键字">
								<input class="ns-btn" type="button" onclick="toSubmit();" value="搜 索">
							</div>
						</div>
					</div>
				</div>
				<!---------------------------->
			</div>
			<!-- 分页 -->
			<div id="pageBar" class="pages">
				<ul class="page-num">

				</ul>
			</div>
		</div>
	</div>
	<!-- 分页 -->
	<script>
        //分页查询结果
        var $type = $('#k1').val();
        var $cate =$('#k2').val();
        var $key =$('#k3').val();
        var $keyword = $('#keyword');
        var tname="";
        if($type){
            tname="bigcate";
        }
        if($cate){
            tname="cate";
        }
        if($key){
            tname="goods";
        }

        function showPaging(line) {
            $.ajax({
                type:"GET",
                url:"/selectgood",
                data:{action:"page",tablename:tname,name:$keyword.val(),currPage:line},
                dataType:"text",
                success:function (pageInfo) {
                    $('.page-num').html(pageInfo);
                }
            });
        }
        function paSelect(curr) {
            $.ajax({
                type:"GET",
                url:"/selectgood",
                data:{tablename:tname,name:$keyword.val(),currPage:curr},
                dataType:"text",
                async:false,
                success:function (pageInfo) {
                    if(pageInfo !="empty"){
                        $('.no-result').hide();
                        $('#showControlPage').html(pageInfo)
                    }else {
                        $('#content_ul').hide();
                        $('.no-result').show();
                    }
                }
            })
        }
	</script>
	<!-- 右侧功能菜单 -->
	<div class="right-navbar">
		<ul class="rnb-list">
			<li class="kf"><a class="hvr" id="ntkf_chat_entrance" onclick="initCustomer()" href="javascript:;"><span>客服咨询</span><i class="icon">▪</i></a></li>
			<li class="gw indexcart"><a href="buycar/carlist.jsp"><i class="icon">▪</i><span>购物车</span>
				<small class="sum" id="cartcount">0</small>
			</a></li>
			<li class="hy"><a class="hvr" target="_blank" href="user/user.jsp"><span>会员中心</span><i class="icon">▪</i></a></li>
			<li class="sc"><a class="hvr" target="_blank" href="user/user.jsp"><span>我的关注</span><i class="icon">▪</i></a></li>
			<li class="jl"><a class="hvr" target="_blank" href="user/user.jsp"><span>我的订单</span><i class="icon">▪</i></a></li>
		</ul>
		<ul class="rnb-link">
			<li class="goback"><a class="hvr" href="#"><span>返回顶部</span><i class="icon">▪</i></a></li>
		</ul>
	</div>
<div id="out"></div>
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
<script type="text/javascript">
var productCategoryId = "";
//列表页筛选样式
var abc = [];
var strvalue=new Array();
var sort = "";
$(function(){
	// 全部撤消
	$(".sift-selected .revoke a").click(function(){
		$("#filter_all .filt-cate").show();
		$("#condition").find("li").remove();
		$("#showStock").removeAttr("checked");
		$(this).parents(".sift-selected").hide();
		strvalue=new Array();

	});
	// 添加
	$("#productCategory ul li a").click(function(){
		var needhide = $(this);
		needhide.parents(".filt-cate").hide();
		abc.push(needhide);
		var lab = $(this).parent().parent().prev().html().replace(/ /g, "kongge");
		var val = $(this).html().replace(/ /g, "kongge");
		var theid = $(this).attr('id');
		var currid = $(this).parents(".filt-cate").attr('id');
		strvalue[theid]="productCategory:"+theid;
		var condition = '<li><a class="onst" rel="'+currid+'" onclick=deleteC("'+currid+'","'+lab+'","'+theid+'")>'+lab+'<span>'+$(this).html()+'</span><i class="icon"></i></a></li>';
		$("#condition").append(condition);
		$("#condition").each(function(){
			var t = $(this).html();
				t = t.replace(/[\r\n]/g,"").replace(/[ ]/g,"");
			if(t !== ''){
				$(this).parent(".sift-selected").show();
			}
		});

	});

	// 添加
	$("#attributeList ul li a").click(function(){
		var needhide = $(this);
		needhide.parents(".filt-cate").hide();
		abc.push(needhide);
		var val = $(this).html().replace(/ /g, "kongge");
		var lab = $(this).parent().parent().prev().html().replace(/ /g, "kongge");
		var theid = $(this).parents(".filt-cate").attr('id');
		if(theid==99){
			if(val=="9.9元以下"){
				strvalue[theid]="price:[0 TO 9.99]";
			}else if(val=="10-19.9元"){
				strvalue[theid]="price:[10 TO 19.99]";
			}else if(val=="20-29.9元"){
				strvalue[theid]="price:[20 TO 29.99]";
			}else if(val=="30-50元"){
				strvalue[theid]="price:[30 TO 50]";
			}else if(val=="51-100元"){
				strvalue[theid]="price:[51 TO 100]";
			}else if(val=="100元以上"){
				strvalue[theid]="price:[101 TO *]";
			}
		}else{
			strvalue[theid]="attrJson:*"+val+"*";
		}
		var condition = '<li><a class="onst" rel="'+theid+'" onclick=deleteC("'+theid+'","'+lab+'","'+theid+'")>'+lab+'<span>'+$(this).html()+'</span><i class="icon"></i></a></li>';
		$("#condition").append(condition);
		$("#condition").each(function(){
			var t = $(this).html();
				t = t.replace(/[\r\n]/g,"").replace(/[ ]/g,"");
			if(t !== ''){
				$(this).parent(".sift-selected").show();
			}
		});

	});
});
function deleteC(v,lab,theid){
    var val = v.replace(/kongge/g, " ");
    strvalue[theid]=null;
    $("#condition li").find("a[rel='"+val+"']").parent("li").remove();
    $("#"+val).show();
    $("#condition").each(function(){
        var t = $(this).html();
        t = t.replace(/[\r\n]/g,"").replace(/[ ]/g,"");
        if(t == ''){
            $(this).parent(".sift-selected").hide();
        }
    });
};


</script>
</body></html>