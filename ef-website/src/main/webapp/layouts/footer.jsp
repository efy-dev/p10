<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="<c:url value='/resources/js/alert.js'/>"></script>
<script src="<c:url value="/resources/assets/js/amazeui.min.js"/>"></script>
<script src="<c:url value="/scripts/js/ef.util.js"/>"></script>
<script src="<c:url value="/scripts/js/myorder.js?v=929"/>"></script>
<c:if test="${init!=true}">
<script src="<c:url value="/scripts/js/system.js?v=929"/>"></script>
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
            <!--<div class="copyright wh">
                <div class="phone">
                    <strong>商家入驻热线</strong>
                    <em>400-876-8766</em>
                </div>
                <div class="frlinks">
                    <span>友情链接：</span>
                    <a rel="nofollow" href="http://www.unesco.org.cn/" target="_blank" title="联合国教科文组织">联合国教科文组织</a>
                    <a rel="nofollow" href="http://www.mcprc.gov.cn/" target="_blank" title="中国文化部">中国文化部</a>
                    <a rel="nofollow" href="" target="_blank" title="中国文化部非物质文化遗产保护司">中国文化部非物质文化遗产保护司</a>
                    <a rel="nofollow" href="" target="_blank" title="中国非物质文化遗产保护中心">中国非物质文化遗产保护中心</a>
                </div>
                <div class="info">Copyright ? 2012-2022 永新华韵文化发展有限公司版权所有-京ICP备15032511号-1</div>
            </div>-->
            <div class="wh authentication">
                <a href="http://www.miitbeian.gov.cn" target="_blank" title=""> <img class="imgfilter"
                                                                                     src="<c:url value="/scripts/images/authentication-0.png"/>"
                                                                                     alt=""></a>
                <a href="http://www.miitbeian.gov.cn" target="_blank" title="网站域名备案"> <img class="imgfilter"
                                                                                           src="<c:url value="/scripts/images/authentication-1.png"/>"
                                                                                           alt="网站域名备案"></a>
                <a href="http://www.baic.gov.cn/" target="_blank" title="企业信用信息备案"> <img class="imgfilter"
                                                                                         src="<c:url value="/scripts/images/authentication-2.png"/>"
                                                                                         alt="企业信用信息备案"></a>
                <a href="/scripts/images/license.jpg" target="_blank" title="企业营业执照"> <img class="imgfilter"
                                                                                           src="<c:url value="/scripts/images/authentication-3.png"/>"
                                                                                           alt="企业营业执照 "></a>
                <div class="info">Copyright © 2012-2022 永新华韵文化发展有限公司版权所有-京ICP备15032511号-1</div>
            </div>
        </div>
        <div class="newphone">
        </div>
    </div>

<div class="scroll-bar" style="z-index: 9999">
    <div class="scroll-bar-top">
        <span class="btn"><i class="icon" style="margin-left: 4px;margin-top: 6px;display: block;"></i></span>
    </div>
</div>

<style type="text/css">
    #MEIQIA-BTN-HOLDER {
        right: 0;bottom: 252px;}
    #MEIQIA-BTN {
        background: #000;
        width: 33px;
        height:53px;
        -webkit-border-radius: 5px;
        -moz-border-radius: 5px;
        border-radius: 5px;
    }
    #MEIQIA-BTN-LINE {
        display: none;}
    #MEIQIA-BTN-TEXT {
        width:48px;
        font-size: 12px;
        position: absolute;
        left:-28px;
        top:20px;
        display: none;
    }
    .MEIQIA-ICON {
        background:url(http://mall.efeiyi.com/scripts/images/icon.png) no-repeat -176px -143px;
    }
    #MEIQIA-BTN-ICON {
        width: 23px;
        height: 28px;
        margin: 0;
        float: left;
        margin-left:5px;
        margin-top: 6px;
    }
</style>
</c:if>
<!--[if lte IE 8 ]>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value="/scripts/js/amazeui.ie8polyfill.min.js"/>"></script>
<![endif]-->
<script>

    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){

                (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),

            m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)

    })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

    ga('create', 'UA-69796169-1', 'auto');

    ga('send', 'pageview');

</script>
<script>

    var _hmt = _hmt || [];

    (function() {

        var hm = document.createElement("script");

        hm.src = "//hm.baidu.com/hm.js?15b49366788c12ff091a0f6b23c8835f";

        var s = document.getElementsByTagName("script")[0];

        s.parentNode.insertBefore(hm, s);

    })();

</script>
<c:if test="${init!=true}">
<script type='text/javascript'>
    (function(m, ei, q, i, a, j, s) {
        m[a] = m[a] || function() {
                    (m[a].a = m[a].a || []).push(arguments)
                };
        j = ei.createElement(q),
                s = ei.getElementsByTagName(q)[0];
        j.async = true;
        j.src = i;
        s.parentNode.insertBefore(j, s)
    })(window, document, 'script', '//eco-api.meiqia.com/dist/meiqia.js', '_MEIQIA');
    _MEIQIA('entId', 486);
</script>
</c:if>
<script>
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
            m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

    ga('create', 'UA-70772829-1', 'auto');
    ga('send', 'pageview');

    //统计推广source点击量
    var currentUrl = window.location.href;
    if(currentUrl.indexOf("source") > 0){
        $.ajax({
            type: 'post',
            url: '<c:url value="/watchUrlSource.do"/>',
            dataType: 'json',
            data: {
                "currentUrl":currentUrl
            },
            success: function (data) {
                console.log(data);
            },

        });
    }
</script>
<script type="text/javascript">
    var _mvq = window._mvq || [];
    window._mvq = _mvq;
    _mvq.push(['$setAccount', 'm-197303-0']);

    _mvq.push(['$logConversion']);
    (function() {
        var mvl = document.createElement('script');
        mvl.type = 'text/javascript'; mvl.async = true;
        mvl.src = ('https:' == document.location.protocol ? 'https://static-ssl.mediav.com/mvl.js' : 'http://static.mediav.com/mvl.js');
        var s = document.getElementsByTagName('script')[0];
        s.parentNode.insertBefore(mvl, s);
    })();
</script>
<script>
    $(function(){
        $(".foretop").click(function(){
            $('html,body').animate({'scrollTop':0},500);
        });
    })();
</script>
<!--//End--右侧返回顶部和在线客服-->
<div style="display: none">
    <script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1256452193'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s4.cnzz.com/z_stat.php%3Fid%3D1256452193' type='text/javascript'%3E%3C/script%3E"));</script>
</div>