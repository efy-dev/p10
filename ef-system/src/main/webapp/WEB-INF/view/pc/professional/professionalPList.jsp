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
    <script>
        function removeProfessional(professionalId){
            jQuery.ajax({
                type:"GET",
                url:'<c:url value="/basic/xmj.do?qm=removeProfessional"/>',
                data:{id:professionalId},
                dataType:"json",
                success:function(data){
                    $("#"+professionalId).remove();
                }
            });
        }
    </script>
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
                    <th class="table-set">操作</th>
                    <th class="table-title">用户id</th>
                    <th class="table-title">temp</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${requestScope.pageInfo.list}" var="professional">
                    <tr id="${professional.id}">
                        <td>
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs">
                                    <button class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" onclick="removeProfessional('${professional.id}')"><span
                                            class="am-icon-trash-o">删除</span>
                                    </button>
                                </div>
                            </div>
                        </td>
                        <td class="am-hide-sm-only"><a href="<c:url value='/basic/xm.do?qm=viewProfessional&view=professional&id=${professional.id}'/>">${professional.id}</a></td>
                        <td class="am-hide-sm-only">${professional.temp}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div style="clear: both">
        <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="/basic/xm.do">
            <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
            <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
        </ming800:pcPageList>
    </div>
</div>
</body>
</html>
