<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>


</head>
<body>
<div class="am-cf am-padding">
  <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">新建/编辑广告</strong> /
    <small>New/Edit Subject</small>
  </div>
</div>
<hr/>

<div class="am-g">

    <form action="<c:url value="/basic/xmm.do"/>" method="post" class="am-form am-form-horizontal"  enctype="multipart/form-data">
      <input type="hidden" name="id" value="${object.id}">
      <input type="hidden" name="qm" value="saveOrUpdateAdvertisement">
        <input type="hidden" name="status" value="1">
        <input type="hidden" name="resultPage" value="redirect:/basic/xm.do?qm=plistAdvertisement_default"/>
      <div class="am-form-group">
        <label name="name" class="am-u-sm-3 am-form-label">广告名称</label>

        <div class="am-u-sm-9">
            <input type="text" name="name" id="name" placeholder="" value="${object.name}" >
        </div>
      </div>
        <div class="am-form-group">
            <label for="img" class="am-u-sm-3 am-form-label">广告图片</label>

            <div class="am-u-sm-9">
                <span style="padding: 10px;">
                       <c:if test="${!empty object.img}">
                           <img width="7%" src="http://pro.efeiyi.com/${object.img}@!product-model">
                       </c:if>
                </span>
                <input type="file" id="img" name="img" placeholder="img"
                       value="${object.img}" >
            </div>

        </div>


        <div class="am-form-group">
            <label name="redirect" class="am-u-sm-3 am-form-label">跳转链接</label>

            <div class="am-u-sm-9">
                <input type="text" name="redirect" id="redirect" placeholder="" value="${object.redirect}" >
            </div>
        </div>



        <div class="am-form-group">
            <label name="adsOrder" class="am-u-sm-3 am-form-label">序号</label>

            <div class="am-u-sm-9">
                <input type="text" name="adsOrder" id="adsOrder" placeholder="" value="${object.adsOrder}"  required>
            </div>
        </div>
        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">

                    <span style="padding: 10px;">


                      <input type="submit" class="am-btn am-btn-primary" value="保存"/>



                    </span>

            </div>
        </div>
</form>

</div>



<!-- content end -->
<hr/>



</body>
</html>
