<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/24
  Time: 19:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="hd">
    <div class="slide-left">
        <div class="nav-list">
            <ul class="nav-list-ul">
                <li class="title"><a href="" target="_parent" title="">${currentJnode.text_zh_CN}</a></li>
                <c:forEach items="${currentJnode.children}" var="child" varStatus="status">
                    <c:if test="${child.id== matchJnode.id}">
                        <c:if test="${empty child.children}">
                        <li class="items active"><a href="${child.url}" target="_parent"
                                                    title="">${child.text_zh_CN}</a></li>
                        </c:if>
                        <c:if test="${not empty child.children}">
                            <li class="items active">
                                <a class="btn-list" href="" target="_parent" title="">协会会员<i class="icon"></i></a>
                                <div class="items-list" style="display: block;">
                                    <c:forEach items="${child.children}" var="subChild">
                                        <c:if test="${child.id== matchJnode.id}">
                                    <a class="items-active" href="${subChild.url}" target="_parent" title="">${subChild.text_zh_CN}</a>
                                        </c:if>
                                        <c:if test="${child.id!= matchJnode.id}">
                                        <a class="items-a" href="${subChild.url}" target="_parent" title="">${subChild.text_zh_CN}</a>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </li>
                        </c:if>
                    </c:if>
                    <c:if test="${child.id != matchJnode.id}">
                        <c:if test="${empty child.children}">
                            <li class="items"><a href="${child.url}" target="_parent"
                                                        title="">${child.text_zh_CN}</a></li>
                        </c:if>
                        <c:if test="${not empty child.children}">
                            <li class="items">
                                <a class="btn-list" href="" target="_parent" title="">${child.text_zh_CN}<i class="icon"></i></a>
                                <div class="items-list" style="display: block;">
                                    <c:forEach items="${child.children}" var="subChild">
                                        <c:if test="${subChild.id== matchJnode.id}">
                                            <a class="items-active" href="${subChild.url}" target="_parent" title="">${subChild.text_zh_CN}</a>
                                        </c:if>
                                        <c:if test="${subChild.id!= matchJnode.id}">
                                            <a class="items-a" href="${subChild.url}" target="_parent" title="">${subChild.text_zh_CN}</a>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </li>
                        </c:if>
                    </c:if>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>
<input type="hidden" value="${matchJnode.id}" id="matchJnode">
<!-- //End--slide-left-->
