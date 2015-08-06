<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Jia Yankun
  Date: 2015/7/9
  Time: 16:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title></title>
  <script type="text/javascript" src="<c:url value='/scripts/jquery-1.11.1.min.js'/>"></script>
  <script type="text/javascript" >
    function orderView(o){
      var orderId = $(o).next().val();
      window.location.href="/order.xml/getOrder.do?id="+orderId;
    }
  </script>
</head>
<body>
  <table border="1">

    <tr>
      <td>${cart.id}</td>
    </tr>
      <c:forEach items="${cart.cartProductList}" var="list">
        <tr>
          <td>
        ${list.productModel.product.name}
          </td>
        </tr>
      </c:forEach>

  </table>
</body>
</html>
