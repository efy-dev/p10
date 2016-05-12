<%@ page import="com.efeiyi.ec.personal.AuthorizationUtil" %>
<%@ page import="com.efeiyi.ec.master.model.Master" %>
<%@ page import="com.efeiyi.ec.personal.master.controller.TenantController" %>
<%@ page import="com.efeiyi.ec.personal.master.MasterUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/10
  Time: 15:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if(MasterUtil.findMaster()!=null){
%>
   <c:set var="review" value="<%=MasterUtil.findMaster().getReview()%>"/>
<%
    }
%>
<div class="admin-sidebar am-offcanvas" id="admin-offcanvas">
    <div class="am-offcanvas-bar admin-offcanvas-bar admin-sidebar-panel">
        <ul class="am-list admin-sidebar-list">
            <c:if test="${review=='4'}">
                <c:forEach items="${jnode.children}" var="childJnode">
                    <c:if test="${!empty childJnode.children&& childJnode.children.size()>0}">
                        <c:if test="${childJnode.text_zh_CN!='入驻审核管理'}">
                            <li class="admin-parent">
                                <a class="am-cf" data-am-collapse="{target: '#${childJnode.id}'}"><span
                                        class="am-icon-file"></span> ${childJnode.text_zh_CN}</a>
                                <ul class="am-list am-collapse admin-sidebar-sub am-in" id="${childJnode.id}">
                                    <c:forEach items="${childJnode.children}" var="childchildJnode">
                                        <li>
                                            <a href="<c:url value="${childchildJnode.url}"/>"
                                               class="am-cf ${childchildJnode.jnodeMatch('efy-active',currentJnode!=null?currentJnode:"")}">${childchildJnode.text_zh_CN}</a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </li>
                        </c:if>
                        <c:if test="${empty childJnode.children}">
                            <li><a class="${childJnode.jnodeMatch('efy-active',currentJnode!=null?currentJnode:"")}" href="<c:url value="${childJnode.url}"/>"></span> ${childJnode.text_zh_CN}</a></li>
                        </c:if>
                    </c:if>
                </c:forEach>
            </c:if>
            <c:if test="${review!='4'}">
                <c:forEach items="${jnode.children}" var="childJnode">
                    <c:if test="${!empty childJnode.children&& childJnode.children.size()>0}">
                        <c:if test="${childJnode.text_zh_CN=='入驻审核管理'}">
                            <li class="admin-parent">
                                <a class="am-cf" data-am-collapse="{target: '#${childJnode.id}'}"><span
                                        class="am-icon-file"></span> ${childJnode.text_zh_CN}</a>
                                <ul class="am-list am-collapse admin-sidebar-sub am-in" id="${childJnode.id}">
                                    <c:forEach items="${childJnode.children}" var="childchildJnode">
                                        <li>
                                            <a href="<c:url value="${childchildJnode.url}"/> "
                                               class="am-cf ${childchildJnode.jnodeMatch('efy-active',currentJnode!=null?currentJnode:"")}">${childchildJnode.text_zh_CN}</a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </li>
                        </c:if>
                        <c:if test="${empty childJnode.children}">
                            <li><a class="${childJnode.jnodeMatch('efy-active',currentJnode!=null?currentJnode:"")}" href="<c:url value="${childJnode.url}"/> "></span> ${childJnode.text_zh_CN}</a></li>
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
    </div>
</div>
<script >
    <%--$.ajax({--%>
        <%--type: "post",--%>
        <%--url: '<c:url value="/getMasterUser.do"/>',--%>
        <%--cache: false,--%>
        <%--dataType: "json",--%>
        <%--sync: false,--%>
        <%--success: function (data) {--%>
            <%--console.log(data);--%>
            <%--$("#review").val(data);--%>
        <%--}--%>
    <%--})--%>
</script>
