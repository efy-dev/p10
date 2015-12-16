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
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>

<html>
<head>

</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">新建/编辑用户</strong> /
        <small>New/Edit Professional</small>
    </div>
</div>
<hr/>
<div class="am-g">

    <fieldset>
        <legend class="" style="font-size: 17px"></legend>
        <form action="<c:url value="/professional/saveProfessional.do"/>" method="post"
              class="am-form am-form-horizontal">
            <input type="hidden" name="id" value="${object.id}">
            <input type="hidden" name="qm" value="saveOrUpdateProfessional">
            <input type="hidden" name="resultPage" value="0"/>
            <input type="hidden" name="bigTenant.id" value="${object.bigTenant.id}">

            <div class="am-form-group">
                <label name="username" class="am-u-sm-3 am-form-label">用户名</label>

                <div class="am-u-sm-9">
                    <input type="text" name="username" id="username" placeholder="用户名" value="${object.username}"
                           >
                </div>
            </div>
            <div class="am-form-group">
                <label name="password" class="am-u-sm-3 am-form-label">密码</label>

                <div class="am-u-sm-9">
                    <c:if test="${empty object.id}">
                      <input type="password" name="password" id="password" placeholder="密码" value="" required>
                    </c:if>
                    <c:if test="${not empty object.id}">
                        <input type="password" name="password" id="password" placeholder="若为空,密码为原密码" value="">
                    </c:if>
                    <!--<small>必填项*</small>-->
                </div>
            </div>
            <div class="am-form-group">
                <label name="name" class="am-u-sm-3 am-form-label">真实姓名</label>

                <div class="am-u-sm-9">
                    <input type="text" name="name" id="name" placeholder="真实姓名" value="${object.name}">
                    <!--<small>必填项*</small>-->
                </div>
            </div>
            <div class="am-form-group">
                <label name="phone" class="am-u-sm-3 am-form-label">手机号码</label>

                <div class="am-u-sm-9">
                    <input type="text" name="phone" id="phone" placeholder="手机号码" value="${object.phone}">
                    <!--<small>必填项*</small>-->
                </div>
            </div>
            <div class="am-form-group">
                <label name="email" class="am-u-sm-3 am-form-label">电子邮箱</label>

                <div class="am-u-sm-9">
                    <input type="text" name="email" id="email" placeholder="电子邮箱" value="${object.email}">
                    <!--<small>必填项*</small>-->
                </div>
            </div>

            <div class="am-form-group">
                <label name="serial" class="am-u-sm-3 am-form-label">商家</label>

                <div class="am-u-sm-9" style="margin-top: 10px;">
                    <select name="tenantCheck" onchange="changeTenant(this)">
                        <option value="0">请选择</option>
                        <c:forEach var="tenant" items="${tenantList}">
                            <option value="${tenant.id}"
                                    <c:if test="${object.bigTenant.id == tenant.id}">selected="selected"</c:if>
                                    <c:if test="${tenantId == tenant.id}">selected="selected"</c:if> >${tenant.name}</option>
                        </c:forEach>
                    </select>
                    <!--<small>必填项*</small>-->
                </div>
            </div>
            <div class="am-form-group">
                <label for="sex" class="am-u-sm-3 am-form-label">性别</label>

                <div class="am-u-sm-9">
                    <ming800:status name="sex" dataType="Master.sex" checkedValue="${object.sex}" type="select" required="true"/>
                </div>
            </div>
            <c:if test="${not empty object.id}">
                <div class="am-form-group">
                    <label name="createDate" class="am-u-sm-3 am-form-label">创建时间</label>

                    <div class="am-u-sm-9">
                        <div style="margin-top: 9px;">
                            <input value="${object.createDatetime}" type="hidden" name="createDatetime"/>
                            <fmt:formatDate value="${object.createDatetime}" type="both" pattern="yyyy-MM-dd hh:mm:ss"/>
                        </div>
                        <!-- <small>必填项*</small>-->
                    </div>
                </div>
            </c:if>

            <div class="am-form-group">
                <div class="am-u-sm-9 am-u-sm-push-3">

                    <span style="padding: 10px;">

                      <input type="button" onclick="toSubmit('redirect:/basic/xm.do?qm=plistProfessional_default')"
                             class="am-btn am-btn-primary" value="保存"/>

                    </span>
                </div>
            </div>
        </form>
    </fieldset>


</div>

<!-- content end -->
<hr/>
<script src="<c:url value='/resources/plugins/ckeditor/ckeditor.js'/>"></script>
<script type="text/javascript">

    $(function () {


    });


    function toSubmit(result) {
        $("input[name='resultPage']").val(result);
        var username = $("#username").val();
        if(username==""){
            alert("用户名不能为空!");
        }else {
            $.ajax({
                type: "GET",
                url: '<c:url value="/professional/checkUsername.do"/>',
                data: {username: username},
                dataType: "json",
                success: function (data) {
                    if(data){
                        alert("用户名已存在!");
                    }else{
                        if ($("select[name='tenantCheck']").val() == "0") {
                            alert("请选择商家!");

                        } else {

                            $("input[name='bigTenant.id']").val($("select[name='tenantCheck']").val());
                            $("form").submit();
                        }
                    }
                }
            });

        }

    }


</script>


</body>
</html>
