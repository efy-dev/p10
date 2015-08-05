<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <title>product</title>
  <script>
    function find(o){
      var pid = $(o).next().val();
      window.location=("/product/getProduct.do?id="+pid);
    }
  </script>
</head>
<body>
<h1>收货地址</h1>
<form name="address"  method="post">
  <table width="95%" align="center" cellpadding="10" cellspacing="0" border="1">
    <c:forEach items="${addressList}" var="address" >
      <tr>
        <td><input type="text" name="productName" value="${address.phone}"/></td>
        <td><input type="text" name="productName" value="${address.phone}"/></td>
        <td><input type="text" name="productName" value="${address.phone}"/></td>
        <td><input type="text" name="productName" value="${address.phone}"/></td>
      </tr>
    </c:forEach>
  </table>
</form>
</body>
</html>
