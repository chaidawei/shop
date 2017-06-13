<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>个人资料</title>
    <script src="../js/jquery.min.js"></script>
    <link rel="stylesheet" href="../css/lp_member.css">
</head>
<body>
<!-- header -->

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
        //个人数据
        //表单数据
        var $username = $('#username');
        var $uname = $('#lpNickName');
        var $realname = $('#name');
        var $gender = $(':input[type=radio]:checked');
        var $year = $('#idYear');
        var $month = $('#idMonth');
        var $day = $('#idDay');

        if(username!="null"){
            $.ajax({
                url:"../userinfo",
                type:"POST",
                data:{action:"person",username:$username.val()},
                dataType:"json",
                success:function (info) {
                    for(i = 0 ; i < info.length;i++){
                        $uname.val(info[i].uname);
                        $realname.val(info[i].realname);
                        $(":input:radio[value="+info[i].gender+"]").attr("checked","true");
                        var date = new Date(info[i].birthday);
                        $year.val(date.getFullYear());
                        $month.val(date.getMonth()+1);
                        $day.val(date.getDate());
                    }
                }
            })
        }

    });

</script>
<input type="hidden" name="username" id="username" value="<%=session.getAttribute("u")%>">
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
<script type="text/javascript">
    $(function() {
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
                <div class="uc-recently-top"><h3>基本信息</h3></div>
                <div class="uc-recently-box">
                    <div class="usre-data-top clearfix">
                        <div class="uc-info">
                            <div class="ui-avatar">
                                <img id="avatarImg" src="../images/head/avatar.png" alt="用户头像">
                                <span class="layer"></span>
                                <span class="mask"><a class="edit member-image" href="javascript:;">编辑头像</a></span>
                            </div>
                            <div class="ui-mate">
                                <div class="u-level"><span>铜卡会员</span><i class="icon"></i></div>
                                <div class="u-name"><span><%=session.getAttribute("username")%></span></div>
                            </div>
                        </div>
                    </div>
                    <div class="user-data-cont">

                        <ul class="data-form-list">
                            <li>
                                <div class="lab-txt">昵称：</div>
                                <div class="lab-for"><input class="tx-ipt" type="text" name="lpNickName" id="lpNickName" value=""></div>
                            </li>
                            <li>
                                <div class="lab-txt"><span>*</span>真实姓名：</div>
                                <div class="lab-for email"><input class="tx-ipt" type="text" name="name" id="name" value=""></div>
                            </li>
                            <li>
                                <div class="lab-txt"><span>*</span>性别：</div>
                                <div class="lab-for">
                                    <label><input class="rd-ipt" type="radio" name="gender" value="男" >男</label>
                                    <label><input class="rd-ipt" type="radio" name="gender" value="女">女</label>
                                    <label><input class="rd-ipt" type="radio" name="gender" value="保密" checked>保密</label>
                                </div>
                            </li>
                            <li>
                                <div class="lab-txt"><span>*</span>生日：</div>
                                <div id="dateSelector" class="lab-for">
                                    <select class="slt-opt" id="idYear" data="1900"><option value="1800">1800</option><option value="1801">1801</option><option value="1802">1802</option><option value="1803">1803</option><option value="1804">1804</option><option value="1805">1805</option><option value="1806">1806</option><option value="1807">1807</option><option value="1808">1808</option><option value="1809">1809</option><option value="1810">1810</option><option value="1811">1811</option><option value="1812">1812</option><option value="1813">1813</option><option value="1814">1814</option><option value="1815">1815</option><option value="1816">1816</option><option value="1817">1817</option><option value="1818">1818</option><option value="1819">1819</option><option value="1820">1820</option><option value="1821">1821</option><option value="1822">1822</option><option value="1823">1823</option><option value="1824">1824</option><option value="1825">1825</option><option value="1826">1826</option><option value="1827">1827</option><option value="1828">1828</option><option value="1829">1829</option><option value="1830">1830</option><option value="1831">1831</option><option value="1832">1832</option><option value="1833">1833</option><option value="1834">1834</option><option value="1835">1835</option><option value="1836">1836</option><option value="1837">1837</option><option value="1838">1838</option><option value="1839">1839</option><option value="1840">1840</option><option value="1841">1841</option><option value="1842">1842</option><option value="1843">1843</option><option value="1844">1844</option><option value="1845">1845</option><option value="1846">1846</option><option value="1847">1847</option><option value="1848">1848</option><option value="1849">1849</option><option value="1850">1850</option><option value="1851">1851</option><option value="1852">1852</option><option value="1853">1853</option><option value="1854">1854</option><option value="1855">1855</option><option value="1856">1856</option><option value="1857">1857</option><option value="1858">1858</option><option value="1859">1859</option><option value="1860">1860</option><option value="1861">1861</option><option value="1862">1862</option><option value="1863">1863</option><option value="1864">1864</option><option value="1865">1865</option><option value="1866">1866</option><option value="1867">1867</option><option value="1868">1868</option><option value="1869">1869</option><option value="1870">1870</option><option value="1871">1871</option><option value="1872">1872</option><option value="1873">1873</option><option value="1874">1874</option><option value="1875">1875</option><option value="1876">1876</option><option value="1877">1877</option><option value="1878">1878</option><option value="1879">1879</option><option value="1880">1880</option><option value="1881">1881</option><option value="1882">1882</option><option value="1883">1883</option><option value="1884">1884</option><option value="1885">1885</option><option value="1886">1886</option><option value="1887">1887</option><option value="1888">1888</option><option value="1889">1889</option><option value="1890">1890</option><option value="1891">1891</option><option value="1892">1892</option><option value="1893">1893</option><option value="1894">1894</option><option value="1895">1895</option><option value="1896">1896</option><option value="1897">1897</option><option value="1898">1898</option><option value="1899">1899</option><option selected="selected" value="1900">1900</option><option value="1901">1901</option><option value="1902">1902</option><option value="1903">1903</option><option value="1904">1904</option><option value="1905">1905</option><option value="1906">1906</option><option value="1907">1907</option><option value="1908">1908</option><option value="1909">1909</option><option value="1910">1910</option><option value="1911">1911</option><option value="1912">1912</option><option value="1913">1913</option><option value="1914">1914</option><option value="1915">1915</option><option value="1916">1916</option><option value="1917">1917</option><option value="1918">1918</option><option value="1919">1919</option><option value="1920">1920</option><option value="1921">1921</option><option value="1922">1922</option><option value="1923">1923</option><option value="1924">1924</option><option value="1925">1925</option><option value="1926">1926</option><option value="1927">1927</option><option value="1928">1928</option><option value="1929">1929</option><option value="1930">1930</option><option value="1931">1931</option><option value="1932">1932</option><option value="1933">1933</option><option value="1934">1934</option><option value="1935">1935</option><option value="1936">1936</option><option value="1937">1937</option><option value="1938">1938</option><option value="1939">1939</option><option value="1940">1940</option><option value="1941">1941</option><option value="1942">1942</option><option value="1943">1943</option><option value="1944">1944</option><option value="1945">1945</option><option value="1946">1946</option><option value="1947">1947</option><option value="1948">1948</option><option value="1949">1949</option><option value="1950">1950</option><option value="1951">1951</option><option value="1952">1952</option><option value="1953">1953</option><option value="1954">1954</option><option value="1955">1955</option><option value="1956">1956</option><option value="1957">1957</option><option value="1958">1958</option><option value="1959">1959</option><option value="1960">1960</option><option value="1961">1961</option><option value="1962">1962</option><option value="1963">1963</option><option value="1964">1964</option><option value="1965">1965</option><option value="1966">1966</option><option value="1967">1967</option><option value="1968">1968</option><option value="1969">1969</option><option value="1970">1970</option><option value="1971">1971</option><option value="1972">1972</option><option value="1973">1973</option><option value="1974">1974</option><option value="1975">1975</option><option value="1976">1976</option><option value="1977">1977</option><option value="1978">1978</option><option value="1979">1979</option><option value="1980">1980</option><option value="1981">1981</option><option value="1982">1982</option><option value="1983">1983</option><option value="1984">1984</option><option value="1985">1985</option><option value="1986">1986</option><option value="1987">1987</option><option value="1988">1988</option><option value="1989">1989</option><option value="1990">1990</option><option value="1991">1991</option><option value="1992">1992</option><option value="1993">1993</option><option value="1994">1994</option><option value="1995">1995</option><option value="1996">1996</option><option value="1997">1997</option><option value="1998">1998</option><option value="1999">1999</option><option value="2000">2000</option><option value="2001">2001</option><option value="2002">2002</option><option value="2003">2003</option><option value="2004">2004</option><option value="2005">2005</option><option value="2006">2006</option><option value="2007">2007</option><option value="2008">2008</option><option value="2009">2009</option><option value="2010">2010</option><option value="2011">2011</option><option value="2012">2012</option><option value="2013">2013</option><option value="2014">2014</option><option value="2015">2015</option><option value="2016">2016</option><option value="2017">2017</option><option value="2018">2018</option></select>年
                                    <select class="slt-opt" id="idMonth" data="01"><option selected="selected" value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option><option value="5">5</option><option value="6">6</option><option value="7">7</option><option value="8">8</option><option value="9">9</option><option value="10">10</option><option value="11">11</option><option value="12">12</option></select>月
                                    <select class="slt-opt" id="idDay" data="01"><option selected="selected" value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option><option value="5">5</option><option value="6">6</option><option value="7">7</option><option value="8">8</option><option value="9">9</option><option value="10">10</option><option value="11">11</option><option value="12">12</option><option value="13">13</option><option value="14">14</option><option value="15">15</option><option value="16">16</option><option value="17">17</option><option value="18">18</option><option value="19">19</option><option value="20">20</option><option value="21">21</option><option value="22">22</option><option value="23">23</option><option value="24">24</option><option value="25">25</option><option value="26">26</option><option value="27">27</option><option value="28">28</option><option value="29">29</option><option value="30">30</option><option value="31">31</option></select>日
                                    <input type="hidden" id="birth" name="birth" value="1900-01-01 00:00:00">
                                </div>
                            </li>
                            <li>
                                <div class="lab-txt">手机号：</div>
                                <div class="lab-for email">
                                    158××××1207
                                </div>
                            </li>

                            <li class="divide-line"><hr></li>
                            <li>
                                <div class="lab-txt">职业：</div>
                                <div class="lab-for">
                                    <select class="slt-opt wide-slt" name="occupation" id="occupation">
                                        <option value="">选择职业</option>
                                        <option value="_10">学生</option>
                                        <option value="_20">上班族</option>
                                        <option value="_30">自由职业</option>
                                        <option value="_40">退休</option>
                                        <option value="_50">没有工作</option>
                                    </select>
                                </div>
                            </li>
                            <li>
                                <div class="lab-txt">学历：</div>
                                <div class="lab-for">
                                    <select class="slt-opt wide-slt" name="eduBackground" id="eduBackground">
                                        <option value="">选择学历</option>
                                        <option value="_0001">博士</option>
                                        <option value="_0002">研究生</option>
                                        <option value="_0003">本科</option>
                                        <option value="_0004">大专</option>
                                        <option value="_0005">中专及以下</option>
                                    </select>
                                </div>
                            </li>

                            <li>
                                <div class="lab-txt">家庭年收入：</div>
                                <div class="lab-for">
                                    <select class="slt-opt wide-slt" name="lpincomecd" id="lpincomecd">
                                        <option value="">请选择</option>
                                        <option value="_10">少于3万</option>
                                        <option value="_20">3万-6万</option>
                                        <option value="_30">6万-10万</option>
                                        <option value="_40">10万-15万</option>
                                        <option value="_50">15万-25万</option>
                                        <option value="_60">超过25万</option>
                                    </select>
                                </div>
                            </li>
                            <li>
                                <div class="lab-txt">婚姻状况：</div>
                                <div class="lab-for">
                                    <label><input class="rd-ipt" type="radio" name="maritalStatus" value="_1">未婚</label>
                                    <label><input class="rd-ipt" type="radio" name="maritalStatus" value="_2">已婚</label>
                                    <label><input class="rd-ipt" type="radio" name="maritalStatus" value="_3">保密</label>
                                </div>
                            </li>
                            <li>
                                <!--
                                <div class="submit-btn">
                                    <a class="save" href="javascript:submitPro();">提交</a>
                                </div>
                                -->
                                <div class="data-submit-btn">
                                    <button class="save" type="button" onclick="submitPro()">保存</button>
                                    <p class="explain">*为必填项目，您填写的所有私人信息都不会公开</p>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
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

<!-- 文件上传  -->
<script src="../js/jquery.fileupload.js"></script>

<script type="text/javascript">

    function submitPro(){
        $lpNickName = $('#lpNickName');
        var lpNickName = $lpNickName.val();
        var rs = /^([\u4E00-\uFA29]|[\uE7C7-\uE7F3]|[a-zA-Z0-9])*$/;
        if(!rs.test(lpNickName)){
            $lpNickName.focus();
            alert('用户昵称不能使用特殊字符！');
            return;
        }
        $("#birth").val($("#idYear").val()+"-"+$("#idMonth").val()+"-"+$("#idDay").val());
        var birthDate = new Date($("#idYear").val(),$("#idMonth").val()-1,$("#idDay").val());
        var nowDate = new Date();
        if(birthDate>nowDate){
            alert('生日不能大于当前时间！');
            return;
        }
        var $uname = $('#lpNickName');
        var $realname = $('#name');
        var $gender = $(':input[type=radio]:checked');
        var $year = $('#idYear');
        var $month = $('#idMonth');
        var $day = $('#idDay');
        var $birthday = $year.val()+"-"+$month.val()+"-"+$day.val();

        $.ajax({
            url:"../savedata",
            type:"POST",
            data:{username:$("#username").val(),uname:$uname.val(),realname:$realname.val(),gender:$gender.val(),birthday:$birthday},
            dataType:"text",
            cache:false,
            sync:false,
            success:function (message) {
                alert(message);
                $('.close-path')
            }
        })
    }
</script>

</body>
</html>