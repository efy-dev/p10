<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/18
  Time: 14:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div class="am-g">
        <div class="am-u-sm-12 am-u-md-6">

        </div>
        <div class="am-u-sm-12">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>
<security:authorize ifAnyGranted="admin,operational,c_operational">
                    <th width="30%">操作</th>
    </security:authorize>
                    <th width="35%">项目名称</th>
                    <th width="35">项目编号</th>

                </tr>
                </thead>
                <tbody>
                <c:forEach items="${objectList}" var="masterProject" end="4">
                    <tr id="${masterProject.id}">
                        <security:authorize ifAnyGranted="admin,operational,c_operational">
                        <td>
                            <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                               onclick="showConfirm('提示','是否删除',function(){removeMasterProject('${masterProject.id}')})" href="#"><span
                                    class="am-icon-trash-o"></span>删除
                            </a>
                        </td>
                        </security:authorize>
                        <td class="am-hide-sm-only">
                            ${masterProject.project.name}
                        </td>
                        <td class="am-hide-sm-only"> ${masterProject.project.serial}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
<script>
    function removeMasterProject(divId){
        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeMasterProject"/>',
            cache: false,
            dataType: "json",
            data:{id:divId},
            success: function (data) {
                $("#"+divId).remove();
            }
        });
    }
</script>
