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
</head>
<body style="height: auto">
<div style="text-align: left;margin-left: 10px;" >
    <input onclick="window.location.href='<c:url value="/basic/xm.do?qm=formLabelBatch"/>'" type="button" class="am-btn am-btn-default am-btn-xs" style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;" value="新建标签批次" />
</div>
<div>
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr style="text-align:left">
            <td>操作</td>
            <td>卷批次</td>
            <td>商品</td>
            <td>商户</td>
            <td>开始</td>
            <td>数量</td>
            <td>状态</td>
            <td>创建日期</td>
        </tr>
        <c:forEach items="${requestScope.pageInfo.list}" var="labelBatch">
            <tr style="text-align: left">
                <td>
                    <div class="am-btn-toolbar">
                        <div class="am-btn-group am-btn-group-xs" style="width: 100%;" >
                            <button onclick="window.location.href='<c:url value="/basic/xm.do?qm=formLabelBatch&id=${labelBatch.id}"/>'"
                                    class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span class="am-icon-edit"></span> 编辑</button>
                            <button onclick="window.location.href='<c:url value="/basic/xm.do?qm=removeLabelBatch&id=${labelBatch.id}"/>'"
                                    class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 删除</button>

                            <c:if test="${labelBatch.status == '1'}">
                                <button onclick="window.location.href='<c:url value="/Label/saveLabelList.do?labelBatchId=${labelBatch.id}"/>'"
                                        class="am-btn am-btn-default am-btn-xs"><font color="green">生成标签</font></button>
                            </c:if>
                            <c:if test="${labelBatch.status == '2'}">
                                <button onclick="window.location.href='<c:url value="/basic/xm.do?qm=plistLabel_default&conditions=labelBatch.id:${labelBatch.id}"/>'"
                                        class="am-btn am-btn-default am-btn-xs"><font color="#a52a2a">查看标签</font></button>
                            </c:if>

                        </div>
                    </div>
                </td>
                <td><a href="/basic/xm.do?qm=viewLabelBatch&id=${labelBatch.id}">${labelBatch.setting}</a></td>
                <td>${labelBatch.product.name}</td>
                <td>${labelBatch.tenant.name}</td>
                <td>${labelBatch.start}</td>
                <td align="right">${labelBatch.amount}</td>
                <td>
                    <c:if test="${labelBatch.status == '0'}">
                        已删除
                    </c:if>
                    <c:if test="${labelBatch.status == '1'}">
                        <font color="green">待生成</font>
                    </c:if>
                    <c:if test="${labelBatch.status == '2'}">
                        <font color="#a52a2a">已生成</font>
                    </c:if>
                </td>
                <td><fmt:formatDate value="${labelBatch.createDate}" pattern="yyyy-MM-dd HH:mm"/> </td>
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