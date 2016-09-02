<%@ page import="com.efeiyi.ec.website.base.util.AuthorizationUtil" %>
<%@ page import="com.ming800.core.p.PConst" %>
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
        <div class="tips fl"><a class="logo" href=""></a></div>
        <ul class="fr">
            <li><a href="http://www.efeiyi.com" title="e飞蚁首页">e飞蚁首页</a></li>
            <li><a href="http://mall.efeiyi.com" title="e飞蚁商城">非遗电商</a></li>
            <li><a href="http://master.efeiyi.com" title="非遗大师">非遗大师</a></li>
            <li><a href="http://minglu.efeiyi.com/" title="非遗大师">非遗百科</a></li>
            <li><a href="http://gift.efeiyi.com/" title="非遗礼品">非遗礼品</a></li>
            <li><a href="http://www.315cheng.com" title="诚品宝">诚品宝</a></li>
            <li><a href="http://ryt.efeiyi.com" title="融艺投">融艺投</a></li>
            <%
                if (AuthorizationUtil.getMyUser().getId() != null) {
            %>
            <li><a href="http://<%=PConst.WEBSITE_CONSUMER_HOST%>" title="个人中心">个人中心</a></li>
            <li><a href="<c:url value='/j_spring_security_logout'/>" title="退出">退出</a></li>
            <%
                }
            %>

            <%
                if (AuthorizationUtil.getMyUser().getId() == null) {
            %>
            <li><a href="http://<%=PConst.WEBSITE_HOST%>/login" title="请登录">请登录</a></li>
            <li>
                <a href="http://<%=PConst.WEBSITE_HOST%>/signin"
                   title="快速注册">快速注册</a></li>
            <%
                }
            %>
            <li><a href="http://<%=PConst.WEBSITE_HOST%>/document/helpCenter?group=ec.rzlc" title="e飞蚁入驻">商家入驻</a></li>
        </ul>
    </div>
</div>
<!--//End--topbar-->

<div class="topv2" style="padding-top: 0;">
    <div class="hd">
        <div class="tips fl"><a href="<c:url value="/"/>" class="logo"><img
                src="<c:url value="/scripts/images/ef-logo-craft.png"/>" alt=""></a></div>
        <div class="fr">
            <form action="http://<%=PConst.WEBSITE_HOST%>/search.do" method="get">
                <input type="text" value="<c:if test="${searchParamBean.q != '*'}">${searchParamBean.q}</c:if>" name="q"
                       id="q" placeholder="搜索" class="txt">
                <input type="submit" value="" class="icon-new btn">
                <input type="hidden" id="resultPage" name="resultPage" value="/searchResult"/>
                <input type="hidden" id="facetFields" name="facetFields" value="project_name"/>
                <input type="hidden" id="group" name="group" value="efeiyi"/>
                <input type="hidden" id="priceUD" name="priceUD" value="0"/>
            </form>
        </div>
    </div>
</div>


<div class="nav2016 bgc">
    <div class="hd bgf">
        <div class="navitems">
            <ul>
                <li><a href="<c:url value="/minglu"/>" title="非遗百科">非遗百科</a></li>
                <li><a href="<c:url value="/minglu/questionList.do"/>" title="">非遗宝典</a></li>
                <li><a href="<c:url value="/minglu/dati"/>" title="">非遗答题赚红包</a></li>
            </ul>
        </div>
    </div>
</div>

