<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--<div class="am-g">--%>
<%--<c:forEach items="${objectList}" var="tenantBanner" varStatus="banner">--%>
<%--<tr>--%>
<%--<td>--%>
<%--<div class="am-u-sm-4">--%>
<%--<div class="am-thumbnail">--%>
<%--<img src="<c:url value="${tenantBanner.imageUrl}"/>" alt=""/>--%>

<%--<h3 class="am-thumbnail-caption">${tenantBanner.title}</h3>--%>
<%--</div>--%>
<%--</div>--%>
<%--</td>--%>
<%--</tr>--%>
<%--</c:forEach>--%>
<%--</div>--%>
<%--<table class="am-table am-table-bordered">--%>
<div class="am-u-md-12">
<%--<thead>--%>
    <%--<tr>--%>
        <%--<th>传承人轮播图</th>--%>
    <%--</tr>--%>
    <%--</thead>--%>
    <c:forEach items="${objectList}" var="tenantBanner" varStatus="banner">
        <%--<c:if test="${banner.index % 3 == 0 && objectList.size() - 1 != banner.index}">--%>
            <%--<tr>--%>
            <%--<td>--%>
            <div class="am-u-sm-4">
                <div class="am-thumbnail">
                    <img src="<c:url value="${tenantBanner.imageUrl}@!tenant-manage-photo"/>" alt=""/>

                    <h3 class="am-thumbnail-caption">${tenantBanner.title}</h3>
                    <p>
                        <button class="am-btn am-btn-primary">删除</button>
                    </p>
                </div>
            </div>
        <%--</c:if>--%>
        <%--<c:if test="${banner.index % 3 == 1 && objectList.size() - 1 != banner.index}">--%>
            <%--<div class="am-u-sm-4">--%>
                <%--<div class="am-thumbnail">--%>
                    <%--<img src="<c:url value="${tenantBanner.imageUrl}"/>" alt=""/>--%>

                    <%--<h3 class="am-thumbnail-caption">${tenantBanner.title}</h3>--%>
                    <%--<p>--%>
                        <%--<button class="am-btn am-btn-primary">删除</button>--%>
                    <%--</p>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</c:if>--%>
        <%--<c:if test="${banner.index % 3 == 2}">--%>
            <%--<div class="am-u-sm-4">--%>
                <%--<div class="am-thumbnail">--%>
                    <%--<img src="<c:url value="${tenantBanner.imageUrl}"/>" alt=""/>--%>

                    <%--<h3 class="am-thumbnail-caption">${tenantBanner.title}</h3>--%>
                    <%--<p>--%>
                        <%--<button class="am-btn am-btn-primary">删除</button>--%>
                    <%--</p>--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--</td>--%>
            <%--</tr>--%>
        <%--</c:if>--%>

        <%--<c:if test="${banner.index % 3 == 0 && objectList.size() - 1 == banner.index}">--%>
        <%--<tr>--%>
            <%--<td>--%>
                <%--<div class="am-u-sm-4">--%>
                    <%--<div class="am-thumbnail">--%>
                        <%--<img src="<c:url value="${tenantBanner.imageUrl}"/>" alt=""/>--%>

                        <%--<h3 class="am-thumbnail-caption">${tenantBanner.title}</h3>--%>
                        <%--<p>--%>
                            <%--<button class="am-btn am-btn-primary">删除</button>--%>
                        <%--</p>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--</td>--%>
            <%--</tr>--%>
        <%--</c:if>--%>

        <%--<c:if test="${banner.index % 3 == 1 && objectList.size() - 1 == banner.index}">--%>
            <%--<div class="am-u-sm-4">--%>
                <%--<div class="am-thumbnail">--%>
                    <%--<img src="<c:url value="${tenantBanner.imageUrl}"/>" alt=""/>--%>

                    <%--<h3 class="am-thumbnail-caption">${tenantBanner.title}</h3>--%>
                    <%--<p>--%>
                        <%--<button class="am-btn am-btn-default">删除</button>--%>
                    <%--</p>--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--</td>--%>
            <%--</tr>--%>
        <%--</c:if>--%>

    </c:forEach>
<%--</table>--%>
</div>