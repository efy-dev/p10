<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/8
  Time: 17:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title></title>
  <script type="text/javascript" src="<c:url value='/META-INF/resources/resources/jquery/jquery-1.11.1.min.js'/>"></script>
  <script>
    function find(o){
      var pid = $(o).next().val();
      window.location.href="/product/getProduct.do?id="+pid;
    }
    function shop(o){
      var pid =$(o).next().val();
      window.location.href="/cart/addProduct.do?id="+pid;
    }
  </script>
</head>
<body>
<body>
<h1>商品列表</h1>
<form name="product"  method="post">
  <table width="95%" align="center" cellpadding="10" cellspacing="0" border="1">
    <tr>
      <td width="40"><input type="checkbox" name="ctlbox" value="1"/></td>
      <td>商品名称</td>
      <td>查看详情</td>
      <td>加入购物车</td>
    </tr>
    <c:forEach items="${productList}" var="product" >
      <tr>
        <td><input type="checkbox"  value="1"/></td>
        <td><input type="text" name="productName" value="${product.name}"/></td>
        <td>
          <input type="button" value="浏览" onclick="find(this);">
          <input type="hidden" id="productId" value="${product.id}">
        </td>

        <td>
          <input type="button" value="购买" onclick="shop(this);">
          <input type="hidden" id="id" value="${product.id}">
        </td>
      </tr>
    </c:forEach>
  </table>
</form>


<ming800:pcPageList bean="${pageEntity}" url="/product/productList.do">
  <%--<ming800:page-param2 name="qm" value="${requestScope.qm}"/>--%>
  <ming800:pcPageParam name="conditions"
                       value='<%=request.getParameter("conditions")!=null ? request.getParameter("conditions") : ""%>'/>
  <ming800:pcPageParam name="sort"
                       value='<%=request.getParameter("sort")!=null ? request.getParameter("sort") : ""%>'/>
</ming800:pcPageList>

</body>
</body>
</html>
