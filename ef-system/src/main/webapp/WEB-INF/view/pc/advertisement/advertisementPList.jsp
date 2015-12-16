<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/25
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title></title>
    <script>
        <%--function removeProduct(productId){--%>
            <%--jQuery.ajax({--%>
                <%--type:"GET",--%>
                <%--url:'<c:url value="/basic/xmj.do?qm=removeProduct"/>',--%>
                <%--data:{id:productId},--%>
                <%--dataType:"json",--%>
                <%--success:function(data){--%>
                    <%--$("#"+productId).remove();--%>
                <%--}--%>
            <%--});--%>
        <%--}--%>
    </script>
</head>
<body>


<div style="text-align: left" >
<security:authorize ifAnyGranted="admin,operational,c_operational,o_operational">
    <input onclick="window.location.href='<c:url value="/basic/xm.do?qm=formAdvertisement"/>'" type="button" class="am-btn am-btn-default am-btn-xs" style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;" value="新建广告" />
</security:authorize>
</div>
<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>
<div class="">
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-6">
        </div>
        <div class="am-u-sm-12">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>
<security:authorize ifAnyGranted="admin,operational,c_operational,o_operational">
                    <th class="table-set" >操作</th>
</security:authorize>
                    <th class="table-title">广告名称</th>
                    <th class="table-title">类别</th>
                    <th class="table-title">广告链接</th>
                    <th class="table-title">广告图片</th>
                    <th class="table-title">价格</th>
                    <th class="table-title">排序</th>

                </tr>
                </thead>
                <tbody>

                <c:forEach items="${requestScope.pageInfo.list}" var="ads">
                    <tr id="${ads.id}">
                        <security:authorize ifAnyGranted="admin,operational,c_operational,o_operational">
                        <td width="15%">
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs">

                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="<c:url value="/basic/xm.do?qm=formAdvertisement&id=${ads.id}"/>">
                                        编辑
                                    </a>
                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="javascript:void (0);" onclick="showConfirm('提示','是否删除',function(){removeAds('${ads.id}')})">
                                        删除
                                    </a>

                                </div>
                            </div>
                        </td>
                        </security:authorize>
                        <td class="am-hide-sm-only" width="20%">${ads.name}</td>
                        <td class="am-hide-sm-only" width="15%">
                            <ming800:status name="groupName" dataType="Advertisement.group" checkedValue="${ads.groupName}" type="normal"/>
                        </td>
                        <td class="am-hide-sm-only" width="15%">
                            <c:if test="${not empty ads.redirect}">
                            <p style="margin-left: 10px;">
                                (PC)<a target="_blank" href="${ads.redirect}">${ads.redirect}</a>
                            </p>
                            </c:if>
                            <c:if test="${not empty ads.wapRedirect}">
                            <p style="margin-left: 0px;">
                                (WAP) <a target="_blank" href="${ads.wapRedirect}">${ads.wapRedirect}</a>
                            </p>
                            </c:if>
                        </td>
                        <td class="am-hide-sm-only" width="15%">
                            <img width="35px;" src="<c:url value="http://pro.efeiyi.com/${ads.img}@!product-model"/>"
                                 alt=""/>
                        </td>
                        <td class="am-hide-sm-only" width="10%">
                           ${ads.price}
                        </td>
                        <td class="am-hide-sm-only" width="10%">${ads.adsOrder}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div style="clear: both">
        <c:url value="/basic/xm.do" var="url" />
        <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
            <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
            <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
        </ming800:pcPageList>
    </div>
</div>
<script>
    function removeAds(divId){
        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeAdvertisement"/>',
            cache: false,
            dataType: "json",
            data:{id:divId},
            success: function (data) {
                $("#"+divId).remove();
            }
        });
    }


</script>

</body>
</html>
