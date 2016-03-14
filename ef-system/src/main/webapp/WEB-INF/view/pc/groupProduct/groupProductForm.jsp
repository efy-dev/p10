<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
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
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>


</head>
<body>
<div class="am-cf am-padding">
  <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">新建/编辑团购商品</strong> /
    <small>New/Edit Product</small>
  </div>
</div>
<hr/>
<div class="am-popup" id="my-popup">
    <div class="am-popup-inner">
        <div class="am-popup-hd">
            <h4 class="am-popup-title">团购商品</h4>
      <span data-am-modal-close
            class="am-close">&times;</span>
        </div>
        <div class="am-popup-bd">
            <input type="text" name="sel"  style="float: left" placeholder="编号或名称" value=""/>
            <a style="width: 10%;float: left;margin-left: 10px;"
               class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
               href="javascript:void(0);" onclick="selModel(this)">查找
            </a>
            <table class="am-table am-table-bd am-table-bdrs am-table-striped am-table-hover"
                   id="productModel">
                <tbody>
                <tr>
                    <th class="am-text-center" width="14%">操作</th>
                    <th class="am-text-center" width="17%">规格编号</th>
                    <th class="am-text-center" width="17%">规格名称</th>
                </tr>
                <c:forEach var="model" items="${productModelList}">
                    <tr name="${model.name}" serial="${model.serial}">
                        <td align="center" width="33%">
                            <a style="width: 10%;"
                               class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                               href="javascript:void(0);" onclick="selectModel('${model.id}','${model.name}')">
                                团购
                            </a>
                        </td>
                        <td class="am-text-center" width="33%">
                                ${model.serial}
                        </td>
                        <td class="am-text-center" width="33%">
                            ${model.product.name}-${model.name}
                        </td>

                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<div class="am-g">
    <form action="<c:url value="/basic/xm.do"/>" method="post" class="am-form am-form-horizontal" >
      <input type="hidden" name="id" value="${object.id}">
      <input type="hidden" name="qm" value="saveOrUpdateGroupProduct">
        <input type="hidden" name="bonus" value="1">
        <input type="hidden" name="status" value="1">
        <input type="hidden" name="resultPage" value="redirect:/basic/xm.do?qm=plistGroupProduct_default"/>
      <div class="am-form-group">
        <label name="name" class="am-u-sm-3 am-form-label">团购商品</label>

        <div class="am-u-sm-9">
            <input type="hidden" name="productModel.id" id="productModelId" placeholder="" value="${object.productModel.id}" >
            <input type="text" name="productModel.name" id="productModelName" placeholder="" data-am-modal="{target: '#my-popup'}" value="${object.productModel.name}" >
        </div>
      </div>
        <div class="am-form-group">
            <label name="groupPrice" class="am-u-sm-3 am-form-label">团购价格</label>

            <div class="am-u-sm-9">
                <input type="text" name="groupPrice" id="groupPrice" placeholder="" value="${object.groupPrice}" >
            </div>
        </div>
        <%--<div class="am-form-group">--%>
            <%--<label name="status" class="am-u-sm-3 am-form-label">状态</label>--%>

            <%--<div class="am-u-sm-9">--%>
                <%--<ming800:status name="status" dataType="SeckillProduct.showStatus" checkedValue="${object.status}" type="select"/>--%>
            <%--</div>--%>
        <%--</div>--%>
        <div class="am-form-group">
            <label for="memberAmount" class="am-u-sm-3 am-form-label">成团人数</label>

            <div class="am-u-sm-9">
                <input type="text" name="memberAmount"  id="memberAmount" placeholder="" value="${object.memberAmount}" >
            </div>

        </div>
        <div class="am-form-group">
            <label for="groupPurchaseTime" class="am-u-sm-3 am-form-label">成团天数</label>

            <div class="am-u-sm-9">
                <input type="text" name="groupPurchaseTime" id="groupPurchaseTime" placeholder="" value="${object.groupPurchaseTime}" >
            </div>

        </div>
        <c:if test="${not empty object.id}">
            <div class="am-form-group">
                <label name="createDateTime" class="am-u-sm-3 am-form-label">创建时间</label>

                <div class="am-u-sm-9">
                    <div style="margin-top: 9px;">
                        <input value="${object.createDateTime}" type="hidden" name="createDateTime"/>
                        <fmt:formatDate value="${object.createDateTime}" type="both" pattern="YYYY-MM-dd HH:mm:ss"/>
                    </div>
                    <!-- <small>必填项*</small>-->
                </div>
            </div>
        </c:if>
        <c:if test="${empty object.id}">
                         <%
                             SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                             String time = sdf.format(new Date());
                         %>
                        <input value="<%=time%>" type="hidden" name="createDateTime"/>
        </c:if>

        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">

                    <span style="padding: 10px;">


                      <input type="submit" class="am-btn am-btn-primary" value="保存"/>



                    </span>

            </div>
        </div>
</form>

</div>



<!-- content end -->
<hr/>
<script src="<c:url value="/resources/plugins/My97DatePicker/WdatePicker.js" />" ></script>
<script>


   function selModel(obj){

       var v = $("input[name='sel']").val();
       if(v==""){
           $("#productModel tr:gt(0)").each(function(){

                   $(this).show();

           });
       }else {
           $("#productModel tr:gt(0)").each(function () {
               if ($(this).attr("name").indexOf(v)!=-1 || $(this).attr("serial").indexOf(v) != -1 ) {
                   $(this).show();
               } else {
                   $(this).hide();
               }
           });
       }
   }

    function selectModel(id,name){
        $("#productModelId").val(id);
        $("#productModelName").val(name);
        $("#my-popup").modal('close');
    }
</script>

</body>
</html>
