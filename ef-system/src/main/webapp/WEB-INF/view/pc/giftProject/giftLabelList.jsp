
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
           href="<c:url value="/basic/xm.do?qm=formGiftLabel&view=label"/>"><span
                class="am-icon-plus"></span>新建项目</a>

      </div>
    </div>
  </div>
  <jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>

  <div class="am-g">
    <div class="am-u-sm-12">
      <table class="am-table am-table-striped am-table-hover table-main">
        <thead>
        <tr>
          <th class="table-set">操作</th>
          <th class="table-title">标签值</th>
          <th class="table-title">标签类型</th>

          <th class="table-title">标签分组</th>
          <th class="table-title">创建日期</th>
        </tr>
        </thead>
        <tbody>

        <c:forEach items="${requestScope.pageInfo.list}" var="labelList">
          <tr id="${labelList.id}">
            <td width="10%">
              <div class="am-btn-toolbar">
                <div class="am-btn-group am-btn-group-xs">
                  <a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="<c:url value="/basic/xm.do?qm=formGiftLabel&view=editLabel&id=${labelList.id}"/>"><span
                          class="am-icon-pencil-square-o"></span> 编辑
                  </a>
                  <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" onclick="showConfirm('提示','是否删除',function(){removeMasterWork('${labelList.id}')})" href="#"><span
                          class="am-icon-trash-o"></span> 删除
                  </a>

                </div>
              </div>
            </td>
            <td class="am-hide-sm-only" width="10%">
                  ${labelList.value}
            </td>
            <td class="am-hide-sm-only" width="10%">
              <ming800:status name="type" dataType="ProductGiftTagValue.type" checkedValue="${labelList.type}" type="normal"/>
            </td>
            <td class="am-hide-sm-only" width="12%">
                ${labelList.group}
            </td>
            <td class="am-hide-sm-only" width="12%">
              <fmt:formatDate value="${labelList.createDatetime}" pattern="yyyy/MM/dd HH:MM:SS" />
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


  function GetCode(serial){

    $.ajax({
      type: "post",
      url: "<c:url value="/masterWork/gg.do" />",
      cache: false,
      dataType: "json",
      data:{"serial":serial},
      success: function (data) {
        alert(data);
      }

    });
  }

  function removeMasterWork(divId){
    $.ajax({
      type: "get",
      url: '<c:url value="/basic/xmj.do?qm=removeGiftLabel"/>',
      cache: false,
      dataType: "json",
      data:{id:divId,masterWorkId:divId},
      success: function (data) {
        $("#"+divId).remove();
      }
    });
  }

</script>
</body>
</html>
