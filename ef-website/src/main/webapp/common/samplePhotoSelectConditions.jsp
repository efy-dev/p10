<%@ page import="com.yuepaila.basic.model.CityShotType" %>
<%@ page import="com.yuepaila.basic.model.ShotType" %>
<%@ page import="java.util.List" %>
<%@ page import="com.yuepaila.basic.model.ShotStyle" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2014/11/11
  Time: 19:39
  To change this template use File | Settings | File Templates.
--%>
<%--如果当前拍摄类型不为空,那么就只列出当前拍摄类型的所有风格,如果当前拍摄类型为空,那么就不列出风格,只列出所有拍摄类型的选项--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="row" style="margin-bottom: 20px;margin-top: 20px;">
    <div class="col-md-12">
        <div class="col-md-6">
            <ul class="nav nav-pills" role="tablist">
                <%
                    CityShotType currentCity = (CityShotType) request.getSession().getAttribute("currentCity");
                    List<ShotType> shotTypeList = currentCity.getShotTypeList();
                    for (ShotType shotType : shotTypeList) {
                %>
                <%
                    if (request.getSession().getAttribute("shotType") != null && (request.getParameter("all") == null || request.getParameter("all").equals(""))) {
                        if (shotType.getName().equals(((ShotType) request.getSession().getAttribute("shotType")).getName())) {%>
                <li class="active" role="presentation"><a
                        href="/pc/${model}/list.do?shotType=<%=shotType.getType()%>"><%=shotType.getName()%>
                </a></li>
                <% } else {%>
                <li role="presentation"><a
                        href="/pc/${model}/list.do?shotType=<%=shotType.getType()%>"><%=shotType.getName()%>
                </a></li>
                <% }
                } else {%>
                <li role="presentation"><a
                        href="/pc/${model}/list.do?shotType=<%=shotType.getType()%>"><%=shotType.getName()%>
                </a></li>
                <%
                    }
                %>
                <%--<li role="presentation"><a href="#"><%=shotType.getName()%></a></li>--%>
                <%}%>
            </ul>
            <%--<c:url var="currentUrl" value="/pc/${model}/list.do?conditions=<%=request.getParameter("conditions")!=null ? request.getParameter("conditions") : ""%>"></c:url>--%>
            <ul class="nav nav-pills" role="tablist">
                <%
                    if (request.getSession().getAttribute("shotType") != null) {
                        ShotType currentShotType = (ShotType) request.getSession().getAttribute("shotType");
                        List<ShotStyle> shotStyleList = currentShotType.getShotStyleList();
                        for (ShotStyle style : shotStyleList) { %>
                <li role="presentation"><a href="/pc/${model}/list.do?conditions=style_<%=style.getId()%>"
                                           style="color: gray;"><%=style.getName()%>
                </a></li>
                <% }
                }
                %>
            </ul>


        </div>
    </div>
</div>

