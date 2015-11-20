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
        function removeProductModel(productId) {
            jQuery.ajax({
                type: "GET",
                url: '<c:url value="/basic/xmj.do?qm=removeProductModel"/>',
                data: {id: productId},
                dataType: "json",
                success: function (data) {
                    $("#" + productId).remove();
                }
            });
        }
    </script>
</head>
<body>
<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>
<div class="admin-content">
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-6">
        </div>
        <div class="am-u-sm-12">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>
                    <th class="table-set">操作</th>
                    <th class="table-title">产品名称</th>
                    <th class="table-title">产品编号</th>
                    <th class="table-title">产品价格</th>
                    <th class="table-title">项目</th>
                    <th class="table-title">项目类别</th>
                    <th class="table-title">图片</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${requestScope.pageInfo.list}" var="productModel">
                    <tr id="${productModel.id}">
                        <td>
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs">
                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                       href="<c:url value=""/>"><span
                                            class="am-icon-trash-o">秒杀</span>
                                    </a>
                                </div>
                            </div>
                        </td>
                        <td class="am-hide-sm-only"><a
                                href="<c:url value='/basic/xm.do?qm=viewProduct&view=index&id=${productModel.product.id}'/>">${productModel.product.name}</a>
                        </td>
                        <td class="am-hide-sm-only">${productModel.serial}</td>
                        <td class="am-hide-sm-only">${productModel.price}</td>
                        <td class="am-hide-sm-only">${productModel.product.project.name}</td>
                        <td class="am-hide-sm-only">${productModel.product.project.projectCategory.name}</td>
                        <td class="am-hide-sm-only">
                            <img width="20px" src="http://pro.efeiyi.com/${productModel.product.picture_url}@!product-model" alt="产品图片">
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
