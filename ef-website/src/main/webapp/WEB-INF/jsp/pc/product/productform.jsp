<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/9
  Time: 9:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>

<form class="am-form am-form-horizontal" action="/product/product/saveOrUpdate">
  <div class="am-form-group">
    <label for="name" class="am-u-sm-2 am-form-label">名称</label>
    <div class="am-u-sm-10">
      <input type="text" id="name" name="name" placeholder="输入产品名称">
    </div>
  </div>


  <div class="am-form-group">
    <div class="am-u-sm-10 am-u-sm-offset-2">
      <button type="submit" class="am-btn am-btn-default">保存产品</button>
    </div>
  </div>
</form>

</body>
</html>
