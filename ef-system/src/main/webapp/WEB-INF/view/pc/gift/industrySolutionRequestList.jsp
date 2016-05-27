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
        <%--<a type="button" class="am-btn am-btn-default"
           href="<c:url value="/basic/xm.do?qm=formIndustrySolution"/>"><span
                class="am-icon-plus"></span>新建解决方案</a>--%>

      </div>
    </div>
  </div>
  <%--<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>--%>

  <div class="am-g">
    <div class="am-u-sm-12">
      <table class="am-table am-table-striped am-table-hover table-main">
        <thead>
        <tr>
          <th class="table-title">用户名</th>
          <th class="table-title">电话</th>
          <th class="table-title">需求描述</th>
          <th class="table-title">需求数量</th>
          <th class="table-title">创建时间</th>

        </tr>
        </thead>
        <tbody>

        <c:forEach items="${requestScope.pageInfo.list}" var="industrySolutionRequest">
          <tr id="${industrySolutionRequest.id}">
            <td class="am-hide-sm-only" width="10%">
              <a href="#">
                  ${industrySolutionRequest.userName}
              </a>
            </td>
            <td class="am-hide-sm-only" width="10%">
              <a href="#">
                  ${industrySolutionRequest.tel}
              </a>
            </td>
            <td class="am-hide-sm-only" width="10%">
              <a href="#">
                  ${industrySolutionRequest.description}
              </a>
            </td>
            <td class="am-hide-sm-only" width="10%">
            <a href="#">
                ${industrySolutionRequest.number}
            </a>
          </td>
            <td class="am-hide-sm-only" width="10%">
              <a href="#">
                <fmt:formatDate value="${industrySolutionRequest.createDateTime}" pattern="yyyy-MM-dd HH:mm:ss" type="both"/>
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
