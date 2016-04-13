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
            <li><a href="" title="e飞蚁商城">e飞蚁商城</a></li>
            <li><a href="" title="">工 艺</a></li>
            <li><a href="" title="">大 师</a></li>
            <li>
                <a href="" title="">登录</a>
                <a href="" title="">注册</a>
            </li>
            <li><a href="" title="">商家入驻</a></li>
            <li><a href="" title="">手机e飞蚁</a></li>
            <li class="cart">
                <a href="" title=""><i class="icon2016 icon-cart"></i><em class="icon-num">5</em></a>
            </li>
        </ul>
    </div>
</div>
<!--//End--topbar-->
<%--<div class="topbar wh">--%>
    <%--<div class="hd">--%>
        <%--<ul class="ul-item">--%>
            <%--&lt;%&ndash;<li><a href="" title="商家入驻">商家入驻</a></li>&ndash;%&gt;--%>
            <%--<%--%>
                <%--if (AuthorizationUtil.getMyUser().getId() != null) {--%>
            <%--%>--%>
            <%--<li><a href="http://i.efeiyi.com" title="个人中心">个人中心</a></li>--%>
            <%--<li><a href="<c:url value='/j_spring_cas_security_logout'/>" title="退出">退出</a></li>--%>
            <%--<%--%>
                <%--}--%>
            <%--%>--%>

            <%--<%--%>
                <%--if (AuthorizationUtil.getMyUser().getId() == null) {--%>
            <%--%>--%>
            <%--<li><a href="<c:url value="/sso.do"/>" title="请登录">请登录</a></li>--%>
            <%--<li><a href="http://passport.efeiyi.com/register?service=http://http://craft.efeiyi.com/ef-wiki" title="快速注册">快速注册</a></li>--%>
            <%--<%--%>
                <%--}--%>
            <%--%>--%>
            <%--&lt;%&ndash;<li><a href="" title="商家入驻">商家入驻</a></li>&ndash;%&gt;--%>
            <%--<li class="btn-top-wechat">--%>
                <%--<a title="手机e飞蚁">手机e飞蚁</a>--%>
                <%--<span class="top-wechat"></span>--%>
            <%--</li>--%>
           <%--&lt;%&ndash; <li class="cart">--%>
                <%--<a href="<c:url value="/cart/view"/> " title="购物车"><i class="icon"></i>购物车</a>--%>
                <%--<span class="tips"><em id="cartAmount">0</em></span>--%>
            <%--</li>&ndash;%&gt;--%>
        <%--</ul>--%>
    <%--</div>--%>
<%--</div>--%>
<!-- //End--topbar-->
<%--<div class="header wh">--%>
    <%--<div class="hd">--%>
        <%--<div class="logo"><a class="icon" href="http://www.efeiyi.com" title="e飞蚁-爱非遗"></a></div>--%>
        <%--<div class="nav">--%>
            <%--<ul>--%>
                <%--<c:forEach items="${jnode.children}" var="child">--%>
                    <%--<li>--%>
                        <%--<c:if test="${!child.getState().equals('productCategory')}">--%>
                            <%--<a class="${child.jnodeMatch("cur",currentJnode)}" href="<c:url value="${child.url}"/>"--%>
                               <%--title="${child.text_zh_CN}">${child.text_zh_CN}</a>--%>
                        <%--</c:if>--%>
                        <%--<c:if test="${child.getState().equals('productCategory')}">--%>
                            <%--<a class="${child.jnodeMatch("cur",currentJnode)}"--%>
                               <%--title="${child.text_zh_CN}">${child.text_zh_CN}</a>--%>
                            <%--&lt;%&ndash;<jsp:include page="/productCategory.do" flush="true"/>&ndash;%&gt;--%>
                        <%--</c:if>--%>
                    <%--</li>--%>
                <%--</c:forEach>--%>
            <%--</ul>--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</div>--%>
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
