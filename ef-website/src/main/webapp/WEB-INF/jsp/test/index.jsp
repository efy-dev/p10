<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="/scripts/test/css/ScrollPic.css">
</head>
<body>

<c:if test="${!empty banners}">

<div class="yiz-slider-1">

    <ul><c:forEach items="${banners}" var="contact" >
        <li><img src="${contact.imageUrl}" /></li>
        </c:forEach>

    </ul>
    </div>
    
</c:if>

<c:if test="${!empty banners}">

    <div class="yiz-slider-2">

        <ul><c:forEach items="${banners}" var="contact" >
            <li><img src="${contact.imageUrl}" /></li>
        </c:forEach>

        </ul>
    </div>

</c:if>
<c:if test="${!empty banners}">

    <div class="yiz-slider-3">

        <ul><c:forEach items="${banners}" var="contact" >
            <li><img src="${contact.imageUrl}" /></li>
        </c:forEach>

        </ul>
    </div>

</c:if>
<div style="clear:left;margin-top:50px;"></div>
<br>


<div style="clear:left;margin-top:50px;"></div>
<br>

<div style="clear:both; height:100px;"></div>

<script src="/scripts/test/js/jquery-1.7.1.min.js" type="text/javascript"></script>
<script src="/scripts/test/js/jquery.ScrollPic.js" type="text/javascript"></script>
<script type="text/javascript">
    
$(function(){
    $('.yiz-slider-1').ScrollPic({
        Time: 1000,
        speed: 1000,
        autoscrooll: true,
        arrowcontrol: true,
        numbercontrol: true

    });
    $('.yiz-slider-2').ScrollPic({
        autoscrooll: true,
        arrowcontrol: true,
        numbercontrol: false

    });
    $('.yiz-slider-3').ScrollPic({
        Time: '3000',
        speed: '800',
        autoscrooll: false,
        arrowcontrol: false,
        numbercontrol: true
    });
})


</script>
</body>
</html>
