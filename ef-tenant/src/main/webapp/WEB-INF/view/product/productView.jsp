<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title></title>
   <link href="<c:url value="/scripts/upload/uploadify.css"/>" rel="stylesheet"/>
  <style>

  </style>
</head>
<body>
<div class="am-cf am-padding">
  <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">商品详情</strong> / <small>Product Details</small></div>
</div>
<hr/>

<div class="am-g">
    <form action="<c:url value="/product/saveNewProduct.do"/>" method="post" class="am-form am-form-horizontal">
        <input type="hidden" name="resultPage" value="0" />
        <input type="hidden" name="step" value="view">
      <div class="am-form-group">
          <label name="serial" class="am-u-sm-3 am-form-label">商品编号</label>

          <div class="am-u-sm-9">
              ${object.serial}
          </div>
      </div>
      <div class="am-form-group">
          <label name="name" class="am-u-sm-3 am-form-label">商品名称</label>

          <div class="am-u-sm-9">
              ${object.name}
              <!--<small>必填项*</small>-->
          </div>
      </div>

      <div class="am-form-group">
          <label name="price" class="am-u-sm-3 am-form-label">商品价格</label>

          <div class="am-u-sm-9">
              ${object.price}
          </div>
      </div>
      <div class="am-form-group">
          <label name="serial" class="am-u-sm-3 am-form-label">商品类型</label>

          <div class="am-u-sm-9" style="margin-top: 10px;">
                     <c:if test="${object.status=='1'}">
                         收藏品
                     </c:if>
                        <c:if test="${object.status=='2'}">
                            精品
                        </c:if>
              <!--<small>必填项*</small>-->
          </div>
      </div>
      <div class="am-form-group">
          <label name="masterList" class="am-u-sm-3 am-form-label">大师</label>
          <div class="am-u-sm-9" style="margin-top: 10px;">
               ${object.master.fullName}
              <!--<small>必填项*</small>-->
          </div>
      </div>
      <div class="am-form-group">
          <label name="masterList" class="am-u-sm-3 am-form-label">项目</label>

          <div class="am-u-sm-9" style="margin-top: 10px;" id="projectDisplay">
                                  ${object.project.name}
          </div>
      </div>
      <c:if test="${not empty object.id}">
          <div class="am-form-group">
              <label name="createDate" class="am-u-sm-3 am-form-label">创建时间</label>

              <div class="am-u-sm-9">
                  <div style="margin-top: 9px;">
                      <fmt:formatDate value="${object.createDateTime}" type="both" pattern="YYYY-MM-dd HH:mm"/>
                  </div>
                  <!-- <small>必填项*</small>-->
              </div>
          </div>
      </c:if>

      <div class="am-form-group" >
          <label class="am-u-sm-3 am-form-label">商品描述</label>
          <div class="am-u-sm-9" style="margin-top: 10px;">
                            <textarea id="productDescription" name="content" class="ckeditor"
                                      placeholder="商品描述" required disabled="disabled">
                                ${object.productDescription.content}
                            </textarea>
          </div>
          <br>
      </div>


      <div class="am-u-md-9" style="margin-left: 19%;">
          <div class="am-panel am-panel-default">
              <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-2'}">商品模型<span
                      class="am-icon-chevron-down am-fr"></span></div>
              <div id="collapse-panel-2" class="am-in">
                  <table class="am-table am-table-bd am-table-bdrs am-table-striped am-table-hover"
                         id="productModel">
                      <tbody>
                      <tr>
                          <th class="am-text-center" width="20%">商品名称</th>
                          <th class="am-text-center" width="20%">属性</th>
                          <th class="am-text-center" width="20%">库存</th>
                          <th class="am-text-center" width="20%">价格(元)</th>
                          <th class="am-text-center" width="20%">图片</th>
                      </tr>
                      <c:forEach var="model" items="${object.productModelList}">
                          <tr>
                              <td align="center">
                                  ${model.name}
                              </td>
                              <td class="am-text-center">
                                  <c:forEach var="modelProperty" items="${model.productPropertyValueList}">
                                            <span style="padding: 5px;" id="${modelProperty.projectPropertyValue.id}" value="${modelProperty.projectPropertyValue.value}">
                                                    ${modelProperty.projectPropertyValue.value}
                                            </span>
                                  </c:forEach>
                              </td>
                              <td align="center">
                                  ${model.amount}
                              </td>
                              <td align="center">
                                  ${model.price}
                              </td>
                              <td align="center">
                                  <c:if test="${not empty model.productModel_url}">
                                      <img width="30%"  name=""  src="http://tenant.efeiyi.com/${model.productModel_url}@!tenant-manage-photo" alt="商品模型图片" />
                                  </c:if>
                              </td>
                          </tr>
                      </c:forEach>
                      </tbody>
                  </table>
              </div>
          </div>
      </div>


      <div class="am-u-md-13">
          <div class="am-panel am-panel-default">
              <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-1'}">
                  <strong> 主商品图片</strong>
                  <span class="am-icon-chevron-down am-fr"></span></div>
              <div class="am-panel-bd am-collapse am-in" id="collapse-panel-1" style="height: auto;overflow: hidden">
                  <a style="margin-bottom: 2px;color: red;" id="btn_upload2"></a>
                  <c:if test="${!empty object.productPictureList}">
                      <ul style="width: 100%"  style="list-style:none">
                          <c:forEach var="productPicture" items="${object.productPictureList}">
                              <c:if test="${productPicture.status == '2'}">
                                  <li style="float: left;margin-right: 10px;"  name="${productPicture.id}">
                                      <dl style="margin-top: 6px;">
                                          <dt style="width: 80%">
                                              <img width="100%" name=""
                                                   src="http://tenant.efeiyi.com/${productPicture.pictureUrl}@!tenant-manage-photo"
                                                   alt="商品主图片"/>
                                          </dt>
                                      </dl>
                                  </li>
                              </c:if>
                          </c:forEach>
                      </ul>
                  </c:if>
              </div>
          </div>
      </div>


      <div class="am-u-md-13">
          <div class="am-panel am-panel-default">
              <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-3'}">
                  <strong> 商品详情图片</strong>
                  <span class="am-icon-chevron-down am-fr" ></span></div>
              <div id="collapse-panel-3" class="am-panel-bd am-collapse am-in" style="height: auto;overflow: hidden">
                  <a  style="margin-bottom: 2px;color: red;" id="btn_upload"></a>
                  <c:if test="${!empty object.productPictureList}">
                      <ul style="width: 100%"  style="list-style:none">
                          <c:forEach var="productPicture" items="${object.productPictureList}" >
                              <c:if test="${productPicture.status == '3'}">
                                  <li style="float: left;margin-right: 10px;"  name="${productPicture.id}">
                                      <dl style="margin-top: 6px;">
                                          <dt style="width: 80%">
                                              <img width="100%"  name=""  src="http://tenant.efeiyi.com/${productPicture.pictureUrl}@!tenant-manage-photo" alt="商品主图片" />
                                          </dt>
                                      </dl>
                                  </li>
                              </c:if>
                          </c:forEach>
                      </ul>
                  </c:if>
              </div>
          </div>
      </div>

      <%--<div class="am-u-md-13">--%>
          <%--<div class="am-panel am-panel-default">--%>
              <%--<div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-4'}">--%>
                  <%--&lt;%&ndash;<a style="margin-bottom: 2px;color: red;" id="btn_upload1"></a>&ndash;%&gt;--%>
                  <%--<strong>  商品模型图片</strong>--%>
                  <%--<span class="am-icon-chevron-down am-fr" ></span></div>--%>
              <%--<div id="collapse-panel-4" class="am-in">--%>
                  <%--<table class="am-table am-table-bd am-table-bdrs am-table-striped am-table-hover" id="productModelPicture">--%>
                      <%--<tbody>--%>
                      <%--<tr>--%>
                          <%--<th>商品名称</th>--%>
                          <%--<th>图片</th>--%>
                      <%--</tr>--%>
                      <%--<c:forEach var="productModel" items="${object.productModelList}" varStatus="status">--%>
                          <%--<tr>--%>
                              <%--<td valign="middle">${productModel.name}</td>--%>
                              <%--<td >--%>
                                  <%--<c:if test="${not empty productModel.productModel_url}">--%>
                                      <%--<img width="10%"  name=""  src="http://tenant.efeiyi.com/${productModel.productModel_url}@!tenant-manage-photo" alt="商品模型图片" />--%>
                                  <%--</c:if>--%>
                              <%--</td>--%>
                          <%--</tr>--%>
                      <%--</c:forEach>--%>

                      <%--</tbody>--%>
                  <%--</table>--%>
              <%--</div>--%>
          <%--</div>--%>
      <%--</div>--%>

      <div class="am-form-group">
          <div class="am-u-sm-9 am-u-sm-push-3">

                    <span style="padding: 10px;">
                       <input type="button"  onclick="toSubmit('redirect:/basic/xm.do?qm=plistProduct_default')" class="am-btn am-btn-primary" value="返回商品列表"/>
                    </span>
          </div>
      </div>
  </form>
</div>
<!-- content end -->
<hr/>
<script src="<c:url value='/resources/plugins/ckeditor/ckeditor.js'/>"></script>
<script>
    //提交
    function toSubmit(result){
        $("input[name='resultPage']").val(result);
        $("form").submit();
    }
</script>

</body>
</html>
