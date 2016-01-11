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
    <script>
        function removeTenant(divId){
            $.ajax({
                type: "get",
                url: '<c:url value="/basic/xmj.do?qm=removeTenant"/>',
                cache: false,
                dataType: "json",
                data:{id:divId},
                success: function (data) {
                    $("#"+divId).remove();
                }
            });
        }
    </script>
</head>
<body>
<div style="text-align: left;margin-bottom: 10px">
    <a type="button" class="am-btn am-btn-default am-btn-xs" href="<c:url value="/basic/xm.do?qm=viewTenant&id=${tenantId}"/>"><span class="am-icon-plus"></span>返回</a>
</div>

<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}&tenantId=${tenantId}"/>

<div class="">
    <div class="am-g">
        <input name="tenantId" type="hidden" value="${tenantId}">
        <div class="am-u-sm-12">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>
                    <th class="table-set">操作</th>
                    <th class="table-title">大师名称</th>
                </tr>
                </thead>
                <tbody>

                <c:forEach items="${requestScope.pageInfo.list}" var="master">
                    <tr >
                        <td>
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs">
                                    <a  id="${master.id}" tenantMasterId="0" class="am-btn am-btn-default am-btn-xs am-text-secondary" status="0" href="javascript:void(0);" onclick="linkMaster(this,'${master.id}');"><span
                                            class="am-icon-pencil-square-o">关联大师</span>
                                    </a>
                                </div>
                            </div>
                        </td>
                        <td class="am-hide-sm-only">
                                ${master.fullName}
                        </td>
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
            <ming800:pcPageParam name="tenantId" value="${tenantId}"/>
        </ming800:pcPageList>
    </div>
</div>
<script>
    $(function(){

        <c:forEach var="tenantMaster" items="${tenantMasterList}">
        var masterId = '${tenantMaster.master.id}';
        if(${tenantMaster.status == '1'}){
            $("#"+masterId).attr("status","1");
            $("#"+masterId).find("span").text("解除商家");
        }

        $("#"+masterId).attr("tenantMasterId",'${tenantMaster.id}')

        </c:forEach>

    });
    function linkMaster(obj,masterId){
        var tenantId = $("input[name='tenantId']").val();
        var tenantMasterId = $(obj).attr("tenantMasterId");
        var status = $(obj).attr("status");
        var r=confirm("关联大师后,大师所关联的项目也会与店铺关联,确认关联吗");
        if(r) {
            $.ajax({
                type: "get",
                url: '<c:url value="/tenant/linkMaster.do"/>',
                cache: false,
                dataType: "json",
                data: {tenantId: tenantId, masterId: masterId, tenantMasterId: tenantMasterId, status: status},
                success: function (data) {
                    if (status == '0') {
                        $(obj).attr("status", "1");
                        $(obj).find("span").text("解除大师");
                        $(obj).attr("tenantMasterId", data)
                    } else {
                        $(obj).attr("status", "0");
                        $(obj).find("span").text("关联大师");
                        $(obj).attr("tenantMasterId", data)
                    }
//                $("a[status='1'] span").text("关联商家");
//                $("a[status='1']").attr("status",'0');
//                $(obj).find("span").text("解除商家");
//                $(obj).attr("status",'1');
                }
            });
        }
    }
</script>
</body>
</html>
