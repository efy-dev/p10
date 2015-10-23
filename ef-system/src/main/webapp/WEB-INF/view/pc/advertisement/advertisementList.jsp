<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/18
  Time: 14:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="admin-content">
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-6">
        </div>
        <div class="am-u-sm-12">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>
                    <th class="table-title">产品名称</th>
                    <th class="table-title">产品编号</th>
                    <th class="table-title">产品价格</th>

                </tr>
                </thead>
                <tbody>
                <c:forEach items="${objectList}" var="product" end="4">
                    <tr id="${product.id}">
                        <td class="am-hide-sm-only"><a
                                href="<c:url value='/basic/xm.do?qm=viewProduct&viewIdentify=${viewIdentify}&param=delivery&id=${product.id}'/>">${product.name}</a>
                            <img width="20px" src="http://pro.efeiyi.com/${product.picture_url}@!product-model" alt="产品图片">
                        </td>
                        <td class="am-hide-sm-only">${product.serial}</td>
                        <td class="am-hide-sm-only">${product.price}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
