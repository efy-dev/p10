<%@ page import="com.efeiyi.ec.website.base.util.AuthorizationUtil" %>
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

        <c:if test="${homepage}">
            <div class="tips fl">欢迎使用e飞蚁-中国最具权威的非遗平台</div>
        </c:if>
        <c:if test="${empty homepage}">
            <div class="tips fl"><i class="min-logo"></i>汇聚东方工艺精粹</div>
        </c:if>

        <ul class="fr">
            <li><a href="http://www.efeiyi.com" title="e飞蚁">e飞蚁商城</a></li>
            <li><a href="http://craft.efeiyi.com/ef-wiki/" title="">工 艺</a></li>
            <li><a href="http://master.efeiyi.com" title="">大 师</a></li>
            <li>

                <%
                    if (AuthorizationUtil.isAuthenticated()) {
                %>
                <a href="http://i.efeiyi.com" title="个人中心"><%=AuthorizationUtil.getCurrentSampleUsername()%>
                </a>
                <a href="<c:url value='/j_spring_cas_security_logout'/>" title="退出">退出</a>
                <%
                } else {
                %>

                <a href="<c:url value="/sso.do"/>" title="e飞蚁登录">登录</a>
                <a href="http://passport.efeiyi.com/register?service=http://www.efeiyi.com/sso.do?registeSuccess=/registerSuccess.do"
                   title="e飞蚁注册">注册</a>
                <%
                    }
                %>
            </li>
            <li><a href="http://www.efeiyi.com/document/helpCenter?group=ec.rzlc" title="e飞蚁入驻">商家入驻</a></li>
            <%--<li><a href="" title="">手机e飞蚁</a></li>--%>
            <li class="cart">
                <a href="<c:url value="/cart/view"/> " title=""><i class="icon2016 icon-cart"></i><em id="cartAmount"
                                                                                                      class="icon-num">0</em></a>
            </li>
        </ul>
    </div>
</div>

<c:if test="${homepage}">
    <div class="logo2016">
        <div class="hd"><a href="" title=""><img src="/scripts/images/logo2016.png" alt=""></a></div>
    </div>
</c:if>
<div class="nav2016">
    <div class="hd" id="cate">
        <div class="cate">
            <div class="dt"><span href="" title="非遗">全部商品<i class="icon2016 icon-arrow"></i></span></div>
            <jsp:include page="/productCategory.do" flush="true"/>
        </div>
        <!--//End--分类-->
        <div class="navitems">
            <ul>
                <li><a href="http://www.efeiyi.com" title="非遗电商平台">首页</a></li>
                <li><a href="http://www.efeiyi.com/subject/ihygpb6m24v43zv9" title="非遗礼品">礼品专区</a></li>
                <li><a href="http://www.efeiyi.com/subject/ihygpskg3j28dh60" title="非遗专题">精选专题</a></li>
            </ul>
        </div>
        <!--//End--导航-->
        <div class="search">
            <form action="<c:url value='/search.do'/>" method="get">
                <input type="text" value="<c:if test="${searchParamBean.q != '*'}">${searchParamBean.q}</c:if>" name="q"
                       id="q" placeholder="搜索" class="ipt">
                <input type="submit" value="" class="icon2016 btn">
                <input type="hidden" id="resultPage" name="resultPage" value="/searchResult"/>
                <input type="hidden" id="facetFields" name="facetFields" value="project_name"/>
                <input type="hidden" id="group" name="group" value="efeiyi"/>
                <input type="hidden" id="priceUD" name="priceUD" value="0"/>
            </form>

        </div>
        <!--//End--搜索-->
    </div>
</div>


<script>

    $().ready(function () {
        var success = function (data) {
            $("#cartAmount").html(data);
        }
        ajaxRequest("<c:url value="/cart/cartAmount.do"/>", {}, success, function () {
        }, "post");
    });

</script>
