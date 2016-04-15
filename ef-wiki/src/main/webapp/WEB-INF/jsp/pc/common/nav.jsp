<%@ page import="com.efeiyi.ec.wiki.organization.util.AuthorizationUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/17
  Time: 10:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="top2016">
    <div class="hd">
        <div class="tips fl"><i class="min-logo"></i>汇聚东方工艺精粹</div>
        <ul class="fr">
            <li><a href="http://www.efeiyi.com" title="e飞蚁商城">e飞蚁商城</a></li>
            <li><a href="/" title="">工 艺</a></li>
            <li><a href="/" title="">大 师</a></li>
            <%
                if (AuthorizationUtil.getMyUser().getId() != null) {
            %>
            <li><a href="http://i.efeiyi.com" title="个人中心">个人中心</a></li>
            <li><a href="<c:url value='/j_spring_cas_security_logout'/>" title="退出">退出</a></li>
            <%
                }
            %>

            <%
                if (AuthorizationUtil.getMyUser().getId() == null) {
            %>
            <li><a href="<c:url value="/sso.do"/>" title="请登录">请登录</a></li>
            <li><a href="http://passport.efeiyi.com/register?service=http://wiki.efeiyi.com" title="快速注册">快速注册</a></li>
            <%
                }
            %>
            <li><a href="http://www.efeiyi.com/document/helpCenter?group=ec.rzlc" title="e飞蚁入驻">商家入驻</a></li>
            <li><a href="" title="">手机e飞蚁</a></li>
            <%--<li class="cart">--%>
                <%--<a href="http://www.efeiyi.com/cart/view" title=""><i class="icon2016 icon-cart"></i><em class="icon-num">0</em></a>--%>
            <%--</li>--%>
        </ul>
    </div>
</div>
<!--//End--topbar-->
<div class="nav2016 bgc">
    <div class="hd bgf">
        <div class="navitems">
            <ul>
                <li><a href="/" title="">首页</a></li>
                <li><a href="" title="">大师精品</a></li>
                <li><a href="" title="">飞蚁工坊</a></li>
            </ul>
        </div>
        <!--//End--导航-->
        <%--<div class="search">--%>
        <%--<form action="">--%>
        <%--<input type="text" value="" placeholder="搜索" class="ipt">--%>
        <%--<input type="submit" value="" class="icon2016 btn">--%>
        <%--</form>--%>
        <%--</div>--%>
        <%--<!--//End--搜索-->--%>
    </div>
</div>
<!--//End--nav2016-->
<script>

   /* $().ready(function () {
        var success = function (data) {
            $("#cartAmount").html(data);
        }
        ajaxRequest("<c:url value="/cart/cartAmount.do"/>", {}, success, function () {
        }, "post");
    });
*/
</script>
