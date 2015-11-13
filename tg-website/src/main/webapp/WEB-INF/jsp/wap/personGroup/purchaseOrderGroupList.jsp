<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>b01020302我的团</title>
  <!-- Set render engine for 360 browser -->
  <meta name="renderer" content="webkit">
  <!-- No Baidu Siteapp-->
  <meta http-equiv="Cache-Control" content="no-siteapp"/>
  <link rel="icon" type="image/png" href="assets/i/favicon.png">
  <!-- Add to homescreen for Chrome on Android -->
  <meta name="mobile-web-app-capable" content="yes">
  <link rel="icon" sizes="192x192" href="assets/i/app-icon72x72@2x.png">
  <!-- Add to homescreen for Safari on iOS -->
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
  <link rel="apple-touch-icon-precomposed" href="assets/i/app-icon72x72@2x.png">
  <!-- Tile icon for Win8 (144x144 + tile color) -->
  <meta name="msapplication-TileImage" content="assets/i/app-icon72x72@2x.png">
  <meta name="msapplication-TileColor" content="#0e90d2">
  <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/wap/css/amazeui.min.css?v=20150831"/>">
  <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/wap/css/app.css?v=20150831"/>">
  <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/wap/css/myorder.css?v=20150831"/>">
</head>
<body>
<header class="am-header custom-header">
  <div class="am-header-left am-header-nav">
    <a href="javascript:history.go(-1)" class="chevron-left"></a>
  </div>
  <!-- //End--chevron-left-->
  <h1 class="am-header-title">我的订单</h1>
  <!-- //End--title-->
</header>
<!--//End--header-->
<div class="m-order ae">
  <div class="order-title ae">
    <ul>
      <li class="active">全部</li>
      <li>待发货</li>
      <li>待收货</li>
      <li>待评价</li>
    </ul>
  </div>
  <div class="order-content ae">
    <div class="od-tab1" title="全部">
      <c:if test="${not empty purchaseOrderGroupList&&fn:length(purchaseOrderGroupList)>0}">
      <ul class="product ae">
        <c:forEach items="${purchaseOrderGroupList}" var="purchaseOrderGroup">
          <li>
            <div class="top">
              <span>${purchaseOrderGroup.purchaseOrder.purchaseOrderProductList.get(0).productModel.product.name}${purchaseOrderGroup.purchaseOrder.purchaseOrderProductList.get(0).productModel.name}</span>
              <i class=" pq"></i>
              <c:if test="${purchaseOrderGroup.group.status==1}">
                <span>组团中</span>
              </c:if>
              <c:if test="${purchaseOrderGroup.group.status==3}">
                <c:if test="${purchaseOrderGroup.purchaseOrder.orderStatus==1}">
                  <span>组团成功-等待付款</span>
                </c:if>
                <c:if test="${purchaseOrderGroup.purchaseOrder.orderStatus==5}">
                  <span>组团成功-已付款</span>
                </c:if>
                <c:if test="${purchaseOrderGroup.purchaseOrder.orderStatus==7}">
                  <span>组团成功-已发货</span>
                </c:if>
                <c:if test="${purchaseOrderGroup.purchaseOrder.orderStatus==13}">
                  <span>组团成功-已完成</span>
                </c:if>
              </c:if>
              <c:if test="${purchaseOrderGroup.group.status==5}">
                <c:if test="${purchaseOrderGroup.purchaseOrder.orderStatus==5}">
                  <span>组团失败-等待付款</span>
                </c:if>
                <c:if test="${purchaseOrderGroup.purchaseOrder.orderStatus!=1}">
                  <span>组团失败-已付款</span>
                </c:if>
              </c:if>
            </div>
            <div class="center ae">
              <div class="pic"><a href="<c:url value="/product/groupProduct/${purchaseOrderGroup.group.groupProduct.id}"/>" ><img src="http://pro.efeiyi.com/${purchaseOrderGroup.purchaseOrder.purchaseOrderProductList.get(0).productModel.productModel_url}@!group-mobile-picture-list"></a></div>
              <div class="txt ae"><p>交易金额：${purchaseOrderGroup.purchaseOrder.total}元</p>
                <c:if test="${purchaseOrderGroup.group.status==1||purchaseOrderGroup.group.status==5}">
                  <p>返回红包：0元</p>
                </c:if>
                <c:if test="${purchaseOrderGroup.group.status==3}">
                  <p>返回红包：${purchaseOrderGroup.member.redPacket}元</p>
                </c:if>
              </div>
            </div>
            <div class="bottom ae">
              <c:if test="${purchaseOrderGroup.member.level==0}">
                <div class="left">身份:团长</div>
              </c:if>
              <c:if test="${purchaseOrderGroup.member.level!=0}">
                <div class="left">身份:团员</div>
              </c:if>
              <ul class="right">
                <!--状态-->
                <%--<li><a href="#">追加评价</a></li>--%>
                <%--<li><a href="#">查看物流</a></li>--%>
              </ul>
            </div>
          </li>
        </c:forEach>
      </ul>
      </c:if>
      <!--没有相关订单状态-->
      <c:if test="${empty purchaseOrderGroupList||fn:length(purchaseOrderGroupList)==0}">
        <div class="no-order ae">
          <div class="top ae">
            <div class="txt">
              <p>您还没有相关订单</p>
              <p>有很多商品等着你呢，快去看看吧</p>
              <i class="bgpic"></i>
            </div>
          </div>
          <div class="b-btn"><a href="#" class="btn">去逛逛</a></div>
        </div>
      </c:if>
      </div>
    <div class="od-tab1" title="待发货" style="display: none">
      <c:if test="${not empty purchaseOrderGroupList5&&fn:length(purchaseOrderGroupList5)>0}">
      <ul class="product ae">
          <c:forEach items="${purchaseOrderGroupList5}" var="purchaseOrderGroup5">
          <li>
          <div class="top">
            <span>${purchaseOrderGroup5.purchaseOrder.purchaseOrderProductList.get(0).productModel.product.name}${purchaseOrderGroup5.purchaseOrder.purchaseOrderProductList.get(0).productModel.name}</span>
            <i class=" pq"></i>
            <span>待发货</span>
          </div>
          <div class="center ae">
            <div class="pic"><a href="<c:url value="/product/groupProduct/${purchaseOrderGroup5.group.groupProduct.id}"/>"><img src="http://pro.efeiyi.com/${purchaseOrderGroup5.purchaseOrder.purchaseOrderProductList.get(0).productModel.productModel_url}@!group-mobile-picture-list"></a></div>
            <div class="txt ae"><p>交易金额：${purchaseOrderGroup5.purchaseOrder.total}元</p>
              <c:if test="${purchaseOrderGroup5.group.status==1||purchaseOrderGroup5.group.status==5}">
                <p>返回红包：0元</p>
              </c:if>
              <c:if test="${purchaseOrderGroup5.group.status==3}">
                <p>返回红包：${purchaseOrderGroup5.member.redPacket}元</p>
              </c:if>
            </div>
          </div>
          <div class="bottom ae">
            <c:if test="${purchaseOrderGroup5.member.level==0}">
            <div class="left">身份:团长</div>
            </c:if>
            <c:if test="${purchaseOrderGroup5.member.level!=0}">
              <div class="left">身份:团员</div>
            </c:if>
          </div>
        </li>
          </c:forEach>
      </ul>
      </c:if>
      <c:if test="${empty purchaseOrderGroupList5||fn:length(purchaseOrderGroupList5)==0}">
      <div class="no-order ae">
        <div class="top ae">
          <div class="txt">
            <p>您还没有相关订单</p>
            <p>有很多商品等着你呢，快去看看吧</p>
            <i class="bgpic"></i>
          </div>
        </div>
        <div class="b-btn"><a href="#" class="btn">去逛逛</a></div>
      </div>
      </c:if>
    </div>
    <div class="od-tab1" title="待收货"  style="display: none">
      <c:if test="${not empty purchaseOrderGroupList7&&fn:length(purchaseOrderGroupList7)>0}">
      <ul class="product ae">
        <c:forEach items="${purchaseOrderGroupList7}" var="purchaseOrderGroup7">
        <li>
          <div class="top">
            <span>${purchaseOrderGroup7.purchaseOrder.purchaseOrderProductList.get(0).productModel.product.name}${purchaseOrderGroup7.purchaseOrder.purchaseOrderProductList.get(0).productModel.name}</span>
            <i class=" pq"></i>
            <span>待收货</span>
          </div>
          <div class="center ae">
            <div class="pic"><a href="<c:url value="/product/groupProduct/${purchaseOrderGroup7.group.groupProduct.id}"/>"><img src="http://pro.efeiyi.com/${purchaseOrderGroup7.purchaseOrder.purchaseOrderProductList.get(0).productModel.productModel_url}@!group-mobile-picture-list"></a></div>
            <div class="txt ae"><p>交易金额：${purchaseOrderGroup7.purchaseOrder.total}元</p>
              <c:if test="${purchaseOrderGroup7.group.status==1||purchaseOrderGroup7.group.status==5}">
                <p>返回红包：0元</p>
              </c:if>
              <c:if test="${purchaseOrderGroup7.group.status==3}">
                <p>返回红包：${purchaseOrderGroup7.member.redPacket}元</p>
              </c:if>
            </div>
          </div>
          <div class="bottom ae">
            <c:if test="${purchaseOrderGroup7.member.level==0}">
              <div class="left">身份:团长</div>
            </c:if>
            <c:if test="${purchaseOrderGroup7.member.level!=0}">
              <div class="left">身份:团员</div>
            </c:if>
            <%--<ul class="right">--%>
              <%--<!--状态-->--%>
              <%--<li><a href="#">追加评价</a></li>--%>
              <%--<li><a href="#">查看物流</a></li>--%>
            <%--</ul>--%>
          </div>
        </li>
        </c:forEach>
        </c:if>
      </ul>
        <c:if test="${empty purchaseOrderGroupList7||fn:length(purchaseOrderGroupList7)==0}">
          <div class="no-order ae">
            <div class="top ae">
              <div class="txt">
                <p>您还没有相关订单</p>
                <p>有很多商品等着你呢，快去看看吧</p>
                <i class="bgpic"></i>
              </div>
            </div>
            <div class="b-btn"><a href="#" class="btn">去逛逛</a></div>
          </div>
        </c:if>
    </div>
    <div class="od-tab1" title="待评价"  style="display: none">
      <!--没有相关订单状态-->
      <c:if test="${not empty purchaseOrderGroupList9&&fn:length(purchaseOrderGroupList9)>0}">
      <ul class="product ae">
        <c:forEach items="${purchaseOrderGroupList9}" var="purchaseOrderGroup9">
          <li>
            <div class="top">
              <span>${purchaseOrderGroup9.purchaseOrder.purchaseOrderProductList.get(0).productModel.product.name}${purchaseOrderGroup9.purchaseOrder.purchaseOrderProductList.get(0).productModel.name}</span>
              <i class=" pq"></i>
              <span>交易成功</span>
            </div>
            <div class="center ae">
              <div class="pic"><a href="<c:url value="/product/groupProduct/${purchaseOrderGroup9.group.groupProduct.id}"/>"><img src="http://pro.efeiyi.com/${purchaseOrderGroup9.purchaseOrder.purchaseOrderProductList.get(0).productModel.productModel_url}@!group-mobile-picture-list"></a></div>
              <div class="txt ae"><p>交易金额：${purchaseOrderGroup9.purchaseOrder.total}元</p>
                <c:if test="${purchaseOrderGroup9.group.status==1||purchaseOrderGroup9.group.status==5}">
                  <p>返回红包：0元</p>
                </c:if>
                <c:if test="${purchaseOrderGroup9.group.status==3}">
                  <p>返回红包：${purchaseOrderGroup9.member.redPacket}元</p>
                </c:if>
              </div>
            </div>
            <div class="bottom ae">
              <c:if test="${purchaseOrderGroup9.member.level==0}">
                <div class="left">身份:团长</div>
              </c:if>
              <c:if test="${purchaseOrderGroup9.member.level!=0}">
                <div class="left">身份:团员</div>
              </c:if>
                <%--<ul class="right">--%>
                <%--<!--状态-->--%>
                <%--<li><a href="#">追加评价</a></li>--%>
                <%--<li><a href="#">查看物流</a></li>--%>
                <%--</ul>--%>
            </div>
          </li>
        </c:forEach>
      </ul>
      </c:if>
      <c:if test="${empty purchaseOrderGroupList9&&fn:length(purchaseOrderGroupList9)==0}">
      <div class="no-order ae">
        <div class="top ae">
          <div class="txt">
            <p>您还没有相关订单</p>
            <p>有很多商品等着你呢，快去看看吧</p>
            <i class="bgpic"></i>
          </div>
        </div>
        <div class="b-btn"><a href="#" class="btn">去逛逛</a></div>
      </div>
      </c:if>
    </div>
    <!--没有相关订单状态-->
  </div>
</div>
<!--//End--footer-->

<!--[if (gte IE 9)|!(IE)]><!-->
<script src="<c:url value="/scripts/wap/js/jquery.min.js"/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script src="<c:url value="/scripts/wap/js/amazeui.min.js"/>"></script>
<!--自定义js--Start-->
<script src="<c:url value="/scripts/wap/js/system.js?v=20150831"/>"></script>
<script src="<c:url value="/scripts/wap/js/myorder.js?v=20150831"/>"></script>
<!--自定义js--End-->
</body>
</html>