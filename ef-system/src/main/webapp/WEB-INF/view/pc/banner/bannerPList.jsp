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

<html>
<head>
    <title></title>

</head>
<body>
<div class="admin-content">
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-6">
            <div class="am-btn-toolbar">
                <div class="am-btn-group am-btn-group-xs">
                    <a type="button" class="am-btn am-btn-default" href="<c:url value="/basic/xm.do?qm=formBanner&groupName=${groupName}&bucket=tenant"/>"><span class="am-icon-plus"></span>新建轮播图</a>
                </div>
            </div>
        </div>
        <div class="am-u-sm-12">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>
                    <th class="table-set">操作</th>
                    <th class="table-title">标题</th>
                    <th class="table-title">跳转地址</th>
                    <th class="table-title">序号</th>
                    <th class="table-title">图片</th>

                </tr>
                </thead>
                <tbody>

                <c:forEach items="${requestScope.pageInfo.list}" var="banner">
                    <tr id="${banner.id}">
                        <td width="30%">
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs">
                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                       href="<c:url value="/basic/xm.do?qm=formBanner&groupName=${groupName}&bucket=tenant&id=${banner.id}"/>"><span
                                        class="am-icon-trash-o">编辑</span>
                                    </a>
                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                      onclick="showConfirm('提示','是否删除',function(){removeBanner('${banner.id}')})" href="javascript:void (0);"><span
                                            class="am-icon-trash-o">删除</span>
                                    </a>
                                </div>
                            </div>
                        </td>
                        <td class="am-hide-sm-only" width="15%">${banner.title}</td>
                        <td class="am-hide-sm-only" width="25%">
                            <c:if test="${not empty banner.directUrl}">
                                <p style="margin-left: 10px;">
                                    (PC)<a target="_blank" href="${banner.directUrl}">${banner.directUrl}</a>
                                </p>
                            </c:if>
                            <c:if test="${not empty banner.wapUrl}">
                                <p style="margin-left: 0px;">
                                    (WAP) <a target="_blank" href="${banner.wapUrl}">${banner.wapUrl}</a>
                                </p>
                            </c:if>
                        </td>
                        <td class="am-hide-sm-only" width="10%">
                            <a href="#" onclick="toUpdateBannerOrder(this,'<c:url value="/banner/updateBannerOrder.do"/>')" bannerOrder="${banner.bannerOrder}" id="${banner.id}">
                                    ${banner.bannerOrder}
                            </a>
                        </td>
                        <td class="am-hide-sm-only"><img width="20px;" src="<c:url value="http://tenant.efeiyi.com/${banner.imageUrl}@!tenant-manage-banner"/>" alt=""/></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div style="clear: both">
        <c:url value="/basic/xm.do" var="url"/>
        <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
            <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
            <ming800:pcPageParam name="groupName" value="${groupName}"/>
            <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
        </ming800:pcPageList>
    </div>
</div>
<script>
    function toUpdateBannerOrder(obj,updateUrl){
        var bannerOrder = $(obj).attr("bannerOrder");
        var id = $(obj).attr("id");
        $(obj).parent().html("<input id="+id+" onblur=\"updateBannerOrder(this,'"+updateUrl+"')\" type=\"text\" name=\"bannerOrder\" style=\"width: 35px;\" value="+bannerOrder+" />");
    }

    /**
     * 更新序号
     * @param obj
     */
    function updateBannerOrder(obj,updateUrl){
        var bannerOrder = $(obj).val();
        var id = $(obj).attr("id");
        $.ajax({
            type: "get",
            url: updateUrl,
            cache: false,
            dataType: "json",
            data:{id:id,bannerOrder:bannerOrder},
            success: function (data) {
                $(obj).parent().html("<a onclick=\"toUpdateBannerOrder(this,'"+updateUrl+"')\" bannerOrder="+bannerOrder+" id="+id+">"+bannerOrder+"</a>");
            }
        });
    }

    function removeBanner(divId){
        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeBanner"/>',
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
