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
  <form action="/basic/xm.do" method="post">
    <input type="hidden" name="qm" value="saveOrUpdateTenantProduct">
    name：<input type="text" name="name" id="name">
    <input type="submit" value="保存">
  </form>


  <div class="admin-content">
    <div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">传承人简介</strong> / <small>Tenant introduction</small></div>
  </div>

    <hr/>

    <div class="am-g">

      <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8"><%--少了这个div就出错--%>
      </div>

      <div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
        <form action="/basic/xm.do" method="post" class="am-form am-form-horizontal">
          <input type="hidden" value="saveOrUpdateTenantProduct" name="qm">
          <input type="hidden" name="id" value="${object.id}">
          <div class="am-form-group">
            <label for="type" class="am-u-sm-3 am-form-label">类型 / Type</label>
            <div class="am-u-sm-9">
              <input type="text" id="type" name="type" placeholder="类型 / Type" value="${object.type}">
              <small>输入你要保存的类型</small>
            </div>
          </div>


          <div class="am-form-group">
            <label for="content" class="am-u-sm-3 am-form-label">简介 / Intro</label>
            <div class="am-u-sm-9">
              <textarea id="content" name="content" class="ckeditor"  placeholder="输入简介">${object.content}</textarea>
            </div><br>
          </div>

          <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
              <button type="submit" class="am-btn am-btn-primary">保存修改</button>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</body>
</html>
