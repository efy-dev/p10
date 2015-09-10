<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title></title>
    <script src="/scripts/PCDSelect.js"></script>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">新建/编辑项目</strong> / <small>New/Edit Project</small></div>
</div>
<hr/>

<div class="am-g">
    <form action="<c:url value="/basic/xmm.do"/>"  class="am-form am-form-horizontal" method="post" enctype="multipart/form-data">
        <input type="hidden" name="qm" value="saveOrUpdateProject">
        <input type="hidden" name="id" value="${object.id}">
        <input type="hidden" name="status" value="1" />
        <input type="hidden" name="fatherProject.id" value="${fatherId}">


        <c:if test="${empty fatherId}">
            <input type="hidden" name="level" value="1" />
        </c:if>
        <c:if test="${not empty fatherId}">
            <input type="hidden" name="level" value="${object.level}" />
        </c:if>

        <div class="am-form-group">
            <label name="name" for="user-name" class="am-u-sm-3 am-form-label">项目名称 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="name" id="user-name" placeholder="项目名称" value="${object.name}">
            </div>
        </div>
        <div class="am-form-group">
            <label name="serial" for="serial" class="am-u-sm-3 am-form-label">项目编号 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="serial" id="serial" placeholder="项目编号" value="${object.serial}">
            </div>
        </div>
        <div id="pcdDiv">
            <div class="am-form-group">
                <label name="province" for="province" class="am-u-sm-3 am-form-label">省份 <small>*</small></label>
                <div class="am-u-sm-9">
                    <select name="province.id" id="province"></select>
                </div>
            </div>
            <div class="am-form-group">
                <label name="city" for="city" class="am-u-sm-3 am-form-label">市 <small>*</small></label>
                <div class="am-u-sm-9">
                    <select name="city.id" id="city"></select>
                </div>
            </div>
            <div class="am-form-group">
                <label name="district" for="district" class="am-u-sm-3 am-form-label">区/县 <small>*</small></label>
                <div class="am-u-sm-9">
                    <select name="district.id" id="district"></select>
                </div>
            </div>
            </div>
        <div class="am-form-group">
            <label name="type" for="type" class="am-u-sm-3 am-form-label">项目类别 <small>*</small></label>
            <div class="am-u-sm-9" style="margin-top: 10px">
                <select  name="projectCategory.id" id="type">
                  <c:forEach var="projectCategory" items="${projectCategoryList}">
                        <option value="${projectCategory.id}" <c:if test="${object.projectCategory.id == projectCategory.id}">selected="selected"</c:if> >${projectCategory.name}</option>
                  </c:forEach>
                </select>
                <%--<ming800:status name="type" dataType="Project.type" checkedValue="${object.type}" type="select"/>--%>
            </div>
        </div>

        <div class="am-form-group">
            <label for="picture_url" class="am-u-sm-3 am-form-label">项目图片</label>

            <div class="am-u-sm-9">
                <span style="padding: 10px;">
                       <c:if test="${!empty object.picture_url}">
                           <img width="7%" src="http://pro.efeiyi.com/${object.picture_url}@!product-model">
                       </c:if>
                </span>
                <input type="file" id="picture_url" name="picture_url" placeholder="picture_url"
                       value="${object.picture_url}">
            </div>

        </div>

        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
                <input type="submit" class="am-btn am-btn-primary" value="保存"/>
            </div>
        </div>
    </form>
</div>
<!-- content end -->
<hr/>

<script type="text/javascript">
    $(function(){
        $("#pcdDiv").pcdSelect(
                "<c:url value='/pj/address/provinceList.do'/>",
                "<c:url value='/pj/address/cityListByProvince.do?conditions=addressProvince.id:'/>",
                "<c:url value='/pj/address/districtListByCity.do?conditions=addressCity.id:'/>",
                "${object.addressDistrict.city.province.id}",
                "${object.addressDistrict.city.id}",
                "${object.addressDistrict.id}"
        )
    });
</script>
</body>
</html>
