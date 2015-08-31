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
                    <th class="table-title">大师姓名</th>
                    <th class="table-title">性别</th>
                    <th class="table-title">等级</th>

                </tr>
                </thead>
                <tbody>
                <c:forEach items="${objectList}" var="tenantMaster" end="4">
                    <tr id="${tenantMaster.id}">
                        <td class="am-hide-sm-only">
                            ${tenantMaster.master.fullName}
                        </td>
                        <td class="am-hide-sm-only">${product.sex}</td>
                        <td class="am-hide-sm-only">${product.level}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
