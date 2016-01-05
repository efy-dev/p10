<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/24
  Time: 9:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
	<title>【${product.name} ${productModel.name}】${product.subName} -e飞蚁</title>
	<c:if test="${product.master!=null}">
		<c:set var="master">
			${product.master.fullName}
		</c:set>
	</c:if>
	<meta name="keywords"
		  content="${product.project.name},${master},${product.name},${product.subName}, ${productModel.name},${product.tenant.name}"/>
	<meta name="description"
		  content="${product.name},${productModel.name},${product.subName},${product.project.description}"/>
</head>
<body>

<article class="custom">
	<div data-am-widget="slider" class="am-slider am-slider-a1" data-am-slider='{&quot;directionNav&quot;:false}'>
		<ul class="am-slides">
			<li><img src="http://pro.efeiyi.com/${productModel.productModel_url}@!wap-product-pic"></li>
			<c:forEach items="${productModel.product.productPictureList}" var="picture">
				<c:if test="${picture.status=='1'&&picture.productModel.id==productModel.id}">
					<li><img src="http://pro.efeiyi.com/${picture.pictureUrl}@!wap-product-pic"></li>
				</c:if>
			</c:forEach>
		</ul>
	</div>
	<!--//End--am-slider-->
	<div class="bd details slnew seckill">
		<div class="bd des-title">
			<strong class="bd txt">${productModel.product.name}
				<c:forEach
						items="${productModel.productPropertyValueList}" var="pv">
					${pv.projectPropertyValue.value}
				</c:forEach> </strong>
			<a href="#分享" class="share">
				<i class="icon icon-share"></i>

				<p>分享</p>
			</a>

			<div id="cover" style="display: none;"><em class="bg"></em><img src="/scripts/wap/upload/guide-share.png" class="share-picture"
													 alt=""></div>
			<div id="cover2" style="display: none">
				<div class="text-co2">
					<strong class="cov-titie">提示</strong>

					<p class="covtext">在浏览器中寻找分享按钮，将本页面分享给您的好友吧。</p>

					<div class="ae" style="text-align: center"><a class="covbtn">确定</a></div>
				</div>
				<div class="bg"></div>
			</div>
			<a id="show" onclick="collect('${productModel.id}')" class="addfav">
				<i class="icon icon-addfav"></i>

				<p>收藏</p>
			</a>
			<a id="hidden" style="display: none;" onclick="deCollect('${productModel.id}')" class="addfav addfav-end">
				<i class="icon icon-addfav"></i>

				<p>已收藏</p>
			</a>
		</div>
		<!-- //End--des-title-->
		<div class="des-master">
			<c:if test="${not empty productModel.product.master.id}">
				<p class="p1">
					<span>${productModel.product.master.fullName}</span>[${productModel.product.master.getMainProjectName().getProject().getName()}]
				</p>

				<p class="p2"><ming800:status name="level" dataType="Project.level"
											  checkedValue="${productModel.product.master.getMainProjectName().getProject().getLevel()}"
											  type="normal"/>传承人</p>

				<p class="img"><img
						src="http://tenant.efeiyi.com/${productModel.product.master.favicon}@!tanent-details-view"></p>
			</c:if>
		</div>
		<!-- //End--des-master-->
		<div class="bd des-price">
			<c:if test="${not empty productModel.marketPrice&&productModel.product.status==1&&productModel.status!=0}">
				<p class="bd t1"><span>市场价：</span>
					<del>${productModel.marketPrice}</del>
				</p>
			</c:if>
			<c:if test="${not empty productModel.price&&productModel.product.status==1&&productModel.status!=0}">
				<p class="s s2 s8"><span>飞蚁价：</span><em>￥</em><strong>${productModel.price}</strong></p>
			</c:if>
			<p class="s s9"><span> 服&nbsp;&nbsp;&nbsp;务：</span>由 <a
					href="<c:url value="/tenantOfMobile/${productModel.product.tenant.id}"/>"
					style="color: #000">${product.bigTenant.name}</a>[${product.bigTenant.address}] 发货并提供售后服务</p>
		</div>

		<%--<div class="bd des-price">--%>
		<%--<div class="s s2 s8"><span>飞蚁价：</span><em>￥</em><strong>11</strong></div>--%>
		<%--<div class="s s9"><span>服&nbsp;&nbsp;&nbsp;务：</span>由姚惠芬刺绣刺绣馆（苏绣）发货并提供售后服务</div>--%>
		<%--</div>--%>
		<!-- //End--des-price-->
		<c:if test="${productModel.product.status==1&&productModel.status!=0}">
			<div class="bd des-format">
				<a id="btn-num" class="bd btn-num">
					<span class="select">数量</span>
                <span class="add-sub">
                    <em class="sub btn-cart-no" onclick="subtractProduct()" href="#"></em>
                    <input id="value" class="ipt-txt" type="text" readOnly="true" value="1">
                    <em class="add" onclick="addProduct()" href="#"></em>
                </span>
				</a>
			</div>
		</c:if>
		<%--<div class="bd des-price">--%>
		<%--<p class="bd p-price"><span>价格：</span><em>￥</em><strong>${productModel.price()}</strong></p>--%>

		<%--<p class="bd express">快递：0（飞蚁包邮）</p>--%>
		<%--</div>--%>
		<!-- //End--des-price-->
		<c:if test="${fn:length(productModelList)>1}">
			<div class="bd des-format">
				<a id="btn-format" class="bd btn-format">
					<span class="select">选择规格</span>
					<i class="arrow-right"></i>
				</a>
			</div>
		</c:if>
		<!-- //End--des-format-->
		<div class="des-content">
			<div class="bd title">详情</div>
			<div class="bd">
				<c:if test="${not empty product.productDescription}">
					${product.productDescription.content}
				</c:if>
				<c:if test="${not empty productPictureList&&fn:length(productPictureList)>0&&empty product.productDescription}">
					<c:forEach items="${productPictureList}" var="productPicture">
						<p>
							<img src="http://pro.efeiyi.com/${productPicture.pictureUrl}"/>
						</p>
					</c:forEach>
				</c:if>
				<c:if test="${not empty purchaseOrderProductList}">
					<div class="discuss">
						<div class="bd dis-title">【顾客评论】</div>
						<ul class="ul-list">
							<c:forEach items="${purchaseOrderProductList}" var="purchaseOrderProduct" varStatus="rec">
								<c:if test="${not empty purchaseOrderProduct.purchaseOrderComment&&purchaseOrderProduct.purchaseOrderComment.status!='0'}">
									<li class="item">
										<div class="user-info">
											<img id="personPhoto${rec.index}" class="user-favor"
												 src="/scripts/upload/yonghm.jpg">
											<c:set var="user">
												${purchaseOrderProduct.purchaseOrder.user.getUsername()}
											</c:set>
											<p class="name">${fn:substring(user, 0,3 )}****${fn:substring(user,7,11)}</p>
												<%--<p class="time">2015-10-12   16:16</p>--%>
										</div>
										<div class="seller">
											<p class="ask">
												<c:if test="${not empty purchaseOrderProduct.purchaseOrderComment}">
													${purchaseOrderProduct.purchaseOrderComment.content}
												</c:if>
											</p>
										</div>
									</li>
								</c:if>
							</c:forEach>
						</ul>
						</ul>
					</div>
					<!-- //End--box-des-->
				</c:if>
			</div>

		</div>

		<!-- //End--des-format-->
	</div>
	<!-- //End---->
	<c:if test="${ productModel.product.status==1&&productModel.status!=0}">
		<div class="bd details-total-bar">
			<c:if test="${empty productModel.product.tenant.id}">
				<a class="btn-default" title="进店">进店</a>
			</c:if>
			<c:if test="${not empty productModel.product.tenant.id}">
				<a class="btn-default" href="<c:url value="/tenantOfMobile/${productModel.product.tenant.id}"/>"
				   title="进店">进店</a>
			</c:if>
				<%--<a class="btn-default" target="_blank"  title="咨询">咨询</a>--%>
			<c:if test="${productModel.amount<=0}">
				<a class="btn-cart" title="放入购物车"><i class="icon"></i>放入购物车</a>
				<a style="width:22%;" class="btn-buy" title="售罄">售罄</a>
			</c:if>
			<c:if test="${productModel.amount>0}">
				<a class="btn-cart" onclick="addCart('${productModel.id}')" title="放入购物车"><i class="icon"></i>放入购物车</a>
				<a style="width:22%;" class="btn-buy" onclick="immediateBuy('${productModel.id}')" title="立即购买">立即购买</a>
			</c:if>
			<a style="width: 22%" class="btn-default" onclick="giftBuy()" title="购买">购买送Ta</a>
		</div>
	</c:if>
</article>
<!--Start--选择规格弹出框-->
<div class="am-modal-actions dialog-des-format" id="my-actions">
	<i class="format-close" title="关闭"></i>

	<div class="format-error">请选择商品规格</div>
	<div class="bd">
		<%--<dl class="bd dl-des">--%>
		<%--</dl>--%>
		<div class="des-scroll">
			<ul class="bd ul-nav">
				<c:if test="${fn:length(productModelList) >1}">
					<c:forEach items="${productModel.product.productModelList}" var="pm">
						<li><a href="<c:url value="/product/productModel/${pm.id}"/> " style="color: #000">
								${pm.name}
						</a></li>
					</c:forEach>
				</c:if>
			</ul>
		</div>
		<!-- //End---->
	</div>
</div>
<div class="am-dimmer am-active" data-am-dimmer="" style="display:none"></div>

<!--//End--Start--选择规格弹出框-->

<script type="text/javascript">
	function collect(o) {
		style = "visibility: none;"
		$.ajax({
			type: 'post',
			async: false,
			url: '<c:url value="/product/addProductFavorite.do?id="/>' + o,
			dataType: 'json',
			success: function (data) {
				if (data == false) {
					window.location.href = "<c:url value="/sso.do"/>";
				} else {
//                    document.getElementById("show").style.visibility = "hidden";
//                    document.getElementById("hidden").style.visibility = "visible";
					$("#show").hide();
					$("#hidden").show();
				}
			},
		});
	}
</script>
<%--<script>--%>
<%--$(function(){--%>
<%--$('.btn-cart,.btn-format,.btn-buy').click(function(){--%>
<%--$('.dialog-des-format').css({'-webkit-transform':'translateY(0)'});--%>
<%--$('.am-dimmer').show();--%>
<%--$('.am-active').click(function(){--%>
<%--$('.dialog-des-format').css({'-webkit-transform':'translateY(110%)'});--%>
<%--$('.am-dimmer').hide();--%>
<%--})--%>
<%--return false;--%>
<%--})--%>
<%--})--%>
<%--</script>--%>
<script type="text/javascript">
	$().ready(function () {
		ajaxRequest("<c:url value="/product/favorite/productFavoriteStatus.do"/>", {"id": "${productModel.id}"}, function (data) {
			if (data) {
				$("#show").hide();
				$("#hidden").show();
			} else {
				$("#show").show();
				$("#hidden").hide();
			}
		}, function () {
		}, "get")
	})
</script>
<script type="text/javascript">
	function deCollect(o) {
		$.ajax({
			type: 'post',
			async: false,
			url: '<c:url value="/product/removeProductFavorite.do?id="/>' + o,
			dataType: 'json',
			success: function (data) {
				if (data == false) {
					window.location.href = "<c:url value="/sso.do"/>";
				} else {
//                    document.getElementById("show").style.visibility = "visible";
//                    document.getElementById("hidden").style.visibility = "hidden";
					$("#show").show();
					$("#hidden").hide();
				}
			},
		});
	}

	function subtractProduct() {
		var t = $("#value");
		if (t.val() <= 1) {
			document.getElementById("classid").value = 1;
		}
		t.val(parseInt(t.val()) - 1)
	}
	function addProduct() {
		var t = $("#value");
		var t1 = ${productModel.amount};
		t.val(parseInt(t.val()) + 1)
		if (t.val() >= t1) {
			document.getElementById("value").value = t1;
		}
	}

	function addCart(o) {
		var t = document.getElementById("value").value;
		addToCart(t, o);
		<%--window.location.href = "<c:url value="/cart/addProduct.do?id="/>" + o + "&amount=" + t + "&redirect=/product/productModel/" + o;--%>
	}

	function giftBuy() {
		var t = document.getElementById("value").value;
		window.location.href = "<c:url value="/order/giftBuy/${productModel.id}/"/>" + t;
	}

	function immediateBuy(o) {
		var t = document.getElementById("value").value;
		window.location.href = "<c:url value=""/>" + "/order/easyBuy/" + o + "?amount=" + t;
	}

	//跟踪加入购物车事件
	function addToCart(t, o) {
		ga('ec:addProduct', {
			'id': "${productModel.id}",
			'name': "【${product.name} ${productModel.name}】${product.subName}",
			'category': "${product.project.name}",
			'brand': "${product.tenant.name}",
			'variant': "${product.subName}",
			'price': "${product.price}",
			'quantity': t
		});
		ga('ec:setAction', 'add');
		ga('send', 'event', {
			'eventCategory': 'addToCart',
			'eventAction': 'add',
			'eventLabel': 'detail',
			'eventValue': t,
			'hitCallback': function () {
				window.location.href = "<c:url value="/cart/addProduct.do?id="/>" + o + "&amount=" + t + "&redirect=/product/productModel/" + o;
			}
		});
	}
</script>
<!--[if (gte IE 9)|!(IE)]><!-->
<script type='text/javascript'>

	$().ready(function () {
		$("img").each(function () {
			$(this).css("width", "100%");
		})
		$("img").each(function () {
			$(".user-favor").css("width", "auto");
		})
		$("img").each(function () {
			$(".share-picture").css("width", "auto");
		})
	})
	$().ready(function () {
		$(".share").click(function () {
			if (isWeiXin()) {
				$("#cover").show();
				$(".custom-header").css("z-index", "0");
			} else {
				$("#cover2").show();
				$(".custom-header").css("z-index", "0");
			}
		})
		$("#cover").click(function () {
			$(this).hide();
		})

	})

</script>
<script type="text/javascript">
	var _mvq = window._mvq || [];
	window._mvq = _mvq;
	_mvq.push(['$setAccount', 'm-197303-0']);
	_mvq.push(['$setGeneral', 'goodsdetail', '', /*用户名*/ '', /*用户id*/ '']);
	_mvq.push(['$logConversion']);

	_mvq.push(['$addGoods', /*分类id*/ '', /*品牌id*/ '',/*商品名称*/ '${productModel.name}',/*商品ID*/ '${productModel.id}',/*商品售价*/ '${productModel.price}',
		/*商品图片url*/ 'http://pro.efeiyi.com/${productModel.productModel_url}', /*分类名*/ '${productModel.product.project.name}', /*品牌名*/ '', /*商品库存状态1或是0*/ '${productModel.product.status}', /*网络价*/ '',/*收藏人数*/ '', /*商品下架时间*/ '']);
	_mvq.push(['$logData']);
</script>
</body>


</html>
