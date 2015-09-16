<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title></title>
</head>
<body>


<div class="am-g">
    <div style="text-align: left;margin-left: 18px;" >
        <input onclick="window.location.href='<c:url value="/basic/xm.do?qm=plistProject_default"/>'" type="button" class="am-btn am-btn-default am-btn-xs" style="margin-top: 4px;margin-bottom: 6px;width: 100px;height: 35px;" value="返回列表" />
        <input onclick="window.location.href='<c:url value="/basic/xm.do?qm=formProject&param=formProject"/>'" type="button" class="am-btn am-btn-default am-btn-xs" style="margin-top: 4px;margin-bottom: 6px;width: 100px;height: 35px;" value="新建项目" />
        <input onclick="window.location.href='<c:url value="/basic/xm.do?qm=formProject&param=formProject&id=${object.id}"/>'" type="button" class="am-btn am-btn-default am-btn-xs" style="margin-top: 4px;margin-bottom: 6px;width: 100px;height: 35px;" value="编辑项目" />
    </div>
    <div class="am-u-sm-12">
        <table class="am-table am-table-bordered">
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">项目名称</td>
                <td class="am-u-md-3">${object.name}</td>
                <td class="am-primary am-u-md-3">项目编号</td>
                <td class="am-u-md-3">${object.serial}</td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">父类别</td>
                <td class="am-u-md-3">
                    <c:if test="${not empty object.projectCategory.id}">
                        ${object.projectCategory.name}
                    </c:if>
                </td>
                <td class="am-primary am-u-md-3">父项目</td>
                <td class="am-u-md-3">
                    <c:if test="${not empty object.fatherProject.id}">
                        ${object.fatherProject.name}
                    </c:if>
                </td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">项目图片</td>
                <td class="am-u-md-3">
                    <img width="35px;" src="<c:url value="http://pro.efeiyi.com/${object.picture_url}@!product-model"/>" alt=""/>
                </td>
                <td class="am-primary am-u-md-3">省</td>
                <td class="am-u-md-3">
                    ${object.addressDistrict.addressCity.addressProvince.name}
                </td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">市</td>
                <td class="am-u-md-3">
                    ${object.addressDistrict.addressCity.name}
                </td>
                <td class="am-primary am-u-md-3">区</td>
                <td class="am-u-md-3">
                    ${object.addressDistrict.name}
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
<!-- content end -->
<hr/>
</body>
</html>
