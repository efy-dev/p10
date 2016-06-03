<!DocType html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer data-am-widget="footer" class="am-footer am-footer-default" data-am-footer="{  }">
    <div class="am-footer-switch">
        <span class="am-footer-ysp" data-rel="mobile" data-am-modal="{target: '#am-switch-mode'}"><a href="http://www.efeiyi.com" target="_blank"><img src="<c:url value='/scripts/images/ef-logo-gf.png'/>" style="width: 35%;"></a></span>
    </div>
    <%--<div class="am-footer-miscs ">--%>
        <%--<p><a href="<c:url value='/index'/>">中国非遗电商平台·传承人官网</a></p>--%>
    <%--</div>--%>
</footer>
<div id="am-footer-modal" class="am-modal am-modal-no-btn am-switch-mode-m am-switch-mode-m-default">
    <div class="am-modal-dialog">
        <div class="am-modal-hd am-modal-footer-hd">
            <a href="javascript:void(0)" data-dismiss="modal" class="am-close am-close-spin "
               data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd">
            <span class="am-switch-mode-owner"></span>
            <span class="am-switch-mode-slogan">中国非遗电商平台·传承人官网</span>
        </div>
    </div>
    <%@ include file="cs.jsp" %>
    <% CS cs = new CS(1255887869);cs.setHttpServlet(request,response);
        String imgurl = cs.trackPageView();%>
    <img src="<%= imgurl %>" width="0" height="0"  />

</div>
