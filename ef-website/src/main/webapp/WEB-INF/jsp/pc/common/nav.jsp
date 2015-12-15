<%@ page import="com.efeiyi.ec.website.organization.util.AuthorizationUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/17
  Time: 10:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="topbar wh">
    <div class="hd">
        <ul class="ul-item">
            <%--<li><a href="" title="商家入驻">商家入驻</a></li>--%>
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
            <li>
                <a href="http://passport.efeiyi.com/register?service=http://www.efeiyi.com/sso.do?registeSuccess=/registerSuccess.do"
                   title="快速注册">快速注册</a></li>
            <%
                }
            %>
            <%--<li><a href="" title="商家入驻">商家入驻</a></li>--%>
            <li class="btn-top-wechat">
                <a title="手机e飞蚁">手机e飞蚁</a>
                <span class="top-wechat"></span>
            </li>
            <li class="cart">
                <a href="<c:url value="/cart/view"/> " title="购物车"><i class="icon"></i>购物车</a>
                <span class="tips"><em id="cartAmount">0</em></span>
            </li>
        </ul>
    </div>
</div>
<!-- //End--topbar-->
<div class="header-new wh">
    <div class="hd">
        <div class="logo"><a class="icon" href="http://www.efeiyi.com" title="e飞蚁-爱非遗"></a></div>
        <form action="<c:url value='/search.do'/>" method="get">
            <input type="text" class="txt" placeholder="" name="q" id="q"
                   value="<c:if test="${searchParamBean.q != '*'}">${searchParamBean.q}</c:if>">
            <input type="submit" class="icon-new btn" value="">
            <%-- 全文检索测试 --%>
            <input type="hidden" id="resultPage" name="resultPage" value="/searchResult"/>
            <input type="hidden" id="facetFields" name="facetFields" value="project_name"/>
            <input type="hidden" id="group" name="group" value="efeiyi"/>
            <input type="hidden" id="priceUD" name="priceUD" value="0"/>
            <%-- End全文检索测试 --%>
            <%--<div class="keywords">--%>
            <%--<a href="">剪纸</a>--%>
            <%--<a href="">景泰蓝</a>--%>
            <%--<a href="">景德镇</a>--%>
            <%--<a href="">二锅头</a>--%>
            <%--<a href="">徽州三雕</a>--%>
            <%--<a href="">藏药</a>--%>
            <%--<a href="">十全大补丸</a>--%>
            <%--</div>--%>
        </form>
    </div>
</div>
<c:if test="${sign != null && sign == '000'}">
    <div class="wh nav-new" id="line">
        <div class="hd">
            <div class="cate">
                <div class="ld"><h2>非遗商品分类<i class="icon-new"></i></h2></div>
                <jsp:include page="/productCategory.do" flush="true"/>

            </div>
            <div class="items">
                <a href="<c:url value="/"/>">首页</a>
                <a href="http://www.efeiyi.com/subject/ihygpb6m24v43zv9">礼品专区</a>
                <a href="http://www.efeiyi.com/subject/ihygpskg3j28dh60">精选专题</a>
            </div>
        </div>
    </div>
</c:if>

<c:if test="${empty sign}">
    <div class="wh nav-new nav-new-list">
        <div class="hd">
            <div class="cate" id="cate">
                <div class="ld"><h2>非遗商品分类<i class="icon-new"></i></h2></div>
                <jsp:include page="/productCategory.do" flush="true"/>

            </div>
            <div class="items">
                <a href="<c:url value="/"/>">首页</a>
                <a href="http://www.efeiyi.com/subject/ihygpb6m24v43zv9">礼品专区</a>
                <a href="http://www.efeiyi.com/subject/ihygpskg3j28dh60">精选专题</a>
            </div>
        </div>
    </div>
</c:if>
<script>

    $().ready(function () {
        var success = function (data) {
            $("#cartAmount").html(data);
        }
        ajaxRequest("<c:url value="/cart/cartAmount.do"/>", {}, success, function () {
        }, "post");
    });

</script>
