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
    <script type="text/javascript" src="<c:url value='/scripts/recommended.js'/>"></script>
</head>
<body>
<div style="text-align: left;margin-left: 10px;" >
    <input onclick="window.location.href='<c:url value="/basic/xm.do?qm=formProjectWiki&param=formProject&fatherId=${fatherId}"/>'" type="button" class="am-btn am-btn-default am-btn-xs" style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;" value="新建项目" />
</div>
<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>
<table class="am-table am-table-bordered am-table-radius am-table-striped" >
    <tr style="text-align: left">
        <td  width="25%">操作</td>
        <td  width="25%">项目名称</td>
        <td  width="15%">项目类别</td>
        <td  width="20%">城市</td>
        <td  width="15%">创建日期</td>
    </tr>


    <c:forEach items="${requestScope.pageInfo.list}" var="project">
       <%int i = 0;%>
        <tr style="text-align: left">
            <td>
                <div class="am-btn-toolbar">
                    <div class="am-btn-group am-btn-group-xs" style="width: 100%;" >

                        <%--<button onclick="window.location.href='<c:url value="/basic/xm.do?qm=plistProjectWiki_default3&conditions=project.id:${project.id}"/>'" class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span class="am-icon-edit"></span> 内容管理</button>--%>
                        <%--<button onclick="window.location.href='<c:url value="/basic/xm.do?qm=plistMasterWorkwiki_getProduct2&conditions=project.id:${project.id}"/>'" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-search"></span> 查看作品</button>--%>
                        <button onclick="window.location.href='<c:url value="/basic/xm.do?qm=plistProductwiki_getProduct2&conditions=project.id:${project.id}"/>'" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-search"></span> 查看作品</button>
                        <%--<button onclick="window.location.href='<c:url value="/basic/xm.do?qm=listMasterProject2Master_default2&conditions=project.id:${project.id}"/>'" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-search-plus"></span> 查看大师</button>--%>
                        <button onclick="window.location.href='<c:url value="/basic/xm.do?qm=plistProjectFollowed_default&conditions=project.id:${project.id}"/>'" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-search"></span> 查看关注</button>
                            <c:if test="${empty project.projectRecommendeds}">
                                <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                   onclick="recommended(this,1,'<c:url
                                           value="/Recommended/deleteObjectRecommended.do"/>')"
                                   href="#" recommend="1" recommendedId="${project.id}" id="">
                                    <span class="am-icon-heart"> 推荐</span>
                                </a>


                            </c:if>
                            <c:if test="${not empty project.projectRecommendeds}">
                                <c:forEach var="recommended"
                                           items="${project.projectRecommendeds}">
                                    <c:if test="${recommended.project.id == project.id}">
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
                         <span style="display: none;float: left;padding-left: 10px;">
                                                <input type="text" name="sort" style="width: 35px;" value=""/>
                                                <a class=" am-btn-primary"
                                                   onclick="saveRecommended(this,'projectRecommended',1,'<c:url
                                                           value="/Recommended/saveObjectRecommended.do"/>')"
                                                   style="padding: 0px 10px 5px 10px"> 保存</a>
                                       </span>
                    </div>
                </div>
            </td>
            <td width="20%">
                <c:if test="${project.level == 1}">
                    <a href="<c:url value="/basic/xm.do?qm=viewProjectwiki&param=project&conditions=project.id:${project.id}&id=${project.id}"/>" >
                      ${project.name}
                    </a>
                </c:if>
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
            <td width="20%">
                    ${project.addressDistrict.addressCity.name} ${project.addressDistrict.name}
            </td>
            <td width="15%">
                        <p><fmt:formatDate value="${project.createDateTime}" pattern="yyyy/MM/dd HH:MM:SS" /></p>
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
    window.onload = function(){

        <% if (request.getParameter("message") != null && !"".equalsIgnoreCase(request.getParameter("message")))
         {
        %>
        alert("<%=request.getParameter("message")%>");
        <% } %>
    }

</script>
</body>
</html>
