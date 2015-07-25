<!DocType html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
</head>
<body>
<div id="page-header">
    <div class="page-header-left">
        <h6 class="page-header-logo"><a href="#"><img src="<c:url value="/scripts/assets/images/logo.gif" />"></a></h6>
        <p>中国非遗电商平台-传承人官网</p>
    </div>
    <div class="page-header-right"></div>
</div>
<div data-am-widget="slider" class="am-slider am-slider-a1 am-banner-q1" data-am-slider='{"directionNav":false}'>
    <ul class="am-slides">
        <li>
            <img src="http://s.amazeui.org/media/i/demos/bing-1.jpg">
        </li>
        <li>
            <img src="http://s.amazeui.org/media/i/demos/bing-2.jpg">
        </li>
        <li>
            <img src="http://s.amazeui.org/media/i/demos/bing-3.jpg">
        </li>
        <li>
            <img src="http://s.amazeui.org/media/i/demos/bing-4.jpg">
        </li>
    </ul>
</div>
<div id="page-section">
    <div class="page-section-text"><a href="#"><img src="<c:url value="/scripts/assets/images/i/wz2-5.gif" />"></a></div>
    <div class="page-section-figure">
        <c:forEach items="${list}" var="tenantProject" varStatus="rec">
            <c:if test="${tenantProject.project.type == 1}">
                <div class="img-mutual am-u-sm-4" style="float:left;">
                    <div class="box">
                        <img src="<c:url value="/scripts/assets/images/images/tx1_03.jpg"/>" alt="">
                        <div class="BG"></div>
                        <p class="txt">
                        <div class="img-mutual-text1">
                            <h1>${tenantProject.tenant.fullName}</h1>
                            <p>${tenantProject.tenant.brief}</p>
                        </div>
                        </p>
                    </div>
                    <span class="img-mutual-jump"><a href="<c:url value="/tenant/${tenantProject.tenant.id}"/>">深入了解</a></span>
                </div>
            </c:if>
        </c:forEach>
    </div>
</div>
<div class="page-border"></div>
<div  class="page-section">
    <div class="page-section-text"><a href="#"><img src="<c:url value="/scripts/assets/images/i/wz2-6.gif" />"></a></div>
    <div class="page-section-figure">
        <c:forEach items="${list}" var="tenantProject" varStatus="rec">
            <c:if test="${tenantProject.project.type == 2}">
                <div class="img-mutual am-u-sm-4" style="float:left;">
                    <div class="box">
                        <img src="<c:url value="/scripts/assets/images/images/tx1_03.jpg"/>" alt="">
                        <div class="BG"></div>
                        <p class="txt">
                        <div class="img-mutual-text1">
                            <h1>${tenantProject.tenant.fullName}</h1>
                            <p>${tenantProject.tenant.brief}</p>
                        </div>
                        </p>
                    </div>
                    <span class="img-mutual-jump"><a href="<c:url value="/tenant/${tenantProject.tenant.id}"/>">深入了解</a></span>
                </div>
            </c:if>
        </c:forEach>
    </div>
</div>
<div class="page-border-solid"></div>
<div class="page-footer">
    <dl class="page-footer-dl">
        <dt>正品保障</dt>
        <dd>
            <p><a href="#">诚品宝</a></p>
            <p><a href="#">防伪溯源</a></p>
        </dd>
    </dl>
    <dl class="page-footer-dl">
        <dt>新手指南</dt>
        <dd>
            <p><a href="#">导购演示</a></p>
            <p><a href="#">常见问题</a></p>
            <p><a href="#">免费注册</a></p>
        </dd>
    </dl>
    <dl class="page-footer-dl">
        <dt>支付方式</dt>
        <dd>
            <p><a href="#">支付宝</a></p>
            <p><a href="#">微信</a></p>
        </dd>
    </dl>
    <dl class="page-footer-dl">
        <dt>物流配送</dt>
        <dd>
            <p><a href="#">验货签收</a></p>
            <p><a href="#">物流查询</a></p>
        </dd>
    </dl>
    <dl class="page-footer-dl">
        <dt>售货服务</dt>
        <dd>
            <p><a href="#">退换货政策</a></p>
            <p><a href="#">退换货流程</a></p>
            <p><a href="#">微信</a></p>
        </dd>
    </dl>
    <dl class="page-footer-dl">
        <dt>正品保障</dt>
        <dd>
            <p><a href="#">商家入驻指南</a></p>
            <p><a href="#">商家帮助</a></p>
        </dd>
    </dl>
    <dl class="page-footer-dl" id="page-footer-dl">
        <dt id="page-wx-tp"></dt>
        <dd>

        </dd>
    </dl>
</div>
<div class="page-bg-text">
    <p>
        <a class="am-btn am-btn-link page-a-text">关于我们</a>
        <a class="am-btn am-btn-link page-a-text">商家入驻</a>
        <a class="am-btn am-btn-link page-a-text">诚聘英才</a>
        <a class="am-btn am-btn-link page-a-text">帮助中心</a>
        <a class="am-btn am-btn-link page-a-text">法律声明</a>
        <a class="am-btn am-btn-link page-a-text">国家非遗博览园</a>
        <a class="am-btn am-btn-link page-a-text">国际非遗博览会</a>
        <a class="am-btn am-btn-link page-a-text">国际非遗峰会</a>
    </p>
</div>
<h4 id="page-footer-head">Copyright(c) 2015-2020 efeiyi.com All Rights Reserved</h4>
<h4 id="page-footer-head-1">京ICP备15032511号-1</h4>
<!--分析-->
<div class="floating_ck">
    <dl>
        <dt></dt>
        <dd class="return">
            <span onClick="gotoTop();return false;"></span>
        </dd>
        <dd class="qrcord">
            <span ></span>
            <div class="floating_left floating_ewm floating_left-1">
                <i><img src="<c:url value="/scripts/assets/images/images/img6_03.jpg" />"></i>
            </div>
        </dd>
        <dd class="quote">
            <span>分享</span>
            <div class="floating_left">
                <a href="#" class="float-a"><img src="<c:url value="/scripts/assets/images/i/wx.gif" />"></a>
                <a href="#" class="float-a"><img src="<c:url value="/scripts/assets/images/i/wqq.gif" />"></a>
                <a href="#" class="float-a"><img src="<c:url value="/scripts/assets/images/i/kj.gif" />"></a>
                <a href="#" class="float-a"><img src="<c:url value="/scripts/assets/images/i/xl.gif" />"></a>
                <a href="#" class="float-a"><img src="<c:url value="/scripts/assets/images/i/qq.gif" />"></a>
            </div>
        </dd>


    </dl>
</div>
</body>
</html>
