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
<html>
<head>
  <title>企业礼品卡批次信息</title>
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
      <label name="giverName" for="giverName" class="am-u-sm-3 am-form-label">送礼人名称<small>&nbsp;&nbsp;</small></label>
      <div class="am-u-sm-9">
        <input type="text" id="giverName" name="giverName" title="送礼人名称" placeholder="送礼人名称"
               value="${object.giverName}">
      </div>
    </div>
    <div class="am-form-group">
      <label name="productModelId" for="productModelName" class="am-u-sm-3 am-form-label">礼品名称<small>*</small></label>
      <div class="am-u-sm-9">
        <input type="hidden" name="productModel.id" id="productModelId" title="礼品名称"
               placeholder="礼品名称" value="${object.productModel.id}" required="true">
        <input type="text" name="productModelName" id="productModelName" title="礼品名称"
               placeholder="礼品名称" data-am-modal="{target: '#selProductModel'}" readonly
               value="${object.productModel.product.name}<c:if test="${not empty object.productModel}">[${object.productModel.name}]</c:if>" >
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
      <label for="message" class="am-u-sm-3 am-form-label">祝福语<small>&nbsp;&nbsp;</small></label>
      <div class="am-u-sm-9">
        <textarea name="message" id="message" title="祝福语" placeholder="祝福语">${object.message}</textarea>
      </div>
    </div>
    <div class="am-form-group">
      <div class="am-u-sm-9 am-u-sm-push-3">
        <input type="submit" class="am-btn am-btn-primary" value="保存"/>
      </div>
    </div>

  </form>
</div>

<div class="am-popup" id="selProductModel" style="height: 550px">
  <div class="am-popup-inner">
    <div class="am-popup-hd">
      <h4 class="am-popup-title">选择商品</h4>
      <span data-am-modal-close class="am-close">&times;</span>
    </div>
    <div class="am-popup-bd" style="height: 10px">
      <input type="text" name="selProductModel"  style="float: left" placeholder="编号或名称" value=""/>
      <a style="width: 10%;float: left;margin-left: 10px;"
         class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
         href="javascript:void(0);" onclick="selProductModel()">查找
      </a>
    </div>
    <div class="am-popup-bd" style="height: 420px">
      <table class="am-table am-table-bd am-table-bdrs am-table-striped am-table-hover">
        <tr>
          <td class="am-text-center" width="4%">操作</td>
          <th class="am-text-center" width="8%">规格编号</th>
          <th class="am-text-center" width="17%">规格名称</th>
        </tr>
      </table>
      <div style="height: 350px; overflow-y: auto;">
        <table class="am-table am-table-bd am-table-bdrs am-table-striped am-table-hover"
               id="productModelTable">
          <tbody>
          <c:forEach var="productModel" items="${productModelList}">
            <tr name="${productModel.name}" serial="${productModel.serial}">
              <td align="center" width="13%">
                <a style="width: 10%;"
                   class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                   href="javascript:void(0);" onclick="selectProductModel('${productModel.id}','${productModel.product.name}<c:if test="${not empty productModel}">[${productModel.name}]</c:if>')">
                  选择
                </a>
              </td>
              <td class="am-text-center" width="33%">${productModel.serial}</td>
              <td class="am-text-center" width="53%">
                ${productModel.product.name}
                  <c:if test="${not empty productModel}">
                    [${productModel.name}]
                  </c:if>
              </td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<script>
  function selProductModel(){
    var v = $("input[name='selProductModel']").val();
    if(v==""){
      $("#productModelTable tr:gt(0)").each(function(){
        $(this).show();
      });
    }else {
      $("#productModelTable tr:gt(0)").each(function () {
        if ($(this).attr("name").indexOf(v)!=-1 || $(this).attr("serial").indexOf(v) != -1 ) {
          $(this).show();
        } else {
          $(this).hide();
        }
      });
    }
  }
  function selectProductModel(id,name){
    $("#productModelId").val(id);
    $("#productModelName").val(name);
    $("#selProductModel").modal('close');
  }
</script>

</body>
</html>
