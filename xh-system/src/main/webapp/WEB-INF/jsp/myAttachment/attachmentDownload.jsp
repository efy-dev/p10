<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/7
  Time: 13:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@include file="/layouts/public.jsp" %>
<html>
<head>
    <title></title>
</head>
<body>
<table class="am-table am-table-bordered am-table-radius am-table-striped">
    <tr>
        <td>操作</td>
        <td><input type="checkbox" onclick="selectAll(this.checked,'status')">全选/申请状态</td>
        <td>申请列表</td>
        <td>申请类别</td>
        <td>附件</td>
        <td>申请人</td>
        <td>申请时间</td>
    </tr>

    <c:forEach items="${applicationMaterialList}" var="material">
        <tr>
            <td>
                <div class="am-btn-toolbar">
                    <div class="am-btn-group am-btn-group-xs" style="width: 100%;">
                        <button onclick="myConfirm('<c:url
                                value="/myAttachment/removeAttachment.do?id=${material.id}&resultPage=/myAttachment/attachmentDownload.do?qm=${requestScope.qm}"/>','D')"
                                class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                                class="am-icon-trash-o"></span> 删除
                        </button>
                        <a href="javascript:void(0)"
                           onclick="downloadFileOnPage('<c:forEach items='${material.documentAttachmentList}'
                                                                   var='attachment'>${attachment.path};</c:forEach>')"
                           class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                                class="am-icon-trash-o"></span> 下载
                        </a>
                        <input value="${material.id}" name="${material.id}" type="hidden"/>
                    </div>
                </div>
            </td>
            <td>
                <input type="checkbox" name="status" id="${material.id}" value="${material.status}"
                       download="<c:forEach items='${material.documentAttachmentList}' var='attachment'>${attachment.path};</c:forEach>">
                <ming800:status name="" dataType="SubmissionMaterial.status"
                                checkedValue='${material.status}' type="normal"
                                onchange="switchValue(this,'/myAttachment/saveAttachmentDownload.do?id=${material.id}','&resultPage=/myAttachment/attachmentDownload.do?qm=plistMaterialDownload_default')"/>
            </td>
            <td>
                <div name="material"><ming800:status name="applyType" dataType="SubmissionMaterial.applyType"
                                                     checkedValue='${material.applyType}' type="normal"/></div>
            </td>
            <td>
                <div name="material"><ming800:status name="group" dataType="SubmissionMaterial.subGroup"
                                                     checkedValue='${material.subGroup}' type="normal"/></div>
            </td>
            <td>
                <c:set var="attachSize" value="0" scope="page"/>

                <div id="${material.id}11" name="${material.id}" href="${material.documentAttachmentList}">
                    <c:forEach items="${material.documentAttachmentList}">
                        <c:set var="attachSize" value="${attachSize = attachSize + 1}" scope="page"/>
                    </c:forEach>${attachSize}</div>
            </td>
            <td>
                <div name="material">${material.name}</div>
            </td>
            <td>
                <fmt:formatDate value="${material.theDatetime}"
                                pattern="yyyy-MM-dd"/>
            </td>
        </tr>
    </c:forEach>
</table>

<div class="am-btn-toolbar">
    <div class="am-btn-group am-btn-group-xs" style="width: 100%;">
        <button onclick="batchPushValue('2','<c:url
                value='/myAttachment/batchSaveAttachmentDownload.do'/>',
                '<c:url value='/myAttachment/attachmentDownload.do?qm=${requestScope.qm}'/>' ,'status')"
                class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                class="am-icon-trash-o">批量通过</span>
        </button>
        <button onclick="batchPushValue('9','<c:url
                value='/myAttachment/batchSaveAttachmentDownload.do'/>',
                '<c:url value='/myAttachment/attachmentDownload.do?qm=${requestScope.qm}'/>' ,'status' )"
                class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                class="am-icon-trash-o">批量驳回</span>
        </button>
        <button onclick="batchPushValue('1','<c:url
                value='/myAttachment/batchSaveAttachmentDownload.do'/>',
                '<c:url value='/myAttachment/attachmentDownload.do?qm=${requestScope.qm}'/>','status' )"
                class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                class="am-icon-trash-o">批量待处理</span>
        </button>
        <button onclick="batchDownloadFileOnPageByCheckbox('status')"
                class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                class="am-icon-trash-o">批量下载</span>
        </button>
    </div>
</div>
<jsp:include page="/layouts/myConfirm.jsp"/>
<div style="clear: both">
    <c:url value="/myDocument/doc.do" var="url"/>
    <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
        <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
        <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
    </ming800:pcPageList>
</div>
</body>
</html>
