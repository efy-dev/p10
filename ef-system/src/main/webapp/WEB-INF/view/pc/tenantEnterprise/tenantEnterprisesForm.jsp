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
    <input type="hidden" name="qm" value="saveOrUpdateEnterprisesTenant">
    <input type="hidden" name="id" value="${object.id}">
    <input type="hidden" name="type" value="11" />
    <table>
      <tr>
        <th>*公司名称</th>
        <td>
          <input type="text" id="name" name="name" value="${object.name}"/>
        </td>
      </tr>
      <tr>
        <th>*法定代表人姓名</th>
        <td>
          <input type="text" id="legalName" name="legalName" value="${object.legalName}"/>
        </td>
      </tr>
      <tr>
        <th>*身份证号</th>
        <td>
          <input type="text" id="identity" name="identity" value="${object.identity}"/>
        </td>
      </tr>
      <tr>
        <th>*法人身份证电子版</th>
        <td>
          <input type="file" id="frontPhotoUrl" name="frontPhotoUrl" value="${object.frontPhotoUrl}"/>
          <input type="file" id="versoPhotoUrl" name="versoPhotoUrl" value="${object.versoPhotoUrl}"/>
        </td>
      </tr>
      <tr>
        <th>*营业执照所在地</th>
        <td>
          <select id="${object.id}" name="addressProvince.id" class="cars"
                  onchange="provinceChange(this , '${object.id}')">
                  <option value="${object.addressProvince.id}">${object.addressProvince.name}</option>
          </select>
          <select id="citys${object.id}" name="addressCity.id" class="car1">
                  <option value="${object.addressCity.id}">${object.addressCity.name}</option>
          </select>
        </td>
      </tr>
      <tr>
        <th>*注册资本</th>
        <td>
          <input type="text" id="registeredAssets" name="registeredAssets" value="${object.registeredAssets}"/>万元
        </td>
      </tr>
      <tr>
        <th>*经营范围</th>
        <td>
          <label for="businessScope"></label><textarea type="text" id="businessScope" name="businessScope" cols="3" rows="4">${object.businessScope}</textarea>
        </td>
      </tr>
      <tr>
        <th>*营业执照副本电子版</th>
        <td>
          <input type="file" id="businessLicense" name="businessLicense" value="${object.businessLicense}"/>
        </td>
      </tr>
      <tr>
        <th>*税务登记证电子版</th>
        <td>
          <input type="file" id="taxRegistrationAttachment" name="taxRegistrationAttachment" value="${object.taxRegistrationAttachment}"/>
        </td>
      </tr>
      <tr>
        <th>*组织机构代码证电子版</th>
        <td>
          <input type="file" id="organizationAttachment" name="organizationAttachment" value="${object.organizationAttachment}"/>
        </td>
      </tr>
      <tr>
        <th>*银行开户许可证电子版</th>
        <td>
          <input type="file" id="bankAttachment" name="bankAttachment" value="${object.bankAttachment}"/>
        </td>
      </tr>
      <tr>
        <td>
          <input type="submit" id="submit"  value="保存公司信息"/>
        </td>
      </tr>
    </table>
  </form>
</center>
<script>
  function chooseCity(element,provinceId,cityId,o){
    $(element).val(provinceId);
    var callback = function(){
      $("#citys" + o).val(cityId);
    }
    provinceChange(element, o,callback);
  }

    $.post("<c:url value="/address/listProvince.do"/>",
      function (data) {
        var obj = eval(data);
        var out = '<option value="">请选择</option>';
        for (var i = 0; i < obj.length; i++) {
          console.log(obj[i]+"----"+obj[i]);
          out += '<option value="' + obj[i]["id"] + '">' + obj[i]["name"] + '</option>';
        }
        $("#${object.id}").append(out);
        chooseCity($("#${object.id}") , "${object.addressProvince.id}","${object.addressCity.id}","${object.id}");
      }
    )

  function provinceChange(element, o, callback) {
    $("#citys" + o).empty();
    var provinceId = $(element).val();
    $.post("<c:url value="/address/listCity.do"/>",
            {provinceId: provinceId},
            function (data) {
              var obj = eval(data);
              var out = '<option value="">请选择</option>';
              for (var i = 0; i < obj.length; i++) {
                out += '<option value="' + obj[i]["id"] + '">' + obj[i]["name"] + '</option>';
              }
              $("#citys" + o).append(out);
              if(typeof callback!= "undefined"){
                callback();
              }
            }
    )
  }
</script>
</body>
</html>
