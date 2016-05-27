<!DocType html>
<%@ page import="com.efeiyi.ec.personal.AuthorizationUtil" %>
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
<!-- 第一版头部 -->
<%--<div  class="header-search">--%>
<%--<h1><a href="http://www.efeiyi.com"><img src="<c:url value="/scripts/assets/images/images/logo.png"/>"></a></h1>--%>
<%--<div class="header-aifeiyi"></div>--%>
<%--<div class="header-sj"></div>--%>
<%--</div>--%>

<!-- 新头部 -->
<div class="top2016">
    <div class="hd" style="width:1200px;">
        <div class="tips fl"><a class="logo"></a></div>
        <ul class="fr">
            <li><a href="http://www.efeiyi.com" title="e飞蚁首页">e飞蚁首页</a></li>
            <li><a href="http://mall.efeiyi.com" title="非遗电商">非遗电商</a></li>
            <li><a href="http://master.efeiyi.com" title="非遗大师">非遗大师</a></li>
            <li><a href="http://minglu.efeiyi.com" title="非遗百科">非遗百科</a></li>
            <li><a href="http://gift.efeiyi.com" title="非遗礼品">非遗礼品</a></li>
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
            <li><a href="<c:url value="/sign/sso.do"/>" title="请登录">请登录</a></li>
            <li><a href="http://passport.efeiyi.com/register?service=http://j.efeiyi.com/ef-gift/sso.do?registeSuccess=/pc/saveEnrollUser.do" title="快速注册">快速注册</a></li>
            <%
                }
            %>
            <li><a href="http://mall.efeiyi.com/document/helpCenter?group=ec.rzlc" title="e飞蚁入驻">商家入驻</a></li>
            <%--<li><a href="http://www.efeiyi.com" title="e飞蚁商城">e飞蚁商城</a></li>--%>
            <%--<li><a href="http://craft.efeiyi.com/ef-wiki/" title="">工 艺</a></li>--%>
            <%--<li><a href="http://master.efeiyi.com" title="">大 师</a></li>--%>
            <%--<li><a href="/ef-wiki/sso.do" title="请登录">请登录</a></li>--%>
            <%--<li><a href="http://passport.efeiyi.com/register?service=http://j.efeiyi.com/ef-wiki/" title="快速注册">快速注册</a></li>--%>
            <%--<li><a href="http://www.efeiyi.com/document/helpCenter?group=ec.rzlc" title="e飞蚁入驻">商家入驻</a></li>--%>
        </ul>
    </div>
</div>
<div class="topv2" style="padding-top: 0;height:86px;">
    <div class="hd" style="width:1200px;">
        <div class="tips fl"><a class="logo" href=""><img src="<c:url value="/scripts/images/ef-logo-gf.png" />" alt=""></a></div>
        <div class="fr">
            <form action="http://www.efeiyi.com/search.do" method="get">
                <input type="text" value="" name="q" id="q" placeholder="搜索" class="txt">
                <input type="submit" value="" class="icon-new btn">
                <input type="hidden" id="resultPage" name="resultPage" value="/searchResult">
                <input type="hidden" id="facetFields" name="facetFields" value="project_name">
                <input type="hidden" id="group" name="group" value="efeiyi">
                <input type="hidden" id="priceUD" name="priceUD" value="0">
            </form>
        </div>
    </div>
</div>
<div class="nav2016 bgc">
    <div class="hd bgf" style="width:1200px;">
        <div class="navitems">
            <ul>
                <li><a href="<c:url value='/index'/>" title="">首页</a></li>
                <li><a href="<c:url value='/allMaster'/>" target="_blank" title="">全部大师</a></li>
                <li><a href="http://j.efeiyi.com/ef-person" target="_blank" title="">大师入驻</a></li>
            </ul>
        </div>
        <!--//End--导航-->
    </div>
</div>


<div style="width:100%;float:left;margin-top: 20px;">
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
                    <c:if test="${tenant.favicon != null && '' != tenant.favicon}">
                        <img src="http://tenant.efeiyi.com/${tenant.favicon}@!tenant-pc-tenant-list" alt="">
                    </c:if>
                    <c:if test="${tenant.favicon == null || '' == tenant.favicon}">
                        <img src="<c:url value="/scripts/assets/images/emptyPhoto.jpg"/>" alt="">
                    </c:if>
                    <div class="BG"></div>
                    <p class="txt">
                        <div class="img-mutual-text1">
                            <h1>${tenant.fullName}</h1>
                    <p>
                        <a href="http://${tenant.name}.efeiyi.com:${pageContext.request.serverPort}${pageContext.request.contextPath}" target="_blank">
                    <p>[${tenant.masterProjectList[0].project.name}]</p>
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
                <p>[${tenant.masterProjectList[0].project.name}]</p>
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
<%--<div class="page-border-solid"></div>--%>
<%--</div>--%>
<div class="footernew wh">
    <div class="servicenew wh">
        <div class="hd tct">
            <div class=" foremax">
                <dl class="fore">
                    <dt>帮助中心</dt>
                    <dd><a href="http://www.efeiyi.com/document/helpCenter?group=ec.gwlc" target="_blank">购物流程</a></dd>
                    <dd><a href="http://www.efeiyi.com/document/helpCenter?group=ec.zffs" target="_blank">支付方式</a></dd>
                    <dd><a href="http://www.efeiyi.com/document/helpCenter?group=ec.psfs" target="_blank">配送方式</a></dd>
                </dl>
                <dl class="fore">
                    <dt>商家服务</dt>
                    <dd><a href="http://www.efeiyi.com/document/helpCenter?group=ec.rzxz" target="_blank">入驻须知</a></dd>
                    <dd><a href="http://www.efeiyi.com/document/helpCenter?group=ec.rzlc" target="_blank">入驻流程</a></dd>
                    <dd><a href="http://www.efeiyi.com/document/helpCenter?group=ec.rzzx" target="_blank">入驻咨询</a></dd>
                </dl>
                <dl class="fore">
                    <dt>售后流程</dt>
                    <dd><a href="http://www.efeiyi.com/document/helpCenter?group=ec.thlc" target="_blank">退货流程</a></dd>
                    <dd><a href="http://www.efeiyi.com/document/helpCenter?group=ec.hhlc" target="_blank">换货流程</a></dd>
                </dl>
                <dl class="fore">
                    <dt>服务保障</dt>
                    <dd><a href="http://www.efeiyi.com/document/helpCenter?group=ec.zpbz" target="_blank">正品保障</a></dd>
                    <dd><a href="http://www.efeiyi.com/document/helpCenter?group=ec.shzc" target="_blank">售后政策</a></dd>
                </dl>
                <dl class="fore">
                    <dt>法律声明</dt>
                    <dd><a href="http://www.efeiyi.com/document/helpCenter?group=ec.flsm" target="_blank">法律声明</a></dd>
                    <dd><a href="http://www.efeiyi.com/document/helpCenter?group=ec.aqjyssm" target="_blank">安全及隐私声明</a></dd>
                </dl>
                <div class="wechatnew" title="手机e飞蚁">
                    <i class="inro-icon0"></i>
                    <i class="inro-icon"></i>
                </div>
            </div>
        </div>
    </div>
    <div class="max-links wh">
        <div class="links wh">
            <a href="/document/aboutUs?group=ec.gywm" target="_blank" title="关于我们"><i class="icon"></i>关于我们</a>
            <a href="/document/aboutUs?group=ec.ptys" target="_blank" title="平台优势"><i class="icon"></i>平台优势</a>
            <a href="/document/aboutUs?group=ec.cpyc" target="_blank" title="诚聘英才"><i class="icon"></i>诚聘英才</a>
            <a href="/document/aboutUs?group=ec.lxwm" target="_blank" title="联系我们"><i class="icon"></i>联系我们</a>
            <a href="/document/aboutUs?group=ec.yjfk" target="_blank" title="意见反馈"><i class="icon"></i>意见反馈</a>
            <a href="/document/aboutUs?group=ec.fyjj" target="_blank" title="非遗简介"><i class="icon"></i>非遗简介</a>
        </div>
        <div class="copyright wh">
            <div class="frlinksimg">
                <div class="simgbox">
                    <strong>战略合作伙伴</strong>
                    <a class="icon1" href="http://en.unesco.org/" title="联合国教科文组织" target="_blank"></a><em class="line"></em><a class="icon3" title="中国非物质文化遗产保护协会"></a><em class="line"></em><a class="icon2" title="中国非物质文化遗产保护协会"></a>
                </div>
            </div>
        </div>
        <div class="wh authentication">
            <div class="info">Copyright © 2012-2022 永新华韵文化发展有限公司版权所有-京ICP备15032511号-1</div>
            <a href="http://www.miitbeian.gov.cn" target="_blank" title=""> <img class="imgfilter" src="<c:url value="/scripts/assets/images/authentication-0.png"/>" alt=""></a>
            <a href="http://www.miitbeian.gov.cn" target="_blank" title="网站域名备案"> <img class="imgfilter" src="<c:url value="/scripts/assets/images/authentication-1.png"/>" alt="网站域名备案"></a>
            <a href="http://www.baic.gov.cn/" target="_blank" title="企业信用信息备案"> <img class="imgfilter" src="<c:url value="/scripts/assets/images/authentication-2.png"/>" alt="企业信用信息备案"></a>
            <a href="/scripts/images/license.jpg" target="_blank" title="企业营业执照"> <img class="imgfilter" src="<c:url value="/scripts/assets/images/authentication-3.png"/>" alt="企业营业执照 "></a>
        </div>
    </div>
</div>
<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1255887869'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "w.cnzz.com/q_stat.php%3Fid%3D1255887869' type='text/javascript'%3E%3C/script%3E"));</script>
</body>
</html>
