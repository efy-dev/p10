<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/25
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>

<html>
<head>
    <title></title>
</head>
<body>

<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>
<table class="am-table am-table-bordered am-table-radius am-table-striped" >
    <tr style="text-align: left">
        <td  width="50%">项目名称</td>
        <td  width="50%">大师名称</td>
    </tr>


    <c:forEach items="${objectList}" var="masterProject">
        <tr style="text-align: left">
            <td>
                <div class="am-btn-toolbar">
                    <div class="am-btn-group am-btn-group-xs" style="width: 100%;" >
                            ${masterProject.project.name}
                    </div>
                </div>
            </td>
            <td width="50%">
                <c:if test="${masterProject.master.name != null}">
                  <a  target="_blank" href="http://${masterProject.master.name}.efeiyi.com ">
                           ${masterProject.master.fullName}
                  </a>
              </c:if>
            </td>

        </tr>

    </c:forEach>
</table>
<%--<div style="clear: both">
    <c:url value="/basic/xm.do" var="url"/>
    <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
        <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
        <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
    </ming800:pcPageList>
</div>--%>

</body>
</html>
