<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
  <title></title>
</head>
<body>

<div class="am-g">
  <div class="am-u-md-12">
    <h2>详细信息</h2>

    <table class="am-table am-table-bordered">
      <tbody>
      <tr>
        <td class="am-primary am-u-md-3">专题名称</td>
        <td class="am-u-md-3">${object.name}</td>
        <td class="am-primary am-u-md-3">封面</td>
        <td class="am-u-md-3" colspan="3">
          <img width="35px" src="http://pro.efeiyi.com/${object.pictureUrl}@!product-model" alt="封面">
        </td>
      </tr>
      <tr>
        <td class="am-primary am-u-md-3">模板</td>
        <td class="am-u-md-3">
          <ming800:status name="template" dataType="Subject.template" checkedValue="${object.template}" type="normal"/>
        </td>
        <td class="am-primary am-u-md-3">类别</td>
        <td class="am-u-md-3" colspan="3">
          <ming800:status name="type" dataType="Subject.type" checkedValue="${object.type}" type="normal" />
        </td>
      </tr>
      <c:if test="${object.template == '2'}">
        <tr>
          <td class="am-primary am-u-md-3">起始时间</td>
          <td class="am-u-md-3">${object.startDateTime}</td>
          <td class="am-primary am-u-md-3">结束时间</td>
          <td class="am-u-md-3" colspan="3">
              ${object.endDateTime}
          </td>
        </tr>
      </c:if>
      </tbody>
    </table>

  </div>
</div>
<div class="am-g">
  <div class="am-u-md-12">
    <h2>附件图片</h2>
  </div>

  <div class="am-u-md-12">
    <div class="am-panel-bd am-collapse am-in" id="collapse-panel-3" style="height: auto;overflow: hidden">

      <ul style="width: 100%" style="list-style:none" id="subjectPicture">
        <c:if test="${!empty object.subjectPictureList}">
          <c:forEach var="subjectPicture" items="${object.subjectPictureList}">

            <li style="float: left;margin-right: 10px; width: 200px;" name="${subjectPicture.id}">
              <dl style="margin-top: 6px;">
                <dt style="width: 100%">
                  <img width="100%" name=""
                       src="http://pro.efeiyi.com/${subjectPicture.pictureUrl}@!product-model"
                       alt="附件图片"/>
                </dt>
              </dl>
            </li>

          </c:forEach>
        </c:if>
      </ul>
    </div>
  </div>
</div>
<div class="am-g">
  <div class="am-u-md-12">
    <h2 id="bt">专题推荐</h2>
  </div>

  <div class="am-u-md-12">
    <select style="width: 40%;height: 30px" id="groupName" onchange="showConfirm('提示','是否确定推荐',function(){
            saveGroupName('${object.id}')
            })">
      <option value="groupName1">组名一</option>
      <option value="groupName2">组名二</option>
      <option value="groupName3">组名三</option>
      <option value="groupName4">组名四</option>
    </select>
  </div>
</div>
<script>
  function saveGroupName(subjectId){
    var groupName=$("#groupName").val();

    $.ajax({
      type: "get",
      url:'<c:url value="/Recommended/saveObjectRecommended.do"/>',
      dataType: "json",
      data: {groupName: groupName, recommendId: subjectId, status: "1", sort: 1},
      success: function (data) {

      }
    });

  }

</script>

</body>
</html>
