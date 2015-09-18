<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title></title>
</head>
<body>
<div class="am-g">
    <div class="am-u-md-12">
        <h2>详细信息</h2>
        <table class="am-table am-table-bordered">
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">类别名称</td>
                <td class="am-u-md-3">${object.name}</td>
                <td class="am-primary am-u-md-3">类别编号</td>
                <td class="am-u-md-3" colspan="3">
                 ${object.serial}
                </td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">类别图片</td>
                <td class="am-u-md-3">  <img width="35px" src="http://pro.efeiyi.com/${object.pictureUrl}@!product-model" alt="类别图片"></td>
                <td class="am-primary am-u-md-3"></td>
                <td class="am-u-md-3" colspan="3">

                </td>
            </tr>
            </tbody>
        </table>

    </div>
</div>

<div class="am-g">
    <div class="am-u-md-12">
        <h2>推荐产品</h2>
    </div>

    <div class="am-u-md-12">
        <jsp:include flush="true"
                     page="/basic/xm.do?qm=listProjectCategoryProductModel_default&conditions=projectCategory.id:${object.id}"/>
    </div>
</div>


</body>
</html>
