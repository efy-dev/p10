<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
</head>
<body>
<div id="header">
    <h1><img src="/scripts/assets/images/logo1.gif" alt="vlogo" class="logov"></h1>
    <div class="printing">国家级非物质文化遗产传承人<span>  [<a href="#">木板水印</a>]</span></div>
    <ul class="register">
        <li class="register-page"><a href="#"><img src="/scripts/assets/images/i/wz1.gif"></a></li>
        <li class="register-left"><a href="#"><img src="/scripts/assets/images/i/wz2.gif"></a></li>
        <li class="register-right"><a href="#"><img src="/scripts/assets/images/i/wz3.gif"></a></li>
    </ul>
</div>
<div id="nav">
    <h1><a href="#"><img src="/scripts/assets/images/logo2.gif"></a></h1>
    <ul class="nav-centent">
        <li><a href="#"><img src="/scripts/assets/images/i/nav-sy.gif"></a></li>
        <li><a href="#"><img src="/scripts/assets/images/i/nav-jj.gif"></a></li>
        <li><a href="#"><img src="/scripts/assets/images/i/nav-zp.gif"></a></li>
        <li><a href="${pageContext.request.contextPath}/tenant/tenantInfoList.do?tenantId=1"><img src="/scripts/assets/images/i/nav-zx.gif"></a></li>
        <li><a href="#"><img src="/scripts/assets/images/i/nav-gzf.gif"></a></li>
    </ul>
</div>

<div id="banner1">
    <div id="full-screen-slider">
        <ul id="slides">
            <li style="background:url(/scripts/assets/images/img4.jpg) no-repeat center top"><a href="#" ></a></li>
            <li style="background:url(/scripts/assets/images/img4.jpg) no-repeat center top"><a href="#" ></a></li>
            <li style="background:url(/scripts/assets/images/img4.jpg) no-repeat center top"><a href="#" ></a></li>
            <li style="background:url(/scripts/assets/images/img4.jpg) no-repeat center top"><a href="#" ></a></li>
        </ul>
    </div>
    <div id="tab">
        <h1>${entity.name}</h1>
        <p>国家级非物质文化遗产传承人</p>
        <dl class="tab-dl">
            <dt><a href="#"><img src="/scripts/assets/images/img5.jpg"></a></dt>
            <dd>魏立中，自幼学习绘画艺术，师从赵燕、冯远、全山石、张耕源、陈品超、徐银森。</dd>
        </dl>
        <span><a href="#">了解详细</a></span>
    </div>
</div>

<div id="center">
    <dl class="center-1">
        <dt class="center-1-dt"><a href="#"><img src="/scripts/assets/images/img1.gif"></a></dt>
        <dd class="center-1-dd"><span><a href="#">大师作品</a></span><span><a href="#">木版水印</a></span><span><a href="#">2015</a></span></dd>
    </dl>
    <dl class="center-2">
        <dt class="center-1-dt"><a href="#"><img src="/scripts/assets/images/img2.gif"></a></dt>
        <dd class="center-1-dd"><span><a href="#">大师作品</a></span><span><a href="#">木版水印</a></span><span><a href="#">2015</a></span></dd>
    </dl>
    <dl class="center-3">
        <dt class="center-1-dt"><a href="#"><img src="/scripts/assets/images/img3.gif"></a></dt>
        <dd class="center-1-dd"><span><a href="#">大师作品</a></span><span><a href="#">木版水印</a></span><span><a href="#">2015</a></span></dd>
    </dl>
</div>
<div id="footer">
    <ul class="guild">
        <li><a href="#"><img src="/scripts/assets/images/i/fybk.jpg"></a></li>
        <li><a href="#"><img src="/scripts/assets/images/i/efeiyi.jpg"></a></li>
        <li><a href="#"><img src="/scripts/assets/images/i/cpb.jpg"></a></li>
        <li><a href="#"><img src="/scripts/assets/images/i/gl.jpg"></a></li>
    </ul>
    <div class="efeiyi-url">Copyright © <a href="#">www.efeiyi.com</a>2015</div>
</div>
<!--分析-->
<div class="floating_ck">
    <dl>
        <dt></dt>
        <dd class="return">
            <span onClick="gotoTop();return false;"></span>
        </dd>
        <dd class="qrcord">
            <span></span>
            <div class="floating_left floating_ewm">
                <i></i>
            </div>
        </dd>
        <dd class="quote">
            <span>分享</span>
            <div class="floating_left"><a href="#">分享</a></div>
        </dd>


    </dl>
</div>
<!--内容-->

</body>
</html>
