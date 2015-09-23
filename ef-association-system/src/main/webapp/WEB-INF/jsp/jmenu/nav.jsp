<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/13
  Time: 11:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header class="am-topbar">
  <h1 class="am-topbar-brand">
    <a href="#">Amaze UI</a>
  </h1>
  <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only" data-am-collapse="{target: '#doc-topbar-collapse'}"><span class="am-sr-only">导航切换</span> <span class="am-icon-bars"></span></button>
  <div class="am-collapse am-topbar-collapse" id="doc-topbar-collapse">
    <ul class="am-nav am-nav-pills am-topbar-nav">
      <c:forEach items="${jmenu.children.get(0).children}" var="jnode">
        <li><a class="${jnode.jnodeMatch('am-active',currentJnode!=null?currentJnode:"")}" href="${jnode.url}">${jnode.text_zh_CN}</a></li>
      </c:forEach>
    </ul>
  </div>
</header>
