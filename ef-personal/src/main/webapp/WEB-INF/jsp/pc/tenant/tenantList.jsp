<!DocType html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
</head>
<body>
<%--<div id="page-header">
    <div class="page-header-left">
        <h6 class="page-header-logo"><a href="http://www.efeiyi.com" target="_blank"><img src="<c:url value="/scripts/assets/images/logo.gif" />"></a></h6>
        <p>中国非遗电商平台-传承人官网</p>
    </div>
    <div class="page-header-right"></div>
</div>--%>
<div  class="header-search">
    <h1><a href="http://www.efeiyi.com"><img src="<c:url value="/scripts/assets/images/images/logo.png"/>"></a></h1>
    <div class="header-aifeiyi"></div>
    <div class="header-sj"></div>
</div>
<div data-am-widget="slider" class="am-slider am-slider-a1 am-banner-q1" data-am-slider='{"directionNav":false}'>
    <ul class="am-slides">
        <li>
            <img src="http://tenant.oss-cn-beijing.aliyuncs.com/index_banner/%E5%A7%9A%E6%83%A0%E8%8A%AC%281%29.jpg">
        </li>
        <li>
            <img src="http://tenant.oss-cn-beijing.aliyuncs.com/index_banner/%E5%BC%A0%E5%90%8C%E7%A6%84%281%29.jpg">
        </li>
        <li>
            <img src="http://tenant.oss-cn-beijing.aliyuncs.com/index_banner/%E6%9C%B1%E7%82%B3%E4%BB%81%282%29.jpg">
        </li>
        <li>
            <img src="http://tenant.oss-cn-beijing.aliyuncs.com/index_banner/%E9%AD%8F%E7%AB%8B%E4%B8%ADbanner%281%29.jpg">
        </li>
    </ul>
</div>
<div id="page-section">
    <div class="page-section-text"><a href="#"><img src="<c:url value="/scripts/assets/images/i/wz2-5.gif" />"></a></div>
    <div class="page-section-figure">
        <c:forEach items="${skillList}" var="tenant" varStatus="rec">
            <div class="img-mutual am-u-sm-4" style="float:left;">
                <div class="box">
                    <img src="http://tenant.efeiyi.com/${tenant.favicon}@!tenant-pc-tenant-list" alt="">
                    <div class="BG"></div>
                    <p class="txt">
                    <div class="img-mutual-text1">
                        <h1>${tenant.fullName}</h1>
                        <p>
                            <a href="http://${tenant.name}.efeiyi.com:${pageContext.request.serverPort}${pageContext.request.contextPath}" target="_blank">
                                <c:forEach items="${tenant.masterProjectList}" var="obj">
                                    <c:if test="${obj.status == '1'}">
                                        <p>[${obj.project.name}]</p>
                                    </c:if>
                                </c:forEach>
                                <p><ming800:status name='level' dataType='Tenant.level' checkedValue='${tenant.level}' type='normal'/>非物质文化遗产传承人</p>
                            </a>
                        </p>
                    </div>
                    </p>
                </div>
                <span class="img-mutual-jump">
                    <a href="http://${tenant.name}.efeiyi.com:${pageContext.request.serverPort}${pageContext.request.contextPath}" target="_blank">
                        深入了解
                    </a></span>
            </div>
        </c:forEach>
    </div>
</div>
<div class="page-border"></div>
<div  class="page-section">
    <div class="page-section-text"><a href="#"><img src="<c:url value="/scripts/assets/images/i/wz2-6.gif" />"></a></div>
    <div class="page-section-figure">
        <c:forEach items="${artList}" var="tenant" varStatus="rec">
            <div class="img-mutual am-u-sm-4" style="float:left;">
                <div class="box">
                    <img src="http://tenant.efeiyi.com/${tenant.favicon}@!tenant-pc-tenant-list" alt="">
                    <div class="BG"></div>
                    <p class="txt">
                    <div class="img-mutual-text1">
                        <h1>${tenant.fullName}</h1>
                        <p>
                            <a href="http://${tenant.name}.efeiyi.com:${pageContext.request.serverPort}${pageContext.request.contextPath}" target="_blank">
                                <c:forEach items="${tenant.masterProjectList}" var="obj">
                                    <c:if test="${obj.status == '1'}">
                                        <p>[${obj.project.name}]</p>
                                    </c:if>
                                </c:forEach>
                                <p><ming800:status name='level' dataType='Tenant.level' checkedValue='${tenant.level}' type='normal'/>非物质文化遗产传承人</p>
                            </a>
                        </p>
                    </div>
                    </p>
                </div>
                <span class="img-mutual-jump">
                    <a href="http://${tenant.name}.efeiyi.com:${pageContext.request.serverPort}${pageContext.request.contextPath}" target="_blank">
                        深入了解
                    </a></span>
            </div>
        </c:forEach>
    </div>
</div>
<div class="page-border-solid"></div>
<%--<div class="page-footer">
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
<h4 id="page-footer-head-1">京ICP备15032511号-1</h4>--%>
<div class="footer">
    <ul class="hd">
        <li class="am-u-sm-2 am-u-end"><strong>友情链接：</strong></li>
        <li class="am-u-sm-2 am-u-end"><a target="_blank" href="http://www.ich-park.com/">永新华韵集团</a></li>
        <li class="am-u-sm-2 am-u-end"><a target="_blank" href="http://www.bjunesco.gov.cn/unesco/index/index.aspx">联合国教科文组织</a></li>
        <li class="am-u-sm-2 am-u-end"><a target="_blank" href="http://www.mcprc.gov.cn/">中国文化部</a></li>
        <li class="am-u-sm-2 am-u-end"><span class="span">中国文化部非物质文化遗产保护司</span></li>
        <li class="am-u-sm-2 am-u-end"><a target="_blank" href="http://govinfo.nlc.gov.cn/gtfz/xxgk/gwyzcbm/whb/201206/t20120620_2212933.html?classid=428">中国非物质文化遗产保护中心</a></li>
        <li class="am-u-sm-2 am-u-end"><a target="_blank" href="http://www.chinaih.com.cn/">中国非物质文化遗产保护协会</a></li>
        <li class="am-u-sm-2 am-u-end"><a target="_blank" href="http://www.dpm.org.cn/index1024768.html">故宫博物院</a></li>
        <li class="am-u-sm-2 am-u-end"><a target="_blank" href="http://www.sach.gov.cn/">国家文物局</a></li>
        <li class="am-u-sm-2 am-u-end"><a target="_blank" href="http://www.chinaculture.org/">中国文化网</a></li>
        <li class="am-u-sm-2 am-u-end"><a target="_blank" href="http://www.cnci.gov.cn/">中国文化产业网</a></li>
    </ul>
    <ul class="imgbg">
        <li class="li-img1"></li>
        <li class="span"></li>
        <li class="li-img2"><a href="http://www.efeiyi.com/ef-www/main/do7" target="_blank"></a></li>
        <li class="span"></li>
        <li class="li-img3"></li>
    </ul>
    <div class="footer-bottom">
        <ul class="correlation">
            <li><a target="_blank" href="http://www.efeiyi.com/main/aboutUs">关于我们</a></li>
            <li><a target="_blank" href="http://www.efeiyi.com/main/contactUs">联系我们</a></li>
            <li><a target="_blank" href="http://www.efeiyi.com/main/welcome">诚聘英才</a></li>
            <li>意见反馈</li>
            <li>诚信保证</li>
            <li><a target="_blank" href="http://www.efeiyi.com/main/helpCenter">帮助中心</a></li>
        </ul>
        <p>Copyright© 2012-2022 永新华韵文化发展有限公司版权所有-京ICP备15032511号-1</p>
        <p>永新华韵旗下网站：e飞蚁 传承人官网 诚品宝 集团官网</p>
        <div class="Keeponrecord">
            <span class="Keeponrecord-l"></span>
            <span class="Keeponrecord-r"></span>
        </div>
    </div>
    <script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1255887869'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "w.cnzz.com/q_stat.php%3Fid%3D1255887869' type='text/javascript'%3E%3C/script%3E"));</script>
</div>
<!--分析-->
<%--<div class="floating_ck">
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
</div>--%>
</body>
</html>
