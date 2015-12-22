<%@ page import="com.efeiyi.ec.system.organization.util.AuthorizationUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/10
  Time: 15:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- sidebar start -->
<div class="admin-sidebar am-offcanvas" id="admin-offcanvas">
  <div class="am-offcanvas-bar admin-offcanvas-bar">
    <ul class="am-list admin-sidebar-list">
      <c:forEach items="${jnode.children}" var="childJnode">
        <c:if test="${!empty childJnode.children&& childJnode.children.size()>0}">
            <security:authorize ifAnyGranted="${childJnode.access}">
          <li class="admin-parent">
            <a class="am-cf" data-am-collapse="{target: '#${childJnode.id}'}"><span
                    class="am-icon-file"></span> ${childJnode.text_zh_CN}</a>
            <ul class="am-list am-collapse admin-sidebar-sub am-in" id="${childJnode.id}">
              <c:forEach items="${childJnode.children}" var="childchildJnode">
                  <security:authorize ifAnyGranted="${childchildJnode.access}">
                <li>
                    <%--<c:if test="${!empty requestScope.qm && childchildJnode.contain(requestScope.qm)}">--%>
                  <a href="<c:url value="${childchildJnode.url}"/>"
                     class="am-cf ${childchildJnode.jnodeMatch('efy-active',currentJnode!=null?currentJnode:"")}">${childchildJnode.text_zh_CN}</a>
                    <%--</c:if>--%>
                    <%--<c:if test="${empty requestScope.qm || !childchildJnode.contain(requestScope.qm)}">--%>
                    <%--<a href="${childchildJnode.url}&menuId=${requestScope.menuId}"--%>
                    <%--class="am-cf">${childchildJnode.text_zh_CN}</a>--%>
                    <%--</c:if>--%>
                </li>
                  </security:authorize>
              </c:forEach>
            </ul>
          </li>
            </security:authorize>
        </c:if>
        <c:if test="${empty childJnode.children}">
          <%--<c:if test="${empty requestScope.qm || !childchildJnode.contain(requestScope.qm)}">--%>
          <%--<li><a href="${childJnode.url}"></span> ${childJnode.text_zh_CN}</a></li>--%>
          <%--</c:if>--%>
          <%--<c:if test="${!empty requestScope.qm && childchildJnode.contain(requestScope.qm)}">--%>

          <li><a class="${childJnode.jnodeMatch('efy-active',currentJnode!=null?currentJnode:"")}" href="<c:url value="${childJnode.url}"/>"></span> ${childJnode.text_zh_CN}</a></li>
          <%--</c:if>--%>
        </c:if>

      </c:forEach>

    </ul>
    <div class="am-panel am-panel-default admin-sidebar-panel">
      <div class="am-panel-bd">
        <p><span class="am-icon-bookmark"></span> 公告</p>
        <p>手机：<%=AuthorizationUtil.getMyUser().getUsername()%></p>
        <div style="width: 100%;table-layout:fixed; word-break: break-all; overflow:hidden; ">
          <p>链接：http://www.efeiyi.com/subject/activity/iia4ndpr2vgul3i4?source=user_<%=AuthorizationUtil.getMyUser().getId()%></p>
        </div>

        <p>
          <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
             href='<c:url value="/userGift/createQRCode.do">
                               <c:param name="userID" value="<%=AuthorizationUtil.getMyUser().getId()%>"></c:param>
                                </c:url>'><span class="am-icon-trash-o">生成二维码并下载</span>
          </a>
        </p>
      </div>
    </div>

  </div>
</div>
