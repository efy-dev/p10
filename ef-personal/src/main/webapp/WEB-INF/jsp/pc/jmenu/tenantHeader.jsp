<%@ page import="com.efeiyi.ec.master.model.Master" %>
<%@ page import="com.efeiyi.ec.personal.master.MasterUtil" %>
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
        <h2>大师后台</h2>
        <h1 id="fullName">
            <%
                if(MasterUtil.findMaster()!=null && !"".equals(MasterUtil.findMaster().getName()) && MasterUtil.findMaster().getName() != null){
            %>
               <a style="font-size: large" href="http://<%=MasterUtil.findMaster().getName()%>.efeiyi.com"><%=MasterUtil.findMaster().getFullName()%></a>
            <%
                }
            %>
        </h1>
        <span>客服热线：<strong>400-876-8766</strong></span>
    </div>
</div>
<script >
    <%--$.ajax({--%>
        <%--type: "post",--%>
        <%--url: '<c:url value="/getMaster.do"/>',--%>
        <%--cache: false,--%>
        <%--dataType: "json",--%>
        <%--sync: false,--%>
        <%--success: function (data) {--%>
            <%--console.log(data);--%>
            <%--if (data != null && "" != data){--%>
                <%--$("#fullName").html(data);--%>
            <%--}else{--%>
                <%--$("#fullName").html("");--%>
            <%--}--%>
        <%--}--%>
    <%--})--%>
</script>

