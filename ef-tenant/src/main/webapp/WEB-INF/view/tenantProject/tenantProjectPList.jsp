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
                    <th class="table-set" width="20%">操作</th>
                    <th class="table-title"  width="40%">项目名称</th>
                    <th class="table-title" width="40%">项目编号</th>
                </tr>
                </thead>
                <tbody>

                <c:forEach items="${requestScope.pageInfo.list}" var="project">
                    <tr >
                        <td>
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs">
                                    <a  id="${project.id}" tenantProjectId="0" class="am-btn am-btn-default am-btn-xs am-text-secondary" status="0" href="javascript:void(0);" onclick="linkProject(this,'${project.id}');"><span
                                            class="am-icon-pencil-square-o">关联项目</span>
                                    </a>
                                </div>
                            </div>
                        </td>
                        <td class="am-hide-sm-only">
                                ${project.name}
                        </td>
                        <td class="am-hide-sm-only">
                                ${project.serial}
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

        <c:forEach var="tenantProject" items="${tenantProjectList}">
        var projectId = '${tenantProject.project.id}';
        if(${tenantProject.status == '1'}){
            $("#"+projectId).attr("status","1");
            $("#"+projectId).find("span").text("解除商家");
        }

        $("#"+projectId).attr("tenantProjectId",'${tenantProject.id}')

        </c:forEach>

    });
    function linkProject(obj,projectId){

        var tenantId = $("input[name='tenantId']").val();
        var tenantProjectId = $(obj).attr("tenantProjectId");
        var status = $(obj).attr("status");
         var  context = "解除关联同时会删除商品与项目的关联，请谨慎操作；如确实要解除，请在商品管理页重新关联项目。";
        if(status=="0") {
            context = "确认关联?";
        }
            var r=confirm(context)
            if (r==true)
            {
                $.ajax({
                    type: "get",
                    url: '<c:url value="/tenant/linkProject.do"/>',
                    cache: false,
                    dataType: "json",
                    data:{tenantId:tenantId,projectId:projectId,tenantProjectId:tenantProjectId,status:status},
                    success: function (data) {
                        if(status == '0'){
                            $(obj).attr("status","1");
                            $(obj).find("span").text("解除项目");
                            $(obj).attr("tenantProjectId",data)
                        }else{
                            $(obj).attr("status","0");
                            $(obj).find("span").text("关联项目");
                            $(obj).attr("tenantProjectId",data)
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
