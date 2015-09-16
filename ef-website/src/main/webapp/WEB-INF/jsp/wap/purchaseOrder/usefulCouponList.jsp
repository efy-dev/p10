<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的卡券</title>
</head>
<body>
<!-- Start--收藏成功提示框 -->
<div class="alert-red-top" style="display: none">
  <span class="red-text">删除成功！</span>
</div>
<!-- //End--收藏成功提示框 -->
<!--//End--header-->
<div class="discount">
  <div data-am-widget="tabs" class="am-tabs am-tabs-default">
    <ul class="am-tabs-nav am-cf">
      <li class="am-active"><a href="[data-tab-panel-0]">
        <p>可使用</p>
        <p>2</p>
      </a></li>
      <li class=""><a href="[data-tab-panel-1]">
        <p>不可使用</p>
        <p>2</p>
      </a></li>
    </ul>
    <div class="am-tabs-bd">
      <div data-tab-panel-0 class="am-tab-panel am-active">
        <div class="on-list">
          <dl>
            <dt><a href="#"><img src="<c:url value="/scripts/wap/upload/mx-1-1.png"/>"></a></dt>
            <dd>
              <p>一次性消费满200元即可使用</p>
              <p>有效期限 2015-08-21—2015-09-21</p>
              <p>仅限于姚慧芬绣品使用</p>
              <p><a href="#">立即使用</a></p>
            </dd>
          </dl>
        </div>
        <div class="on-list">
          <dl>
            <dt><a href="#"><img src="<c:url value="/scripts/wap/upload/mx-1-1.png"/>"></a></dt>
            <dd>
              <p>一次性消费满200元即可使用</p>
              <p>有效期限 2015-08-21—2015-09-21</p>
              <p>仅限于姚慧芬绣品使用</p>
              <p><a href="#">立即使用</a></p>
            </dd>
          </dl>
        </div>
      </div>
      <div data-tab-panel-1 class="am-tab-panel ">
        <div class="on-list">
          <dl>
            <dt><a href="#"><img src="<c:url value="/scripts/wap/upload/mx-1-1.png"/>"><i class="icon-gq"></i></a></dt>
            <dd class="clpt">
              <p>一次性消费满200元即可使用</p>
              <p>有效期限 2015-08-21—2015-09-21</p>
              <p>仅限于姚慧芬绣品使用</p>
              <p>
                <a href="#" class="addfav">删除</a>
                <span>立即使用</span>
              </p>
            </dd>
          </dl>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
