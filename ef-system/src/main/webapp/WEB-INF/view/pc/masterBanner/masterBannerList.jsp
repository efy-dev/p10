<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<%--<div class="am-g">--%>
<%--<c:forEach items="${objectList}" var="masterBanner" varStatus="banner">--%>
<%--<tr>--%>
<%--<td>--%>
<%--<div class="am-u-sm-4">--%>
<%--<div class="am-thumbnail">--%>
<%--<img src="<c:url value="${masterBanner.imageUrl}"/>" alt=""/>--%>

<%--<h3 class="am-thumbnail-caption">${masterBanner.title}</h3>--%>
<%--</div>--%>
<%--</div>--%>
<%--</td>--%>
<%--</tr>--%>
<%--</c:forEach>--%>
<%--</div>--%>
<%--<table class="am-table am-table-bordered">--%>
<%--<thead>--%>
    <%--<tr>--%>
        <%--<th>传承人轮播图</th>--%>
    <%--</tr>--%>
    <%--</thead>--%>
    <%--<c:forEach items="${objectList}" var="masterBanner" varStatus="banner">--%>
        <%--&lt;%&ndash;<c:if test="${banner.index % 3 == 0 && objectList.size() - 1 != banner.index}">&ndash;%&gt;--%>
            <%--&lt;%&ndash;<tr>&ndash;%&gt;--%>
            <%--&lt;%&ndash;<td>&ndash;%&gt;--%>
            <%--<div class="am-u-sm-4" id="${masterBanner.id}">--%>
                <%--<div class="am-thumbnail">--%>
                    <%--<img src="<c:url value="http://master.efeiyi.com/${masterBanner.imageUrl}@!master-manage-photo"/>" alt=""/>--%>

                    <%--<h3 class="am-thumbnail-caption">${masterBanner.title}</h3>--%>
                    <%--<p>--%>
                        <%--<a class="am-btn am-btn-primary" onclick="removeMasterBanner('${masterBanner.id}')">删除</a>--%>
                    <%--</p>--%>
                <%--</div>--%>
            <%--</div>--%>
    <%--</c:forEach>--%>


    <table class="am-table am-table-striped am-table-hover table-main">
        <thead>
        <tr>
<security:authorize ifAnyGranted="admin,operational,c_operational">
            <th class="table-set">操作</th>
</security:authorize>
            <th class="table-title">标题</th>
            <th class="table-title">图片</th>


        </tr>
        </thead>
        <tbody>

        <c:forEach items="${objectList}" var="masterBanner" varStatus="banner">
            <tr id="${masterBanner.id}">
                <security:authorize ifAnyGranted="admin,operational,c_operational">
                <td>
                    <div class="am-btn-toolbar">
                        <div class="am-btn-group am-btn-group-xs">
                            <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" onclick="removeMasterBanner('${masterBanner.id}')"><span
                                    class="am-icon-trash-o"></span> 删除
                            </a>
                        </div>
                    </div>
                </td>
                </security:authorize>
                <td class="am-hide-sm-only">${masterBanner.title}</td>
                <td class="am-hide-sm-only"><img width="35px;" src="<c:url value="http://tenant.efeiyi.com/${masterBanner.imageUrl}@!tenant-manage-banner"/>" alt=""/></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>




<%--</table>--%>

<script>

    function removeMasterBanner(divId){
        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeMasterBanner"/>',
            cache: false,
            dataType: "json",
            data:{id:divId},
            success: function (data) {
                $("#"+divId).remove();
            }
        });
    }

</script>