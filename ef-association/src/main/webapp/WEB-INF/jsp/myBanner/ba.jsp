<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/7
  Time: 13:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@include file="/layouts/public.jsp"%>
<html>
<head>
  <title></title>
</head>
<body>
<jsp:include page="/layouts/myConfirm.jsp"/>
<div class="am-g">
  <button onclick="window.location.href='<c:url value="/myBanner/newBanner.do?qm=direct2BannerJsp_new&banner.group=${banner.group}&resultPage=/myBanner/ba.do?qm=${requestScope.qm}"/>'"
          class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span>新建</button>

  <table class="am-table am-table-bordered am-table-radius am-table-striped">
    <tr>
      <td>操作</td>
      <td>标题</td>
      <td>图片</td>
      <td>排序</td>
    </tr>

    <c:forEach items="${bannerList}" var="banner">
      <tr>
        <td>
          <button onclick="window.location.href='<c:url value="/myBanner/newBanner.do?qm=direct2BannerJsp_new&id=${banner.id}&resultPage=/myBanner/ba.do?qm=${requestScope.qm}"/>'"
                  class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 编辑</button>
          <button onclick="myConfirm('<c:url value="/myBanner/removeBanner.do?qm=removeBanner&id=${banner.id}&resultPage=/myBanner/ba.do?qm=${requestScope.qm}"/>','D')"
                  class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 删除</button>

          <input id="${banner.id}0" value="${banner.id}" name="${banner.id}"
                 metaProperty="id" type="hidden"/>
          <input id="${banner.id}1" value="${banner.group}"
                 name="${banner.id}"
                 metaProperty="group" type="hidden"/>
          <input id="${banner.id}2" value="${banner.status}" name="${banner.id}"
                 metaProperty="status" type="hidden"/>
          <input id="${banner.id}3" value="${banner.directUrl}"
                 name="${banner.id}" readonly="true" metaProperty="directUrl" type="hidden"/>
        </td>
        <td>
          <div  id="${banner.id}4" name="${banner.id}" >${banner.title}</div>
        </td>
        <td>
          <img id="${banner.id}5"  name="${banner.id}" src="<%=imgBasePath%>${banner.imageUrl}<%=imgListCss%>">
        </td>
        <td>
          <div id="${banner.id}6"  name="${banner.id}">${banner.bannerOrder}</div>
        </td>
      </tr>
    </c:forEach>
  </table>
</div>
<div style="clear: both">
  <c:url value="/banner/ba.do" var="url"/>
  <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
    <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
    <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
  </ming800:pcPageList>
</div>
<%--<script src="<c:url value='http://libs.baidu.com/jquery/1.11.3/jquery.min.js'/>"></script>--%>
</body>
</html>
