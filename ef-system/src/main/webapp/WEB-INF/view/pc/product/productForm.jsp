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
  <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">新建/编辑商品</strong> /
    <small>New/Edit Product</small>
  </div>
</div>
<hr/>
<div class="am-g">

  <fieldset>
    <legend class="" style="font-size: 17px">商品信息</legend>
    <%--<form action="<c:url value="/product/saveNewProduct.do?view=${view}"/>" method="post" class="am-form am-form-horizontal">--%>
      <form action="<c:url value="/basic/xm.do?view=${view}"/>" method="post" class="am-form am-form-horizontal">
      <input type="hidden" name="id" value="${object.id}">
      <input type="hidden" name="qm" value="saveOrUpdateProduct">
      <input type="hidden" name="resultPage" value="0" />
      <input type="hidden" name="step" value="product">
        <input type="hidden" name="view" value="${view}">
      <%--<input type="hidden" name="view" value="${view}">--%>
      <input type="hidden" name="productDescription.id" value="${object.productDescription.id}">
      <div class="am-form-group">
        <label name="serial" class="am-u-sm-3 am-form-label">商品编号</label>

        <div class="am-u-sm-9">
          <c:if test="${empty object.serial}">
            <input type="text" name="serial" id="serial" placeholder="自动生成" value="${serial}" readonly="readonly">
          </c:if>
          <c:if test="${not empty object.serial}">
            <input type="text" name="serial" id="serial" placeholder="自动生成" value="${object.serial}" readonly="readonly">
          </c:if>
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
        <label name="price" class="am-u-sm-3 am-form-label">商品价格</label>

        <div class="am-u-sm-9">
          <input type="text" name="price" id="price" value="${object.price}">
          <!--<small>必填项*</small>-->
        </div>
      </div>

      <div class="am-form-group">
        <label name="serial" class="am-u-sm-3 am-form-label">商品类型</label>

        <div class="am-u-sm-9" style="margin-top: 10px;">
                 <span style="margin-left: 10px;">
                   <input type="radio" name="status" value="1" />
                     收藏品
                 </span>
                 <span style="margin-left: 10px;">
                   <input type="radio" name="status" value="2"/>
                     精品
                 </span>
          <!--<small>必填项*</small>-->
        </div>
      </div>

      <div class="am-form-group">
        <label name="serial" class="am-u-sm-3 am-form-label">关联商家</label>

        <div class="am-u-sm-9" style="margin-top: 10px;">
                <select name="tenant.id" onchange="changeTenant(this)">
                   <option value="0">请选择</option>
                 <c:forEach var="tenant" items="${tenantList}">
                    <option value="${tenant.id}" <c:if test="${object.tenant.id == tenant.id}">selected="selected"</c:if> <c:if test="${tenantId == tenant.id}">selected="selected"</c:if> >${tenant.name}</option>
                 </c:forEach>
                </select>
          <!--<small>必填项*</small>-->
        </div>
      </div>


      <div class="am-form-group">
        <label name="masterList" class="am-u-sm-3 am-form-label">大师</label>

        <div class="am-u-sm-9" style="margin-top: 10px;" id="master">
          <c:forEach var="tenantMaster" items="${masterList}">
            <span style="margin-left: 10px;">
               <input type="radio" <c:if test="${tenantMaster.master.id == object.master.id }">checked="checked"</c:if> value="${tenantMaster.master.id}" onclick="changeMaster(this)" name="master.id"/>
               ${tenantMaster.master.fullName}
            </span>
          </c:forEach>
          <!--<small>必填项*</small>-->
        </div>
      </div>

      <div class="am-form-group">
        <label name="masterList" class="am-u-sm-3 am-form-label">项目</label>

        <div class="am-u-sm-9" style="margin-top: 10px;" id="Project">

          <c:forEach var="masterProject" items="${projectList}">
            <span style="margin-left: 10px;">
               <input type="radio" <c:if test="${masterProject.project.id == object.project.id }">checked="checked"</c:if> value="${masterProject.project.id}"  name="project.id"/>
               ${masterProject.project.name}
            </span>
          </c:forEach>
        </div>
      </div>


      <c:if test="${not empty object.id}">
        <div class="am-form-group">
          <label name="createDate" class="am-u-sm-3 am-form-label">创建时间</label>

          <div class="am-u-sm-9">
            <div style="margin-top: 9px;">
              <input value="${object.createDateTime}" type="hidden" name="createDateTime"/>
              <fmt:formatDate value="${object.createDateTime}" type="both" pattern="YYYY-MM-dd HH:mm"/>
            </div>
            <!-- <small>必填项*</small>-->
          </div>
        </div>
      </c:if>


      <div class="am-form-group">
        <div class="am-u-sm-9 am-u-sm-push-3">
                    <span style="padding: 10px;">
                   <%--<c:if test="${view == 'newProduct'}">--%>
                       <%--<input type="button" onclick="toSubmit('redirect:/basic/xm.do?qm=formProduct_ProductModel&view=${view}&id=${object.id}')" class="am-btn am-btn-primary" value="下一步"/>--%>
                   <%--</c:if>--%>
                        <%--<c:if test="${view == 'tenant'}">--%>
                          <%--<input type="button" onclick="toSubmit('redirect:/basic/xm.do?qm=formProduct_ProductModel&view=${view}&tenantId=${tenantId}&id=${object.id}')" class="am-btn am-btn-primary" value="下一步"/>--%>
                        <%--</c:if>--%>
                    </span>
                    <span style="padding: 10px;">
                      <c:if test="${view == 'newProduct'}">
                        <input type="button" onclick="toSubmit('redirect:/basic/xm.do?qm=plistProduct_default&view=${view}')"  class="am-btn am-btn-primary" value="保存"/>
                      </c:if>
                      <c:if test="${view == 'tenant'}">
                        <input type="button" onclick="toSubmit('redirect:/basic/xm.do?qm=plistProduct_tenant&view=${view}&conditions=tenant.id:${tenantId}&tenantId=${tenantId}')"  class="am-btn am-btn-primary" value="保存"/>
                      </c:if>
                    </span>

        </div>
      </div>
    </form>
  </fieldset>



</div>

<!-- content end -->
<hr/>
<script src="<c:url value='/resources/plugins/ckeditor/ckeditor.js'/>"></script>
<script type="text/javascript">

  $(function(){
    //新建初始化
    var status = '${object.status}';
    $("input[name='status'][value='"+status+"']").attr("checked",true);

    if(${empty object.id}){
      var date = new Date();
    }
  });

  function changeTenant(obj){
    var tenantId = $(obj).val();
    $.ajax({
      type: "get",
      url: '<c:url value="/product/changeTenant.do"/>',
      cache: false,
      dataType: "json",
      data:{tenantId:tenantId},
      success: function (data) {
        var obj = eval(data);
        $("#master").text("");
        for(var i=0;i<obj.length;i++){
          var span = '<span style="margin-left: 10px;">'+
                  '     <input type="radio" value="'+obj[i].master.id+'" onclick="changeMaster(this)" name="master.id"/>'+obj[i].master.fullName+
                  ' </span>';
          $("#master").append(span);
        }

      }
    });
  }
  function toSubmit(result){
    $("input[name='resultPage']").val(result);
    if($("#name").val()==""){
      alert("商品名称不能为空");
    }else if($("#price").val()==""){
      alert("商品价格不能为空!");
//
    }else if(!checkPrice($("#price").val())){
        alert("商品价格必须为数字!");
    }else{
      $("form").submit();
    }

  }

  function checkPrice(value){
    var temp=/^\d+(\.\d+)?$/;
    return temp.test(value);
  }



  ///大师改变
  function changeMaster(obj) {
    var masterId = $(obj).val();
    $.ajax({
      type: "get",
      url: '<c:url value="/product/changeMaster.do"/>',
      cache: false,
      dataType: "json",
      data:{masterId:masterId},
      success: function(data) {
        var obj = eval(data);
        $("#Project").text("");
        for(var i=0;i<obj.length;i++){
          var span = '<span style="margin-left: 10px;">'+
                  '     <input type="radio" value="'+obj[i].project.id+'"  name="project.id"/>'+obj[i].project.name+
                  ' </span>';
          $("#Project").append(span);
        }

      }
    });


  }



</script>


</body>
</html>
