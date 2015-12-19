<%@ page import="com.ming800.core.p.PConst" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head></head>
<body>
<!-- //End--header-->
<!--content-->

    <div class="layout-col">
      <div class="my-favorite">
        <!--收藏商品和收藏店铺-->
        <div class="my-goods">
          <ul class="favorite-category">
            <li><a href="#" class="fav-active">收藏的商品</a></li>
            <%--<li><a href="#">收藏的店铺</a></li>--%>
          </ul>
        </div>

        <div class="goods-list">
        <c:if test="${empty collectList}">
          <tr style="border-top: 1px solid #ccc">
            <td colspan="6">
              <div class="mt-null">
                <p>目前还没有收藏商品，挑几件您喜欢的商品吧！</p>
                <ul>
                  <li class="efeiyi"><a href="http://www.efeiyi.com/">e飞蚁首页</a></li>
                </ul>
              </div>
            </td>
          </tr>
          </c:if>
         <c:if test="${!empty collectList}">
          <ul class="list-number">
            <c:forEach items="${collectList}" var="collectList">
            <li class="single">
              <dl>
                <dt class="list-img"><a href="<%=PConst.HOSTNAME%>/product/productModel/${collectList.productModel.id}" target=_blank><img width="150"height="150" src="http://pro.efeiyi.com/${collectList.productModel.productModel_url}@!product-collect"></a></dt>
                <dd>
                  <dl class="list-title">
                    <%--<dt>--%>
                      <%--<label><input type="checkbox"></label>--%>
                    <%--</dt>--%>
                    <dd>
                      <p class="list-title-text"><a href="<%=PConst.HOSTNAME%>/product/productModel/${collectList.productModel.id}" style="color: #666;font-size: 12px;" target=_blank>${collectList.productModel.product.name}[${collectList.productModel.name}]</a>
                        <%--<c:if test="${collectList.productModel.productPropertyValueList.size()>1}">--%>
                        <%--[--%>
                        <%--<c:forEach items="${collectList.productModel.productPropertyValueList}"--%>
                                   <%--var="ppv">${ppv.projectPropertyValue.value}</c:forEach>--%>
                        <%--]--%>
                      <%--</c:if>--%>
                      </p>
                      <p class="list-cost">￥<span>${collectList.productModel.price}</span></p>
                      <ul class="list-option">
                        <li class="option-left"><a href="<c:url value="/purchaseCollect/unfollow.do?id=${collectList.id}"/>">取消关注</a></li>
                        <c:if test="${collectList.productModel.amount!=0}">
                        <li class="option-right"><a href="<%=PConst.HOSTNAME%>/cart/addProduct.do?id=${collectList.productModel.id}&amount=1"> 加入购物车</a></li>
                        </c:if>

                      </ul>
                    </dd>
                  </dl>
                </dd>
              </dl>
            </li>

            </c:forEach>
          </ul>
            <ming800:pcPageList bean="${pageEntity}" url="${pageContext.request.contextPath}/purchaseCollect/collectList.do">
              <ming800:pcPageParam name="conditions"
                                   value='<%=request.getParameter("conditions")!=null ? request.getParameter("conditions") : ""%>'/>
            </ming800:pcPageList>
          </c:if>

        </div>
      </div>
    </div>
  </div>
</div>

</body>
</html>