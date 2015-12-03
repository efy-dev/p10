<%@ page import="com.efeiyi.ec.system.organization.util.AuthorizationUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/10
  Time: 15:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="header wh">
    <div class="hd">
        <div class="logo">
            <a class="icon" href="http://www.efeiyi.com" title="e飞蚁-商户后台"></a>
        </div>
        <h2>商户后台</h2>
        <h1>

            <%=AuthorizationUtil.getMyUser().getBigTenant().getName()==null?"":AuthorizationUtil.getMyUser().getBigTenant().getName() %>
        </h1>
        <span>客服热线：<strong>400-876-8766</strong></span>
    </div>
</div>

