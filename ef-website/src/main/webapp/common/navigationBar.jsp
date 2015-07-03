<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2014/11/12
  Time: 16:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.ming800.core.util.AuthorizationUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="navbar navbar-inverse" role="navigation" style="border-radius: 0;">
    <div class="container">
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <%
                    String username = AuthorizationUtil.getMyUser().getName();
                    String userId = AuthorizationUtil.getMyUser().getId();
                %>
                <%if (username == null) {%>
                <li><a href="/pc/login.do">登录</a></li>
                <li><a href="/pc/enroll.do">注册</a></li>
                <%} else {%>
                <li class="">
                    <a href="#">
                        <%=AuthorizationUtil.getMyUser().getName()%>
                    </a>
                </li>
                <li class="">
                    <a href="javascript:void(0)"
                       onclick="window.open('<c:url value="/j_spring_security_logout"/>','_top');">
                        退出
                    </a>
                </li>
                <%}%>
            </ul>
            <%if (username != null) {%>
            <ul class="nav navbar-nav" style="float: right;">
                <% if("photographer".equals(AuthorizationUtil.getMyUser().getRole().getBasicType())){%><!--摄影师-->

                <li><a href="/pc/photographerMenu/xm.do?qm=plistPurchaseOrderComment_default">个人管理</a></li>
                <%} else {%>
                <c:url var="orderUrl"
                       value="/pc/consumerMenu/xm.do?qm=plistPCPurchaseOrder_default&amp;selectedMenuItem=myOrder"/>
                <li><a href="${orderUrl}">我的订单</a></li>
                <%}%>
            </ul>
            <%}%>
        </div>
    </div>
</nav>
