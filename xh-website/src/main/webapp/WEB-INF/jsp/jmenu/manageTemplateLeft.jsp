<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/17
  Time: 19:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="wh nav">
    <div class="hd">
        <ul class="ul-list">
            <c:forEach items="${jmenu.children}" var="jmenuNode">
                <c:if test="${currentJnode.id== jmenuNode.id}">
                    <li class="items active"><a href="<c:url value= '${jmenuNode.url}'/>" title=""
                                                target="_parent">${jmenuNode.text_zh_CN}</a></li>
                </c:if>
                <c:if test="${currentJnode.id!= jmenuNode.id}">
                    <li>
                        <a href="<c:url value= '${jmenuNode.url}'/>" title=""
                           target="_parent">${jmenuNode.text_zh_CN}</a>
                    </li>
                </c:if>

            </c:forEach>
        </ul>
        <a href="#btn-menu-down" class="btn-menu-down" title=""><i class="icon icon-menu"></i></a>
        <a style="display:none" href="btn-menu-up" class="btn-menu-up" title=""><i class="icon icon-menu"></i></a>
    </div>
</div>
<input type="hidden" value="${currentJnode.id}" id="currentJnode">
<input type="hidden" value="${jmenu.id}" id="jmenu">
<!--//End--nav-->