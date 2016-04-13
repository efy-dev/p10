<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/18
  Time: 16:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<div class="allsort" style="display: none;">--%>
    <%--<c:forEach items="${categoryList}" var="category" begin="0" end="8">--%>
        <%--<div class="item">--%>
            <%--<c:if test="${category.id==projectCategory.id}">--%>
            <%--<h3 class="active">--%>

                <%--</c:if>--%>
                <%--<c:if test="${category.id!=projectCategory.id}">--%>
                <%--<h3>--%>

                    <%--</c:if><i class="icon-new icon-left"></i><a href="<c:url value="/project/list/${category.id}"/>"--%>
                                                                <%--title="">${category.name}</a><i--%>
                        <%--class="icon-new icon-link"></i><i class="icon-new icon-right"></i></h3>--%>
                    <%--&lt;%&ndash;<h3 class="active"><i class="icon-new icon-left"></i><a href="<c:url value="/project/list/${category.id}"/>" title="">${category.name}</a><i class="icon-new icon-link"></i><i class="icon-new icon-right"></i></h3>&ndash;%&gt;--%>
                <%--<div class="i-mc" style="display: none;">--%>
                    <%--<div class="links">--%>
                        <%--<c:forEach items="${projectMap.get(category.id)}" var="project">--%>
                            <%--<a href="<c:url value="/product/list/${project.id}"/>" title="">${project.name}</a>--%>
                        <%--</c:forEach>--%>
                    <%--</div>--%>
                <%--</div>--%>
        <%--</div>--%>
    <%--</c:forEach>--%>
<%--</div>--%>


<div class="dd" style="display:none">
    <c:forEach items="${categoryList}" var="category" begin="0" end="8">
        <div class="layer">
            <ul>
                <li class="title"><a href="<c:url value="/project/list/${category.id}"/>"
                                     title="${category.name}"><strong>${category.name}：</strong></a></li>
                <c:forEach items="${projectMap.get(category.id)}" var="project">
                    <li><a href="<c:url value="/product/list/${project.id}"/>" title="${project.name}">${project.name}</a></li>
                </c:forEach>
            </ul>
        </div>
    </c:forEach>
</div>


<!--//End--nav-new-->
<style>
    .nav-new .cate .allsort {
        width: 180px;
        height: 380px;
        padding: 30px 0;
        position: absolute;
        top: 30px;
        left: 0;
        background: #fff;
        box-sizing: content-box;
    }

    .nav-new .cate .allsort .item .i-mc .links {
        width: 240px;
        height: 384px;
        padding: 28px 41px;
        float: left;
        border-left: 1px solid #e5e5e5;
        border-right: 1px solid #e5e5e5;
        box-sizing: content-box;
    }
</style>