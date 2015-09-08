<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/25
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>

<html>
<head>
    <title></title>
    <script type="text/javascript" src="<c:url value='/scripts/recommended.js'/>"></script>
    <script>
        function removeTenant(divId){
            $.ajax({
                type: "get",
                url: '<c:url value="/basic/xmj.do?qm=removeTenant"/>',
                cache: false,
                dataType: "json",
                data:{id:divId},
                success: function (data) {
                    $("#"+divId).remove();
                }
            });
        }
    </script>
</head>
<body>
        <div style="text-align: left;margin-bottom: 10px">
            <a type="button" class="am-btn am-btn-default am-btn-xs" href="<c:url value="/basic/xm.do?qm=plistProduct_default&view=newProduct"/>"><span class="am-icon-plus"></span>返回</a>
        </div>

<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}&productId=${productId}"/>

<div class="admin-content">
    <div class="am-g">
        <input name="productId" type="hidden" value="${productId}">
        <div class="am-u-sm-12">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>
                    <th class="table-set">操作</th>
                    <th class="table-title">商家名称</th>
                </tr>
                </thead>
                <tbody>

                <c:forEach items="${requestScope.pageInfo.list}" var="tenant">
                    <tr>
                        <td>
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs">
                                    <c:if test="${tenant.id == tenantId}">
                                        <a  class="am-btn am-btn-default am-btn-xs am-text-secondary" status="1" href="javascript:void(0);" onclick="linkTenant(this,'${tenant.id}');"><span
                                                class="am-icon-pencil-square-o">解除商家</span>
                                        </a>
                                    </c:if>
                                    <c:if test="${tenant.id != tenantId}">
                                        <a  class="am-btn am-btn-default am-btn-xs am-text-secondary" status="0" href="javascript:void(0);" onclick="linkTenant(this,'${tenant.id}');"><span
                                                class="am-icon-pencil-square-o">关联商家</span>
                                        </a>
                                    </c:if>
                                </div>
                            </div>
                        </td>
                        <td class="am-hide-sm-only">
                                ${tenant.name}
                        </td>
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
            <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
            <ming800:pcPageParam name="productId" value="${productId}"/>
        </ming800:pcPageList>
    </div>
</div>
<script>
    function linkTenant(obj,tenantId){
        var productId = $("input[name='productId']").val();
        $.ajax({
            type: "get",
            url: '<c:url value="/product/linkTenant.do"/>',
            cache: false,
            dataType: "json",
            data:{tenantId:tenantId,productId:productId},
            success: function (data) {
                $("a[status='1'] span").text("关联商家");
                $("a[status='1']").attr("status",'0');
                $(obj).find("span").text("解除商家");
                $(obj).attr("status",'1');
            }
        });
    }
</script>
</body>
</html>
