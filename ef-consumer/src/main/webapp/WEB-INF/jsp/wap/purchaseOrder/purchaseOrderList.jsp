<%@ page import="com.efeiyi.ec.consumer.organization.util.AuthorizationUtil" %>
<%@ page import="com.ming800.core.p.PConst" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
	<title>个人中心</title>
	<style>
		.myorder .order-section .money-btn a{width: 80px}
	</style>
</head>
<body>
<!--//End--header-->
<div class="myorder">
	<div class="order-head ae">
		<dl>
			<c:if test="${!empty user.pictureUrl}">
				<dt><img src="<c:url value="http://pro.efeiyi.com/${user.pictureUrl}@!user-pic"/>" alt="..."
						 class="am-img-thumbnail"></dt>
			</c:if>
			<c:if test="${empty user.pictureUrl}">
				<dt><img src="<c:url value="/scripts/images/yonghm.jpg"/>" alt="..." class="am-img-thumbnail"></dt>

			</c:if>
			<c:set var="user">
				<%= AuthorizationUtil.getMyUser().getUsername()%>
			</c:set>
			<dd>${fn:substring(user, 0,3 )}****${fn:substring(user,7,11)}</dd>
		</dl>
	</div>

	<div class="myfunction ae">
		<ul>
			<li class="am-u-sm-6 " style="float: left;line-height: 36px;"><a
					href="<c:url value="/purchaseCollect/wapCollectList.do"/>"><p>商品收藏</p></a></li>
			<li class="am-u-sm-6" style="float: left;line-height: 36px;"><a href="<c:url value="/coupon/list?cf=4"/>">
				<p>我的卡券</p></a></li>
		</ul>
	</div>
	<div class="order-list ae">
		<div class="order-had ae">
			<span>我的订单</span>
			<%--<span><a href="#">全部订单<i class="right-icon"></i></a></span>--%>
		</div>
		<c:forEach items="${orderList}" var="purchaseOrder">
			<c:if test="${purchaseOrder.orderStatus==1}">
				<div class="order-section ae">
					<div class="shop-name"><span>${purchaseOrder.tenant.name}</span>
					<span><ming800:status name="orderStatus" dataType="PurchaseOrder.orderStatus"
										  checkedValue="${purchaseOrder.orderStatus}" type="normal"/></span>
						<c:if test="${purchaseOrder.orderType!=1}">
					<span><ming800:status name="orderType" dataType="PurchaseOrder.orderType"
										  checkedValue="${purchaseOrder.orderType}" type="normal"/></span></div>
					</c:if>
					<!-- 商品-->
					<ul class="shops ae">
						<c:forEach items="${purchaseOrder.purchaseOrderProductList}" var="purchaseOrderProduct">
							<li>
								<div class="shops-pic"><img
										src="http://pro.efeiyi.com/<c:url value="${purchaseOrderProduct.productModel.productModel_url}"/>"
										onclick="window.location.href='/order/myEfeiyi/view/${purchaseOrder.id}'"></div>
								<div class="shops-text">
									<p>${purchaseOrderProduct.productModel.product.name}</p>

									<p>${purchaseOrderProduct.productModel.name}</p>
									<span class="money-txt">￥${purchaseOrderProduct.productModel.price}</span>
									<span class="list-txt">x${purchaseOrderProduct.purchaseAmount}</span>
								</div>
							</li>
						</c:forEach>
					</ul>
					<!-- 商品-->
					<div class="payment">应付款：<em>${purchaseOrder.total-purchaseOrder.getOrderPayMoney()}</em>元</div>
					<div class="money-btn">
						<c:choose>
							<c:when test="${purchaseOrder.orderStatus == '3'}">
								<a href="<c:url value="/order/myEfeiyi/view/${purchaseOrder.id}"/>">查&nbsp;看&nbsp;详&nbsp;情</a>
							</c:when>
							<c:when test="${purchaseOrder.orderStatus == '6'}">
								<a href="<c:url value="/order/myEfeiyi/view/${purchaseOrder.id}"/>">查&nbsp;看&nbsp;详&nbsp;情</a>
							</c:when>
							<c:when test="${purchaseOrder.orderStatus == '1'}">
								<a href="<c:url value="/order/myEfeiyi/view/${purchaseOrder.id}"/>">查&nbsp;看&nbsp;详&nbsp;情</a>
								<a href="<%=PConst.HOSTNAME%>/order/pay/${purchaseOrder.id}" name="payButton"/>立&nbsp;即&nbsp;支&nbsp;付</a>
							</c:when>
						</c:choose>
							<c:choose>
							<c:when test="${purchaseOrder.orderType == '4'}">
								<a href="<c:url value="/order/groupBuyView?orderId=${spList.id}"/>">查&nbsp;看&nbsp;团&nbsp;购</a>
							</c:when>
							</c:choose>
					</div>
				</div>
			</c:if>

			<c:if test="${purchaseOrder.orderStatus!=1}">
				<c:if test="${purchaseOrder.subPurchaseOrder==null || purchaseOrder.subPurchaseOrder.size()==0}">
					<div class="order-section ae">
						<div class="shop-name"><span>${purchaseOrder.tenant.name}</span>
					<span><ming800:status name="orderStatus" dataType="PurchaseOrder.orderStatus"
										  checkedValue="${purchaseOrder.orderStatus}" type="normal"/></span>
					<span><ming800:status name="orderType" dataType="PurchaseOrder.orderType"
										  checkedValue="${purchaseOrder.orderType}" type="normal"/></span></div>
						<!-- 商品-->
						<ul class="shops ae">
							<c:forEach items="${purchaseOrder.purchaseOrderProductList}" var="purchaseOrderProduct">
								<li>
									<div class="shops-pic"><img
											src="http://pro.efeiyi.com/<c:url value="${purchaseOrderProduct.productModel.productModel_url}"/>"
											onclick="window.location.href='/order/myEfeiyi/view/${purchaseOrder.id}'">
									</div>
									<div class="shops-text">
										<p>${purchaseOrderProduct.productModel.product.name}</p>

										<p>${purchaseOrderProduct.productModel.name}</p>
										<span class="money-txt">￥${purchaseOrderProduct.productModel.price}</span>
										<span class="list-txt">x${purchaseOrderProduct.purchaseAmount}</span>
									</div>
								</li>
							</c:forEach>
						</ul>
						<!-- 商品-->
						<div class="payment">实付款：<em>${purchaseOrder.total-purchaseOrder.getOrderPayMoney()}</em>元</div>
						<div class="money-btn" >
							<c:choose>
								<c:when test="${purchaseOrder.orderStatus == '3'}">
									<a href="<c:url value="/order/myEfeiyi/view/${purchaseOrder.id}"/>">查&nbsp;看&nbsp;详&nbsp;情</a>
								</c:when>
								<c:when test="${purchaseOrder.orderStatus == '6'}">
									<a href="<c:url value="/order/myEfeiyi/view/${purchaseOrder.id}"/>">查&nbsp;看&nbsp;详&nbsp;情</a>
								</c:when>
								<c:when test="${purchaseOrder.orderStatus == '15'}">
									<a href="<c:url value="/order/myEfeiyi/view/${purchaseOrder.id}"/>">查&nbsp;看&nbsp;详&nbsp;情</a>
								</c:when>
								<c:when test="${purchaseOrder.orderStatus == '5'}">
									<a href="<c:url value="/order/myEfeiyi/view/${purchaseOrder.id}"/>">查&nbsp;看&nbsp;详&nbsp;情</a>
								</c:when>
								<c:when test="${purchaseOrder.orderStatus == '7'}">
									<a href="<c:url value="/order/myEfeiyi/view/${purchaseOrder.id}"/>">查&nbsp;看&nbsp;物&nbsp;流</a>
									<a href="#" onclick="showConfirm('提示','是否确定收货',function(){
											window.location.href='<c:url
											value="/order/confirmGet/${purchaseOrder.id}"/>';
											})">确定收货</a>
								</c:when>
								<c:when test="${purchaseOrder.orderStatus == '13'}">
									<a href="<c:url value="/order/myEfeiyi/view/${purchaseOrder.id}"/>">查&nbsp;看&nbsp;详&nbsp;情</a>
								</c:when>
								<c:when test="${purchaseOrder.orderStatus == '17'}">
									<a href="#">已&nbsp;取&nbsp;消</a>
								</c:when>
								<c:when test="${purchaseOrder.orderStatus == '9'}">
									<a href="<c:url value="/order/myEfeiyi/view/${purchaseOrder.id}"/>">查&nbsp;看&nbsp;详&nbsp;情</a>
									<a href="<c:url value="/comment/mobileFinishOrder.do?orderId=${purchaseOrder.id}"/>">去&nbsp;评&nbsp;价</a>
								</c:when>
							</c:choose>
							<c:choose>
								<c:when test="${purchaseOrder.orderType == '3'}">
									<a href="<%=PConst.HOSTNAME%>/giftReceive/${purchaseOrder.id}">查&nbsp;看&nbsp;礼&nbsp;品</a>
								</c:when>
								<c:when test="${purchaseOrder.orderType == '4'}">
									<a href="<c:url value="/order/groupBuyView?orderId=${purchaseOrder.id}"/>">查&nbsp;看&nbsp;团&nbsp;购</a>
								</c:when>
							</c:choose>
						</div>
					</div>
				</c:if>
			</c:if>
			<c:if test="${purchaseOrder.orderStatus!=1}">
				<c:if test="${purchaseOrder.subPurchaseOrder != null || purchaseOrder.subPurchaseOrder.size()>0 }">
					<c:forEach items="${purchaseOrder.subPurchaseOrder}" var="spList">
						<div class="order-section ae">
							<div class="shop-name"><span>${spList.tenant.name}</span>
					<span><ming800:status name="orderStatus" dataType="PurchaseOrder.orderStatus"
										  checkedValue="${spList.orderStatus}" type="normal"/></span>
					<span><ming800:status name="orderType" dataType="PurchaseOrder.orderType"
										  checkedValue="${spList.orderType}" type="normal"/></span></div>
							<!-- 商品-->
							<ul class="shops ae">
								<c:forEach items="${spList.purchaseOrderProductList}" var="purchaseOrderProduct">
									<li>
										<div class="shops-pic"><img
												src="http://pro.efeiyi.com/<c:url value="${purchaseOrderProduct.productModel.productModel_url}"/>"
												onclick="window.location.href='/order/myEfeiyi/view/${purchaseOrder.id}'">
										</div>
										<div class="shops-text">
											<p>${purchaseOrderProduct.productModel.product.name}</p>

											<p>${purchaseOrderProduct.productModel.name}</p>
											<span class="money-txt">￥${purchaseOrderProduct.productModel.price}</span>
											<span class="list-txt">x${purchaseOrderProduct.purchaseAmount}</span>
										</div>
									</li>
								</c:forEach>
							</ul>
							<!-- 商品-->
							<div class="payment">实付款：<em>${spList.total-purchaseOrder.getOrderPayMoney()}</em>元</div>
							<div class="money-btn">
								<c:choose>
									<c:when test="${spList.orderStatus == '3'}">
										<a href="<c:url value="/order/myEfeiyi/view/${spList.id}"/>">查&nbsp;看&nbsp;详&nbsp;情</a>
									</c:when>
									<c:when test="${spList.orderStatus == '6'}">
										<a href="<c:url value="/order/myEfeiyi/view/${spList.id}"/>">查&nbsp;看&nbsp;详&nbsp;情</a>
									</c:when>
									<c:when test="${spList.orderStatus == '15'}">
										<a href="<c:url value="/order/myEfeiyi/view/${spList.id}"/>">查&nbsp;看&nbsp;详&nbsp;情</a>
									</c:when>
									<c:when test="${spList.orderStatus == '5'}">
										<a href="<c:url value="/order/myEfeiyi/view/${spList.id}"/>">查&nbsp;看&nbsp;详&nbsp;情</a>
									</c:when>
									<c:when test="${spList.orderStatus == '7'}">
										<a href="<c:url value="/order/myEfeiyi/view/${spList.id}"/>">查&nbsp;看&nbsp;物&nbsp;流</a>
										<a href="#" onclick="showConfirm('提示','是否确定收货',function(){
												window.location.href='<c:url value="/order/confirmGet/${spList.id}"/>';
												})">确定收货</a>
									</c:when>
									<c:when test="${purchaseOrder.orderStatus == '13'}">
										<a href="<c:url value="/order/myEfeiyi/view/${spList.id}"/>">查&nbsp;看&nbsp;详&nbsp;情</a>
									</c:when>
									<c:when test="${purchaseOrder.orderStatus == '17'}">
										<a href="#">已&nbsp;取&nbsp;消</a>
									</c:when>
									<c:when test="${purchaseOrder.orderStatus == '9'}">
										<a href="<c:url value="/order/myEfeiyi/view/${spList.id}"/>">查&nbsp;看&nbsp;详&nbsp;情</a>
										<a href="<c:url value="/comment/mobileFinishOrder.do?orderId=${spList.id}"/>">去&nbsp;评&nbsp;价</a>
									</c:when>
								</c:choose>
								<c:choose>
									<c:when test="${spList.orderType == '3'}">
										<a href="<%=PConst.HOSTNAME%>/giftReceive/${spList.id}">查&nbsp;看&nbsp;礼&nbsp;品</a>
									</c:when>
									<c:when test="${spList.orderType == '4'}">
									<a href="<c:url value="/order/groupBuyView?orderId=${spList.id}"/>">查&nbsp;看&nbsp;团&nbsp;购</a>
									</c:when>
								</c:choose>
							</div>
						</div>
					</c:forEach>

				</c:if>

			</c:if>
		</c:forEach>
	</div>
	<div class="order-box ae">
		<!--个人信息-->
		<div class="Extras">
			<a href="<c:url value="/myEfeiyi/personalInfo.do"/>"> 个人信息<i class="icon-sj"></i></a>
		</div>
		<!--账户余额-->
		<%--<div class="Extras">--%>
		<%--<a href="#"> 账户余额<i class="icon-sj"></i></a>--%>
		<%--</div>--%>
		<!--地址管理-->
		<div class="Extras">
			<a href="<c:url value="/myEfeiyi/address/list"/>"> 地址信息<i class="icon-sj"></i></a>
		</div>
		<!--修改密码-->
		<div class="Extras">
			<a href="<c:url value="/myEfeiyi/getPassword.do"/>"> 修改密码<i class="icon-sj"></i></a>
		</div>
		<!--安全退出-->
		<div class="aq-btn"><a href="<c:url value="/j_spring_cas_security_logout"/>">安全退出</a></div>
	</div>
</div>
<script>

	function isWeiXin(){
		var ua = window.navigator.userAgent.toLowerCase();
		if(ua.match(/MicroMessenger/i) == 'micromessenger'){
			return true;
		}else{
			return false;
		}
	}

	var  isWeiXinFlag = isWeiXin();

	$().ready(function(){
		$("a[name=payButton]").each(function(){
			if(isWeiXinFlag){
				$(this).attr("href",$(this).attr("href")+"?isWeiXin=true");
			}else{
				$(this).attr("href",$(this).attr("href")+"?isWeiXin=false");
			}
		});
	})
</script>
</body>
</html>
