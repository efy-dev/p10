<%@ page import="com.efeiyi.ec.consumer.organization.util.AuthorizationUtil" %>
<%@ page import="com.ming800.core.p.PConst" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>个人中心</title>
</head>
<body>
<div class="myorder">
	<div class="order-head">
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
			<dd>
				<p>${fn:substring(user, 0,3 )}****${fn:substring(user,7,11)}</p>
			</dd>
		</dl>
	</div>
	<div class="myfunction">
		<ul>
			<li class="am-u-sm-6 "><a href="<c:url value="/purchaseCollect/wapCollectList.do"/>"
									  style="padding: 15px 0;"><p>商品收藏</p></a></li>
			<li class="am-u-sm-6 ac-ave1"><a href="<c:url value="/coupon/list?cf=4"/>"><p>我的卡券</p></a></li>
		</ul>
	</div>
	<div class="order-list">
		<div class="list-topic">
			<h2>我的订单</h2>
			<%--<span><a href="/myMobileEfeiyi/list.do">查看全部订单<i class="jt-bg"></i></a></span>--%>
		</div>
		<!--订单状态-->
		<c:forEach items="${orderList}" var="purchaseOrder">
			<c:if test="${purchaseOrder.orderStatus==1}">
				<div class="list-pege">
					<div class="state" style="padding: 1rem 0">
						<p class="clo-2"><span><ming800:status name="orderStatus" dataType="PurchaseOrder.orderStatus"
															   checkedValue="${purchaseOrder.orderStatus}" type="normal"/>
						</p>
					</div>
					<ul>
						<c:if test="${purchaseOrder.purchaseOrderProductList.size()<=4}">
							<c:forEach items="${purchaseOrder.purchaseOrderProductList}" var="purchaseOrderProduct">
								<li class="am-u-sm-3 am-u-end jp-pd-l"><img
										src="http://pro.efeiyi.com/<c:url value="${purchaseOrderProduct.productModel.productModel_url}"/>"
										onclick="window.location.href='/order/myEfeiyi/view/${purchaseOrder.id}'"></li>
							</c:forEach>
						</c:if>
						<c:if test="${purchaseOrder.purchaseOrderProductList.size()>4}">
							<li class="am-u-sm-3 am-u-end jp-pd-l"><img
									src="http://pro.efeiyi.com/<c:url value="${purchaseOrder.purchaseOrderProductList.get(0).productModel.productModel_url}"/>"
									onclick="window.location.href='/order/myEfeiyi/view/${purchaseOrder.id}'"></li>
							<li class="am-u-sm-3 am-u-end jp-pd-l"><img
									src="http://pro.efeiyi.com/<c:url value="${purchaseOrder.purchaseOrderProductList.get(1).productModel.productModel_url}"/>"
									onclick="window.location.href='/order/myEfeiyi/view/${purchaseOrder.id}'"></li>
							<li class="am-u-sm-3 am-u-end jp-pd-l"><img
									src="http://pro.efeiyi.com/<c:url value="${purchaseOrder.purchaseOrderProductList.get(2).productModel.productModel_url}"/>"
									onclick="window.location.href='/order/myEfeiyi/view/${purchaseOrder.id}'"></li>
							<li class="am-u-sm-3 am-u-end jp-pd-l"><img
									src="http://pro.efeiyi.com/<c:url value="${purchaseOrder.purchaseOrderProductList.get(3).productModel.productModel_url}"/>"
									onclick="window.location.href='/order/myEfeiyi/view/${purchaseOrder.id}'"></li>
						</c:if>
					</ul>
					<c:if test="${purchaseOrder.orderStatus == '1'}">
						<ul class="jp-pd jp-pd-btns">
							<li>￥${purchaseOrder.total-purchaseOrder.coupon.couponBatch.price}</li>
							<li><a style="margin-right: 10px;" href="<%=PConst.HOSTNAME%>/order/pay/${purchaseOrder.id}" name="payButton">立即支付</a></li>
						</ul>
					</c:if>
				</div>
			</c:if>
			<c:if test="${purchaseOrder.orderStatus!=1}">
				<c:if test="${purchaseOrder.subPurchaseOrder==null || purchaseOrder.subPurchaseOrder.size()==0}">
					<div class="list-pege">
						<div class="state" style="padding: 1rem 0">
							<p class="clo-2"><span><ming800:status name="orderStatus" dataType="PurchaseOrder.orderStatus"
																   checkedValue="${purchaseOrder.orderStatus}" type="normal"/>
							</p>
						</div>
						<ul>
							<c:if test="${purchaseOrder.purchaseOrderProductList.size()<=4}">
								<c:forEach items="${purchaseOrder.purchaseOrderProductList}" var="purchaseOrderProduct">
									<li class="am-u-sm-3 am-u-end jp-pd-l"><img
											src="http://pro.efeiyi.com/<c:url value="${purchaseOrderProduct.productModel.productModel_url}"/>"
											onclick="window.location.href='/order/myEfeiyi/view/${purchaseOrder.id}'"></li>
								</c:forEach>
							</c:if>
							<c:if test="${purchaseOrder.purchaseOrderProductList.size()>4}">
								<li class="am-u-sm-3 am-u-end jp-pd-l"><img
										src="http://pro.efeiyi.com/<c:url value="${purchaseOrder.purchaseOrderProductList.get(0).productModel.productModel_url}"/>"
										onclick="window.location.href='/order/myEfeiyi/view/${purchaseOrder.id}'"></li>
								<li class="am-u-sm-3 am-u-end jp-pd-l"><img
										src="http://pro.efeiyi.com/<c:url value="${purchaseOrder.purchaseOrderProductList.get(1).productModel.productModel_url}"/>"
										onclick="window.location.href='/order/myEfeiyi/view/${purchaseOrder.id}'"></li>
								<li class="am-u-sm-3 am-u-end jp-pd-l"><img
										src="http://pro.efeiyi.com/<c:url value="${purchaseOrder.purchaseOrderProductList.get(2).productModel.productModel_url}"/>"
										onclick="window.location.href='/order/myEfeiyi/view/${purchaseOrder.id}'"></li>
								<li class="am-u-sm-3 am-u-end jp-pd-l"><img
										src="http://pro.efeiyi.com/<c:url value="${purchaseOrder.purchaseOrderProductList.get(3).productModel.productModel_url}"/>"
										onclick="window.location.href='/order/myEfeiyi/view/${purchaseOrder.id}'"></li>
							</c:if>
						</ul>
						<c:if test="${purchaseOrder.orderStatus == '3'}">
							<ul class="jp-pd jp-pd-btns">
								<li>￥${purchaseOrder.total-purchaseOrder.coupon.couponBatch.price}</li>
								<li><a style="margin-right: 10px;"
									   href="<c:url value="/order/myEfeiyi/view/${purchaseOrder.id}"/>">查看详情</a></li>
							</ul>
						</c:if>
						<c:if test="${purchaseOrder.orderStatus == '6'}">
							<ul class="jp-pd jp-pd-btns">
								<li>￥${purchaseOrder.total-purchaseOrder.coupon.couponBatch.price}</li>
								<li><a style="margin-right: 10px;"
									   href="<c:url value="/order/myEfeiyi/view/${purchaseOrder.id}"/>">查看详情</a></li>
							</ul>
						</c:if>
						<c:if test="${purchaseOrder.orderStatus == '15'}">
							<ul class="jp-pd jp-pd-btns">
								<li>￥${purchaseOrder.total-purchaseOrder.coupon.couponBatch.price}</li>
								<li><a style="margin-right: 10px;"
									   href="<c:url value="/order/myEfeiyi/view/${purchaseOrder.id}"/>">查看详情</a></li>
							</ul>
						</c:if>
						<c:if test="${purchaseOrder.orderStatus == '5'}">
							<ul class="jp-pd jp-pd-btns">
								<li>￥${purchaseOrder.total-purchaseOrder.coupon.couponBatch.price}</li>
								<li><a style="margin-right: 10px;"
									   href="<c:url value="/order/myEfeiyi/view/${purchaseOrder.id}"/>">查看详情</a></li>
							</ul>
						</c:if>

						<c:if test="${purchaseOrder.orderStatus == '7'}">

							<ul class="jp-pd jp-pd-btns">
								<li>￥${purchaseOrder.total-purchaseOrder.coupon.couponBatch.price}</li>
								<li><a style="margin-right: 10px;"
									   href="<c:url value="/order/myEfeiyi/view/${purchaseOrder.id}"/>">查看物流</a>
									<a style="margin-right: 0px;" href="#" onclick="showConfirm('提示','是否确定收货',function(){
											window.location.href='<c:url value="/order/confirmGet/${purchaseOrder.id}"/>';
											})">确定收货</a></li>
							</ul>
						</c:if>

						<c:if test="${purchaseOrder.orderStatus == '13'}">
							<ul class="jp-pd jp-pd-btns">
								<li>￥${purchaseOrder.total-purchaseOrder.coupon.couponBatch.price}</li>
								<li><a style="margin-right: 10px;"
									   href="<c:url value="/order/myEfeiyi/view/${purchaseOrder.id}"/>">已完成</a></li>
							</ul>
						</c:if>

						<c:if test="${purchaseOrder.orderStatus == '17'}">
							<ul class="jp-pd jp-pd-btns">
								<li>￥${purchaseOrder.total-purchaseOrder.coupon.couponBatch.price}</li>
								<li><a style="margin-right: 10px;"
									   href="<c:url value="/order/myEfeiyi/view/${purchaseOrder.id}"/>">已取消</a></li>
							</ul>
						</c:if>

						<c:if test="${purchaseOrder.orderStatus == '9'}">
							<ul class="jp-pd jp-pd-btns">
								<li>￥${purchaseOrder.total-purchaseOrder.coupon.couponBatch.price}</li>
								<li><a style="margin-right: 10px;"
									   href="<c:url value="/order/myEfeiyi/view/${purchaseOrder.id}"/>">查看详情</a>
									<a style="margin-right: 0px;"
									   href="<c:url value="/comment/mobileFinishOrder.do?orderId=${purchaseOrder.id}"/>">去&nbsp;评&nbsp;价</a>
								</li>


							</ul>
						</c:if>

					</div>

				</c:if>
			</c:if>
			<c:if test="${purchaseOrder.orderStatus!=1}">
				<c:if test="${purchaseOrder.subPurchaseOrder != null || purchaseOrder.subPurchaseOrder.size()>0 }">
					<c:forEach items="${purchaseOrder.subPurchaseOrder}" var="spList">

						<div class="list-pege">
							<div class="state" style="padding: 1rem 0">
								<p class="clo-2"><span><ming800:status name="orderStatus" dataType="spList.orderStatus"
																	   checkedValue="${spList.orderStatus}" type="normal"/>
								</p>
							</div>
							<ul>
								<c:if test="${spList.purchaseOrderProductList.size()<=4}">
									<c:forEach items="${spList.purchaseOrderProductList}" var="purchaseOrderProduct">
										<li class="am-u-sm-3 am-u-end jp-pd-l"><img
												src="http://pro.efeiyi.com/<c:url value="${purchaseOrderProduct.productModel.productModel_url}"/>"
												onclick="window.location.href='/order/myEfeiyi/view/${spList.id}'"></li>
									</c:forEach>
								</c:if>
								<c:if test="${spList.purchaseOrderProductList.size()>4}">
									<li class="am-u-sm-3 am-u-end jp-pd-l"><img
											src="http://pro.efeiyi.com/<c:url value="${spList.purchaseOrderProductList.get(0).productModel.productModel_url}"/>"
											onclick="window.location.href='/order/myEfeiyi/view/${spList.id}'"></li>
									<li class="am-u-sm-3 am-u-end jp-pd-l"><img
											src="http://pro.efeiyi.com/<c:url value="${spList.purchaseOrderProductList.get(1).productModel.productModel_url}"/>"
											onclick="window.location.href='/order/myEfeiyi/view/${spList.id}'"></li>
									<li class="am-u-sm-3 am-u-end jp-pd-l"><img
											src="http://pro.efeiyi.com/<c:url value="${spList.purchaseOrderProductList.get(2).productModel.productModel_url}"/>"
											onclick="window.location.href='/order/myEfeiyi/view/${spList.id}'"></li>
									<li class="am-u-sm-3 am-u-end jp-pd-l"><img
											src="http://pro.efeiyi.com/<c:url value="${spList.purchaseOrderProductList.get(3).productModel.productModel_url}"/>"
											onclick="window.location.href='/order/myEfeiyi/view/${spList.id}'"></li>
								</c:if>
							</ul>
							<c:if test="${purchaseOrder.orderStatus == '3'}">
								<ul class="jp-pd jp-pd-btns">
									<li>￥${purchaseOrder.total-purchaseOrder.coupon.couponBatch.price}</li>
									<li><a style="margin-right: 10px;"
										   href="<c:url value="/order/myEfeiyi/view/${purchaseOrder.id}"/>">查看详情</a></li>
								</ul>
							</c:if>
							<c:if test="${purchaseOrder.orderStatus == '6'}">
								<ul class="jp-pd jp-pd-btns">
									<li>￥${purchaseOrder.total-purchaseOrder.coupon.couponBatch.price}</li>
									<li><a style="margin-right: 10px;"
										   href="<c:url value="/order/myEfeiyi/view/${purchaseOrder.id}"/>">查看详情</a></li>
								</ul>
							</c:if>
							<c:if test="${purchaseOrder.orderStatus == '15'}">
								<ul class="jp-pd jp-pd-btns">
									<li>￥${purchaseOrder.total-purchaseOrder.coupon.couponBatch.price}</li>
									<li><a style="margin-right: 10px;"
										   href="<c:url value="/order/myEfeiyi/view/${purchaseOrder.id}"/>">查看详情</a></li>
								</ul>
							</c:if>
							<c:if test="${spList.orderStatus == '5'}">
								<ul class="jp-pd jp-pd-btns">
									<li>￥${spList.total-spList.coupon.couponBatch.price}</li>
									<li><a style="margin-right: 10px;"
										   href="<c:url value="/order/myEfeiyi/view/${spList.id}"/>">查看详情</a></li>
								</ul>
							</c:if>

							<c:if test="${spList.orderStatus == '7'}">

								<ul class="jp-pd jp-pd-btns">
									<li>￥${spList.total-spList.coupon.couponBatch.price}</li>
									<li><a style="margin-right: 10px;"
										   href="<c:url value="/order/myEfeiyi/view/${spList.id}"/>">查看物流</a>
										<a style="margin-right: 0px;" href="#" onclick="showConfirm('提示','是否确定收货',function(){
												window.location.href='<c:url value="/order/confirmGet/${spList.id}"/>';
												})">确定收货</a></li>
								</ul>
							</c:if>

							<c:if test="${spList.orderStatus == '13'}">
								<ul class="jp-pd jp-pd-btns">
									<li>￥${spList.total-spList.coupon.couponBatch.price}</li>
									<li><a style="margin-right: 10px;"
										   href="<c:url value="/order/myEfeiyi/view/${spList.id}"/>">已完成</a></li>
								</ul>
							</c:if>

							<c:if test="${spList.orderStatus == '17'}">
								<ul class="jp-pd jp-pd-btns">
									<li>￥${spList.total-spList.coupon.couponBatch.price}</li>
									<li><a style="margin-right: 10px;"
										   href="<c:url value="/order/myEfeiyi/view/${spList.id}"/>">已取消</a></li>
								</ul>
							</c:if>

							<c:if test="${spList.orderStatus == '9'}">
								<ul class="jp-pd jp-pd-btns">
									<li>￥${spList.total-spList.coupon.couponBatch.price}</li>
									<li><a style="margin-right: 10px;"
										   href="<c:url value="/order/myEfeiyi/view/${spList.id}"/>">查看详情</a>
										<a style="margin-right: 0px;"
										   href="<c:url value="/comment/mobileFinishOrder.do?orderId=${spList.id}"/>"/>">去&nbsp;评&nbsp;价</a>
									</li>

								</ul>
							</c:if>

						</div>

					</c:forEach>
				</c:if>
			</c:if>
		</c:forEach>
		<!--订单状态-->
	</div>
	<!--个人信息-->
	<div class="Extras">
		<a href="<c:url value="/myEfeiyi/personalInfo.do"/>"> 个人信息<i class="icon-sj"></i></a>
	</div>
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
