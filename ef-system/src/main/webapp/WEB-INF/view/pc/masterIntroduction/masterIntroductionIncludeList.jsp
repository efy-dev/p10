<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/21
  Time: 15:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="am-g">
    <div class="am-u-sm-12">
        <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
            <tr>
<security:authorize ifAnyGranted="admin,operational,c_operational">
                <th class="table-set">操作</th>
    </security:authorize>
    <th class="table-title">类型</th>
            </tr>
            </thead>
            <tbody>

            <c:forEach items="${objectList}" var="masterIntroduction">
                <tr id="${masterIntroduction.id}">
                    <security:authorize ifAnyGranted="admin,operational,c_operational">
                    <td>
                        <div class="am-btn-toolbar">
                            <div class="am-btn-group am-btn-group-xs">
                                <a class="am-btn am-btn-default am-btn-xs am-text-secondary"
                                   href="<c:url value="/basic/xm.do?qm=formMasterIntroduction&masterId=${masterIntroduction.master.id}&id=${masterIntroduction.id}"/>"><span
                                        class="am-icon-pencil-square-o"></span> 编辑
                                </a>
                                <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                   onclick="removeMasterIntorduction('${masterIntroduction.id}')"><span
                                        class="am-icon-trash-o"></span> 删除
                                </a>
                            </div>
                        </div>
                    </td>
                    </security:authorize>
                    <td class="am-hide-sm-only">
                    <a href="<c:url value="/basic/xm.do?qm=viewMasterIntroduction&id=${masterIntroduction.id}"/>">
                        <ming800:status name="type" dataType="MasterIntroduction.type" checkedValue="${masterIntroduction.type}" type="normal" />
                    </a>
                   </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script>
    function removeMasterIntorduction(divId){
        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeMasterIntroduction"/>',
            cache: false,
            dataType: "json",
            data:{id:divId},
            success: function (data) {
                $("#"+divId).remove();
            }
        });
    }
</script>
