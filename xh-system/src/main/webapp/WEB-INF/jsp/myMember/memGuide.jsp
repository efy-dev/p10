<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/21
  Time: 20:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title></title>
</head>
<body>
<div style="text-align: left;margin-left: 10px;">
    <input onclick="window.location.href='<c:url
            value="/myMember/memGuideForm.do?qm=memGuideForm_form&group=${group}&resultPage=/myMember/memGuide.do?qm=${requestScope.qm}"/>'"
           type="button" class="am-btn am-btn-default am-btn-xs"
           style="margin-top: 4px;margin-bottom: 6px;margin-left:2px;height: 35px;" value="新建会员申请指南"/>
</div>
<div class="am-g">
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr>
            <td>操作</td>
            <td>标题</td>
            <td>创建时间</td>
        </tr>
        <c:forEach items="${documentList}" var="document">
            <tr>
                <td>
                    <div class="am-btn-toolbar">
                        <div class="am-btn-group am-btn-group-xs" style="width: 100%;">
                            <button onclick="window.location.href='<c:url
                                    value="/myMember/memGuideForm.do?qm=memGuideForm_form&group=${group}&id=${document.id}&resultPage=/myMember/memGuide.do?qm=${requestScope.qm}"/>'"
                                    class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span
                                    class="am-icon-edit"></span> 编辑</button>
                            <button onclick="myConfirm('<c:url
                                    value="/myMember/removeMemGuide.do?id=${document.id}&resultPage=/myMember/memGuide.do?qm=${requestScope.qm}"/>', 'D');"
                                    class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                                    class="am-icon-trash-o"></span> 删除</button>
                        </div>
                    </div>
                </td>
                <td>${document.title}</td>
                <td><fmt:formatDate value="${document.publishDate}" pattern="yyyy-MM-dd HH:mm"/></td>
            </tr>
        </c:forEach>
    </table>
</div>
<jsp:include page="/layouts/myConfirm.jsp"/>
<div style="clear: both">
    <c:url value="/myMember/memGuide.do" var="url"/>
    <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
        <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
        <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
    </ming800:pcPageList>
</div>
</body>
</html>
