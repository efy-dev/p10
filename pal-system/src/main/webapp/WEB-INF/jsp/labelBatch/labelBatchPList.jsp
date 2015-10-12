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
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title></title>
</head>
<body style="height: auto">
<div style="text-align: left;margin-left: 10px;" >
    <input onclick="window.location.href='<c:url value="/basic/xm.do?qm=formLabelBatch"/>'"
           type="button" class="am-btn am-btn-default am-btn-xs"
           style="margin-top: 4px;margin-bottom: 6px;margin-left:2px;height: 35px;"
           value="新建标签批次" />
</div>
<jsp:include page="/layouts/myConfirm.jsp"/>
<div>
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr style="text-align:left">
            <td>操作</td>
            <td>批次序号</td>
            <td>标签批次</td>
            <td>数量</td>
            <td>标签类型</td>
            <td>状态</td>
            <td>创建日期</td>
            <td>下载标签文本</td>
        </tr>
        <c:forEach items="${requestScope.pageInfo.list}" var="labelBatch">
            <tr style="text-align: left">
                <td>
                    <div class="am-btn-toolbar">
                        <div class="am-btn-group am-btn-group-xs" style="width: 100%;" >
                            <c:if test="${labelBatch.status == '1'}">
                                <button onclick="window.location.href='<c:url value="/basic/xm.do?qm=formLabelBatch&id=${labelBatch.id}"/>'"
                                        class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span class="am-icon-edit"></span> 编辑</button>
                                <button onclick="myConfirm('<c:url value="/basic/xm.do?qm=removeLabelBatch&id=${labelBatch.id}"/>', 'D')"
                                        class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 删除</button>
                            </c:if>

                            <c:if test="${labelBatch.status == '1'}">
                                <button onclick="window.location.href='<c:url value="/Label/saveLabelList.do?labelBatchId=${labelBatch.id}"/>'"
                                        class="am-btn am-btn-default am-btn-xs"><font color="green">生成标签列表</font></button>
                            </c:if>
                            <c:if test="${labelBatch.status == '2'}">
                                <button onclick="window.location.href='<c:url value="/basic/xm.do?qm=plistLabel_batchLabel&conditions=labelBatch.serial:${labelBatch.serial}"/>'"
                                        class="am-btn am-btn-default am-btn-xs"><font color="#a52a2a">查看标签列表</font></button>
                            </c:if>
                        </div>
                    </div>
                </td>
                <td><a href="<c:url value="/basic/xm.do?qm=viewLabelBatch&view=view&id=${labelBatch.id}"/>">${labelBatch.serial}</a></td>
                <td>${labelBatch.setting}</td>
                <td>${labelBatch.amount}</td>
                <td>
                    <ming800:status name="type" dataType="PCLabelBatch.type" checkedValue="${labelBatch.type}" type="normal"/>
                </td>
                <td>
                    <ming800:status name="status" dataType="PCLabelBatch.status" checkedValue="${labelBatch.status}" type="normal"/>
                </td>
                <td><fmt:formatDate value="${labelBatch.createDate}" pattern="yyyy-MM-dd HH:mm"/> </td>
                <td>
                    <c:if test="${labelBatch.status == '2' && labelBatch.type == '1'}">
                        <a href="<c:url value='/Label/downLabelTxt.do?labelBatchId=${labelBatch.id}'/>">下载标签文本</a>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
<div style="clear: both">
    <c:url value="/basic/xm.do" var="url" />
    <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
        <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
        <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
    </ming800:pcPageList>
</div>
</body>
</html>
