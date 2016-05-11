<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--//End--nav2016-->
<div id="slide2016" class="slide2016">
    <div class="img">
        <div class="click prev"></div>
        <ul>
            <c:if test="${bannerList != null && bannerList != ''}">
                <c:forEach items="${bannerList}" var="banner">
                    <li><a href="${banner.directUrl}" title=""><img src="http://gift-oss.efeiyi.com/${banner.imageUrl}" alt=""></a></li>
                </c:forEach>
            </c:if>
        </ul>
        <div class="click next"></div>
    </div>
    <div class="num">
        <ul>
            <li class="active"></li>
            <li></li>
            <li></li>
        </ul>
    </div>
</div>
<!--//End--slide2016-->
<div class="gift2016">
    <div class="gift-home">
        <div class="recommend">
            <div class="title-txt">推荐好礼</div>
            <ul class="list">
                <c:if test="${advertisementList != null && advertisementList != ''}">
                    <c:forEach items="${advertisementList}" var="advertisement">
                        <li>
                            <a href="${advertisement.redirect}">
                                <div style="height: 242px;float: left">
                                    <img src="http://pro.efeiyi.com/${advertisement.img}" alt="">
                                </div>
                                <%--<div class="list-content">
                                    <p class="name">${subject.name}</p>
                                    <p class="title">国家级非遗项目</p>
                                </div>--%>
                            </a>
                        </li>
                    </c:forEach>
                </c:if>
            </ul>
        </div>
        <div class="banner"><a href=""><img src="<c:url value="/scripts/upload/banner-gift.png"/>" alt=""></a></div>
        <div class="strategy">
            <ul class="strategy-list">
                <c:if test="${subjectList != null && subjectList != ''}">
                    <c:forEach items="${subjectList}" var="subject">
                        <li>
                            <a href="<c:url value="/viewSubject/${subject.id}"/>">
                                <img src="http://gift-oss.efeiyi.com/${subject.pictureUrl}" alt="">
                                <div class="list-content">
                                    <p class="name">${subject.name}</p>
                                    <p class="content">${subject.content}</p>
                                </div>
                            </a>
                        </li>
                    </c:forEach>
                </c:if>
            </ul>
        </div>
    </div>
</div>
