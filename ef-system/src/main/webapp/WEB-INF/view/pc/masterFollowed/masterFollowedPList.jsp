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
    <script type="text/javascript" src="<c:url value='/scripts/recommended.js'/>"></script>
</head>
<body>
<div class="admin-content">
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-6">
        </div>
        <div class="am-u-sm-12">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>
                    <th class="table-set">传承人名称</th>
                    <th class="table-title">粉丝名称</th>
                    <%--<th class="table-title">动态</th>--%>
                    <%--<th class="table-title">动态类型</th>--%>
                </tr>
                </thead>
                <tbody>

                <c:forEach items="${requestScope.pageInfo.list}" var="followed">
                    <tr id="${master.id}">
                        <td class="am-hide-sm-only">
                                ${followed.master.fullName}
                        </td>
                        <td class="am-hide-sm-only">
                                ${followed.user.name}
                        </td>
                        <%--<td class="am-hide-sm-only">--%>
                                <%--${msg.content}--%>
                        <%--</td>--%>
                        <%--<td class="am-hide-sm-only">--%>
                            <%--<ming800:status name="type" dataType="MasterMessage.type" checkedValue="${msg.type}" type="normal" />--%>
                        <%--</td>--%>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div style="clear: both">
        <c:url value="/basic/xm.do" var="url"/>
        <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
            <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
            <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
        </ming800:pcPageList>
    </div>
</div>
<script>



    function removeMaster(divId){
        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeMaster"/>',
            cache: false,
            dataType: "json",
            data:{id:divId,recommendId:divId},
            success: function (data) {
                $("#"+divId).remove();
            }
        });
    }

</script>
</body>
</html>
