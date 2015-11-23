<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="<c:url value="/scripts/js/system.js?v=929"/>"></script>
<div class="footer wh">
    <div class="service wh">
        <div class="icon phone"></div>
        <div class="line"></div>
        <div class="icon platform"><a href="<c:url value="/document/richTextView?group=ec.ptys"/>" target="_blank" title="平台优势">平台优势</a></div>
        <div class="line"></div>
        <div class="icon chengbao"><a href="http://www.315cheng.com" target="_blank" title="诚品宝">诚品宝</a></div>
        <div class="line"></div>
        <div class="icon wechat"><i class="icon"></i></div>
    </div>
    <div class="links wh">
        <a href="<c:url value="/document/richTextView?group=ec.gwlc"/> " target="_blank" title="帮助中心">帮助中心</a>
        <a class="line"></a>
        <a href="<c:url value="/document/richTextView?group=ec.zpbz"/> " target="_blank" title="服务保障">服务保障</a>
        <a class="line"></a>
        <a href="<c:url value="/document/richTextView?group=ec.gywm"/> " target="_blank" title="关于我们">关于我们</a>
        <a class="line"></a>
        <a href="<c:url value="/document/richTextView?group=ec.lxwm"/>" target="_blank" title="联系我们">联系我们</a>
        <a class="line"></a>
        <a href="<c:url value="/document/richTextView?group=ec.cpyc"/>" target="_blank" title="诚聘英才">诚聘英才</a>
        <a class="line"></a>
        <a href="<c:url value="/document/richTextView?group=ec.yjfk"/>" target="_blank" title="意见反馈">意见反馈</a>
        <a class="line"></a>
        <a href="<c:url value="/document/richTextView?group=ec.flsm"/>" target="_blank" title="法律声明">法律声明</a>
        <%--<a class="line"></a>--%>
        <%--<a href="<c:url value="/document/richTextView?group=ec.gywm"/> " target="_blank" title="新闻资讯">新闻资讯</a>--%>
    </div>
    <div class="copyright wh">
        <div class="frlinksimg">
            <strong>独家合作</strong>
            <a class="icon1" href="http://en.unesco.org/" title="联合国教科文组织" target="_blank"></a>
            <em class="line"></em>
            <a class="icon3" title="中国非物质文化遗产保护协会"></a>
            <em class="line"></em>
            <a class="icon2" title="中国非物质文化遗产保护协会"></a>
        </div>
        <div class="phone">
            <strong>商家入驻热线</strong>
            <em>400-876-8766</em>
        </div>
        <div class="frlinks">
            <span>友情链接：</span>
            <a rel="nofollow" href="http://en.unesco.org/" target="_blank" title="联合国教科文组织">联合国教科文组织</a>
            <a rel="nofollow" href="http://www.mcprc.gov.cn/" target="_blank" title="中国文化部">中国文化部</a>
            <%--<a rel="nofollow" href="http://www.yongxinhua.cn/ " target="_blank" title="永新华控股">永新华控股</a>--%>
            <%--<a rel="nofollow" href="http://www.ihchina.cn/show/feiyiweb/index.html" target="_blank" title="中国非物质文化遗产保护中心">中国非物质文化遗产保护中心</a>--%>
        </div>
        <div class="info">Copyright © 2012-2022 永新华韵文化发展有限公司版权所有-京ICP备15032511号-1&nbsp;&nbsp;京公网安备11010502027457</div>
    </div>
    <div class="wh authentication">
        <a href="http://gawa.bjchy.gov.cn/" target="_blank" title="网站域名备案"><img src="<c:url value="/scripts/images/authentication-0.png"/>" alt="网站域名备案"></a>
        <a href="http://www.miitbeian.gov.cn" target="_blank" title="网站域名备案"><img src="<c:url value="/scripts/images/authentication-1.png"/>" alt="网站域名备案"></a>
        <a href="http://www.baic.gov.cn/" target="_blank" title="企业信用信息备案"><img src="<c:url value="/scripts/images/authentication-2.png"/>" alt="企业信用信息备案"></a>
        <a href="<c:url value="/scripts/images/license.jpg"/>" target="_blank" title="企业营业执照"><img src="<c:url value="/scripts/images/authentication-3.png"/>" alt="企业营业执照 "></a>
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
        background:url(http://www.efeiyi.com/scripts/images/icon.png) no-repeat -176px -143px;
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
<!--[if lte IE 8 ]>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value="/scripts/js/amazeui.ie8polyfill.min.js"/>"></script>
<![endif]-->

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

<!--//End--右侧返回顶部和在线客服-->
<div style="display: none">
<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1256452193'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s4.cnzz.com/z_stat.php%3Fid%3D1256452193' type='text/javascript'%3E%3C/script%3E"));</script>
</div>
