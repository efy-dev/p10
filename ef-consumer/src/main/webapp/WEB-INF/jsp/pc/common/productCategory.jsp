<%@ page import="com.ming800.core.p.PConst" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/18
  Time: 16:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="allsort" style="display: none;">
    <c:forEach items="${categoryList}" var="category" begin="0" end="8">
        <div class="item">
            <c:if test="${category.id==projectCategory.id}">
            <h3 class="active">

                </c:if>
                <c:if test="${category.id!=projectCategory.id}">
                <h3>

                    </c:if><i class="icon-new icon-left"></i><a href="<%=PConst.HOSTNAME%>/project/list/${category.id}" title="">${category.name}</a><i class="icon-new icon-link"></i><i class="icon-new icon-right"></i></h3>
                    <%--<h3 class="active"><i class="icon-new icon-left"></i><a href="<c:url value="/project/list/${category.id}"/>" title="">${category.name}</a><i class="icon-new icon-link"></i><i class="icon-new icon-right"></i></h3>--%>
                <div class="i-mc" style="display: none;">
                    <div class="links">
                        <c:forEach items="${projectMap.get(category.id)}" var="project">
                            <a href="<%=PConst.HOSTNAME%>/product/list/${project.id}" title="">${project.name}</a>
                        </c:forEach>
                            <%--<a class="addeven" href="<c:url value="/product/list/${project.id}"/>" title="查看更多">查看更多</a>--%>
                    </div>
                    <!-- //End--links-->
                        <%--<div class="reco">--%>
                        <%--<c:forEach items="${projectMap.get(category.id)}" var="project">--%>
                        <%--<c:if test="${not empty recommendedTenantList}">--%>
                        <%--<c:forEach items="${recommendedTenantList}" var="tenant">--%>
                        <%--<c:if test="${project.id==tenantMap.get(tenant.id)}">--%>
                        <%--<a href="<c:url value="/tenant/${tenant.id}"/>" title=""> <img class="imgfilter"--%>
                        <%--src="http://pro.efeiyi.com/${tenant.logoUrl}@!project-tenant-pc"--%>
                        <%--alt=""></a>--%>
                        <%--</c:if>--%>
                        <%--</c:forEach>--%>
                        <%--</c:if>--%>
                        <%--</c:forEach>--%>
                        <%--</div>--%>
                        <%--</c:forEach>--%>
                </div>
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