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
<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}&tenantId=${tenantId}"/>
<div class="admin-content">
  <div class="am-g">
    <div class="am-u-sm-12 am-u-md-6">
    </div>
    <div class="am-u-sm-12">
      <div class="am-u-sm-12">
        <table class="am-table am-table-bordered am-table-radius am-table-striped">
          <tr>
            <security:authorize ifAnyGranted="admin,operational,c_operational,o_operational">
              <td>操作</td>
            </security:authorize>
            <td>类别名称</td>
            <td>类别编号</td>
            <td>类别图片</td>
          </tr>

          <c:forEach items="${requestScope.pageInfo.list}" var="projectCategory">

            <tr id="${projectCategory.id}">
              <security:authorize ifAnyGranted="admin,operational,c_operational,o_operational">
                <td width="25%">
                  <div class="am-btn-toolbar">
                    <div class="am-btn-group am-btn-group-xs">
                      <c:set value="0" var="isOk"/>
                      <c:if test="${not empty projectCategory.projectCategoryRecommendeds}">
                        <c:forEach var="recommended"
                                   items="${projectCategory.projectCategoryRecommendeds}">
                          <c:if test="${recommended.projectCategory.id == projectCategory.id && recommended.group == 'mainCategoryRecommended'}">
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
                        <a class="am-btn am-btn-default am-btn-xs w-text-danger am-hide-sm-only"
                           onclick="recommended(this,1,'<c:url
                                   value="/Recommended/deleteObjectRecommended.do"/>')"
                           href="#" recommend="1" recommendedId="${projectCategory.id}" id="">
                          <span class="am-icon-heart"> 推荐</span>
                        </a>
                          </c:if>

                                    <span style="display: none;float: left;padding-left: 10px;">
                                                <input type="text" name="sort" style="width: 35px;" value=""/>
                                                <a class=" am-btn-primary"
                                                   onclick="saveRecommended(this,'mainCategoryRecommended',1,'<c:url
                                                           value="/Recommended/saveObjectRecommended.do"/>')"
                                                   style="padding: 0px 10px 5px 10px"> 保存</a>
                                       </span>
                    </div>
                  </div>
                </td>
                <td width="25%">
                  <a href="<c:url value="/basic/xm.do?qm=viewEcProjectCategory&id=${projectCategory.id}"/>">
                      ${projectCategory.name}
                  </a>
                  <c:forEach var="recommended" items="${projectCategory.projectCategoryRecommendeds}">
                    <c:if test="${recommended.projectCategory.id == projectCategory.id && recommended.group == 'mainCategoryRecommended'}">
                      <span id="${recommended.id}" style="margin-left: 5px;color: red;"> 推荐</span>
                    </c:if>
                  </c:forEach>
                </td>
              </security:authorize>
              <td width="25%">
                  ${projectCategory.serial}
              </td>
              <td width="25%">
                <img  width="10%" src="http://pro.efeiyi.com/${projectCategory.pictureUrl}@!product-model">
              </td>
            </tr>
          </c:forEach>
        </table>
      </div>
      <div style="clear: both">
        <c:url value="/basic/xm.do" var="url"/>
        <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
          <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
          <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
        </ming800:pcPageList>
      </div>

    </div>
  </div>
</div>
</body>
</html>
