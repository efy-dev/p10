<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/11
  Time: 14:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title></title>
</head>
<body>
<div style="text-align: left;margin-left: 10px;">
    <button onclick="window.location.href='<c:url value="/myDocument/newOrganization.do?qm=direct2JspOrganization_default&group=${group}&resultPage=/myDocument/organization.do?qm=${requestScope.qm}"/>'"
            class="am-btn am-btn-default am-btn-xs"
            style="margin-top: 4px;margin-bottom: 6px;margin-left:2px;height: 35px;">新建
        <ming800:status name="group" dataType="intangibleCultureOrganization.group" checkedValue='${group}' type="normal"/>
    </button>
</div>
<jsp:include page="/layouts/myConfirm.jsp"/>
<div class="am-g">
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr>
            <td>操作</td>
            <td>名称</td>
            <td>地址</td>
            <td>负责人</td>
        </tr>
        <c:forEach items="${intangibleCulturalOrganizationList}" var="organization">
            <tr>
                <td>
                    <div class="am-btn-toolbar">
                        <div class="am-btn-group am-btn-group-xs" style="width: 100%;">
                            <button onclick="window.location.href='<c:url
                                    value="/myDocument/newOrganization.do?qm=direct2JspOrganization_newOrganization&group=${group}&id=${organization.id}&resultPage=/myDocument/organization.do?qm=${requestScope.qm}"/>'"
                                    class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span class="am-icon-edit"></span> 编辑</button>
                            <button onclick="myConfirm('<c:url
                                    value="/myOrganization/removeOrganization.do?qm=removeContent&id=${organization.id}&resultPage=/myDocument/organization.do?qm=${requestScope.qm}"/>', 'D');"
                                    class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 删除</button>
                        </div>
                    </div>
                </td>
                <td>
                    <div>${organization.name}</div>
                </td>
                <td>
                    <div>${organization.addressDistrict.addressCity.addressProvince.name} ${organization.addressDistrict.addressCity.name} ${organization.addressDistrict.name}</div>
                </td>
                <td>
                    <div>${organization.inCharge}</div>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
<div style="clear: both">
    <c:url value="/myDocument/organization.do" var="url"/>
    <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
        <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
        <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
    </ming800:pcPageList>
</div>
</body>
</html>
