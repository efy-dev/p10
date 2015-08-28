<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>0202个人中心</title>
</head>
<body>
<div class="myorder">
  <div class="order-head">
    <dl>
      <dt><img src="<c:url value="/scripts/wap/assets/upload/yonghm.jpg"/>" alt="..." class="am-img-thumbnail"></dt>
      <dd>
        <p>15110008479</p>
      </dd>
    </dl>
  </div>
  <div><hr data-am-widget="divider" style="" class="am-divider am-divider-default" /></div>
  <div class="myfunction">
    <ul>
      <li class="am-u-sm-4 "><a href="#"><p>商品收藏</p><p>1</p></a></li>
      <li class="am-u-sm-4"><a href="#"><p>店铺收藏</p><p>1</p></a></li>
      <li class="am-u-sm-4 ac-ave1"><a href="#"><p>我的卡券</p><p>1</p></a></li>
    </ul>
  </div>
  <div class="order-list">
    <div class="list-topic">
      <h2>我的订单</h2>
      <span><a href="#">查看全部订单<i class="jt-bg"></i></a></span>
    </div>
    <!--订单状态-->
    <c:forEach items="${orderList}" var="purchaseOrder">
      <div class="list-pege">
          <ul>
            <c:if test="${purchaseOrder.purchaseOrderProductList.size()<=4}">
              <c:forEach items="${purchaseOrder.purchaseOrderProductList}" var="purchaseOrderProduct">
                <li class="am-u-sm-3 am-u-end jp-pd-l"><img src="<c:url value="${purchaseOrderProduct.productModel.product.picture_url}"/>"></li>
              </c:forEach>
            </c:if>
            <c:if test="${purchaseOrder.purchaseOrderProductList.size()>4}">
              <li class="am-u-sm-3 am-u-end jp-pd-l"><img src="<c:url value="${purchaseOrder.purchaseOrderProductList.get(0).productModel.product.picture_url}"/>"></li>
              <li class="am-u-sm-3 am-u-end jp-pd-l"><img src="<c:url value="${purchaseOrder.purchaseOrderProductList.get(1).productModel.product.picture_url}"/>"></li>
              <li class="am-u-sm-3 am-u-end jp-pd-l"><img src="<c:url value="${purchaseOrder.purchaseOrderProductList.get(2).productModel.product.picture_url}"/>"></li>
              <li class="am-u-sm-3 am-u-end jp-pd-l"><img src="<c:url value="${purchaseOrder.purchaseOrderProductList.get(3).productModel.product.picture_url}"/>"></li>
            </c:if>
          </ul>
        <c:if test="${purchaseOrder.orderStatus == '1'}">
          <ul class="jp-pd">
            <li class="am-u-sm-2 jp-pd-r">待付款</li>
            <li class="am-u-sm-4 jp-pd-l">￥${purchaseOrder.total}</li>
            <li class="am-u-sm-6 jp-pd-l"><a href="#">立即支付</a></li>
          </ul>
        </c:if>
        <c:if test="${purchaseOrder.orderStatus == '5'}">
          <ul class="jp-pd">
            <li class="am-u-sm-2 jp-pd-r">待收货</li>
            <li class="am-u-sm-4 jp-pd-l">￥${purchaseOrder.total}</li>
            <li class="am-u-sm-6 jp-pd-l"><a href="#">查看物流</a></li>
          </ul>
        </c:if>
        <c:if test="${purchaseOrder.orderStatus == '13'}">
        <ul class="jp-pd">
          <li class="am-u-sm-2 jp-pd-r">已收货</li>
          <li class="am-u-sm-4 jp-pd-l">￥${purchaseOrder.total}</li>
          <li class="am-u-sm-6 jp-pd-l"><a href="#"></a></li>
        </ul>
      </c:if>
        <c:if test="${purchaseOrder.orderStatus == '17'}">
          <ul class="jp-pd">
            <li class="am-u-sm-2 jp-pd-r">已取消</li>
            <li class="am-u-sm-4 jp-pd-l">￥${purchaseOrder.total}</li>
            <li class="am-u-sm-6 jp-pd-l"><a href="#"></a></li>
          </ul>
        </c:if>
        <div><hr data-am-widget="divider" style="" class="am-divider am-divider-default" /></div>
      </div>
    </c:forEach>
    <!--订单状态-->
  </div>
  <!--个人信息-->
  <div class="Extras">
    <h2>个人信息</h2>
    <span><a href="/myEfeiyi/personalInfo.do"><i class="icon-sj"></i></a></span>
  </div>
  <!--地址管理-->
  <div class="Extras">
    <h2>地址管理</h2>
    <span><a href="/myEfeiyi/address/list"><i class="icon-sj"></i></a></span>
  </div>
  <!--修改密码-->
  <div class="Extras">
    <h2>修改密码</h2>
    <span><a href="/myEfeiyi/getPassword.do"><i class="icon-sj"></i></a></span>
  </div>
  <!--安全退出-->
  <div class="aq-btn"><a href="/j_spring_security_logout">安全退出</a> </div>
</div>
</body>
</html>
