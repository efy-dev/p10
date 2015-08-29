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
    <form action="<c:url value="/basic/xmm.do"/>" method="post"  class="am-form am-form-horizontal"  enctype="multipart/form-data">
        <input type="hidden" name="qm" value="saveOrUpdateProduct" />
        <input type="hidden" name="id" value="${object.id}">
        <input type="hidden" name="resultPage" value="redirect:/basic/xm.do?qm=plistProduct_default"/>
        <input type="hidden" name="status" value="1">

      <div class="am-form-group">
        <label name="masterList" class="am-u-sm-3 am-form-label">大师</label>
        <div class="am-u-sm-9" style="margin-top: 10px;">
          <c:forEach var="tenantMaster" items="${masterList}">
            <span style="margin-left: 10px;">
               <input type="radio" value="${tenantMaster.master.id}" onclick="checkOutProject(this)" name="master"/>
               ${tenantMaster.master.fullName}
            </span>
          </c:forEach>
          <!--<small>必填项*</small>-->
        </div>
      </div>

      <div class="am-form-group">
        <label name="masterList" class="am-u-sm-3 am-form-label">项目</label>
        <div class="am-u-sm-9" style="margin-top: 10px;">
          <select data-am-selected="{btnSize: 'sm'}" id="project">
            <option value="option1">选项一...</option>
            <option value="option2">选项二.....</option>
            <option value="option3">选项三........</option>
          </select>
          <!--<small>必填项*</small>-->
        </div>
      </div>

      <div class="am-form-group">
        <label name="masterList" class="am-u-sm-3 am-form-label">商品</label>
        <div class="am-u-sm-9" style="margin-top: 10px;">
            <span style="margin-left: 10px;">
               <input type="radio" value="" name="product"/>
                 商品一
            </span>
          <span style="margin-left: 10px;">
               <input type="radio" value="" name="product"/>
                 商品一
            </span>
          <span style="margin-left: 10px;">
               <input type="radio" value="" name="product"/>
                 商品一
            </span>
          <!--<small>必填项*</small>-->
        </div>
      </div>

      <div class="am-form-group">
        <label name="masterList" class="am-u-sm-3 am-form-label">属性</label>
        <div class="am-u-sm-9">
          <table class=" table-main" width="50%" style="margin-top: 10px;">
            <tr>
              <td width="7%">
                <div class="">尺寸</div>
              </td>
              <td class="am-hide-sm-only" width="20%">
                <div class="am-btn-group" data-am-button>
                  <label class="am-btn am-btn-default am-btn-xs">
                    <input type="checkbox"> 大
                  </label>
                  <label class="am-btn am-btn-default am-btn-xs">
                    <input type="checkbox"> 中
                  </label>
                  <label class="am-btn am-btn-default am-btn-xs">
                    <input type="checkbox"> 小
                  </label>
                </div>
              </td>
              <td width="7%">
                <div>颜色</div>
              </td>
              <td class="am-hide-sm-only" width="20%">
                <div class="am-btn-group" data-am-button>
                  <label class="am-btn am-btn-default am-btn-xs">
                    <input type="checkbox"> 黑
                  </label>
                  <label class="am-btn am-btn-default am-btn-xs">
                    <input type="checkbox"> 白
                  </label>
                </div>
              </td>
            </tr>

            <tr>

            </tr>

          </table>
          <!--<small>必填项*</small>-->
        </div>
      </div>





      <%--<div class="am-form-group">--%>
        <%--<label name="serial" class="am-u-sm-3 am-form-label">商品编号</label>--%>
        <%--<div class="am-u-sm-9">--%>
          <%--<c:if test="${empty object.serial}">--%>
            <%--<input type="text" name="serial" id="serial" placeholder="自动生成" value="${serial}"  >--%>
          <%--</c:if>--%>
          <%--<c:if test="${not empty object.serial}">--%>
            <%--<input type="text" name="serial" id="serial" placeholder="自动生成" value="${object.serial}"  >--%>
          <%--</c:if>--%>
          <%--<!--<small>必填项*</small>-->--%>
        <%--</div>--%>
      <%--</div>--%>
      <%--<div class="am-form-group">--%>
        <%--<label name="name" class="am-u-sm-3 am-form-label">商品名称</label>--%>
        <%--<div class="am-u-sm-9">--%>
          <%--<input type="text" name="name" id="name" placeholder="商品名称" value="${object.name}">--%>
          <%--<!--<small>必填项*</small>-->--%>
        <%--</div>--%>
      <%--</div>--%>

      <%--<div class="am-form-group">--%>
        <%--<label name="price"  class="am-u-sm-3 am-form-label">价格</label>--%>
        <%--<div class="am-u-sm-9">--%>
          <%--<input type="text" name="price" id="price" placeholder="价格" value="${object.price}">--%>
          <%--<!-- <small>必填项*</small>-->--%>
        <%--</div>--%>
      <%--</div>--%>
      <%--<div class="am-form-group">--%>
        <%--<label name="createDate" class="am-u-sm-3 am-form-label">创建时间</label>--%>
        <%--<div class="am-u-sm-9">--%>
          <%--<div style="margin-top: 9px;">--%>
            <%--<fmt:formatDate value="${object.createDateTime}" type="both" pattern="YYYY-MM-dd HH:mm" />--%>
          <%--</div>--%>
          <%--<!-- <small>必填项*</small>-->--%>
        <%--</div>--%>
      <%--</div>--%>

      <div class="am-form-group">
        <div class="am-u-sm-9 am-u-sm-push-3">
          <input type="submit" class="am-btn am-btn-primary" value="保存"/>
        </div>
      </div>
    </form>
 </div>
<!-- content end -->
<hr/>
<script type="text/javascript">
  function checkOutProject(obj){
    var masterId = $(obj).val();
    $.ajax({
      type:"post",
      dataType:"json",
      data:{masterId:masterId},
      url:"<c:url value="/product/getProjectList.do"/>",
      success:function(data){

        alert(data);
      }
    });
  }
</script>


</body>
</html>
