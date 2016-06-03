<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
    <title>${masterNews.title}</title>
    <meta name="description" content="${masterNews.title}">
    <meta name="keywords" content="${masterNews.master.fullName}">
</head>
<body style="background-color:#F1F5F8">
<header class="work-details">
    <div class="work-details-i"><a href="<c:url value="/info/list"/>"><img src="<c:url value="/scripts/assets/wap/images/logo10.gif"/>"></a></div>
</header>
<section class="work-text-h2">
    <div class="message-text2">
        <h1><c:forEach items="${masterNews.masterNewsTagList}" var="masterNewsTag">
            [${masterNewsTag.wordValue.value}]
        </c:forEach>
            ${masterNews.title} </h1>
        <p class="message-text-p2"><fmt:formatDate value="${masterNews.createDateTime}" pattern="yyyy-MM-dd" /></p>
        <hr data-am-widget="divider" style="margin-top:0;" class="am-divider am-divider-dashed" />
    </div>
    <p class="am-p-p">
      <%--  <img src="http://master.efeiyi.com/${masterNews.}" class="am-img-responsive"  style="height:201px; margin-bottom:16px;"/>--%>
    <span>
        ${masterNews.content}
    </span>
    </p>
</section>
</body>
</html>