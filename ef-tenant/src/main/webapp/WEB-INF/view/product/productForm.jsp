<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<div class="am-cf am-padding">
  <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">新建商品</strong> / <small>New Product</small></div>
</div>
<hr/>

<div class="am-g">
    <form action="/basic/xm.do" method="post"  class="am-form am-form-horizontal">
        <input type="hidden" name="qm" value="saveOrUpdateProduct">
      <input type="hidden" name="id" value="${object.id}">
      <div class="am-form-group">
        <label name="name" for="user-name" class="am-u-sm-3 am-form-label">商品名称</label>
        <div class="am-u-sm-9">
          <input type="text" name="name" id="user-name" placeholder="商品名称" value="${object.name}">
          <small>必填项*</small>
        </div>
      </div>
      <div class="am-form-group">
        <label name="price" for="price" class="am-u-sm-3 am-form-label">商品价格</label>
        <div class="am-u-sm-9">
          <input type="text" name="price" id="price" placeholder="商品价格" value="${object.price}">
          <small>必填项*</small>
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
