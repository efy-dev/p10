<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/22
  Time: 17:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <script src="/scripts/ckeditor/ckeditor.js"></script>
</head>
<body>
<div class="am-g">
    <div class="am-u-md-12">
        <h2>传承人资讯详细信息</h2>
        <table class="am-table am-table-bordered">
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">标题</td>
                <td class="am-u-md-3">${object.title}</td>
                <td class="am-primary am-u-md-3">作者</td>
                <td class="am-u-md-3">${!empty object.creator ?object.creator.name:""}</td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">来源</td>
                <td class="am-u-md-3">${object.dataSource}</td>
                <td class="am-primary am-u-md-3">创建时间</td>
                <%--<td class="am-u-md-3"><fmt:formatDate value="${object.createDateTime}" pattern="yyyy-MM-dd HH:mm"/></td>--%>
                <td class="am-u-md-3">${object.createDateTime}</td>
            </tr>
            </tbody>
        </table>
        <div class="am-u-md-6">
            <h3>资讯内容</h3>
            <textarea style="width:100%" id="content" class="ckeditor"
                      readonly>${object.content}</textarea>
        </div>


    </div>
</div>
</body>
</html>
