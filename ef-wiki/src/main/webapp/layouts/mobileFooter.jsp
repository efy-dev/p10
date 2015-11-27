<%@ page import="com.efeiyi.ec.wiki.organization.util.AuthorizationUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="login-reg">
 <%--   <%
        if (AuthorizationUtil.getMyUser().getId() != null) {
    %>

    <%
        }
    %>

    <%
        if (AuthorizationUtil.getMyUser().getId() == null) {
    %>
    <a href="<c:url value="/home.do"/>" class="btn-login" title="登录">登&nbsp;&nbsp;&nbsp;&nbsp;录</a>
    <a id="signin" href="<c:url value="/register"/>" class="btn-reg">注&nbsp;&nbsp;&nbsp;&nbsp;册</a>
    <%
        }
    %>--%>
     <div class="login-reg">
         <%if(AuthorizationUtil.getMyUser()!=null && AuthorizationUtil.getMyUser().getId() != null){ %>
         <div class="bd logined"><%=AuthorizationUtil.getMyUser().getUsername()%><a class="btn-exit" href="<c:url value='/j_spring_cas_security_logout'/>">退出</a></div>
         <% } %>
         <%if(AuthorizationUtil.getMyUser()==null || AuthorizationUtil.getMyUser().getId() == null){ %>
         <a href="<c:url value='/sso.do'/>" class="btn-login" title="登录">登&nbsp;&nbsp;&nbsp;&nbsp;录</a>
         <a href="http://passport.efeiyi.com/register?service=http://http://master.efeiyi.com/ef-wiki/sso.do" class="btn-reg">注&nbsp;&nbsp;&nbsp;&nbsp;册</a>
         <% } %>

     </div>
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
<%--<!--[if (gte IE 9)|!(IE)]><!-->

<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value='/resources/assets/js/amazeui.ie8polyfill.min.js?v=20150831'/>"></script>
<![endif]-->
<!--自定义js--Start-->

<script src="<c:url value='/scripts/assets/wap/js/system.js?v=20150831'/>"></script>
<script src="<c:url value='/scripts/assets/wap/js/cyclopedia.js?v=20150831'/>"></script>--%>


