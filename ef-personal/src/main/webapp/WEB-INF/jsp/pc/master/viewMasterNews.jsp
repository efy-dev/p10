<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title></title>
    <script src="<c:url value='/resources/plugins/ckeditor/ckeditor.js'/>" ></script>
    <style>
    </style>
</head>
<body>
<%--<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>--%>

<div class="am-g">
    <div class="am-u-md-12">
        <h2>详细信息</h2>
        <table class="am-table am-table-bordered">
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">标题</td>
                <td class="am-u-md-3">${object.title}</td>
                <td class="am-primary am-u-md-3">资讯来源</td>
                <td class="am-u-md-3">${object.dataSource}</td>
            </tr>

            </tbody>
        </table>

    </div>

</div>

<div>
    <label   class="am-u-sm-3 am-form-label">短简介 / Brief</label>
</div>
<div class="am-u-md-12">
  <div >
    ${object.brief}
  </div>
</div>

<div>
    <label   class="am-u-sm-3 am-form-label">作品介绍 / content</label>
</div>
<div class="am-u-md-12">
    <div >
          <textarea id="content" name="content" class="ckeditor" placeholder=""
                    value="${object.content}" readonly="readonly">${object.content}</textarea>
    </div>
</div>


</div>
</body>
</html>
