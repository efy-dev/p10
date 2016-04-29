<%@ page import="java.util.HashMap" %>
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


<div class="admin-content">
    <div class="am-u-md-12">
        <div class="am-btn-toolbar">
            <div class="am-btn-group am-btn-group-xs">
                <a type="button" class="am-btn am-btn-default"
                   href="<c:url value="/basic/xm.do?qm=plistProject_default"/>"><span
                        class="am-icon-plus"></span>新建关联</a>
                <%--<a type="button" class="am-btn am-btn-default" id="dddd"--%>
                   <%--href="javascript:void (0);" onclick="getPinyin()"><span class="am-icon-plus"></span>初始化作者</a>--%>
            </div>
        </div>
    </div>

    <%--<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>--%>
    <div class="am-g">
        <div class="am-u-sm-12">
                <table class="am-table am-table-striped am-table-hover table-main">
                    <thead>
                    <tr>
                         <th class="table-set">操作</th>
                         <th class="table-title">项目名称</th>
                         <th class="table-title">项目编号</th>
                        <%--<th class="table-title">项目</th>--%>
                        <%--<th class="table-title">作者</th>--%>
                         <th class="table-title">项目类别</th>
                        <%--<th class="table-title">简介</th>--%>
                        <%--<th class="table-title">规格尺寸</th>--%>
                        <%--<th class="table-title">材质</th>--%>
                        <%--<th class="table-title">管藏地</th>--%>
                    </tr>
                    </thead>
                    <tbody>

                    <c:forEach items="${requestScope.pageInfo.list}" var="masterProject">
                        <tr id="${masterProject.id}">
                            <td width="25%">
                                <div class="am-btn-toolbar">
                                    <div class="am-btn-group am-btn-group-xs">
                                        <%--<a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="<c:url value="/onMasterWork.do?id=${masterWork.id}"/>"><span--%>
                                                <%--class="am-icon-pencil-square-o"></span> 编辑--%>
                                        <%--</a>--%>
                                        <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" onclick="showConfirm('提示','是否解除关联',function(){removeMasterProject('${masterProject.id}')})" href="javaScript:void (0)"><span
                                                class="am-icon-trash-o">解除关联</span>
                                        </a>

                                    </div>
                                </div>
                            </td>
                            <td class="am-hide-sm-only" width="25%">
                                 <%--<a href="<c:url value="/basic/xm.do?qm=viewWork&view=masterWork&id=${masterWork.id}"/>">--%>
                                    ${masterProject.project.name}
                                 <%--</a>--%>
                            </td>

                            <td class="am-hide-sm-only" width="25%">
                                        <%--<a href="<c:url value="/basic/xm.do?qm=viewWork&view=masterWork&id=${masterWork.id}"/>">--%>
                                        ${masterProject.project.serial}
                                        <%--</a>--%>
                            </td>
                            <%--<td class="am-hide-sm-only" width="10%">--%>
                                        <%--${masterWork.project.name}--%>
                            <%--</td>--%>
                            <%--<td class="am-hide-sm-only" width="10%">--%>
                               <%--${masterWork.master.fullName}--%>
                            <%--</td>--%>
                            <td class="am-hide-sm-only" width="25%">
                                    ${masterProject.project.projectCategory.name}
                            </td>
                            <%--<td class="am-hide-sm-only">--%>
                                   <%--${masterWork.brief}--%>
                            <%--</td>--%>
                            <%--<td class="am-hide-sm-only" width="12%">--%>
                                    <%--${masterWork.size}--%>
                            <%--</td>--%>
                            <%--<td class="am-hide-sm-only" width="12%">--%>
                                    <%--${masterWork.material}--%>
                            <%--</td>--%>
                            <%--<td class="am-hide-sm-only" width="13%">--%>
                                    <%--${masterWork.site}--%>
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
<script type="text/javascript">

    <%--function  getPinyin(){--%>
        <%--$("#dddd").text("正在初始化...");--%>
        <%--$("#dddd").attr("disabled",true);--%>
        <%--$.ajax({--%>
            <%--type: "get",--%>
            <%--url: '<c:url value="/masterWork/getPinyin.do" />',--%>
            <%--cache: false,--%>
            <%--dataType: "json",--%>
            <%--data: {},--%>
            <%--success: function (data) {--%>
                <%--if(data){--%>
                    <%--alert("初始化成功!");--%>
                <%--}else{--%>
                    <%--alert("初始化失败!!");--%>
                <%--}--%>
                <%--$("#dddd").text("初始化作者");--%>
                <%--$("#dddd").removeAttr("disabled");--%>
            <%--}--%>
        <%--});--%>
    <%--}--%>

    <%--function GetCode(serial){--%>

        <%--$.ajax({--%>
            <%--type: "post",--%>
            <%--url: "<c:url value="/masterWork/gg.do" />",--%>
            <%--cache: false,--%>
            <%--dataType: "json",--%>
            <%--data:{"serial":serial},--%>
            <%--success: function (data) {--%>
                <%--alert(data);--%>
            <%--}--%>

        <%--});--%>
    <%--}--%>

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
</body>
</html>
