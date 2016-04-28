<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="top2016">
    <div class="hd">
        <div class="tips fl"><i class="min-logo"></i>汇聚东方工艺精粹</div>
        <div class="search-gift">
            <form action="">
                <input type="text" value="" placeholder="搜索" class="ipt">
                <input type="submit" value="" class="icon2016-gift btn">
            </form>
            <div class="gift-link">
                <a href="">剪纸</a>
                <span class="icon2016-gift"></span>
                <a href="">景泰蓝</a>
                <span class="icon2016-gift"></span>
                <a href="">湘绣</a>
                <span class="icon2016-gift"></span>
                <a href="">苏绣</a>
                <span class="icon2016-gift"></span>
                <a href="">铜雕</a>
                <span class="icon2016-gift"></span>
                <a href="">鼻烟壶</a>
                <span class="icon2016-gift"></span>
                <a href="">金银丝镶嵌</a>
            </div>
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
                            <c:forEach items="${map.value}" var="productGiftTagValue">
                                <li><a href="">${productGiftTagValue.value}</a></li>
                            </c:forEach>

                        </ul>
                    </div>

                </c:forEach>
            </div>
        </div>
        <!--//End--分类-->
        <div class="navitems">
            <ul>
                <li><a href="<c:url value="/home.do"/>" title="">首页</a></li>
                <li><a href="<c:url value="/industrySolution"/>" title="">企业礼品</a></li>
                <li><a href="<c:url value="/viewSubject/{}"/>" title="">国礼轶事</a></li>
                <li><a href="<c:url value="/viewSubject/{}"/>" title="">礼尚往来</a></li>
                <li><a href="<c:url value="/getProductGiftList"/>" title="">礼品专区</a></li>
            </ul>
        </div>
        <!--//End--导航-->

        <!--//End--搜索-->
    </div>
</div>