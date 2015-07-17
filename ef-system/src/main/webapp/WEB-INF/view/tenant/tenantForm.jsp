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
  <script src="/scripts/ckeditor/ckeditor.js"></script>
</head>
<body>
  <div class="admin-content">
    <div class="am-g">

      <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8"><%--少了这个div就出错--%>
      </div>

      <div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
        <form action="/basic/xm.do" method="post" class="am-form am-form-horizontal">
          <input type="hidden" value="saveOrUpdateTenant" name="qm">
          <input type="hidden" name="id" value="${object.id}">
          <div class="am-form-group">
            <label for="name" class="am-u-sm-3 am-form-label">姓名 / Name</label>
            <div class="am-u-sm-9">
              <input type="text" id="name" name="name" placeholder="姓名 / Name" value="${object.name}">
              <small>输入你要保存的名字</small>
            </div>
          </div>

          <div class="am-form-group">
            <label for="level" class="am-u-sm-3 am-form-label">等级 / Level</label>
            <div class="am-u-sm-9">
              <input type="text" id="level" name="level" placeholder="等级 / Name" value="${object.level}">
              <small>输入你要保存的等级</small>
            </div>
          </div>


          <div class="am-form-group">
            <label for="brief" class="am-u-sm-3 am-form-label">简介 / Intro</label>
            <div class="am-u-sm-9">
              <textarea id="brief" name="brief" class="ckeditor"  placeholder="输入简介">${object.brief}</textarea>
            </div>
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
