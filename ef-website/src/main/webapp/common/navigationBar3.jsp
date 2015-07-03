<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/1/28
  Time: 16:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header data-am-widget="header" class="am-header am-header-default ">
    <div class="am-header-left am-header-nav">
        <a href="#left-link" class="" data-am-offcanvas="{target: '#cityNav'}">
            <i class="am-icon-city">${requestScope.currentCity.getLabel()}</i>
        </a>
    </div>
    <h1 class="am-header-title"><a href="/"><img src="/scripts/yuepaila/images/mobile/icon/logo.png"></a></h1>

    <div class="am-header-right am-header-nav">
        <%if (AuthorizationUtil.getMyUser().getId() != null) {%>
        <%}%>
        <%if (AuthorizationUtil.getMyUser().getId() == null) {%>
        <a href="/pc/login" class="">
            <i class="am-icon-user am-icon-md"></i>
        </a>
        <%}%>
    </div>
</header>

<%if (AuthorizationUtil.getMyUser().getId() != null) {%>
<nav data-am-widget="menu" class="am-menu  am-menu-dropdown1" data-am-menu-collapse>
    <a href="javascript: void(0)" class="am-menu-toggle">
        <i class="am-menu-toggle-icon am-icon-user am-icon-md"></i>
    </a>
    <ul class="am-menu-nav am-avg-sm-1 am-collapse">
        <%
            if (AuthorizationUtil.getMyUser().getRole().getBasicType().equals("photographer") || AuthorizationUtil.getMyUser().getRole().getBasicType().equals("consumer")) {
        %>
        <li>
            <a href="##" class=""><%=AuthorizationUtil.getMyUser().getUsername()%>
            </a>
        </li>
        <li>
            <a href="/pc/myypl" class="">我的约拍啦</a>
        </li>
        <% if (AuthorizationUtil.getMyUser().getRole().getBasicType().equals("consumer")) {%>
        <c:if test="${!empty sessionScope.purchaseGuide}">
        <li>
            <a href="/pc/budget/view.do" class="">预算单</a>
        </li>
        </c:if>
        <%}%>
        <%}%>

        <li>
            <a href="/j_spring_security_logout" class="">退出</a>
        </li>
    </ul>
</nav>

<%}%>

<nav data-am-widget="menu" class="am-menu  am-menu-offcanvas1" data-am-menu-offcanvas>
    <div class="am-offcanvas" id="cityNav">
        <div class="am-offcanvas-bar">
            <ul class="am-menu-nav sm-block-grid-1" id="citymenu">
            </ul>
        </div>
    </div>
</nav>





<script>
    function getCityHtml(data) {
        var out = '';
        for (var i = 0; i < data.length; i++) {
            out += '<li  style="text-align: center"><a href="http://' + (data[i].name) + '.yuepaila.com:<%=request.getServerPort()%>" id="' + (data[i].id) + '" name="city">' + (data[i].label) + '</a></li>';
        }
        console.log(out);
        return out;
    }

    function getCityData() {
        jQuery.ajax({
            type: 'get',
            async: false,
            url: '<c:url value="/pc/city/list.do"/>',
            dataType: 'json',
            success: function (data) {
                if (typeof data == "string") {
                    data = JSON.parse(data);
                }
                console.log(data);
                $("#citymenu").html(getCityHtml(data));

            },
            error: function () {
            }
        });
    }

    $().ready(function () {

        getCityData();
        $("[name='city']").each(function () {
            console.log("添加事件");
            $(this).click(function () {
                // $("#choosecity").html($(this).html()+"<span class='caret'></span>");
            });
        });
    });

</script>