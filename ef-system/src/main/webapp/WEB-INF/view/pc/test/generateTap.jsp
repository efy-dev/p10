<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/15
  Time: 13:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <style>
    </style>
</head>
<body>
<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>

<div class="am-g">
    <div class="am-u-md-12">
        <table class="am-table am-table-bordered">
            <thead>
            <tr>
                <th>测试数据</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">key</td>
                <td class="am-u-md-3">value</td>
                <td class="am-primary am-u-md-3">key</td>
                <td class="am-u-md-3">value</td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">key</td>
                <td class="am-u-md-3">value</td>
                <td class="am-primary am-u-md-3">key</td>
                <td class="am-u-md-3">
                    卡拉集散地反抗了的加速卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
<%--url param target finish--%>
<form action="/basic/xmm.do" enctype="multipart/form-data" method="post">
    <input type="hidden" name="qm" value="saveOrUpdateProduct">

    <input type="text" id="test" data-efy-choose-input
           target="<c:url value="/do/generatePages.do?qm=plistProduct_default"/>">
    <input type="hidden" id="testreal" name="modelName">

    <div class="am-form-group am-form-file">
        <i class="am-icon-cloud-upload"></i> 选择要上传的文件
        <input name="test" type="file" multiple>
    </div>
    <input type="submit" class="am-btm am-btn-default" value="提交">
</form>

<script src="<c:url value="/resources/js/choosePage.js?v=1"/> "></script>
</body>
</html>
