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

<html>
<head>
    <title></title>
    <script type="text/javascript" src="<c:url value='/scripts/recommended.js'/>"></script>
</head>
<body>
<div class="admin-content">
    <div class="am-u-sm-12 am-u-md-6">
        <div class="am-btn-toolbar">
            <div class="am-btn-group am-btn-group-xs">
                <%--<a type="button" class="am-btn am-btn-default" href="<c:url value="/basic/xm.do?qm=formProductRecommended"/>"><span class="am-icon-plus"></span> 新建</a>--%>
            </div>
        </div>
    </div>
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-6">
        </div>
        <div class="am-u-sm-12">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>
                    <th class="table-set">操作</th>
                    <th class="table-title">排序</th>
                    <th class="table-title">产品名称</th>
                    <th class="table-title">产品价格</th>
                    <th class="table-title">产品分类</th>
                    <th class="table-title">所属商家</th>
                    <th class="table-title">产品图片</th>

                </tr>
                </thead>
                <tbody>



                <c:forEach items="${requestScope.pageInfo.list}" var="productRecommended">
                    <tr id="${productRecommended.id}">
                        <td>
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs">
                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                       href="<c:url value="/basic/xm.do?qm=removeProductRecommended&id=${productRecommended.id}"/>"><span
                                            class="am-icon-trash-o"></span> 删除
                                    </a>
                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                       onclick="deleteObjectRecommended('${productRecommended.id}','<c:url value="/Recommended/deleteObjectRecommended.do" />')" href="#"><span
                                            class="am-icon-trash-o"></span> 取消推荐
                                    </a>
                                </div>
                            </div>
                        </td>
                        <td class="am-hide-sm-only">
                            <a href="#" onclick="toUpdateSort(this,'<c:url value="/Recommended/updateSort.do"/>')" sort="${productRecommended.sort}" id="${productRecommended.id}">
                                    ${productRecommended.sort}
                            </a>
                        </td>
                        <td class="am-hide-sm-only"><a href="<c:url value='/basic/xm.do?qm=viewProduct&view=recommend&id=${productRecommended.product.id}'/>">${productRecommended.product.name}</a></td>
                        <td class="am-hide-sm-only">${productRecommended.product.price}</td>
                        <td class="am-hide-sm-only">${productRecommended.product.category.name}</td>
                        <td class="am-hide-sm-only"><a href="<c:url value='/basic/xm.do?qm=viewTenant&view=recommend&id=${productRecommended.product.tenant.id}'/>">${productRecommended.product.tenant.name}</a></td>
                        <td class="am-hide-sm-only"><img src="${productRecommended.product.picture_url}" alt="推荐产品图片"></td>
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
