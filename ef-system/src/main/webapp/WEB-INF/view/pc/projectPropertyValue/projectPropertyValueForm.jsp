<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<<div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">新建/编辑项目属性值</strong> / <small>New/Edit ProjectTag</small></div>
</div>
<hr/>

<div class="am-g">
    <form action="<c:url value="/basic/xm.do"/>" method="post"  class="am-form am-form-horizontal">
        <input type="hidden" name="qm" value="saveOrUpdateProjectPropertyValue">
        <input type="hidden" name="id" value="${object.id}">
        <input type="hidden" name="projectProperty.id" value="${projectPropertyId}">
        <input type="hidden" name="project.id" value="${projectPropertyId}">
        <input type="hidden" name="resultPage" value="redirect:/basic/xm.do?qm=viewProject&param=project&id=${projectId}" />
        <div class="am-form-group">
            <label name="value" for="value" class="am-u-sm-3 am-form-label">属性值</label>
            <div class="am-u-sm-9">
                <input type="text" name="value" id="value" placeholder="属性值" value="${object.value}">
                <small>必填项*</small>
            </div>
        </div>

        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
                <input type="submit" class="am-btn am-btn-primary" value="保存"/>
            </div>
        </div>
    </form>
</div>
<!-- content end -->
<hr/>
</body>
</html>
