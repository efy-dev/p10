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
<%@include file="/layouts/public.jsp"%>
<html>
<head>
    <title></title>
</head>
<body>
<div class="am-g">
    <button onclick="window.location.href='<c:url
            value="/myDocument/newDocument.do?qm=direct2Jsp_newDocument&document.group=${document.group}&resultPage=/myDocument/doc.do?qm=${requestScope.qm}"/>'"
            class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span>新建
    </button>

    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr>
            <td>操作</td>
            <td>标题</td>
            <td>图片</td>
            <td>发布人</td>
            <td>创建时间</td>
        </tr>

        <c:forEach items="${documentList}" var="document">
            <tr>
                <td>
                    <button onclick="window.location.href='<c:url
                            value="/myDocument/newDocument.do?qm=direct2Jsp_newDocument&id=${document.id}&resultPage=/myDocument/doc.do?qm=${requestScope.qm}"/>'"
                            class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                            class="am-icon-trash-o"></span> 编辑
                    </button>
                    <button onclick="window.location.href='<c:url
                            value="/myDocument/removeDocument.do?qm=removeContent&id=${document.id}&resultPage=/myDocument/doc.do?qm=${requestScope.qm}"/>'"
                            class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                            class="am-icon-trash-o"></span> 删除
                    </button>
                    <button onclick="saveObject('${document.id}','<c:url
                            value='/myDocument/saveDocument.do'/>','status',<c:if test="${document.status == 1}">'2'</c:if><c:if test="${document.status != 1}">'1'</c:if>,'&qm=/myDocument/doc.do?qm=${requestScope.qm}'
                            )"
                            class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                            class="am-icon-trash-o"></span> <c:if test="${document.status == 1}">取消推荐</c:if><c:if test="${document.status != 1}">推荐</c:if>
                    </button>
                    <input id="${document.id}0" value="${document.id}" name="${document.id}" metaProperty="id" type="hidden"/>
                    <input id="${document.id}1" value="${document.documentContent.id}" name="${document.id}" metaProperty="documentContent.id"
                           type="hidden"/>
                    <input id="${document.id}2" value="${document.documentOrder}" name="${document.id}" metaProperty="documentOrder" type="hidden"/>
                    <input id="${document.id}3" value="${document.keywords}" name="${document.id}" metaProperty="keywords" type="hidden"/>
                    <input id="${document.id}4" value="${document.sampleContent}" name="${document.id}" metaProperty="sampleContent" type="hidden"/>
                    <input id="${document.id}5"
                           value="<fmt:formatDate value="${document.theDatetime}" pattern="yyyy-MM-dd HH:mm"/>"
                           name="${document.id}" metaProperty="theDatetime" type="hidden"/>
                    <input id="${document.id}6"
                           value="<fmt:formatDate value="${document.publishDate}" pattern="yyyy-MM-dd HH:mm"/>"
                           name="${document.id}" metaProperty="publishDate" type="hidden"/>
                    <input id="${document.id}7" value="${document.status}" name="${document.id}" type="hidden" metaProperty="status"/>
                    <input id="${document.id}8" value="${document.group}" name="${document.id}" metaProperty="group" type="hidden"/>
                    <input id="${document.id}9" value="${document.documentContent.content}" metaProperty="documentContent.content" name="${document.id}"
                           type="hidden"/>
                </td>
                <td>
                    <div name="title">${document.title}</div>
                    <input type="hidden" id="${document.id}10" name="${document.id}" value="${document.title}" metaProperty="title">
                </td>
                <td>
                    <c:forEach items="${document.documentAttachmentList}" var="attachment">
                        <img  id="${document.id}11" name="${document.id}" src="<%=imgBasePath%>${attachment.path}<%=imgListCss%>">
                    </c:forEach>
                </td>
                <td>
                    <div name="name">${document.name}</div>
                    <input type="hidden" id="${document.id}12" name="${document.id}" value="${document.name}" metaProperty="name">
                </td>
                <td>
                    <div id="${document.id}13"><fmt:formatDate value="${document.publishDate}"
                                                               pattern="yyyy-MM-dd HH:mm"/></div>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
<div style="clear: both">
    <c:url value="/myDocument/doc.do" var="url"/>
    <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
        <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
        <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
    </ming800:pcPageList>
</div>
</body>
</html>
