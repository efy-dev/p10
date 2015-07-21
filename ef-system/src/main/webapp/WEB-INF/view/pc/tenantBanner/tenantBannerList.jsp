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
    <%--<c:forEach items="${objectList}" var="tenantBanner" varStatus="banner">--%>
        <%--&lt;%&ndash;<c:if test="${banner.index % 3 == 0 && objectList.size() - 1 != banner.index}">&ndash;%&gt;--%>
            <%--&lt;%&ndash;<tr>&ndash;%&gt;--%>
            <%--&lt;%&ndash;<td>&ndash;%&gt;--%>
            <%--<div class="am-u-sm-4" id="${tenantBanner.id}">--%>
                <%--<div class="am-thumbnail">--%>
                    <%--<img src="<c:url value="http://tenant.efeiyi.com/${tenantBanner.imageUrl}@!tenant-manage-photo"/>" alt=""/>--%>

                    <%--<h3 class="am-thumbnail-caption">${tenantBanner.title}</h3>--%>
                    <%--<p>--%>
                        <%--<a class="am-btn am-btn-primary" onclick="removeTenantBanner('${tenantBanner.id}')">删除</a>--%>
                    <%--</p>--%>
                <%--</div>--%>
            <%--</div>--%>
    <%--</c:forEach>--%>


    <table class="am-table am-table-striped am-table-hover table-main">
        <thead>
        <tr>
            <th class="table-set">操作</th>
            <th class="table-title">标题</th>
            <th class="table-title">图片</th>


        </tr>
        </thead>
        <tbody>

        <c:forEach items="${objectList}" var="tenantBanner" varStatus="banner">
            <tr id="${tenantBanner.id}">
                <td>
                    <div class="am-btn-toolbar">
                        <div class="am-btn-group am-btn-group-xs">
                            <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" onclick="removeTenantBanner('${tenantBanner.id}')"><span
                                    class="am-icon-trash-o"></span> 删除
                            </a>
                        </div>
                    </div>
                </td>
                <td class="am-hide-sm-only">${tenantBanner.title}</td>
                <td class="am-hide-sm-only"><img src="<c:url value="http://tenant.efeiyi.com/${tenantBanner.imageUrl}@!tenant-manage-banner"/>" alt=""/></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>




<%--</table>--%>
</div>

<script>

    function removeTenantBanner(divId){
        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeTenantBanner"/>',
            cache: false,
            dataType: "json",
            data:{id:divId},
            success: function (data) {
                $("#"+divId).remove();
            }
        });
    }

</script>