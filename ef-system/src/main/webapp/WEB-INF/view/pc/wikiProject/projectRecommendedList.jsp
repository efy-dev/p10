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


<div class="am-u-md-12">
  <div class="am-btn-toolbar">
    <div class="am-btn-group am-btn-group-xs">
      <a type="button" class="am-btn am-btn-default"
         href="<c:url value="/basic/xm.do?qm=formWiki&view=wiki"/>"><span
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
        <th class="table-title">项目名称</th>
        <th class="table-title">项目级别</th>

        <th class="table-title">项目类型</th>
        <th class="table-title">城市</th>
        <th class="table-title">创建日期</th>
      </tr>
      </thead>
      <tbody>

      <c:forEach items="${requestScope.pageInfo.list}" var="wikiList">
        <tr id="${wikiList.id}">
          <td width="10%">
            <div class="am-btn-toolbar">
              <div class="am-btn-group am-btn-group-xs">
                <c:set value="0" var="isOk"/>
                <c:if test="${not empty wikiList.getArtistryRecommendList()}">
                  <c:forEach var="recommended"
                             items="${wikiList.getArtistryRecommendList()}">
                    <c:if test="${recommended.artistry.id== wikiList.id && recommended.groupName == 'mainArtistryRecommended'}">
                      <c:set value="1" var="isOk"/>
                      <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                         href="#" onclick="recommended(this,1,'<c:url
                              value="/Recommended/deleteObjectRecommended.do"/>')"
                         recommendedId="${wikiList.id}" id="${recommended.id}"
                         recommend="0">
                        <span class="am-icon-heart">取消推荐 </span>
                      </a>
                    </c:if>
                  </c:forEach>
                </c:if>
                <c:if test="${isOk=='0'}">
                  <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                     onclick="recommended(this)"
                     href="#" recommend="1" recommendedId="${wikiList.id}" id="">
                    <span class="am-icon-heart"> 推荐</span>
                  </a>

                </c:if>

                                        <span style="display: none;float: left;padding-left: 10px;">
                                            <input type="text" name="sort" style="width: 35px;" value=""/>
                                            <a class=" am-btn-primary"
                                               onclick="saveRecommended(this,'mainArtistryRecommended',1,'<c:url
                                                       value="/Recommended/saveObjectRecommended.do"/>')"
                                               style="padding: 0px 10px 5px 10px"> 保存</a>
                                        </span>
                  <%--</security:authorize>--%>
              </div>
            </div>
          </td>
          <td class="am-hide-sm-only" width="10%">
            <a target="_blank"
               href="<c:url value="/basic/xm.do?qm=viewProjectWiki&view=masterWork&id=${wikiList.id}"/>">
                ${wikiList.name}
            </a>
          </td>
          <td class="am-hide-sm-only" width="10%">
            <ming800:status name="level" dataType="ProjectWiki.level"
                            checkedValue="${wikiList.level}" type="normal"/>
          </td>
          <td class="am-hide-sm-only" width="10%">
            <ming800:status name="type" dataType="ProjectWiki.type" checkedValue="${wikiList.type}"
                            type="normal"/>
          </td>
          <td class="am-hide-sm-only" width="12%">
              ${wikiList.project.addressDistrict.addressCity.name}
          </td>
          <td class="am-hide-sm-only" width="12%">
            <fmt:formatDate value="${wikiList.createDatetime}" pattern="yyyy/MM/dd HH:MM:SS"/>
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
<script type="text/javascript">

  function getPinyin() {
    $("#dddd").text("正在初始化...");
    $("#dddd").attr("disabled", true);
    $.ajax({
      type: "get",
      url: '<c:url value="/masterWork/getPinyin.do" />',
      cache: false,
      dataType: "json",
      data: {},
      success: function (data) {
        if (data) {
          alert("初始化成功!");
        } else {
          alert("初始化失败!!");
        }
        $("#dddd").text("初始化作者");
        $("#dddd").removeAttr("disabled");
      }
    });
  }

  function GetCode(serial) {

    $.ajax({
      type: "post",
      url: "<c:url value="/masterWork/gg.do" />",
      cache: false,
      dataType: "json",
      data: {"serial": serial},
      success: function (data) {
        alert(data);
      }

    });
  }

  function removeMasterWork(divId) {
    $.ajax({
      type: "get",
      url: '<c:url value="/basic/xmj.do?qm=removeProjectWiki"/>',
      cache: false,
      dataType: "json",
      data: {id: divId, masterWorkId: divId},
      success: function (data) {
        $("#" + divId).remove();
      }
    });
  }

</script>
</body>
</html>
