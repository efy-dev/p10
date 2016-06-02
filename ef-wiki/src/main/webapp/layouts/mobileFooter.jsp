<%@ page import="com.efeiyi.ec.wiki.organization.util.AuthorizationUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (AuthorizationUtil.getMyUser().getId() == null) {
%>
    <div class="login-reg">
        <a href="<c:url value="/sso.do"/>" class="btn-login" title="登录">登&nbsp;&nbsp;&nbsp;&nbsp;录</a>
        <a id="signin"
           href="http://passport.efeiyi.com/register?service=http://minglu.efeiyi.com/sso.do?registeSuccess=/pc/saveEnrollUser.do"
           class="btn-reg"
           >注&nbsp;&nbsp;&nbsp;&nbsp;册</a>
    </div>
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
            <div class="wechat"><img src="<c:url value="/scripts/assets/wap/images/icon-wechat.png"/>"></div>
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
<script src="<c:url value="/resources/jquery/jquery.min.js"/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<!--自定义js--Start-->
<script src="<c:url value='/resources/assets/js/jquery.min.js'/>"></script>
<script src="<c:url value='/scripts/assets/wap/js/system.js'/>"></script>
<script src="<c:url value='/resources/assets/js/amazeui.min.js'/>"></script>
<!--自定义js--End-->
<script src="<c:url value='/resources/js/alert.js'/>"></script>
<!--自定义js--End-->



