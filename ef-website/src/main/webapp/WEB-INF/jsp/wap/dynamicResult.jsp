<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${not empty searchParamBean.searchResultList}">
<ul class="ul-list">
  <%-- 数据显示 --%>
  <c:forEach items="${searchParamBean.searchResultList}" var="result">
    <li>
      <a href="http://192.168.1.57/ef-website/product/productModel/${result.id}" title="">
        <img src="http://ec-efeiyi.oss-cn-beijing.aliyuncs.com/${result.picture_url}" alt="">
        <p class="name">${result.product_name}<c:if test="${result.frequent != 1}">[${result.specification}]</c:if></p>
        <p class="price"><em>￥</em>${result.product_model_price}</p>
      </a>
    </li>
  </c:forEach>
</ul>
</c:if>