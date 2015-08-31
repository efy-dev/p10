<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 14:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <script src="<c:url value="/scripts/jquery-1.11.1.min.js"/>"></script>
    <title></title>
</head>
<body>
<center>
  <form action="<c:url value="/basic/xmm.do"/>" method="post" enctype="multipart/form-data" class="am-form am-form-horizontal">
    <input type="hidden" name="qm" value="saveOrUpdatePersonTenant">
    <input type="hidden" name="id" value="${object.id}">
    <input type="hidden" name="type" value="13" />
    <table>
      <tr>
        <th>*姓名</th>
        <td>
          <input type="text" id="name" name="name" value="${object.name}"/>
        </td>
      </tr>
      <tr>
        <th>*身份证号</th>
        <td>
          <input type="text" id="identity" name="identity" value="${object.identity}"/>
        </td>
      </tr>

      <tr>
        <th>*经营者身份证电子版</th>
        <td>
          <input type="file" id="frontPhotoUrl" name="frontPhotoUrl" value="${object.frontPhotoUrl}"/>
          <input type="file" id="versoPhotoUrl" name="versoPhotoUrl" value="${object.versoPhotoUrl}"/>
        </td>
      </tr>
      <tr>
        <th>*手持身份证照片</th>
        <td>
          <input type="file" id="identityPhotoUrl" name="identityPhotoUrl" value="${object.identityPhotoUrl}"/>
        </td>
      </tr>
      <tr>
        <th>*所在地</th>
        <td>
          <select id="provinceVal" onchange="province(this);" name="addressProvince.id">
            <option value="${object.addressProvince.id}">${object.addressProvince.name}</option>
          </select>
          <select id="cityVal" name="addressCity.id">
            <option value="${object.addressCity.id}">${object.addressCity.name}</option>
          </select>
        </td>
      </tr>
      <tr>
        <td>
          <input type="submit" value="保存个人信息"/>
        </td>
      </tr>
    </table>
  </form>
</center>
<script>

  function province(obj) {
    var v = $(obj).val();
    $("#provinceVal").empty();
    $.ajax({
      type: 'post',
      url: '<c:url value="/address/listProvince.do"/>',
      dataType: 'json',
      success: function (data) {
        var obj = eval(data);
        var rowHtml = "";
        rowHtml += "<option value='请选择'>请选择</option>";
        for (var i = 0; i < obj.length; i++) {
          rowHtml += "<option value='" + obj[i].id + "'>" + obj[i].name + "</option>";
        }
        $("#provinceVal").append(rowHtml);
        $("#provinceVal option[value='" + v + "']").attr("selected", "selected");
        city(v);
      },
    });
  }

  function city(obj) {
    var pid = $("#provinceVal").val();
    var v = $(obj).val();
    $("#cityVal").empty();
    $.ajax({
      type: 'post',
      async: false,
      url: '<c:url value="/address/listCity.do"/>',
      dataType: 'json',
      data: {
        provinceId: pid
      },
      success: function (data) {
        var obj = eval(data);
        var rowHtml = "";
        rowHtml += "<option value='请选择'>请选择</option>";
        for (var i = 0; i < obj.length; i++) {
          rowHtml += "<option value='" + obj[i].id + "'>" + obj[i].name + "</option>";
        }
        $("#cityVal").append(rowHtml);
        $("#cityVal option[value='" + v + "']").attr("selected", "selected");

      },
    });
  }

  $().ready(function(){
    province();
  })



</script>
</body>
</html>
