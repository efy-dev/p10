<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/25
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>

<html>
<head>
  <title></title>
  <script type="text/javascript" src="<c:url value='/scripts/recommended.js'/>"></script>
  <script>
    function removeTenant(divId){
      $.ajax({
        type: "get",
        url: '<c:url value="/basic/xmj.do?qm=removeTenant"/>',
        cache: false,
        dataType: "json",
        data:{id:divId},
        success: function (data) {
          $("#"+divId).remove();
        }
      });
    }
  </script>
</head>
<body>
<div style="text-align: left;margin-bottom: 10px">
  <a type="button" class="am-btn am-btn-default am-btn-xs" href="<c:url value="/basic/xm.do?qm=viewTenantCategory&id=${tenantCategoryId}&tenantId=${tenantId}"/>"><span class="am-icon-plus"></span>返回</a>
</div>

<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions};tenant.id:${tenantId}&tenantCategoryId=${tenantCategoryId}&tenantId=${tenantId}"/>

<div class="admin-content">
  <div class="am-g">
    <input name="tenantCategoryId" type="hidden" value="${tenantCategoryId}">
    <div class="am-u-sm-12">
      <table class="am-table am-table-striped am-table-hover table-main">
        <thead>
        <tr>
          <th class="table-set" width="20%">操作</th>
          <th class="table-title"  width="40%">商品名称</th>
          <th class="table-title" width="40%">商品编号</th>
        </tr>
        </thead>
        <tbody>

        <c:forEach items="${requestScope.pageInfo.list}" var="product">
          <tr >
            <td>
              <div class="am-btn-toolbar">
                <div class="am-btn-group am-btn-group-xs">
                  <a  id="${product.id}" tenantProductId="0" class="am-btn am-btn-default am-btn-xs am-text-secondary" status="0" href="javascript:void(0);" onclick="linkProduct(this,'${product.id}');"><span
                          class="am-icon-pencil-square-o">添加商品</span>
                  </a>
                </div>
              </div>
            </td>
            <td class="am-hide-sm-only">
                ${product.name}
            </td>
            <td class="am-hide-sm-only">
                ${product.serial}
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>
  </div>
  <div style="clear: both">
    <c:url value="/basic/xm.do" var="url"/>
    <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
      <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
      <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
      <ming800:pcPageParam name="tenantCategoryId" value="${tenantCategoryId}"/>
      <ming800:pcPageParam name="tenantId" value="${tenantId}"/>
    </ming800:pcPageList>
  </div>
</div>
<script>
  $(function(){

    <c:forEach var="tenantProduct" items="${tenantProductTagList}">
    var productId = '${tenantProduct.product.id}';
    if(${tenantProduct.status == '1'}){
      $("#"+productId).attr("status","1");
      $("#"+productId).find("span").text("移除商品");
    }

    $("#"+productId).attr("tenantProductId",'${tenantProduct.id}')

    </c:forEach>

  });
  function linkProduct(obj,productId){

    var tenantCategoryId = $("input[name='tenantCategoryId']").val();
    var tenantProductId = $(obj).attr("tenantProductId");
    var status = $(obj).attr("status");
    var  context = "确认移除商品?。";
    if(status=="0") {
      context = "确认关联?";
    }
    var r=confirm(context)
    if (r==true)
    {
      $.ajax({
        type: "get",
        url: '<c:url value="/tenant/linkProduct.do"/>',
        cache: false,
        dataType: "json",
        data:{tenantCategoryId:tenantCategoryId,productId:productId,tenantProductId:tenantProductId,status:status},
        success: function (data) {
          if(status == '0'){
            $(obj).attr("status","1");
            $(obj).find("span").text("移除商品");
            $(obj).attr("tenantProductId",data)
          }else{
            $(obj).attr("status","0");
            $(obj).find("span").text("添加商品");
            $(obj).attr("tenantProductId",data)
          }
//                $("a[status='1'] span").text("关联商家");
//                $("a[status='1']").attr("status",'0');
//                $(obj).find("span").text("解除商家");
//                $(obj).attr("status",'1');
        }
      });
    }



  }
</script>
</body>
</html>
