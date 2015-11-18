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
    <a class="am-btn am-btn-default am-btn-xs am-text-secondary" target="_blank"
       href="<c:url value="/tuan/sendRedPacket.do"/>"><span
            class="am-icon-pencil-square-o">发放成团红包</span>
    </a>
</div>
<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>
<div class="admin-content">
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-6">
        </div>
        <div class="am-u-sm-12">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>
                    <th class="table-set" >操作</th>
                    <th class="table-title">团长</th>
                    <th class="table-title">团购商品</th>
                    <th class="table-title">状态</th>
                    <th class="table-title">创建时间</th>
                </tr>
                </thead>
                <tbody>

                <c:forEach items="${requestScope.pageInfo.list}" var="group">
                    <tr id="${group.id}">
                        <td width="20%">
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs">

                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="<c:url value="/basic/xm.do?qm=formGroup&id=${group.id}"/>">
                                        查看详情
                                    </a>

                                </div>
                            </div>
                        </td>
                        <td class="am-hide-sm-only" width="20%">${group.manUser.name}</td>
                        <td class="am-hide-sm-only" width="20%">
                                ${group.groupProduct.productModel.name}
                        </td>
                        <td class="am-hide-sm-only" width="20%">
                            <ming800:status name="showStatus" dataType="Group.showStatus" checkedValue="${group.status}" type="normal"/>
                        </td>
                        <td class="am-hide-sm-only" width="20%">
                           <fmt:formatDate value="${group.createDateTime}" pattern="yyyy-MM-dd HH:mm:ss" type="both"/>
                        </td>
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
