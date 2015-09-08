<%@ page import="com.ming800.core.util.StringUtil" %>
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
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">修改密码</strong>
        <%--<small>New/Edit Product</small>--%>
    </div>
</div>
<hr/>
<div class="am-g">

    <fieldset>

        <form action="<c:url value="/product/saveNewProduct.do"/>" method="post" class="am-form am-form-horizontal">
            <input type="hidden" name="id" value="${object.id}">
            <input type="hidden" name="tenant.id" value="${tenantId}">
            <input type="hidden" name="resultPage" value="0" />
            <input type="hidden" name="step" value="product">
            <input type="hidden" name="productDescription.id" value="${object.productDescription.id}">
            <div class="am-form-group">
                <label name="serial" class="am-u-sm-3 am-form-label">用户名</label>

                <div class="am-u-sm-9">
                    ${user.username}
                </div>
            </div>
            <div class="am-form-group">
                <label name="oldPassword" class="am-u-sm-3 am-form-label">原密码</label>

                <div class="am-u-sm-9">
                    <input type="password" name="oldPassword" id="oldPassword" placeholder="原密码" value="">
                </div>

            </div>

            <div class="am-form-group">
                <label name="password" class="am-u-sm-3 am-form-label">新密码</label>

                <div class="am-u-sm-9">
                    <input type="password" name="password" id="password" value="">
                    <!--<small>必填项*</small>-->
                </div>
            </div>

            <div class="am-form-group">
                <label name="RePassword" class="am-u-sm-3 am-form-label">重复新密码</label>
                <div class="am-u-sm-9">
                    <input type="password" name="RePassword" id="RePassword" value="">
                    <!--<small>必填项*</small>-->
                </div>
            </div>
            <div class="am-form-group">
                <div class="am-u-sm-9 am-u-sm-push-3">
                    <span style="padding: 10px;">
                       <input type="button" onclick="toSubmit('/productDescription/productDescriptionForm')" class="am-btn am-btn-primary" value="确认修改"/>
                    </span>
                </div>
            </div>

        </form>
    </fieldset>



</div>

<!-- content end -->
<hr/>

<script type="text/javascript">
    var password = '${user.password}';
  <%=StringUtil.encodePassword(password,"sha") %>

  %>

</script>


</body>
</html>
