<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/24
  Time: 19:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--//End--header-->
<%--<div class="wh home-list news">--%>
    <%--${matchJnode.id}--%>
    <div class="hd">
        <div class="slide-left">
            <div class="nav-list">
                <ul class="nav-list-ul">
                    <li class="title"><a href="" target="_parent" title="">${currentJnode.text_zh_CN}</a></li>
                    <c:forEach items="${currentJnode.children}" var="children" varStatus="status">
                        <c:if test="${children.id== matchJnode.id}">
                            <li class="items active"><a href="${children.url}" target="_parent"
                                                        title="">${children.text_zh_CN}</a></li>
                        </c:if>
                        <c:if test="${children.id!= matchJnode.id}">
                            <li class="items"><a href="${children.url}" target="_parent"
                                                 title="">${children.text_zh_CN}</a></li>
                        </c:if>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
<%--</div>--%>
        <!-- //End--slide-left-->
        <!-- //End--slide-right-->