<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>地址管理</title>
</head>
<body>
<!--//End--header-->
<div class="manage">
  <div class="manage-list">
    <!--一个地址-->
    <!--一个地址-->
    <c:forEach items="${addressList}" var="address">
      <div class="list-one">
        <div class="head-list">
          <strong>${address.consignee}</strong>
          <span>${address.phone}</span>
        </div>
        <div class="content-list">
          <p>${address.province.name}${address.city.name}${address.district.name}${address.details}</p>
        </div>
        <ul class="botton-list">
          <li><a href="#"  onclick="showConfirm('提示','是否删除',function(){
                  window.location.href='<c:url value="/myEfeiyi/removeAddress.do?addressId=${address.id}"/>';
                  })">删除</a></li>

          <li><a href="<c:url value="/myEfeiyi/addAddressOfMobile.do?addressId=${address.id}"/>">编辑</a></li>
        </ul>
      </div>
    </c:forEach>
    <!--一个地址-->
  </div>
  <div class="edit-info">
    <a href="<c:url value="/myEfeiyi/addAddressOfMobile.do?addressId=null"/>">新增地址</a>
  </div>
</div>
</body>
</html>
