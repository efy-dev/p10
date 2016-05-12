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


<div class="admin-content">
    <div class="am-u-md-12">
        <div class="am-btn-toolbar">
            <div class="am-btn-group am-btn-group-xs">
                <a type="button" class="am-btn am-btn-default"
                   href="<c:url value="/basic/xm.do?qm=formIndustrySolution"/>"><span
                        class="am-icon-plus"></span>新建解决方案</a>

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
                    <th class="table-title">企业名称</th>
                    <th class="table-title">企业介绍</th>

                </tr>
                </thead>
                <tbody>

                <c:forEach items="${requestScope.pageInfo.list}" var="industrySolution">
                    <tr id="${industrySolution.id}">
                        <td width="10%">
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs">
                                    <a class="am-btn am-btn-default am-btn-xs am-text-secondary"
                                       href="<c:url value="/basic/xm.do?qm=formIndustrySolution&id=${industrySolution.id}"/>"><span
                                            class="am-icon-pencil-square-o"></span> 编辑
                                    </a>
                                    <a class="am-btn am-btn-default am-btn-xs am-text-secondary"
                                       href="<c:url value="/basic/xm.do?qm=viewIndustrySolution&id=${industrySolution.id}"/>"><span
                                            class="am-icon-pencil-square-o"></span> 关联礼品
                                    </a>
                                        <%--<a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"--%>
                                        <%--onclick="showConfirm('提示','是否删除',function(){removeMasterWork('${industrySolution.id}')})"--%>
                                        <%--href="#"><span--%>
                                        <%--class="am-icon-trash-o"></span> 删除--%>
                                        <%--</a>--%>
                                        <%--<security:authorize ifAnyGranted="admin,operational,c_operational">--%>
                                    <c:set value="0" var="isOk"/>
                                    <c:if test="${not empty industrySolution.getIndustrySolutionRecommendList()}">
                                        <c:forEach var="recommended"
                                                   items="${industrySolution.getIndustrySolutionRecommendList()}">
                                            <c:if test="${recommended.industrySolution.id== industrySolution.id && recommended.groupName == 'gift.industrySolutionRecommend'}">
                                                <c:set value="1" var="isOk"/>
                                                <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                                   href="#" onclick="recommended(this,1,'<c:url
                                                        value="/Recommended/deleteObjectRecommended.do"/>')"
                                                   recommendedId="${industrySolution.id}" id="${recommended.id}"
                                                   recommend="0">
                                                    <span class="am-icon-heart">取消推荐 </span>
                                                </a>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                    <c:if test="${isOk=='0'}">
                                        <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                           onclick="recommended(this)"
                                           href="#" recommend="1" recommendedId="${industrySolution.id}" id="">
                                            <span class="am-icon-heart"> 推荐</span>
                                        </a>

                                    </c:if>

                                        <span style="display: none;float: left;padding-left: 10px;">
                                            <input type="text" name="sort" style="width: 35px;" value=""/>
                                            <a class=" am-btn-primary"
                                               onclick="saveRecommended(this,'gift.industrySolutionRecommend',1,'<c:url
                                                       value="/Recommended/saveObjectRecommended.do"/>')"
                                               style="padding: 0px 10px 5px 10px"> 保存</a>
                                        </span>
                                        <%--</security:authorize>--%>
                                </div>
                            </div>
                        </td>
                        <td class="am-hide-sm-only" width="10%">
                            <a href="#">
                                ${industrySolution.solutionName}
                            </a>
                        </td>
                        <td class="am-hide-sm-only" width="10%">
                            <a href="#">
                                ${industrySolution.introduction}
                            </a>
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
        </ming800:pcPageList>
    </div>
</div>
<script type="text/javascript">
</script>
</body>
</html>
