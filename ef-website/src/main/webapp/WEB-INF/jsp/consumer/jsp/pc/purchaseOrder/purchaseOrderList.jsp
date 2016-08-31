<%@ page import="com.ming800.core.p.PConst" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
  <script>

    function func(o){
      window.location.href="<c:url value="/order/myEfeiyi/list.do?status="/>"+o;
    }
  </script>
</head>
<body>
<!-- //End--header-->
<!--content-->
<c:if test="${empty orderList}">
  <div class="layout-col">
    <div class="mt wh1">
      <div class="extra-l">
        <strong>我的订单</strong>
        <a href="#" onclick="func(0)">全部订单</a>
        <a href="#" onclick="func(1)">待付款</a>
        <a href="#" onclick="func(5)">待收货</a>
        <a href="#" onclick="func(13)">已完成</a>
        <a href="#" onclick="func(17)">订单回收站</a>
        <strong style="font-size: 22px"><small>客服电话:</small> 400-876-8766</strong>
      </div>
    </div>
    <!-- //End--mt-->
    <div class="title wh1">
      <table>
        <tr>
          <th width="237">商品名称</th>
          <th width="174">单价</th>
          <th width="107">数量</th>
          <th width="100">总计</th>
          <th width="130">交易状态</th>
          <th width="139">操作</th>
        </tr>
        <tr style="border-top: 1px solid #ccc">
          <td colspan="6">
            <div class="mt-null">
              <p>目前还没有订单，现在开启您的购物之旅吧！</p>
              <ul>
                <li class="efeiyi"><a href="<%=PConst.HOSTNAME%>">e飞蚁首页</a></li>
              </ul>
            </div>
          </td>
        </tr>
      </table>
    </div>
    <!-- //End--title-->
  </div>
  </div>
  </div>

</c:if>
<c:if test="${!empty orderList}">
  <div class="layout-col">
    <div class="mt wh1">
      <div class="extra-l">
        <strong>我的订单</strong>
        <a href="#" onclick="func(0)">全部订单</a>
        <a href="#" onclick="func(1)">待付款</a>
        <a href="#" onclick="func(5)">待收货</a>
        <a href="#" onclick="func(13)">已完成</a>
        <a href="#" onclick="func(17)">订单回收站</a>
        <strong style="font-size: 22px"><small>客服电话:</small> 400-876-8766</strong>
      </div>

    </div>
    <div class="title wh1">
      <table>
        <tr>
          <th width="237">商品名称</th>
          <th width="174">单价</th>
          <th width="107">数量</th>
          <th width="100">总计</th>
          <th width="130">交易状态</th>
          <th width="139">操作</th>
        </tr>
      </table>
    </div>
    <!-- //End--title-->
      <%--<div class="list-pro wh1">--%>
      <%--<table></table>--%>
      <%--</div>--%>
    <div class="list-pro wh1" id="orderNum">
      <c:forEach items="${orderList}" var="order">
        <c:if test="${order.orderStatus==1 || order.orderStatus==17}">
          <table class="list-pro-table">
            <tr>
              <th colspan="6">
              <span>
              <fmt:formatDate value="${order.createDatetime}" pattern="yyyy-MM-dd H:mm:ss" />
              </span>
                <span>订单号：<strong>${order.serial}</strong></span>
                <span>${order.tenant.name}</span>
              </th>
            </tr>
            <tr>
              <td width="618">
                <c:forEach  items="${order.purchaseOrderProductList}" var="op">
                  <table class="item">
                    <td width="237">
                      <div class="cols1">
                        <a href="<%=PConst.HOSTNAME%>/product/productModel/${op.productModel.id}" target=_blank><img src="http://pro.efeiyi.com/${op.productModel.productModel_url}@!product-icon" alt=""></a>
                        <div class="info">
                          <a href="<%=PConst.HOSTNAME%>/product/productModel/${op.productModel.id}" target=_blank><p>${op.productModel.product.project.projectCategory.name}</p>
                            <p>${op.productModel.product.name}
                              <c:if test="${op.productModel.product.productModelList.size()>1}">
                                [${op.productModel.name}]
                              </c:if>

                            </p></a>
                        </div>
                      </div>
                    </td>
                    <td width="174">￥${op.purchasePrice}</td>
                    <td width="107">x<span>${op.purchaseAmount}</span></td>
                    <td width="100">
                      <p>￥${op.purchasePrice * op.purchaseAmount}</p>
                      <ming800:status name="payWay" dataType="PurchaseOrder.payWay" checkedValue="${order.payWay}" type="normal"/>
                    </td>
                  </table>
                </c:forEach>
              </td>
              <td class="rowspan" width="130" rowspan='2' style="border-left:1px solid #ccc;">
                <p>
                  <ming800:status name="orderStatus" dataType="PurchaseOrder.orderStatus" checkedValue="${order.orderStatus}" type="normal"/>
                </p>
              </td>
              <c:if test="${order.orderStatus == 1}">
              <td class="rowspan" width="139" rowspan='2' style="border-left:1px solid #ccc;border-right:1px solid #ccc">
                <p><a href="<c:url value="/order/myEfeiyi/view/${order.id}"/>">查看</a></p>
                <p><a href="<%=PConst.HOSTNAME%>/order/pay/${order.id}">付款</a></p>
                <p><a href="#" onclick="showConfirm('提示','是否删除订单',function(){
                        window.location.href='<c:url value="/order/cancelOrder/${order.id}"/>';
                        })">删除订单</a></p>
              </td>
            </c:if>
              <c:if test="${order.orderStatus == 17}">
                <td class="rowspan" width="139" rowspan='2' style="border-left:1px solid #ccc;border-right:1px solid #ccc">
                  <p><a href="<c:url value="/order/myEfeiyi/view/${order.id}"/>">查看</a></p>
                  <p><a href="<c:url value="/order/deleteOrder/${order.id}"/>">彻底删除</a></p>
                </td>
              </c:if>
            </tr>
          </table>
        </c:if>

        <c:if test="${ order.orderStatus!=1 && order.orderStatus!=17}">
          <c:if test="${order.subPurchaseOrder==null || order.subPurchaseOrder.size()==0}">
            <table class="list-pro-table">
              <tr>
                <th colspan="6">
              <span>
              <fmt:formatDate value="${order.createDatetime}" pattern="yyyy-MM-dd H:mm:ss" />
              </span>
                  <span>订单号：<strong>${order.serial}</strong></span>
                  <span>${order.tenant.name}</span>
                </th>
              </tr>
              <tr>
                <td width="618">
                  <c:forEach  items="${order.purchaseOrderProductList}" var="op">
                    <table class="item">
                      <td width="237">
                        <div class="cols1">
                          <a href="<%=PConst.HOSTNAME%>/product/productModel/${op.productModel.id}" target=_blank><img src="http://pro.efeiyi.com/${op.productModel.productModel_url}@!product-icon" alt=""></a>
                          <div class="info">
                            <a href="<%=PConst.HOSTNAME%>/product/productModel/${op.productModel.id}" target=_blank><p>${op.productModel.product.project.projectCategory.name}</p>
                              <p>${op.productModel.product.name}
                                <c:if test="${op.productModel.product.productModelList.size()>1}">
                                  [${op.productModel.name}]
                                </c:if>
                              </p></a>

                          </div>
                        </div>
                      </td>
                      <td width="174">￥${op.purchasePrice}</td>
                      <td width="107">x<span>${op.purchaseAmount}</span></td>
                      <td width="100">
                        <p>￥${op.purchasePrice * op.purchaseAmount}</p>
                        <ming800:status name="payWay" dataType="PurchaseOrder.payWay" checkedValue="${order.payWay}" type="normal"/>
                      </td>
                    </table>
                  </c:forEach>
                </td>
                <td class="rowspan" width="130" rowspan='2' style="border-left:1px solid #ccc;">
                  <p>
                    <ming800:status name="orderStatus" dataType="PurchaseOrder.orderStatus" checkedValue="${order.orderStatus}" type="normal"/>
                  </p>
                </td>
                <c:if test="${order.orderStatus == 6}">
                  <td class="rowspan" width="139" rowspan='2' style="border-left:1px solid #ccc;border-right:1px solid #ccc">
                    <p><a href="<c:url value="/order/myEfeiyi/view/${order.id}"/>">查看</a></p>
                  </td>
                </c:if>
                <c:if test="${order.orderStatus == 15}">
                  <td class="rowspan" width="139" rowspan='2' style="border-left:1px solid #ccc;border-right:1px solid #ccc">
                    <p><a href="<c:url value="/order/myEfeiyi/view/${order.id}"/>">查看</a></p>
                    <p><a href="#" onclick="showConfirm('提示','是否删除订单',function(){
                            window.location.href='<c:url value="/order/cancelOrder/${order.id}"/>';
                            })">删除订单</a></p>                  </td>
                </c:if>
                <c:if test="${order.orderStatus == 3}">
                  <td class="rowspan" width="139" rowspan='2' style="border-left:1px solid #ccc;border-right:1px solid #ccc">
                    <p><a href="<c:url value="/order/myEfeiyi/view/${order.id}"/>">查看</a></p>
                  </td>
                </c:if>
                <c:if test="${order.orderStatus == 5}">
                  <td class="rowspan" width="139" rowspan='2' style="border-left:1px solid #ccc;border-right:1px solid #ccc">
                    <p><a href="<c:url value="/order/myEfeiyi/view/${order.id}"/>">查看</a></p>
                  </td>
                </c:if>
                <c:if test="${order.orderStatus == 7}">
                  <td class="rowspan" width="139" rowspan='2' style="border-left:1px solid #ccc;border-right:1px solid #ccc">
                    <p><a href="<c:url value="/order/myEfeiyi/view/${order.id}"/>">查看</a></p>

                    <p><a href="#" onclick="showConfirm('提示','是否确定收货',function(){
                            window.location.href='<c:url value="/order/confirmGet/${order.id}"/>';
                            })">确定收货</a></p>
                  </td>
                </c:if>

                <c:if test="${order.orderStatus == 13}">
                  <td class="rowspan" width="139" rowspan='2' style="border-left:1px solid #ccc;border-right:1px solid #ccc">
                    <p><a href="<c:url value="/order/myEfeiyi/view/${order.id}"/>">查看</a></p>
                    <p><a href="#" onclick="showConfirm('提示','是否删除订单',function(){
                            window.location.href='<c:url value="/order/cancelOrder/${order.id}"/>';
                            })">删除订单</a></p>
                  </td>
                </c:if>
                <c:if test="${order.orderStatus == 9}">
                  <td class="rowspan" width="139" rowspan='2' style="border-left:1px solid #ccc;border-right:1px solid #ccc">
                    <p><a href="<c:url value="/comment/finishOrderList.do"/>">去评价</a></p>
                    <p><a href="#" onclick="showConfirm('提示','是否删除订单',function(){
                            window.location.href='<c:url value="/order/cancelOrder/${order.id}"/>';
                            })">删除订单</a></p>
                  </td>
                </c:if>
                <c:if test="${order.orderStatus == 51}">
                  <td class="rowspan" width="139" rowspan='2' style="border-left:1px solid #ccc;border-right:1px solid #ccc">
                    <p><a href="<c:url value="/order/myEfeiyi/view/${order.id}"/>">查看</a></p>
                  </td>
                </c:if>
              </tr>
            </table>
          </c:if>
        </c:if>

        <c:if test="${order.orderStatus!=1 && order.orderStatus!=17}">
          <c:if test="${order.subPurchaseOrder!=null || order.subPurchaseOrder.size()>0}">
            <c:forEach items="${order.subPurchaseOrder}" var="spList">

              <table class="list-pro-table">
                <tr>
                  <th colspan="6">
              <span>
              <fmt:formatDate value="${spList.createDatetime}" pattern="yyyy-MM-dd H:mm:ss" />
              </span>
                    <span>订单号：<strong>${spList.serial}</strong></span>
                    <span>${spList.tenant.name}</span>
                  </th>
                </tr>
                <tr>
                  <td width="618">
                    <c:forEach  items="${spList.purchaseOrderProductList}" var="op">
                      <table class="item">
                        <td width="237">
                          <div class="cols1">
                            <a href="<%=PConst.HOSTNAME%>/product/productModel/${op.productModel.id}" target=_blank><img src="http://pro.efeiyi.com/${op.productModel.productModel_url}@!product-icon" alt=""></a>
                            <div class="info">
                              <a href="<%=PConst.HOSTNAME%>/product/productModel/${op.productModel.id}" target=_blank><p>${op.productModel.product.project.projectCategory.name}</p>
                                <p>${op.productModel.product.name}
                               <c:if test="${op.productModel.product.productModelList.size()>1}">
                                  [${op.productModel.name}]
                                </c:if>
                                </p>
                              </a>

                            </div>
                          </div>
                        </td>
                        <td width="174">￥${op.purchasePrice}</td>
                        <td width="107">x<span>${op.purchaseAmount}</span></td>
                        <td width="100">
                          <p>￥${op.purchasePrice * op.purchaseAmount}</p>
                          <ming800:status name="payWay" dataType="PurchaseOrder.payWay" checkedValue="${order.payWay}" type="normal"/>
                        </td>
                      </table>
                    </c:forEach>
                  </td>
                  <td class="rowspan" width="130" rowspan='2' style="border-left:1px solid #ccc;">
                    <p>
                      <ming800:status name="orderStatus" dataType="PurchaseOrder.orderStatus" checkedValue="${spList.orderStatus}" type="normal"/>
                    </p>
                  </td>
                  <c:if test="${order.orderStatus == 6}">
                    <td class="rowspan" width="139" rowspan='2' style="border-left:1px solid #ccc;border-right:1px solid #ccc">
                      <p><a href="<c:url value="/order/myEfeiyi/view/${spList.id}"/>">查看</a></p>
                    </td>
                  </c:if>
                  <c:if test="${order.orderStatus == 15}">
                    <td class="rowspan" width="139" rowspan='2' style="border-left:1px solid #ccc;border-right:1px solid #ccc">
                      <p><a href="<c:url value="/order/myEfeiyi/view/${order.id}"/>">查看</a></p>
                      <p><a href="#" onclick="showConfirm('提示','是否删除订单',function(){
                              window.location.href='<c:url value="/order/cancelOrder/${spList.id}"/>';
                              })">删除订单</a></p>
                    </td>
                  </c:if>
                  <c:if test="${order.orderStatus == 3}">
                    <td class="rowspan" width="139" rowspan='2' style="border-left:1px solid #ccc;border-right:1px solid #ccc">
                      <p><a href="<c:url value="/order/myEfeiyi/view/${spList.id}"/>">查看</a></p>
                    </td>
                  </c:if>
                  <c:if test="${spList.orderStatus == 5}">
                    <td class="rowspan" width="139" rowspan='2' style="border-left:1px solid #ccc;border-right:1px solid #ccc">
                      <p><a href="<c:url value="/order/myEfeiyi/view/${spList.id}"/>">查看</a></p>
                    </td>
                  </c:if>
                  <c:if test="${spList.orderStatus == 7}">
                    <td class="rowspan" width="139" rowspan='2' style="border-left:1px solid #ccc;border-right:1px solid #ccc">
                      <p><a href="<c:url value="/order/myEfeiyi/view/${spList.id}"/>">查看</a></p>

                      <p><a href="#" onclick="showConfirm('提示','是否确定收货',function(){
                              window.location.href='<c:url value="/order/confirmGet/${spList.id}"/>';
                              })">确定收货</a></p>
                    </td>
                  </c:if>

                  <c:if test="${spList.orderStatus == 13}">
                    <td class="rowspan" width="139" rowspan='2' style="border-left:1px solid #ccc;border-right:1px solid #ccc">
                      <p><a href="<c:url value="/order/myEfeiyi/view/${spList.id}"/>">查看</a></p>
                      <p><a href="#" onclick="showConfirm('提示','是否删除订单',function(){
                              window.location.href='<c:url value="/order/cancelOrder/${spList.id}"/>';
                              })">删除订单</a></p>
                    </td>
                  </c:if>
                  <c:if test="${spList.orderStatus == 9}">
                    <td class="rowspan" width="139" rowspan='2' style="border-left:1px solid #ccc;border-right:1px solid #ccc">
                      <p><a href="<c:url value="/comment/finishOrderList.do"/>">去评价</a></p>
                      <p><a href="#" onclick="showConfirm('提示','是否删除订单',function(){
                              window.location.href='<c:url value="/order/cancelOrder/${spList.id}"/>';
                              })">删除订单</a></p>
                    </td>
                  </c:if>
                  <c:if test="${spList.orderStatus == 51}">
                    <td class="rowspan" width="139" rowspan='2' style="border-left:1px solid #ccc;border-right:1px solid #ccc">
                      <p><a href="<c:url value="/order/myEfeiyi/view/${order.id}"/>">查看</a></p>
                    </td>
                  </c:if>
                </tr>
              </table>
            </c:forEach>
          </c:if>
        </c:if>
      </c:forEach>
    </div>
  </div>

  </div>

  <style>

  </style>


  <ming800:pcPageList bean="${pageEntity}" url="${pageContext.request.contextPath}/order/myEfeiyi/list.do">
    <ming800:pcPageParam name="conditions"
                         value='<%=request.getParameter("conditions")!=null ? request.getParameter("conditions") : ""%>'/>
    <ming800:pcPageParam name="status"
                         value='<%=request.getParameter("status")!=null ? request.getParameter("status") : ""%>'/>
  </ming800:pcPageList>
</c:if>

</body>
</html>