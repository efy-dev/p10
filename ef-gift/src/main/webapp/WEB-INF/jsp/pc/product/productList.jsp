<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/18
  Time: 16:15
  To change this template use File | Settings | File Templates.
--%>
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
    function ctrl(o){
      var pid = $(o).next().val();
      window.location=("/product/addProductFavorite.do?productId="+pid);
    }
  </script>
</head>
<body>
<h1>商品列表</h1>
<form name="product"  method="post">
  <table width="95%" align="center" cellpadding="10" cellspacing="0" border="1">
    <tr>
      <td width="40"><input type="checkbox" name="ctlbox" value="1"/></td>
      <td>商品名称</td>
      <td>查看详情</td>
      <td>收藏产品</td>
    </tr>
    <c:forEach items="${productList}" var="product" >
      <tr>
        <td><input type="checkbox"  value="1"/></td>
        <td><input type="text" name="productName" value="${product.name}"/></td>
        <td><input type="button" value="浏览" onclick="find(this);"><input type="hidden" id="productId" value="${product.id}"></td>
        <td><input type="button" value="收藏" onclick="ctrl(this);"><input type="hidden" id="Id" value="${product.id}"></td>
      </tr>
    </c:forEach>
  </table>
</form>
</body>
</html>
