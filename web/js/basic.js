$(document).ready(function() {
	// 浏览历史
    $(".ur-cont").each(function(){
        var len = $(this).find("li").length;
        if (len > 3) {
            $(this).slide({
                mainCell: ".ur-list",
		        prevCell: ".ur-prev",
		        nextCell: ".ur-next",
                effect: "left",
                scroll: 3,
                vis: 3,
        		autoPage: true
            });
        }
    });
	// 我的关注
    $(".atte-cont").each(function(){
        var len = $(this).find("li").length;
        if (len > 6) {
            $(this).slide({
                mainCell: ".atte-list",
		        prevCell: ".atte-prev",
		        nextCell: ".atte-next",
                effect: "left",
                scroll: 6,
                vis: 6,
        		autoPage: true
            });
        }
    });

	/* 用户头像 */
	$(".ui-avatar").hover(function(){
		$(this).find(".layer").show();
		$(this).find(".mask").addClass("on")
	},function(){
		$(this).find(".layer").hide();
		$(this).find(".mask").removeClass("on")
	});
	// 发表评价
	$(".view-btn").on("click", function() {
		var $next = $(this).closest("tr").next(".comm-publish");
		var $siblings = $next.siblings(".comm-publish, .comm-cont");
		$siblings.hide();
		$next.toggle();
	});
	// 查看评价
	$(".text-btn").on("click", function() {
		var $next = $(this).closest("tr").next(".comm-cont");
		var $siblings = $next.siblings(".comm-publish, .comm-cont");
		$siblings.hide();
		$next.toggle();
	});
	// 判断标签是否已选中5个并返回true(不满足)/false(满足)
	var checkTagNum = function(element) {
		var $obj = $(element).closest(".comm-tag");
		if ($obj.find(".checked").length > 4) {
			tagMsg($obj, "最多可选择5个标签");
			return !1;
		}
		return !0;
	}
	// 标签操作提示
	var tagMsg = function($obj, msg) {
		var tips = $obj.find(".tips");
		this.timer && clearTimeout(this.timer);
		if (tips.length === 0) {
			tips = $('<div class="tips" />').appendTo($obj);
		}
		tips.html(msg);
		this.timer = setTimeout(function() {
			tips.remove();
		}, 2e3);
	}
	/* 评价标签 */
	$(".comm-tag .tag dd").on("click", function() {
		if ($(this).hasClass("checked")) {
			$(this).removeClass("checked");
		} else {
			checkTagNum(this) && $(this).addClass("checked");
		}
	});
	// 用户自定义
	$(".comm-tag").on("click", ".fore1", function() {
		checkTagNum(this) && $(this).hide().next().show().find(".itxt").focus();
	});
	/* 自定义评价 */
	$(".comm-tag").on("click", " .ibtn", function(e){
		var val = $(this).prev().val(),
			has = false,
			li 	= '';
		if (checkTagNum(this) && val.length > 0) {
			$(".comm-tag dd").each(function(){
				if ($.trim($(this).text()) === val) {
					has = true;
					return false;
				}
			});
			if (!has) {
				li ='<dd class="checked"><i></i><em>' + val + '</em></dd>';
				$(this).closest("dt").before(li);
			} else {
				tagMsg($(this).closest(".comm-tag"), "标签已存在！");
			}
		}
		$(this).prev().val("").parent().hide().prev().show();
	});
	/* 晒图 */
	$(".comm-publish .ud-img-list").on("mouseenter mouseleave", "li", function(e){
		if (e.type === "mouseenter") {
			$(this).find(".del-img").show();
		} else {
			$(this).find(".del-img").hide();
		}
	});
	// $(".ud-img-list > li").hover(function(){
	// 	$(this).find(".del-img").show();
	// },function(){
	// 	$(this).find(".del-img").hide();
	// });
	/* 删除晒图 */
	$(".ud-img-list").on("click", "span", function(){
		$(this).closest("li").remove();
	});
	//增改地址关闭
	$("#pathAddress .close-path,#pathAddress .cancel").click(function(){
		$("#pathAddress").hide()
		$(".mask-layer").remove();
	});
	//设置默认地址
	$(".addr-item .addr-op .set-default").on("click",function(){
		$(this).parents(".addr-item").find("dl dt").append('<span class="default">默认地址</span>');
		$(this).parents(".addr-item").siblings().find("span.default").remove();
		$(this).parents(".addr-item").siblings().find(".set-default").removeClass("hide");
		$(this).addClass("hide");
	});
	// 选择支付方式
	$(".bp-way-list .pay-item").on("click",function(){
		$(this).addClass("select").siblings().removeClass("select");
		$(this).find(".rd-ipt").prop("checked",true);
	});
	//输入框焦点样式
    $(".focus-bd .tx-ipt").focus(function() {
        $(this).addClass("focus");
        $(this).parent().find(".hint").show();
        if ($(this).parent().find("label.fieldError").is(":visible") == false) {
            $(this).parent().find(".hint").show();
        } else {
            $(this).parent().find(".hint").hide();
        }
    });
    $(".focus-bd .tx-ipt").blur(function() {
        $(this).removeClass("focus");
        $(this).parent().find(".hint").hide();
    });
	$(".popup-modal .shut-modal").on("click",function(){
		closePopupModal();
	});
	//查看订单物流
	$(".order-logistics").hover(function(){
		$(this).find(".logis-info").stop().fadeIn();
		if($(this).find(".courier-cont").height() >300){
			$(this).find(".courier-cont").css({"height":"300px"})
		};
	},function(){
		$(this).find(".logis-info").stop().hide();
	})
});
// 提示弹层
function alertModal(msgTitle,msgText,Callback){
	// var modalTop = ($(window).height() - $(".alert-modal").outerHeight())/2 + $(document).scrollTop();
	var html = "";
	html +='<div class="alert-modal">'
	html +='<div class="am-title"><a class="close" href="javascript:;">×</a></div>'
	html +='<div class="am-cont am-affirm">'
	html +='<div class="am-cont-icon"></div>'
	html +='<div class="am-cont-info"><strong>'+msgTitle+'</strong><p>'+msgText+'</p></div>'
	html +='</div>'
	html +='<div class="am-btn"><a class="confirm" href="javascript:;">确定</a><a class="cancel" href="javascript:;">取消</a></div>'
	html +='</div>'
	html +='<div class="mask-layer"></div>';
	if($("div").hasClass("alert-modal")){
		$(".alert-modal").remove();
		$("body").append(html);
	}else{
		$("body").append(html);
	};
	$('.alert-modal .close,.alert-modal .cancel').on('click', function(){
		alertModalClose();
	});
	if(typeof Callback == 'function'){
		Callback();
	}
};
function alertModalClose(){
	$(".alert-modal").remove();
	$(".mask-layer").remove();
};
//商品详情图片控制
jQuery(window).load(function() {
    var maxwidth = 700;
    $(".description img").each(function() {
        if ($(this).width() > maxwidth) {
            autoheight = $(this).height() * (maxwidth / $(this).width());
            $(this).width(maxwidth);
            $(this).height(autoheight);
        }
    });
});
//弹层
function pathUp(obj){
    if($(obj).size()>0){
        $(obj).show();
        $("body").append('<div class="mask-layer"></div>');
    };
};
function pathUpOn(obj){
    var _x = ($(window).width() - $(obj).outerWidth())/2;
    var _y = ($(window).height() - $(obj).outerHeight())/2 + $(document).scrollTop();
    if($(obj).size()>0){
        $(obj).css({left:_x,top:_y}).show();
        $(obj).focus();
        $("body").append('<div class="mask-layer"></div>');
    };
};
function giftModalClose(){
	$(".gift-modal").hide();
	$(".mask-layer").remove();
}
// 关闭POPUP弹层
function closePopupModal(){
	$(".popup-modal").hide();
	$(".mask-layer").remove();
}
//绑定账号成功
function closeBindOk(){
	closePopupModal();
	pathUp('#addBindOk');
}
//绑定账号失败
function closeBindError(){
	closePopupModal();
	pathUp('#addBindError');
}