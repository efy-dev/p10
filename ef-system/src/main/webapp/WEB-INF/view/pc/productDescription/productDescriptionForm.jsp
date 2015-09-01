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
  <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">新建/编辑商品描述</strong> /
    <small>New/Edit ProductDescription</small>
  </div>
</div>
<hr/>
<div class="am-g">

  <fieldset>
    <legend class="" style="font-size: 17px">商品描述</legend>
    <form action="<c:url value="/product/saveNewProduct.do"/>" method="post" class="am-form am-form-horizontal">
      <input type="hidden" name="id" value="${object.productDescription.id}">
      <input type="hidden" name="product.id" value="${object.id}">
      <input type="hidden" name="resultPage" value="0" />
        <input type="hidden" name="view" value="${view}">
      <input type="hidden" name="step" value="description">

      <div class="am-form-group">
        <label name="name" class="am-u-sm-3 am-form-label">商品名称</label>

        <div class="am-u-sm-9" style="margin-top: 10px;">
          ${object.name}

        </div>
      </div>




      <div class="am-form-group" >
        <label for="productDescription" class="am-u-sm-3 am-form-label">商品描述</label>

        <div class="am-u-sm-9" style="margin-top: 10px;">
                        <textarea id="productDescription" name="content" class="ckeditor"
                                  placeholder="商品描述" required>
                          ${object.productDescription.content}
                        </textarea>
        </div>
        <br>
      </div>
      <div class="am-form-group">
        <div class="am-u-sm-9 am-u-sm-push-3">
                    <span style="padding: 10px;">
                       <input type="button" class="am-btn am-btn-primary" onclick="toSubmit('/productModel/productModelForm')" value="保存,并进入商品模型"/>
                    </span>
                    <span style="padding: 10px;">
                       <input type="button" class="am-btn am-btn-primary" onclick="toSubmit('redirect:/basic/xm.do?qm=plistProduct_tenant&view=${view}&conditions=tenant.id:${object.tenant.id}&tenantId=${object.tenant.id}')" value="保存,并返回商品列表"/>
                    </span>
                      <span style="padding: 10px;">
                       <input type="button" onclick="toSubmit('/product/productView')"  class="am-btn am-btn-primary" value="保存,并查看商品详情"/>
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


  function toSubmit(result){
    $("input[name='resultPage']").val(result);
    $("form").submit();
  }
</script>


</body>
</html>
