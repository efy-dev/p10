<!doctype html>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="no-js">
<head></head>
<!--输入内容-->
<div class="am-g am-color-000">
    <c:if test="${tenantProjectList.size() > 1}">

    <c:forEach items="${tenantProjectList}" var="tenantProject">
    <div class="am-u-sm-4 an-mg-top am-u-end"><button type="button" class="am-btn am-btn-default"> ${tenantProject.project.name} </button></div>
    </c:forEach>
    </c:if>
    <c:if test="${tenantProjectList.size() == 1}">
    <c:forEach items="${tenantProjectList}" var="tenantProject">
        <c:forEach items="${tenantProject.project.projectTagList}" var="projectTag">
        <div class="am-u-sm-4 an-mg-top am-u-end"><button type="button" class="am-btn am-btn-default"> ${projectTag.value} </button></div>
       </c:forEach>
        </c:forEach>
    </c:if>

</div>
<!--1-->
<c:forEach items="${tenantWorkList}" var="tenantWork">
<section class="vessel">

    <figure data-am-widget="figure" class="am am-figure am-figure-default  am-color-000">
        <img src="http://s.amazeui.org/media/i/demos/pure-1.jpg?imageView2/0/w/640"
             data-rel="http://s.amazeui.org/media/i/demos/pure-1.jpg"
                />
        <figcaption class="am-figure-capition-btm intro-text-2">${tenantWork.productDescription.content} </figcaption>
    </figure>
</section>
</c:forEach>

</body>
</html>