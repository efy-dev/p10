<%@ page import="com.efeiyi.ec.consumer.organization.util.AuthorizationUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="login-reg">
    <%
        if (AuthorizationUtil.getMyUser().getId() != null) {
    %>

    <%
        }
    %>

    <%
        if (AuthorizationUtil.getMyUser().getId() == null) {
    %>
    <a href="<c:url value="/sso.do"/>" class="btn-login" title="登录">登&nbsp;&nbsp;&nbsp;&nbsp;录</a>
    <a id="signin" href="http://passport.efeiyi.com/register?service=http://www.efeiyi.com/sso.do" class="btn-reg">注&nbsp;&nbsp;&nbsp;&nbsp;册</a>
    <%
        }
    %>
</div>
<footer class="bd footer">
    <div class="bd info">
        <a class="icon"></a>

        <div class="txt">中&nbsp;&nbsp;国&nbsp;&nbsp;非&nbsp;&nbsp;遗&nbsp;&nbsp;电&nbsp;&nbsp;商&nbsp;&nbsp;平&nbsp;&nbsp;台
        </div>
        <div class="wechat"></div>
        <div class="txt">关注微信公众号</div>
        <div class="txt">领取好礼</div>
    </div>
    <div class="bd copyright">京ICP备15032511号-1</div>
</footer>
<!--[if (gte IE 9)|!(IE)]><!-->
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value="/scripts/js/amazeui.ie8polyfill.min.js"/>"></script>
<![endif]-->
<script src="<c:url value="/resources/assets/js/amazeui.min.js"/>"></script>
<!--自定义js--Start-->
<script src="<c:url value="/scripts/wap/js/system.js?v=929"/>"></script>
<!--自定义js--End-->

<div style="display: none">

<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1256452193'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s4.cnzz.com/z_stat.php%3Fid%3D1256452193' type='text/javascript'%3E%3C/script%3E"));</script>
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
</div>
<script>

    function isWeiXin(){
        var ua = window.navigator.userAgent.toLowerCase();
        if(ua.match(/MicroMessenger/i) == 'micromessenger'){
            return true;
        }else{
            return false;
        }
    }

</script>