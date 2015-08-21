<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
</head>
<body>
<div class="am-cf am-padding">
  <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">新建/编辑商品</strong> / <small>New/Edit Product</small></div>
</div>
<hr/>

<div class="am-g">
  <form action="<c:url value="/basic/xm.do"/>" method="post"  class="am-form am-form-horizontal"  enctype="multipart/form-data">
    <input type="hidden" name="qm" value="saveOrUpdateProduct" />
    <input type="hidden" name="id" value="${object.id}">
    <input type="hidden" name="tenant.id" value="${tenantId}">
    <input type="hidden" name="resultPage" value="redirect:/basic/xm.do?qm=plistProduct_tenant&conditions=tenant.id:${tenantId} "/>
    <input type="hidden" name="status" value="1">
    <div class="am-form-group">
      <label name="serial" class="am-u-sm-3 am-form-label">商品编号</label>
      <div class="am-u-sm-9">
        <input type="text" name="serial" id="serial" placeholder="商品编号" value="${object.serial}">
        <!--<small>必填项*</small>-->
      </div>
    </div>
    <div class="am-form-group">
      <label name="name" class="am-u-sm-3 am-form-label">商品名称</label>
      <div class="am-u-sm-9">
        <input type="text" name="name" id="name" placeholder="商品名称" value="${object.name}">
        <!--<small>必填项*</small>-->
      </div>
    </div>

    <div class="am-form-group">
      <label name="price"  class="am-u-sm-3 am-form-label">价格</label>
      <div class="am-u-sm-9">
        <input type="text" name="price" id="price" placeholder="价格" value="${object.price}">
        <!-- <small>必填项*</small>-->
      </div>
    </div>
    <div class="am-form-group">
      <label name="createDate" class="am-u-sm-3 am-form-label">创建时间</label>
      <div class="am-u-sm-9">
        <div style="margin-top: 9px;">
          <fmt:formatDate value="${object.createDateTime}" type="both" pattern="YYYY-MM-dd HH:mm" />
        </div>
        <!-- <small>必填项*</small>-->
      </div>
    </div>

    <div class="am-form-group">
      <div class="am-u-sm-9 am-u-sm-push-3">
        <input type="submit" class="am-btn am-btn-primary" value="保存"/>
      </div>
    </div>
  </form>
</div>
<!-- content end -->
<hr/>



</body>
</html>
