<%@ page import="com.efeiyi.ec.system.organization.util.AuthorizationUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/10
  Time: 15:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- sidebar start -->
<c:set var="review" value="<%=AuthorizationUtil.getMyUser().getBigTenant().getReview()%>"/>
<div class="admin-sidebar am-offcanvas" id="admin-offcanvas">
    <div class="am-offcanvas-bar admin-offcanvas-bar admin-sidebar-panel">
        <ul class="am-list admin-sidebar-list">
            <c:if test="${review=='4'}">
                <c:forEach items="${jnode.children}" var="childJnode">
                    <c:if test="${!empty childJnode.children&& childJnode.children.size()>0}">

                        <c:if test="${childJnode.text_zh_CN!='账号审核管理'}">
                            <li class="admin-parent">
                                <a class="am-cf" data-am-collapse="{target: '#${childJnode.id}'}"><span
                                        class="am-icon-file"></span> ${childJnode.text_zh_CN}</a>
                                <ul class="am-list am-collapse admin-sidebar-sub am-in" id="${childJnode.id}">
                                    <c:forEach items="${childJnode.children}" var="childchildJnode">
                                        <li>
                                                <%--<c:if test="${!empty requestScope.qm && childchildJnode.contain(requestScope.qm)}">--%>
                                            <a href="${childchildJnode.url}"
                                               class="am-cf ${childchildJnode.jnodeMatch('efy-active',currentJnode!=null?currentJnode:"")}">${childchildJnode.text_zh_CN}</a>
                                                <%--</c:if>--%>
                                                <%--<c:if test="${empty requestScope.qm || !childchildJnode.contain(requestScope.qm)}">--%>
                                                <%--<a href="${childchildJnode.url}&menuId=${requestScope.menuId}"--%>
                                                <%--class="am-cf">${childchildJnode.text_zh_CN}</a>--%>
                                                <%--</c:if>--%>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </li>
                        </c:if>


                        <c:if test="${empty childJnode.children}">
                            <%--<c:if test="${empty requestScope.qm || !childchildJnode.contain(requestScope.qm)}">--%>
                            <%--<li><a href="${childJnode.url}"></span> ${childJnode.text_zh_CN}</a></li>--%>
                            <%--</c:if>--%>
                            <%--<c:if test="${!empty requestScope.qm && childchildJnode.contain(requestScope.qm)}">--%>

                            <li><a class="${childJnode.jnodeMatch('efy-active',currentJnode!=null?currentJnode:"")}" href="${childJnode.url}"></span> ${childJnode.text_zh_CN}</a></li>
                            <%--</c:if>--%>
                        </c:if>
                    </c:if>
                </c:forEach>
            </c:if>

            <c:if test="${review!='4'}">
                <c:forEach items="${jnode.children}" var="childJnode">
                    <c:if test="${!empty childJnode.children&& childJnode.children.size()>0}">

                        <c:if test="${childJnode.text_zh_CN=='账号审核管理'}">
                            <li class="admin-parent">
                                <a class="am-cf" data-am-collapse="{target: '#${childJnode.id}'}"><span
                                        class="am-icon-file"></span> ${childJnode.text_zh_CN}</a>
                                <ul class="am-list am-collapse admin-sidebar-sub am-in" id="${childJnode.id}">
                                    <c:forEach items="${childJnode.children}" var="childchildJnode">
                                        <li>
                                                <%--<c:if test="${!empty requestScope.qm && childchildJnode.contain(requestScope.qm)}">--%>
                                            <a href="${childchildJnode.url}"
                                               class="am-cf ${childchildJnode.jnodeMatch('efy-active',currentJnode!=null?currentJnode:"")}">${childchildJnode.text_zh_CN}</a>
                                                <%--</c:if>--%>
                                                <%--<c:if test="${empty requestScope.qm || !childchildJnode.contain(requestScope.qm)}">--%>
                                                <%--<a href="${childchildJnode.url}&menuId=${requestScope.menuId}"--%>
                                                <%--class="am-cf">${childchildJnode.text_zh_CN}</a>--%>
                                                <%--</c:if>--%>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </li>
                        </c:if>


                        <c:if test="${empty childJnode.children}">
                            <%--<c:if test="${empty requestScope.qm || !childchildJnode.contain(requestScope.qm)}">--%>
                            <%--<li><a href="${childJnode.url}"></span> ${childJnode.text_zh_CN}</a></li>--%>
                            <%--</c:if>--%>
                            <%--<c:if test="${!empty requestScope.qm && childchildJnode.contain(requestScope.qm)}">--%>

                            <li><a class="${childJnode.jnodeMatch('efy-active',currentJnode!=null?currentJnode:"")}" href="${childJnode.url}"></span> ${childJnode.text_zh_CN}</a></li>
                            <%--</c:if>--%>
                        </c:if>
                    </c:if>
                </c:forEach>
            </c:if>
        </ul>
        <div class="am-panel am-panel-default admin-sidebar-panel">
            <div class="am-panel-bd">
                <p><span class="am-icon-bookmark"></span> 公告</p>

                <p>暂无公告</p>
            </div>
        </div>
        <!-- <div class="am-panel am-panel-default admin-sidebar-panel">
          <div class="am-panel-bd">
            <p><span class="am-icon-tag"></span> wiki</p>

            <p>Welcome to the Amaze UI wiki!</p>
          </div>
        </div>-->
    </div>
</div>
