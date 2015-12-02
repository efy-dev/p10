<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/11/20 0020
  Time: 17:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/wap/css/amazeui.min.css?v=20150831"/>">
    <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/wap/css/app.css?v=20150831"/>">
    <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/wap/css/myorder.css?v=20150831"/>">
    <script src="<c:url value="/scripts/wap/js/jquery-1.11.1.min.js"/>"></script>
</head>
<body>
<div class="packet ae">
    <div class="efeiyi-lod ae">
        <a class="efiyi-logo"></a>
        <a class="eifyi-ld"><div class="ld-img"><img src="<c:url value="/scripts/wap/images/jazq2.gif"/>"></div></a>
        <p>正在获取支付结果，请勿关闭当前页面。</p>
    </div>
</div>

<!--[if (gte IE 9)|!(IE)]><!-->
<script src="<c:url value="/scripts/wap/js/jquery.min.js"/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script src="<c:url value="/scripts/wap/js/amazeui.min.js"/>"></script>
<!--自定义js--Start-->
<script src="<c:url value="/scripts/wap/js/system.js"/>"></script>
<script src="<c:url value="/scripts/wap/js/myorder.js?v=20150831"/>"></script>
<!--自定义js--End-->
<script>


    function check() {
        $.ajax({
            type: "get",//设置get请求方式
            url: "<c:url value="/group/checkOrder.do"/>",//设置请求的脚本地址
            data: {"purchaseOrderId":"${purchaseOrderId}"},//设置请求的数据
            async: true,
            dataType: "json",//设置请求返回的数据格式
            success: function (data) {
                if(data){
                    window.location.href="<c:url value="/group/createGroup?purchaseOrderId=${purchaseOrderId}&groupProductId=${groupProductId}&groupId=${groupId}&memberId=${memberId}"/>";
                }else{
                    setTimeout("check()",2000);
                }
            }
        })
    }

    check();
</script>
</body>
</html>
