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

    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-6">
        </div>
        <div class="am-u-sm-12">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>
                    <td width="74%">项目名称</td>
                    <td width="">项目编号</td>

                </tr>
                </thead>
                <tbody>
                <c:forEach items="${objectList}" var="tenantProject" end="4">
                    <tr id="${tenantProject.id}">
                        <td class="am-hide-sm-only">
                            ${tenantProject.project.name}
                        </td>
                        <td class="am-hide-sm-only"> ${tenantProject.project.serial}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

