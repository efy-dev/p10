<%@ page import="com.efeiyi.ec.wiki.organization.util.AuthorizationUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>个人中心</title>
</head>
<body>
<div class="myorder">
    <div class="order-head">
        <dl>
            <dt><img src="<c:url value="/scripts/assets/wap/upload/yonghm.jpg"/>" alt="..." class="am-img-thumbnail"></dt>
            <c:set var="user" >
                <%= AuthorizationUtil.getMyUser().getUsername()%>
            </c:set>
            <dd>
                <p>${fn:substring(user, 0,3 )}*****${fn:substring(user,7,11)}</p>
            </dd>
        </dl>
    </div>
    <div><hr data-am-widget="divider" style="" class="am-divider am-divider-default" /></div>
    <%-- <div class="myfunction">
       <ul>
         <li class="am-u-sm-4 "><a href="#"><p>商品收藏</p><p>1</p></a></li>
         <li class="am-u-sm-4"><a href="#"><p>店铺收藏</p><p>1</p></a></li>
         <li class="am-u-sm-4 ac-ave1"><a href="#"><p>我的卡券</p><p>1</p></a></li>
       </ul>
     </div>--%>

    <!--个人信息-->
    <div class="Extras">
        <a href="<c:url value='/myEfeiyi/getPersonalInfo.do'/>"> 个人信息<i class="icon-sj"></i></a>
    </div>

    <!--修改密码-->
    <div class="Extras">
        <a href="/myEfeiyi/getPassword.do"> 修改密码<i class="icon-sj"></i></a>
    </div>
    <!--安全退出-->
    <div class="aq-btn"><a href="/j_spring_cas_security_logout">安全退出</a> </div>
</div>
</body>
</html>
