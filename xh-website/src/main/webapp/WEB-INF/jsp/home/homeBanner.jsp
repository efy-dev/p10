<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/10/13
  Time: 14:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="focus">
  <div data-am-widget="slider" class="am-slider am-slider-default" data-am-slider='{"animation":"slide","slideshow":false}' >
    <ul class="am-slides">
      <c:forEach items="${bannerList}" var="banner">
        <li>
          <a href="${banner.directUrl}" target="_self"><img src="${banner.imageUrl}"></a>
          <div class="am-slider-desc">
            <h3>${banner.title}</h3>
            <%--<p>这是标题标题标题标题标题标题标题这是标题标题标题标题标题标题标题</p>--%>
          </div>
        </li>
      </c:forEach>
    </ul>
  </div>
</div>
