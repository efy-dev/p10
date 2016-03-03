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
<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>
<div class="">


            <div>
<security:authorize ifAnyGranted="admin,operational,c_operational">
                <c:if test="${empty level}">
                    <input onclick="window.location.href='<c:url
                            value="/basic/xm.do?qm=formProjectCategory&param=JiChu&fatherCategoryId=${fatherCategoryId}&level=1"/>'"
                           type="button" class="am-btn am-btn-default am-btn-xs"
                           style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;"
                           value="新建类别"/>
                </c:if>
                <c:if test="${not empty level}">
                    <input onclick="window.location.href='<c:url
                            value="/basic/xm.do?qm=formProjectCategory&fatherCategoryId=${fatherCategoryId}&level=${level}"/>'"
                           type="button" class="am-btn am-btn-default am-btn-xs"
                           style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;"
                           value="新建类别"/>
                </c:if>
    </security:authorize>
            </div>

                <table class="am-table am-table-bordered am-table-radius am-table-striped">
                    <tr>
<security:authorize ifAnyGranted="admin,operational,c_operational">
                        <td>操作</td>
</security:authorize>
                        <td>类别名称</td>
                        <td>类别编号</td>
                        <td>类别图片</td>
                    </tr>

                    <c:forEach items="${requestScope.pageInfo.list}" var="projectCategory">

                        <tr id="${projectCategory.id}">
                            <security:authorize ifAnyGranted="admin,operational,c_operational">
                            <td width="30%">
                                <div class="am-btn-toolbar">
                                    <div class="am-btn-group am-btn-group-xs">
                                        <button onclick="window.location.href='<c:url
                                                value="/basic/xm.do?qm=formProjectCategory&param=JiChu&fatherCategoryId=${fatherCategoryId}&level=${projectCategory.level}&id=${projectCategory.id}"/>'"
                                                class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span
                                                class="am-icon-edit"></span> 编辑
                                        </button>
                                        <c:if test="${projectCategory.status == '1'}">
                                            <button onclick="changeCategoryStatus(this,'${projectCategory.id}')" status="2"
                                                    class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                                                    class="am-icon-trash-o">隐藏</span>

                                            </button>
                                        </c:if>
                                        <c:if test="${projectCategory.status == '2'}">
                                            <button onclick="changeCategoryStatus(this,'${projectCategory.id}')" status="1"
                                                    class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                                                    class="am-icon-trash-o">显示</span>

                                            </button>
                                        </c:if>
                                        <button onclick="window.location.href='<c:url
                                                value="/basic/xm.do?qm=removeProjectCategory&id=${projectCategory.id}"/>'"
                                                class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                                                class="am-icon-trash-o"></span> 删除
                                        </button>
                                        <c:set value="0" var="isOk"/>
                                        <c:if test="${not empty projectCategory.projectCategoryRecommendeds}">
                                            <c:forEach var="recommended"
                                                       items="${projectCategory.projectCategoryRecommendeds}">
                                                <c:if test="${recommended.projectCategory.id == projectCategory.id && recommended.group == 'wiki.categoryRecommended'}">
                                                    <c:set value="1" var="isOk"/>
                                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                                       href="#" onclick="recommended(this,1,'<c:url
                                                            value="/Recommended/deleteObjectRecommended.do"/>')"
                                                       recommendedId="${projectCategory.id}" id="${recommended.id}"
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
                                               href="#" recommend="1" recommendedId="${projectCategory.id}" id="">
                                                <span class="am-icon-heart"> 推荐</span>
                                            </a>


                                        </c:if>

                                    <span style="display: none;float: left;padding-left: 10px;">
                                                <input type="text" name="sort" style="width: 35px;" value=""/>
                                                <a class=" am-btn-primary"
                                                   onclick="saveRecommended(this,'wiki.categoryRecommended',1,'<c:url
                                                           value="/Recommended/saveObjectRecommended.do"/>')"
                                                   style="padding: 0px 10px 5px 10px"> 保存</a>
                                       </span>
                                    </div>
                                </div>
                            </td>
                            </security:authorize>
                            <td width="20%">
                                <a href="<c:url value="/basic/xm.do?qm=viewProjectCategory&view=plist&id=${projectCategory.id}"/>">
                                        ${projectCategory.name}
                                </a>
                                <c:forEach var="recommended" items="${projectCategory.projectCategoryRecommendeds}">
                                    <c:if test="${recommended.projectCategory.id == projectCategory.id && recommended.group == 'wiki.categoryRecommended'}">
                                        <span id="${recommended.id}" style="margin-left: 5px;color: red;"> 推荐(${recommended.sort})</span>
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td width="25%">
                                    ${projectCategory.serial}
                            </td>
                            <td width="25%">
                                <img width="8%" src="http://pro.efeiyi.com/${projectCategory.pictureUrl}@!product-model">
                            </td>
                        </tr>
                    </c:forEach>
                </table>

            <div style="clear: both">
                <c:url value="/basic/xm.do" var="url"/>
                <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
                    <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
                    <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
                </ming800:pcPageList>
            </div>

        </div>
    </div>
<script>
    function changeCategoryStatus(obj,id){
        var status = $(obj).attr("status");
        $.ajax({
            type: "get",
            url: '<c:url value="/projectCategory/updateStatus.do"/>',
            cache: false,
            dataType: "json",
            data:{id:id,status:status},
            success: function (data) {
                $(obj).attr("status",data);
                if(status=="1"){
                    $(obj).find("span").text("隐藏");
                    $(obj).attr("status","2");
                }
                if(status=="2"){
                    $(obj).find("span").text("显示");
                    $(obj).attr("status","1");
                }
            }
        });
    }
</script>
</body>
</html>
