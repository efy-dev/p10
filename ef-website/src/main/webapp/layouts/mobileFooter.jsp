<%@ page import="com.efeiyi.ec.website.organization.util.AuthorizationUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (AuthorizationUtil.getMyUser().getId() != null) {
%>

<%
    }
%>

<%
    if (AuthorizationUtil.getMyUser().getId() == null) {
%>
<c:if test="${request!='/purchaseOrder/receiveGift'&&request!='/purchaseOrder/giftView'}">
<div class="login-reg">
    <a href="<c:url value="/sso.do"/>" class="btn-login" title="登录">登&nbsp;&nbsp;&nbsp;&nbsp;录</a>
    <a id="signin"
       href="http://passport.efeiyi.com/register?service=http://www.efeiyi.com/sso.do?registeSuccess=/registerSuccess.do"
       class="btn-reg"
       onclick="register()">注&nbsp;&nbsp;&nbsp;&nbsp;册</a>
</div>
    </c:if>
<%
    }
%>
<c:if test="${request!='/purchaseOrder/receiveGift'&&request!='/purchaseOrder/giftView'}">
<footer class="footer-new">
    <div class="bd authentication">
        <h3>战略合作伙伴</h3>

        <div class="bd">
            <a class="icon1" href="http://en.unesco.org/" title="联合国教科文组织"></a>
            <em class="line"></em>
            <a class="icon2" href="http://www.efeiyi.com" title="e飞蚁"></a>
            <em class="line"></em>
            <a class="icon3" title="中国非物质文化遗产保护协会"></a>
        </div>
    </div>
    <div class="bd info">
        <a class="icon" href="http://www.efeiyi.com"></a>

        <div class="txt">中&nbsp;&nbsp;国&nbsp;&nbsp;非&nbsp;&nbsp;遗&nbsp;&nbsp;电&nbsp;&nbsp;商&nbsp;&nbsp;平&nbsp;&nbsp;台
        </div>
        <div class="wechat"><img src="/scripts/images/icon-wechat.png"></div>
        <div class="txt">关注微信公众号</div>
        <div class="txt">领取超值代金券</div>
    </div>
    <%--<div class="bd info">--%>
    <%--<a class="icon"></a>--%>

    <%--<div class="txt">中&nbsp;&nbsp;国&nbsp;&nbsp;非&nbsp;&nbsp;遗&nbsp;&nbsp;电&nbsp;&nbsp;商&nbsp;&nbsp;平&nbsp;&nbsp;台--%>
    <%--</div>--%>
    <%--<div class="wechat"  id="wechat"><img src="/scripts/images/icon-wechat.png"></div>--%>
    <%--<div class="txt" id="wechatStr1">关注微信公众号</div>--%>
    <%--<div class="txt"id="wechatStr2">领取好礼</div>--%>
    <%--</div>--%>
    <div class="bd copyright">京ICP备15032511号-1</div>
</footer>
</c:if>
<!--[if (gte IE 9)|!(IE)]><!-->
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value="/scripts/js/amazeui.ie8polyfill.min.js"/>"></script>
<![endif]-->
<script src="<c:url value="/resources/assets/js/amazeui.min.js"/>"></script>
<!--自定义js--Start-->
<script src="<c:url value="/scripts/wap/js/system.js?"/>"></script>
<!--自定义js--End-->

<div style="display: none">

    <script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");
    document.write(unescape("%3Cspan id='cnzz_stat_icon_1256452193'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s4.cnzz.com/z_stat.php%3Fid%3D1256452193' type='text/javascript'%3E%3C/script%3E"));</script>
</div>
<div class="scroll-bar">
    <div class="scroll-bar-top" style="display: block;">
        <span class="btn"><i class="icon1"></i></span>
    </div>
    <!-- //End--返回顶部-->
</div>

<style type="text/css">
    #MEIQIA-BTN-HOLDER {
        right: 0;
        bottom: 145px;
    }

    #MEIQIA-BTN {
        background: #000;
        width: 33px;
        height: 53px;
        -webkit-border-radius: 5px;
        -moz-border-radius: 5px;
        border-radius: 5px;
    }

    #MEIQIA-BTN-LINE {
        display: none;
    }

    #MEIQIA-BTN-TEXT {
        width: 48px;
        font-size: 12px;
        position: absolute;
        left: -28px;
        top: 20px;,
    display : none;
    }

    .MEIQIA-ICON {
        background: url("http://www.efeiyi.com/scripts/wap/images/qq.png") -176px -143px;
        background-size: auto auto;
    }

    #MEIQIA-BTN-ICON {
        width: 23px;
        height: 28px;
        margin: 0;
        float: left;
        margin-left: 5px;
        margin-top: 6px;
    }
</style>

<script>
    function isWeiXin() {
        var ua = window.navigator.userAgent.toLowerCase();
        if (ua.match(/MicroMessenger/i) == 'micromessenger') {
            return true;
        } else {
            return false;
        }
    }
    (function (m, ei, q, i, a, j, s) {
        m[a] = m[a] || function () {
                    (m[a].a = m[a].a || []).push(arguments)
                };
        j = ei.createElement(q),
                s = ei.getElementsByTagName(q)[0];
        j.async = true;
        j.src = i;
        s.parentNode.insertBefore(j, s)
    })(window, document, 'script', '//eco-api.meiqia.com/dist/meiqia.js', '_MEIQIA');
    _MEIQIA('entId', 486);

    var registerWx = "<c:url value="/wx/userInfo"/>";

    var register = "http://passport.efeiyi.com/register?service=http://www.efeiyi.com/sso.do?registeSuccess=/registerSuccess.do";

    if (isWeiXin()) {
//        alert("not weixin");
        $("#signin").attr("href", registerWx);

    } else {
        $("#wechat").hide();
        $("#wechatStr1").hide();
        $("#wechatStr2").hide();
    }
</script>

<script>
    (function (i, s, o, g, r, a, m) {
        i['GoogleAnalyticsObject'] = r;
        i[r] = i[r] || function () {
                    (i[r].q = i[r].q || []).push(arguments)
                }, i[r].l = 1 * new Date();
        a = s.createElement(o), m = s.getElementsByTagName(o)[0];
        a.async = 1;
        a.src = g;
        m.parentNode.insertBefore(a, m)
    })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');
    ga('create', 'UA-69796169-1', 'auto');
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
<script>

    var _hmt = _hmt || [];

    (function () {

        var hm = document.createElement("script");

        hm.src = "//hm.baidu.com/hm.js?15b49366788c12ff091a0f6b23c8835f";

        var s = document.getElementsByTagName("script")[0];

        s.parentNode.insertBefore(hm, s);

    })();

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