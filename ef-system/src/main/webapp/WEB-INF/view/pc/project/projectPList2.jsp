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
    <script type="text/javascript" src="<c:url value='/scripts/recommended.js'/>"></script>
</head>
<body>
<div style="text-align: left;margin-left: 10px;">
    <security:authorize ifAnyGranted="admin,operational,c_operational">
        <input onclick="window.location.href='<c:url
                value="/basic/xm.do?qm=formProjectWiki&param=formProject&fatherId=${fatherId}"/>'" type="button"
               class="am-btn am-btn-default am-btn-xs"
               style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;" value="新建项目"/>
    </security:authorize>
</div>
<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>
<table class="am-table am-table-bordered am-table-radius am-table-striped">
    <tr style="text-align: left">
        <td width="25%">操作</td>
        <td width="15%">项目名称</td>
        <td width="15%">项目级别</td>
        <td width="15%">项目类别</td>
        <td width="15%">城市</td>
        <td width="15%">创建日期</td>
    </tr>


    <c:forEach items="${requestScope.pageInfo.list}" var="project">
        <%int i = 0;%>
        <tr style="text-align: left" id="${project.id}">
            <td width="25%">
                <div class="am-btn-toolbar">
                    <div class="am-btn-group am-btn-group-xs" style="width: 100%;">
                        <button onclick="showConfirm('提示','删除项目同时也会解除该项目与大师，商家的关联，确定删除吗',function(){removeProject('${project.id}')})"
                                class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                                class="am-icon-trash-o"></span> 删除
                        </button>
                            <%--<button onclick="window.location.href='<c:url value="/basic/xm.do?qm=plistProjectWiki_default3&conditions=project.id:${project.id}"/>'" class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span class="am-icon-edit"></span> 内容管理</button>--%>
                            <%--<button onclick="window.location.href='<c:url value="/basic/xm.do?qm=plistMasterWorkwiki_getProduct2&conditions=project.id:${project.id}"/>'" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-search"></span> 查看作品</button>--%>
                        <button onclick="window.location.href='<c:url
                                value="/basic/xm.do?qm=plistProductwiki_getProduct2&conditions=project.id:${project.id}"/>'"
                                class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                                class="am-icon-search"></span> 查看作品
                        </button>
                            <%--<button onclick="window.location.href='<c:url value="/basic/xm.do?qm=listMasterProject2Master_default2&conditions=project.id:${project.id}"/>'" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-search-plus"></span> 查看大师</button>--%>
                        <button onclick="window.location.href='<c:url
                                value="/basic/xm.do?qm=plistProjectFollowed_default&conditions=project.id:${project.id}"/>'"
                                class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                                class="am-icon-search"></span> 查看关注
                        </button>
                        <c:if test="${project.status == '1'}">
                            <button onclick="changeStatus(this,'${project.id}')" status="2"
                                    class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                                    class="am-icon-trash-o">隐藏</span>

                            </button>
                        </c:if>
                        <c:if test="${project.status == '2'}">
                            <button onclick="changeStatus(this,'${project.id}')" status="1"
                                    class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                                    class="am-icon-trash-o">显示</span>

                            </button>
                        </c:if>
                        <security:authorize ifAnyGranted="admin,operational,c_operational">
                            <c:set value="0" var="isOk"/>
                            <c:if test="${not empty project.projectRecommendeds}">
                                <c:forEach var="recommended"
                                           items="${project.projectRecommendeds}">
                                    <c:if test="${recommended.project.id == project.id && recommended.groupName == 'wiki.projectRecommended'}">
                                        <c:set value="1" var="isOk"/>
                                        <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                           href="#" onclick="recommended(this,1,'<c:url
                                                value="/Recommended/deleteObjectRecommended.do"/>')"
                                           recommendedId="${project.id}" id="${recommended.id}"
                                           recommend="0">
                                            <span class="am-icon-heart">取消推荐 </span>
                                        </a>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                            <c:if test="${isOk=='0'}">
                                <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                   onclick="recommended(this,1,'<c:url
                                           value="/Recommended/deleteObjectRecommended.do"/>')"
                                   href="#" recommend="1" recommendedId="${project.id}" id="">
                                    <span class="am-icon-heart"> 推荐</span>
                                </a>

                            </c:if>

                         <span style="display: none;float: left;padding-left: 10px;">
                                                <input type="text" name="sort" style="width: 35px;" value=""/>
                                                <a class=" am-btn-primary"
                                                   onclick="saveRecommended(this,'wiki.projectRecommended',1,'<c:url
                                                           value="/Recommended/saveObjectRecommended.do"/>')"
                                                   style="padding: 0px 10px 5px 10px"> 保存</a>
                                       </span>
                        </security:authorize>
                    </div>
                </div>
            </td>
            <td width="15%">
                    <%--<c:if test="${project.level == 1}">--%>
                <a href="<c:url value="/basic/xm.do?qm=viewProjectwiki&param=project&conditions=project.id:${project.id}&id=${project.id}"/>">
                        ${project.name}
                </a>
                    <%--</c:if>--%>
                <c:forEach var="recommended" items="${project.projectRecommendeds}">
                    <c:if test="${recommended.project.id == project.id && recommended.groupName == 'wiki.projectRecommended'}">
                        <span id="${recommended.id}"
                              style="margin-left: 5px;color: red;"> 推荐(${recommended.sort})</span>
                    </c:if>
                </c:forEach>
            </td>
            <td width="15%">
                    <%--<c:if test="${project.level == 1}">--%>
                    <%--国家级--%>
                    <%--</c:if>--%>
                    <%--<c:if test="${project.level == 2}">--%>
                    <%--省级--%>
                    <%--</c:if>--%>
                    <%--<c:if test="${project.level == 3}">--%>
                    <%--市级--%>
                    <%--</c:if>--%>
                    <%--<c:if test="${project.level == 4}">--%>
                    <%--县级--%>
                    <%--</c:if>--%>
                <ming800:status name="level" dataType="Project.level" checkedValue="${project.level}" type="normal"/>

            </td>
            <td width="15%">
                    <%-- <c:if test="${project.type == 1}">
                         美术
                     </c:if>
                     <c:if test="${project.type == 2}">
                         技艺
                     </c:if>--%>
                    ${project.projectCategory.name}

            </td>
            <td width="15%">
                    ${project.addressDistrict.addressCity.name}
            </td>
            <td width="15%">
                <p><fmt:formatDate value="${project.createDateTime}" pattern="yyyy/MM/dd HH:MM:SS"/></p>
            </td>

        </tr>
        <% i++;%>
    </c:forEach>
</table>
<div style="clear: both">
    <c:url value="/basic/xm.do" var="url"/>
    <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
        <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
        <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
    </ming800:pcPageList>
</div>
<script>
    window.onload = function () {

        <% if (request.getParameter("message") != null && !"".equalsIgnoreCase(request.getParameter("message")))
         {
        %>
        alert("<%=request.getParameter("message")%>");
        <% } %>
    }
    function removeProject(id) {
        $.ajax({
            type: "post",
            url: '<c:url value="/product/project/removeProject.do"/>',
            cache: false,
            dataType: "json",
            data: {id: id},
            success: function (data) {
                console.log(data);
                $("#" + data).remove();
            }
        });
    }
    function changeStatus(obj, id) {
        var status = $(obj).attr("status");
        $.ajax({
            type: "get",
            url: '<c:url value="/product/project/updateStatus.do"/>',
            cache: false,
            dataType: "json",
            data: {id: id, status: status},
            success: function (data) {
                $(obj).attr("status", data);
                if (status == "1") {
                    $(obj).find("span").text("隐藏");
                    $(obj).attr("status", "2");
                }
                if (status == "2") {
                    $(obj).find("span").text("显示");
                    $(obj).attr("status", "1");
                }
            }
        });
    }

</script>
</body>
</html>
