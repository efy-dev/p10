<%@ page import="com.efeiyi.ec.gift.base.util.AuthorizationUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="top2016">
    <div class="hd">
        <ul class="fr">
            <li><a href="http://www.efeiyi.com" title="e飞蚁首页">e飞蚁首页</a></li>
            <li><a href="http://mall.efeiyi.com" title="非遗电商">非遗电商</a></li>
            <li><a href="http://master.efeiyi.com" title="非遗大师">非遗大师</a></li>
            <li><a href="http://j.efeiyi.com/ef-wiki/" title="非遗百科">非遗百科</a></li>
            <li><a href="http://j.efeiyi.com/ef-gift/" title="非遗礼品">非遗礼品</a></li>
            <li><a href="http://www.315cheng.com" title="诚品宝">诚品宝</a></li>
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
            <li><a href="http://passport.efeiyi.com/register?service=http://j.efeiyi.com/ef-gift/sso.do?registeSuccess=/pc/saveEnrollUser.do" title="快速注册">快速注册</a></li>
            <%
                }
            %>
            <li><a href="http://mall.efeiyi.com/document/helpCenter?group=ec.rzlc" title="e飞蚁入驻">商家入驻</a></li>
        </ul>
    </div>
</div>
<!--//End--topbar-->

<div class="topv2" style="padding-top: 0;">
    <div class="hd">
        <div class="tips fl"><a class="logo"><img src="<c:url value="/scripts/images/ef-logo-gift.png"/>" alt=""></a></div>
        <div class="fr">
            <form action="http://mall.efeiyi.com/search.do" method="get">
                <input type="text" value="<c:if test="${searchParamBean.q != '*'}">${searchParamBean.q}</c:if>" name="q"
                       id="q" placeholder="搜索" class="txt">
                <input type="submit" value="" class="icon2016-gift btn">
                <input type="hidden" id="resultPage" name="resultPage" value="/searchResult"/>
                <input type="hidden" id="facetFields" name="facetFields" value="project_name"/>
                <input type="hidden" id="group" name="group" value="efeiyi"/>
                <input type="hidden" id="priceUD" name="priceUD" value="0"/>
            </form>
        </div>
    </div>
</div>
<!--//End--topbar-->
<div class="nav2016 bgc">
    <div class="hd bgf">
        <div id="cate" class="cate">
            <div class="dt"><span href="" title="">全部商品<i class="icon2016 icon-arrow"></i></span></div>
            <div class="dd" style="display:none">
                <c:forEach items="${map}" var="map">
                    <div class="layer">
                        <ul>
                            <li class="title"><strong>${map.key}：</strong></li>
                            <%
                                if(request.getParameter("minPrice")!=null && !request.getParameter("minPrice").equals("") && request.getParameter("maxPrice")!=null && !request.getParameter("maxPrice").equals("")){

                            %>
                            <c:forEach items="${map.value}" var="productGiftTagValue">
                                <li><a href="<c:url value="/getProductGiftpList?value="/>${productGiftTagValue.value}&minPrice=<%=request.getParameter("minPrice")%>&maxPrice=<%=request.getParameter("maxPrice")%>">${productGiftTagValue.value}</a></li>
                            </c:forEach>
                            <%
                            }else {
                            %>
                            <c:forEach items="${map.value}" var="productGiftTagValue">
                                <li><a href="<c:url value="/getProductGiftpList?value="/>${productGiftTagValue.value}&minPrice=&maxPrice=">${productGiftTagValue.value}</a></li>
                            </c:forEach>
                            <%
                                }
                            %>
                        </ul>
                    </div>
                </c:forEach>
                <div class="layer">
                    <ul>
                        <li class="title"><strong>商品价格 : </strong></li>
                        <%
                            if(request.getParameter("value")!=null && !request.getParameter("value").equals("")){

                        %>
                        <li><a href="<c:url value="/getProductGiftpList?value="/><%=request.getParameter("value")%>&minPrice=0&maxPrice=100">百元以内</a></li>
                        <li><a href="<c:url value="/getProductGiftpList?value="/><%=request.getParameter("value")%>&minPrice=100&maxPrice=1000">100~1000</a></li>
                        <li><a href="<c:url value="/getProductGiftpList?value="/><%=request.getParameter("value")%>&minPrice=1000&maxPrice=5000">1000~5000</a></li>
                        <li><a href="<c:url value="/getProductGiftpList?value="/><%=request.getParameter("value")%>&minPrice=5000&maxPrice=10000">5000~1万</a></li>
                        <li><a href="<c:url value="/getProductGiftpList?value="/><%=request.getParameter("value")%>&minPrice=10000&maxPrice=100000">1万~10万</a></li>
                        <li><a href="<c:url value="/getProductGiftpList?value="/><%=request.getParameter("value")%>&minPrice=100000&maxPrice=1000000000">10万以上</a></li>
                        <%
                        }else {
                        %>
                        <li><a href="<c:url value="/getProductGiftpList?value="/>&minPrice=0&maxPrice=100">百元以内</a></li>
                        <li><a href="<c:url value="/getProductGiftpList?value="/>&minPrice=100&maxPrice=1000">100~1000</a></li>
                        <li><a href="<c:url value="/getProductGiftpList?value="/>&minPrice=1000&maxPrice=5000">1000~5000</a></li>
                        <li><a href="<c:url value="/getProductGiftpList?value="/>&minPrice=5000&maxPrice=10000">5000~1万</a></li>
                        <li><a href="<c:url value="/getProductGiftpList?value="/>&minPrice=10000&maxPrice=100000">1万~10万</a></li>
                        <li><a href="<c:url value="/getProductGiftpList?value="/>&minPrice=100000&maxPrice=1000000000">10万以上</a></li>
                        <%
                            }
                        %>
                    </ul>
                </div>
            </div>
        </div>
        <!--//End--分类-->
        <div class="navitems">
            <ul>
                <li><a href="<c:url value="/home.do"/>" title="">首页</a></li>
                <li><a href="<c:url value="/industrySolution"/>" title="">企业礼品</a></li>
                <li><a href="<c:url value="/viewSubject/inzu4ha1b7pa9flo"/>" title="">国礼轶事</a></li>
                <li><a href="<c:url value="/viewSubject/inzu4s481azja868"/>" title="">中国“礼”文化</a></li>
            </ul>
        </div>
        <!--//End--导航-->

        <!--//End--搜索-->
    </div>
</div>