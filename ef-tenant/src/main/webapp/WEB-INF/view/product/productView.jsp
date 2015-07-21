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
  <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">订单详情</strong> / <small>Order Details</small></div>
</div>
<hr/>

<div class="am-g">
  <form action="/basic/xm.do" method="post"  class="am-form am-form-horizontal">
    <input type="hidden" name="qm" value="">
    <div class="am-form-group">
      <label name="tenantName"  class="am-u-sm-3 am-form-label">传承人</label>
      <div class="am-u-sm-9">
        ${object.tenant.id}
        <!-- <small>必填项*</small>-->
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
      <label name="price"  class="am-u-sm-3 am-form-label">价格</label>
      <div class="am-u-sm-9">
        ${object.price}
        <!-- <small>必填项*</small>-->
      </div>
    </div>
    <div class="am-form-group">
      <label name="createDate" class="am-u-sm-3 am-form-label">创建时间</label>
      <div class="am-u-sm-9">
        ${object.createDateTime}
        <!-- <small>必填项*</small>-->
      </div>
    </div>

    <div class="am-form-group">
      <div class="am-u-sm-9 am-u-sm-push-3">
        <input type="button" onclick="window.location.href='/basic/xm.do?qm=plistProduct_default'" class="am-btn am-btn-primary" value="返回"/>
      </div>
    </div>
  </form>
</div>
<!-- content end -->
<hr/>

</body>
</html>
