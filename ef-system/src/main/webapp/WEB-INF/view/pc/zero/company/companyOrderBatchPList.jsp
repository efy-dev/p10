<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/12/14
  Time: 14:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title>企业礼品卡批次管理</title>
</head>
<body style="height: auto">
<div style="text-align: left;margin-left: 10px;">
    <input onclick="window.location.href='<c:url value="/basic/xm.do?qm=formCompanyOrderBatch&company=company"/>'"
           type="button" class="am-btn am-btn-default am-btn-xs"
           style="margin-top: 4px;margin-bottom: 6px;margin-left:2px;height: 35px;"
           value="新建礼品卡批次"/>
</div>
<div>
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr style="text-align:left">
            <td>操作</td>
            <td>礼品卡编号</td>
            <td>企业用户</td>
            <td>礼品名称</td>
            <td>礼品数量</td>
            <td>创建时间</td>
        </tr>
        <c:forEach items="${requestScope.pageInfo.list}" var="batch">
            <tr>
                <td>
                    <div class="am-btn-toolbar">
                        <div class="am-btn-group am-btn-group-xs" style="width: 100%;">
                            <c:if test="${batch.status == '1'}">
                                <button onclick="window.location.href='<c:url
                                        value="/basic/xm.do?qm=formCompanyOrderBatch&company=company&id=${batch.id}"/>'"
                                        class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span
                                        class="am-icon-edit"></span> 编辑
                                </button>
                                <button onclick="window.location.href='<c:url
                                        value="/basic/xm.do?qm=removeCompanyOrderBatch&id=${batch.id}"/>'"
                                        class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                                        class="am-icon-trash-o"></span> 删除
                                </button>
                                <button onclick="window.location.href='<c:url
                                        value="/company/saveCompanyOrderGiftList.do?id=${batch.id}"/>'"
                                        class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span
                                        class="am-icon-edit"></span> 生成礼品卡
                                </button>
                            </c:if>
                            <c:if test="${batch.status == '2'}">
                                <button onclick="window.location.href='<c:url
                                        value="/basic/xm.do?qm=plistPurchaseOrderGift_companyOrderBatch&company=company&conditions=companyOrderBatch.id:${batch.id}"/>'"
                                        class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span
                                        class="am-icon-edit"></span> 查看礼品卡
                                </button>
                                <button onclick="window.location.href='<c:url
                                        value="/company/downloadOrderGiftsTxt.do?id=${batch.id}"/>'"
                                        class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span
                                        class="am-icon-edit"></span> 下载礼品卡链接
                                </button>
                            </c:if>
                        </div>
                    </div>
                </td>
                <td>${batch.serial}</td>
                <td>${batch.companyName}</td>
                <td>${batch.productModel.product.name}
                    <c:if test="${not empty batch.productModel}">[${batch.productModel.name}]</c:if>
                </td>
                <td>${batch.amount}</td>
                <td>
                    <fmt:formatDate value="${batch.createDatetime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
<div style="clear: both">
    <c:url value="/basic/xm.do" var="url"/>
    <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
        <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
        <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
    </ming800:pcPageList>
</div>
</body>
</html>
