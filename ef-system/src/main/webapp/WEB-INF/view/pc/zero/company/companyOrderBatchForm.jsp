<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/12/14
  Time: 16:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%
  String path = request.getContextPath();
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path ;
%>
<html>
<head>
  <title>企业礼品卡批次信息</title>
  <script type="text/javascript" src="/scripts/function.js"></script>
</head>
<body>
<div class="am-cf am-padding">
  <div class="am-fl am-cf">
    <strong class="am-text-primary am-text-lg">企业礼品卡批次信息</strong>
  </div>
</div>
<hr/>
<div class="am-g">
  <form id="orderBatchForm" onsubmit="return afterSubmitForm2zero('orderBatchForm')"
        action="<c:url value='/basic/xm.do?qm=saveOrUpdateCompanyOrderBatch'/>"
        method="post" enctype="multipart/form-data" class="am-form am-form-horizontal">
    <input type="hidden" name="id" value="${object.id}">
    <input type="hidden" name="serial" value="${object.serial}"/>
    <input type="hidden" name="status" value="${object.status}"/>

    <div class="am-form-group">
      <label name="companyName" for="companyName" class="am-u-sm-3 am-form-label">企业用户名称<small>*</small></label>
      <div class="am-u-sm-9">
        <input type="text" id="companyName" name="companyName" title="企业用户名称" placeholder="企业用户名称"
               value="${object.companyName}" required="true">
      </div>
    </div>

    <div class="am-form-group">
      <label name="productModel_id" for="productModel_idName" class="am-u-sm-3 am-form-label">礼品名称<small>*</small></label>
      <div class="am-u-sm-9">
        <input type="text" id="productModel_idName" title="礼品名称" placeholder="礼品名称"
               onclick="m8uDialog.openDialog2zero('productModel_id','productModel_idName','productModel', '<%=basePath%>')"
               value="${object.productModel.product.name}<c:if test="${not empty object.productModel}">[${object.productModel.name}]</c:if>"
               required="true" readonly>
        <input type="hidden" id="productModel_id"  name="productModel.id" value="${object.productModel.id}">
      </div>
    </div>

    <div class="am-form-group">
      <label for="amount" class="am-u-sm-3 am-form-label">礼品卡数量<small>*</small></label>
      <div class="am-u-sm-9">
        <input type="number" min="1" name="amount" id="amount" title="礼品卡数量" placeholder="礼品卡数量"
               value="${object.amount}" required="true">
      </div>
    </div>

    <div class="am-form-group">
      <label for="message" class="am-u-sm-3 am-form-label">祝福语<small>*</small></label>
      <div class="am-u-sm-9">
        <textarea name="message" id="message" title="祝福语" placeholder="祝福语" required="true">${object.message}</textarea>
      </div>
    </div>

    <div class="am-form-group">
      <div class="am-u-sm-9 am-u-sm-push-3">
        <input type="submit" class="am-btn am-btn-primary" value="保存"/>
      </div>
    </div>

  </form>
</div>
</body>
</html>
