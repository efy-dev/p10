<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>

<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/17
  Time: 15:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>资讯</title>
</head>
<body>
<div id="page-nav">
    <p><a href="#">首页</a><span>资讯</span></p>
</div>
<div class="border-nav"></div>
<!--资讯内容-->
<div id="center--1">
    <div class="center-buttom">
        <h1>当前标签</h1>
        <div class="buttom-zx">
            <div class="buttom-zx-tr">
                <ul class="buttom-zx-td-1">
                    <li class="buttom-zx-td-left"></li>
                    <li class="buttom-zx-td-center">
                        <div class="buttom-zx-td-border-1"></div>
                        <div class="buttom-zx-td-center-1"><a href="#">全部</a></div>
                        <div class="buttom-zx-td-border-2"></div>
                    </li>
                    <li class="buttom-zx-td-right"></li>
                </ul>
                <ul class="buttom-zx-td-2">
                    <li class="buttom-zx-td-left"></li>
                    <li class="buttom-zx-td-center">
                        <div class="buttom-zx-td-border-1"></div>
                        <div class="buttom-zx-td-center-1"><a href="#">视频</a></div>
                        <div class="buttom-zx-td-border-2"></div>
                    </li>
                    <li class="buttom-zx-td-right"></li>
                </ul>
            </div>
            <div class="buttom-zx-tr-2">
                <ul class="buttom-zx-td-3">
                    <li class="buttom-zx-td-left"></li>
                    <li class="buttom-zx-td-center">
                        <div class="buttom-zx-td-border-1"></div>
                        <div class="buttom-zx-td-center-1"><a href="#">动态更新</a></div>
                        <div class="buttom-zx-td-border-2"></div>
                    </li>
                    <li class="buttom-zx-td-right"></li>
                </ul>
                <ul class="buttom-zx-td-2">
                    <li class="buttom-zx-td-left"></li>
                    <li class="buttom-zx-td-center">
                        <div class="buttom-zx-td-border-1"></div>
                        <div class="buttom-zx-td-center-1"><a href="#">流行观点</a></div>
                        <div class="buttom-zx-td-border-2"></div>
                    </li>
                    <li class="buttom-zx-td-right"></li>
                </ul>
            </div>
            <div class="buttom-zx-tr-2">
                <ul class="buttom-zx-td-4">
                    <li class="buttom-zx-td-left"></li>
                    <li class="buttom-zx-td-center">
                        <div class="buttom-zx-td-border-1"></div>
                        <div class="buttom-zx-td-center-1"><a href="#">动态更新</a></div>
                        <div class="buttom-zx-td-border-2"></div>
                    </li>
                    <li class="buttom-zx-td-right"></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="center-right">
        <C:forEach items="${tenantInfoList}" var="tenantInfo" varStatus="vs">
            <div class="alllist">
                <div class="alllist-content">
                    <div class="alllist-time">
                        <h1><fmt:formatDate value="${tenantInfo.createDateTime}" pattern="dd/MM" />
                        </h1>
                        <p><fmt:formatDate value="${tenantInfo.createDateTime}" pattern="yyyy" /></p>
                    </div>
                    <div class="alllist-xq">
                        <h1><a href="#">${tenantInfo.title}</a></h1>
                        <p>
                            <c:choose>
                                <c:when test="${fn:length(tenantInfo.content)  > 60}">
                                    ${fn:substring(tenantInfo.content,0 ,60 ) }......
                                </c:when>
                                <c:otherwise>
                                    ${tenantinfo.content}
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <span><a href="#">详情</a></span>
                    </div>
                </div>
                <div class="alllist-border"></div>
            </div>
        </C:forEach>
        <div class="page-number">
            <a href="#">1</a><span>/</span><a href="#">2</a><span>/</span><a href="#">3</a><span>/</span><a href="#">4</a>
        </div>
    </div>
</div>
<!--其他内容-->
<div id="footer">
    <ul class="guild">
        <li><a href="#"><img src="/scripts/assets/images/i/fybk.jpg"></a></li>
        <li><a href="#"><img src="/scripts/assets/images/i/efeiyi.jpg"></a></li>
        <li><a href="#"><img src="/scripts/assets/images/i/cpb.jpg"></a></li>
        <li><a href="#"><img src="/scripts/assets/images/i/gl.jpg"></a></li>
    </ul>
    <div class="efeiyi-url">Copyright © <a href="#">www.efeiyi.com</a>2015</div>
</div>
<!--分析-->
<div class="floating_ck">
    <dl>
        <dt></dt>
        <dd class="return">
            <span onClick="gotoTop();return false;"></span>
        </dd>
        <dd class="qrcord">
            <span></span>
            <div class="floating_left floating_ewm">
                <i><img src="images/images/img6_03.jpg"></i>
            </div>
        </dd>
        <dd class="quote">
            <span>分享</span>
            <div class="floating_left"><a href="#">分享</a></div>
        </dd>


    </dl>
</div>
<ming800:pcPageList bean="${pageEntity}" url="/tenant/tenantInfoList.do">
    <%--<ming800:page-param2 name="qm" value="${requestScope.qm}"/>--%>
    <ming800:pcPageParam name="conditions"
                         value='<%=request.getParameter("conditions")!=null ? request.getParameter("conditions") : ""%>'/>
    <ming800:pcPageParam name="sort"
                         value='<%=request.getParameter("sort")!=null ? request.getParameter("sort") : ""%>'/>
</ming800:pcPageList>
</body>
</html>