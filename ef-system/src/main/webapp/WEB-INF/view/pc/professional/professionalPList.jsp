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
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title></title>
    <script>
        function removeProfessional(professionalId){
            $.ajax({
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
        <div style="text-align: left;margin-left: 10px;">
<security:authorize ifAnyGranted="admin,operational,c_operational">
            <input onclick="window.location.href='<c:url
                    value="/basic/xm.do?qm=formProfessional"/>'" type="button"
                   class="am-btn am-btn-default am-btn-xs"
                   style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;" value="新建商家用户"/>
    </security:authorize>
        </div>
        <jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>
        <div class="am-u-sm-12">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>
<security:authorize ifAnyGranted="admin,operational,c_operational">
                    <th class="table-set">操作</th>
</security:authorize>
                    <th class="table-title">用户名</th>
                    <th class="table-title">性别</th>
                    <th class="table-title">商家</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${requestScope.pageInfo.list}" var="professional">
                    <tr id="${professional.id}">
                        <security:authorize ifAnyGranted="admin,operational,c_operational">
                        <td width="25%">
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs">
                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" href="<c:url value="/basic/xm.do?qm=formProfessional&id=${professional.id}"/>" ><span
                                            class="am-icon-trash-o">编辑</span>
                                    </a>
                                    <button class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" onclick="showConfirm('提示','是否删除',function(){removeProfessional('${professional.id}')})"><span
                                            class="am-icon-trash-o">删除</span>
                                    </button>
                                </div>
                            </div>
                        </td>
                        </security:authorize>

                        <td class="am-hide-sm-only" width="25%"><a href="<c:url value='/basic/xm.do?qm=viewProfessional&view=professional&id=${professional.id}'/>">${professional.username}</a></td>
                        <td class="am-hide-sm-only" width="25%">
                            <ming800:status name="sex" dataType="Professional.sex" checkedValue="${professional.sex}" type="normal"/>
                        </td>
                        <td class="am-hide-sm-only" width="25%">${professional.bigTenant.name}</td>
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
</body>
</html>
