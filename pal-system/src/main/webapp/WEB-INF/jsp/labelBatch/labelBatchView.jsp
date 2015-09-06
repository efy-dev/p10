<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/22
  Time: 16:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title></title>
</head>
<body>

<div style="text-align: left;margin-left: 10px;">
<c:if test="${object.status == '1'}">
    <input onclick="window.location.href='<c:url value="/basic/xm.do?qm=formLabelBatch&id=${object.id}"/>'"
           type="button" class="am-btn am-btn-default am-btn-xs"
           style="margin-top: 8px;margin-bottom: 6px;margin-left:2px;height: 35px;"
           value="编辑"/>
    <input onclick="myConfirm('<c:url value="/basic/xm.do?qm=removeLabelBatch&id=${object.id}"/>', 'D')"
           type="button" class="am-btn am-btn-default am-btn-xs am-text-danger"
           style="margin-top: 8px;margin-bottom: 6px;margin-left:2px;height: 35px;"
           value="删除" />
</c:if>
    <input onclick="window.history.back()"
           type="button" class="am-btn am-btn-default am-btn-xs"
           style="margin-top: 8px;margin-bottom: 6px;margin-left:2px;height: 35px;"
           value="返回" />
</div>
<jsp:include page="/layouts/myConfirm.jsp"/>
<div class="am-cf am-padding">
    <div class="am-fl am-cf">
        <strong class="am-text-primary am-text-lg">标签批次${object.setting}详情</strong>
    </div>
</div>
<div am-panel am-panel-default admin-sidebar-panel>
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr>
            <td>标签编号</td>
            <td>${object.serial}</td>
        </tr>
        <tr>
            <td>标签批次</td>
            <td>${object.setting}</td>
        </tr>
        <tr>
            <td>数量</td>
            <td>${object.amount}</td>
        </tr>
        <tr>
            <td>创建时间</td>
            <td><fmt:formatDate value="${object.createDate}" pattern="yyyy-MM-dd"/> </td>
        </tr>
        <tr>
            <td>状态</td>
            <td>
                <ming800:status name="status" dataType="PCLabelBatch.status" checkedValue="${object.status}" type="normal"/>
            </td>
        </tr>
    </table>
</div>
</body>
</html>
