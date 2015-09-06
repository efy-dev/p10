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
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ include file="/layouts/public.jsp" %>
<html>
<head>
    <title></title>
</head>
<body style="height: auto">
<div style="text-align: left;margin-left: 10px;" >
    <input onclick="window.location.href='<c:url value="/basic/xm.do?qm=formProduct&product=product"/>'" type="button"
           class="am-btn am-btn-default am-btn-xs"
           style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;" value="新建商品" />
</div>
<jsp:include page="/layouts/myConfirm.jsp"/>
<div>
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr>
            <td>操作</td>
            <td>商品编号</td>
            <td>商品名称</td>
            <td>制作大师</td>
            <td>非遗项目</td>
            <td>所属商户</td>
            <td>制作完成时间</td>
        </tr>
        <c:forEach items="${requestScope.pageInfo.list}" var="product">
            <tr>
                <td>
                    <div class="am-btn-toolbar">
                        <div class="am-btn-group am-btn-group-xs" style="width: 100%;" >
                            <button onclick="window.location.href='<c:url value="/basic/xm.do?qm=formProduct&product=product&id=${product.id}"/>'"
                                    class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span class="am-icon-edit"></span> 编辑</button>
                            <button onclick="myConfirm('<c:url value="/basic/xm.do?qm=removeProduct&id=${product.id}"/>', 'D')"
                                    class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 删除</button>
                        </div>
                    </div>
                </td>
                <td><a href="<c:url value='/basic/xm.do?qm=viewProduct&product=product&id=${product.id}'/>">${product.serial}</a></td>
                <td>${product.name}
                    <c:if test="${not empty product.logo}">
                        <img src="<%=imgBasePath %>${product.logo}<%=imgListCss %>">
                    </c:if>
                </td>
                <td>${product.masterName}</td>
                <td>${product.productSeries.name}</td>
                <td>${product.tenant.name}</td>
                <td><fmt:formatDate value="${product.madeYear}" pattern="yyyy-MM-dd"/></td>
            </tr>
        </c:forEach>
    </table>
</div>
<div style="clear: both">
    <c:url value="/basic/xm.do" var="url" />
    <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
        <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
        <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
    </ming800:pcPageList>
</div>
</body>
</html>
