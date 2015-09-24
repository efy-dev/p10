<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/17
  Time: 19:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- sidebar start -->
<div class="admin-sidebar am-offcanvas" id="admin-offcanvas">
  <div class="am-offcanvas-bar admin-offcanvas-bar">
    <ul class="am-list admin-sidebar-list">
      <c:forEach items="${jnode.children}" var="childJnode">
        <c:if test="${!empty childJnode.children&& childJnode.children.size()>0}">
          <li class="admin-parent">
            <a class="am-cf" data-am-collapse="{target: '#${childJnode.id}'}"><span
                    class="am-icon-file"></span> ${childJnode.text_zh_CN}</a>
            <ul class="am-list am-collapse admin-sidebar-sub am-in" id="${childJnode.id}">
              <c:forEach items="${childJnode.children}" var="childchildJnode">
                <li>
                  <a href="<c:url value='${childchildJnode.url}'/> "
                     class="am-cf ${childchildJnode.jnodeMatch('pal-active',currentJnode!=null?currentJnode:"")}">${childchildJnode.text_zh_CN}</a>
                </li>
              </c:forEach>
            </ul>
          </li>
        </c:if>
        <c:if test="${empty childJnode.children}">
          <li><a class="${childJnode.jnodeMatch('pal-active',currentJnode!=null?currentJnode:"")}" href="<c:url value='${childJnode.url}'/>"> ${childJnode.text_zh_CN}</a></li>
        </c:if>
      </c:forEach>
    </ul>
    <div class="am-panel am-panel-default admin-sidebar-panel" style="opacity: 0"><%-- opacity: 0 完全透明 --%>
      <div class="am-panel-bd">
        <p><span class="am-icon-bookmark"></span> 公告</p>
        <p>暂无</p>
      </div>
    </div>
  </div>
</div>
