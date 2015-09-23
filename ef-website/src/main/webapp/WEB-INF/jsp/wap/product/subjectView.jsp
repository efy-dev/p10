<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
  <title>${subject.name}</title>
<body>
<artice class="custom">
  <div class="bd list-class">
    <ul class="ul-list-img">
      <li><img src="http://pro.efeiyi.com/${subject.pictureUrl}" alt=""/></li>
      <li><p>${subject.subjectDescription.content}</p></li>
    </ul>
    <ul class="ul-list">
      <c:forEach items="${productModelList}" var="productModel">
        <li>
          <img src="http://pro.efeiyi.com/${productModel.productModel.productModel_url}" alt="">
          <p class="name">${productModel.productModel.product.name}</p>
          <p class="price red"><em>￥</em><span>${productModel.productModel.price}</span></p>
        </li>
      </c:forEach>
    </ul>
  </div>
</artice>
</body>
</html>