<%@ page import="com.ming800.core.p.PConst" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/28
  Time: 16:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>分类导航</title>
</head>
<body>
<article class="custom">
    <%--<div class="box-hd">--%>
    <%--<div class="title2"><strong>陶冶烧造</strong></div>--%>
    <%--<ul class="ul-index-list">--%>
    <%--<li>--%>
    <%--<a class="item" href="javascript;" title=""><i class="arrow-down"></i><img src="../shop2015/upload/box-hd-2-4.jpg" alt=""/></a>--%>
    <%--</li>--%>
    <%--</ul>--%>
    <%--<ul class="ul-nav-list" style="display:none;">--%>
    <%--<li class="active"><a href="#汝窑" title="汝窑">汝窑</a></li>--%>
    <%--<li><a href="#定窑" title="定窑">定窑</a></li>--%>
    <%--<li><a href="#钧窑" title="钧窑">钧窑</a></li>--%>
    <%--<li><a href="#景德镇" title="景德镇">景德镇</a></li>--%>
    <%--<li><a href="#景德镇" title="景德镇">景德镇</a></li>--%>
    <%--<li><a href="#景德镇" title="景德镇">景德镇</a></li>--%>
    <%--</ul>--%>
    <%--</div>--%>

    <c:forEach items="${categoryList}" var="category">
        <div class="box-hd">
            <div class="title2"><strong>${category.name}</strong></div>
            <ul class="ul-index-list">
                <li>
                    <a class="item" href="javascript;" title=""><i class="arrow-down"></i><img
                            src="http://pro.efeiyi.com/${category.pictureUrl}" alt=""/></a>
                </li>
            </ul>
            <ul class="ul-nav-list" style="display:none;">
                <c:forEach items="${projectMap.get(category.id)}" var="project">
                    <%--<li><a href="<c:url value="/product/list/${project.id}"/>" target="_blank" title="${project.name}">${project.name}</a></li>--%>
                    <li class="active"><a href="<%=PConst.HOSTNAME%>/product/list/${project.id}"
                                          title="${project.name}">${project.name}</a></li>
                </c:forEach>
                    <%--<li><a href="" target="_blank" title="">景泰蓝</a></li>--%>
                    <%--<li><a href="" target="_blank" title="">景德镇</a></li>--%>
                    <%--<li><a href="" target="_blank" title="">钧瓷</a></li>--%>
                    <%--<li><a href="" target="_blank" title="">龙泉青瓷</a></li>--%>
            </ul>
        </div>
    </c:forEach>

</article>
</body>
</html>
