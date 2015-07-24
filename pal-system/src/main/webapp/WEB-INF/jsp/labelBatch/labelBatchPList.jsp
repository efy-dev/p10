<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/25
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>

<html>
<head>
    <title></title>
    <script type="text/javascript" src="<c:url value='/scripts/jquery-1.11.1.min.js'/>"></script>
    <script type="text/javascript" >
        function updateLabelBatch(o){
            var labelBatchId = $(o).next().val();
            window.location.href="/basic/xm.do?qm=formLabelBatch&id="+labelBatchId;
        }
        function addLabelBatch(){
            window.location.href="/basic/xm.do?qm=formLabelBatch";
        }
    </script>
</head>
<body style="height: auto">
<div class="am-panel am-panel-default admin-sidebar-panel">
    <a href="javascript:addLabelBatch()">新建</a>
</div>
<div>
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr>
            <td>操作</td>
            <td>集合</td>
            <td>开始</td>
            <td>数量</td>
            <td>创建日期</td>
        </tr>
        <c:forEach items="${requestScope.pageInfo.list}" var="labelBatch">
            <tr>
                <td>
                    <input type="button" value="修改" id="update" onclick="updateLabelBatch(this)"/>
                    <input type="hidden" value="${labelBatch.id}">
                    <input type="button" value="删除" id="delete" />
                </td>
                <td><a href="/basic/xm.do?qm=viewLabelBatch&id=${labelBatch.id}">${labelBatch.setting}</a></td>
                <td>${labelBatch.start}</td>
                <td>${labelBatch.amount}</td>
                <td><fmt:formatDate value="${labelBatch.createDate}" pattern="yyyy-MM-dd"/> </td>
            </tr>
        </c:forEach>
    </table>
</div>
<div style="clear: both">
    <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="/basic/xm.do">
        <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
        <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
    </ming800:pcPageList>
</div>
</body>
</html>
