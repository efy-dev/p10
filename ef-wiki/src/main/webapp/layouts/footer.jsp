<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="footernew wh">
    <div class="servicenew wh">
        <div class="hd tct">
            <div class=" foremax">
                <div class="foretop"></div>
                <dl class="fore">
                    <dt>帮助中心</dt>
                    <dd><a href="/document/helpCenter?group=ec.gwlc" target="_blank">购物流程</a></dd>
                    <dd><a href="/document/helpCenter?group=ec.zffs" target="_blank">支付方式</a></dd>
                    <dd><a href="/document/helpCenter?group=ec.psfs" target="_blank">配送方式</a></dd>
                </dl>
                <dl class="fore">
                    <dt>商家服务</dt>
                    <dd><a href="/document/helpCenter?group=ec.rzxz" target="_blank">入驻须知</a></dd>
                    <dd><a href="/document/helpCenter?group=ec.rzlc" target="_blank">入驻流程</a></dd>
                    <dd><a href="/document/helpCenter?group=ec.rzzx" target="_blank">入驻咨询</a></dd>
                </dl>
                <dl class="fore">
                    <dt>售后流程</dt>
                    <dd><a href="/document/helpCenter?group=ec.thlc" target="_blank">退货流程</a></dd>
                    <dd><a href="/document/helpCenter?group=ec.hhlc" target="_blank">换货流程</a></dd>
                </dl>
                <dl class="fore">
                    <dt>服务保障</dt>
                    <dd><a href="/document/helpCenter?group=ec.zpbz" target="_blank">正品保障</a></dd>
                    <dd><a href="/document/helpCenter?group=ec.shzc" target="_blank">售后政策</a></dd>
                </dl>
                <dl class="fore">
                    <dt>法律声明</dt>
                    <dd><a href="/document/helpCenter?group=ec.flsm" target="_blank">法律声明</a></dd>
                    <dd><a href="/document/helpCenter?group=ec.aqjyssm" target="_blank">安全及隐私声明</a></dd>
                </dl>
            </div>
        </div>
    </div>
    <div class="max-links wh">
        <div class="copyright wh">
            <div class="frlinksimg">
                <div class="simgbox">
                    <strong>战略合作伙伴</strong>
                    <a class="icon1" href="http://en.unesco.org/" title="联合国教科文组织" target="_blank"></a><em
                        class="line"></em><a class="icon3" title="中国非物质文化遗产保护协会"></a><em class="line"></em><a
                        class="icon2" title="中国非物质文化遗产保护协会"></a>
                </div>
            </div>

        </div>
        <div class="links wh">
            <a href="/document/aboutUs?group=ec.gywm" target="_blank" title="关于我们">关于我们</a>
            <a class="line"></a>
            <a href="/document/aboutUs?group=ec.ptys" target="_blank" title="平台优势">平台优势</a>
            <a class="line"></a>
            <a href="/document/aboutUs?group=ec.cpyc" target="_blank" title="诚聘英才">诚聘英才</a>
            <a class="line"></a>
            <a href="/document/aboutUs?group=ec.lxwm" target="_blank" title="联系我们">联系我们</a>
            <a class="line"></a>
            <a href="/document/aboutUs?group=ec.yjfk" target="_blank" title="意见反馈">意见反馈</a>
            <a class="line"></a>
            <a href="/document/aboutUs?group=ec.fyjj" target="_blank" title="非遗简介">非遗简介</a>
        </div>
        <div class="wh authentication">
            <a href="http://www.miitbeian.gov.cn" target="_blank" title=""> <img class="imgfilter"
                                                                                 src="<c:url value="/scripts/assets/images/authentication-0.png"/>"
                                                                                 alt=""></a>
            <a href="http://www.miitbeian.gov.cn" target="_blank" title="网站域名备案"> <img class="imgfilter"
                                                                                       src="<c:url value="/scripts/assets/images/authentication-1.png"/>"
                                                                                       alt="网站域名备案"></a>
            <a href="http://www.baic.gov.cn/" target="_blank" title="企业信用信息备案"> <img class="imgfilter"
                                                                                     src="<c:url value="/scripts/assets/images/authentication-2.png"/>"
                                                                                     alt="企业信用信息备案"></a>
            <a href="/scripts/images/license.jpg" target="_blank" title="企业营业执照"> <img class="imgfilter"
                                                                                       src="<c:url value="/scripts/assets/images/authentication-3.png"/>"
                                                                                       alt="企业营业执照 "></a>
            <div class="info">Copyright © 2012-2022 永新华韵文化发展有限公司版权所有-京ICP备15032511号-1</div>
        </div>
    </div>
    <div class="newphone">
        <%--<div class="efy-icon"></div>--%>
    </div>
</div>
<script>
    $(function(){
        $(".foretop").click(function(){
            $('html,body').animate({'scrollTop':0},500);
        });
    })();
</script>