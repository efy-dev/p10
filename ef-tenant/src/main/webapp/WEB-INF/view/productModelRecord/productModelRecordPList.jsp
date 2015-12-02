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
        function removeProductModelRecord(divId) {
            jQuery.ajax({
                type: "GET",
                url: '<c:url value="/basic/xmj.do?qm=removeProductModelRecord"/>',
                data: {id: divId},
                dataType: "json",
                success: function (data) {
                    $("#" + divId).remove();
                }
            });
        }
    </script>
</head>
<body>
<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>
<div class="admin-content">

    <div class="am-g">
        <div class="am-btn-toolbar" style="margin-left: 20px;">
            <div class="am-btn-group am-btn-group-xs">
                <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" href="<c:url value="/basic/xm.do?qm=plistKCProductModel_default"/>">
                        <span class="am-icon-trash-o">返回</span>
                </a>

            </div>
        </div>
        <div class="am-u-sm-12">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>
                    <th class="table-set">操作</th>
                    <th class="table-title">产品编号</th>
                    <th class="table-title">产品名称</th>
                    <th class="table-title">入库者</th>
                    <th class="table-title">入库数</th>
                    <th class="table-title">入库时间</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${requestScope.pageInfo.list}" var="productModelRecord">
                    <tr id="${productModelRecord.id}">
                        <td width="15%">
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs">
                                    <button class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                            onclick="showConfirm('提示','是否删除',function(){removeProductModelRecord('${productModelRecord.id}')})"><span
                                            class="am-icon-trash-o">删除</span>
                                    </button>

                                </div>
                            </div>
                        </td>
                        <td class="am-hide-sm-only" width="15%">${productModelRecord.productModel.serial}</td>
                        <td class="am-hide-sm-only" width="15%">${productModelRecord.productModel.name}</td>
                        <td class="am-hide-sm-only" width="15%">${productModelRecord.creator}</td>
                        <td class="am-hide-sm-only" width="15%">${productModelRecord.amount}</td>
                        <td class="am-hide-sm-only" width="15%">
                            <fmt:formatDate value="${productModelRecord.createDateTime}" pattern="yyyy-MM-dd HH:mm:ss" />
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
        </ming800:pcPageList>
    </div>
</div>
</body>
</html>
