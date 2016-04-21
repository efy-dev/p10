<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head></head>
<body>
<div class="wh">
    <div class="help-order">
        <div class="title ae"><p>
            <c:forEach items="${document}" var="document">
                ${document.title}
            </c:forEach>
        </p></div>
        <div class="page ae">
            <div class="left bk">
                <dl class="ae">
                    <dt class="active"> <a href="#">帮助中心<i class="add-icon"></i></a></dt>
                    <dd style="display: block">
                        <a href="<c:url value="/document/helpCenter?group=ec.gwlc"/>">购物流程<i class="sj"></i></a>
                        <a href="<c:url value="/document/helpCenter?group=ec.zffs"/>">支付方式<i class="sj"></i></a>
                        <a href="<c:url value="/document/helpCenter?group=ec.psfs"/>">配送方式<i class="sj"></i></a>
                    </dd>
                </dl>
                <dl class="ae">
                    <dt class="active"> <a href="#">商家服务<i class="add-icon"></i></a></dt>
                    <dd style="display: block">
                        <a href="<c:url value="/document/helpCenter?group=ec.rzxz"/>">入驻须知<i class="sj"></i></a>
                        <a href="<c:url value="/document/helpCenter?group=ec.rzlc"/>">入驻流程<i class="sj"></i></a>
                        <a href="<c:url value="/document/helpCenter?group=ec.rzzx"/>">入驻资询<i class="sj"></i></a>
                    </dd>
                </dl>

                <dt class="active" ><a href="#">售后流程<i class="add-icon"></i></a></dt>
                <dd style="display: block">
                    <a href="<c:url value="/document/helpCenter?group=ec.thlc"/>">退货流程<i class="sj"></i></a>
                    <a href="<c:url value="/document/helpCenter?group=ec.hhlc"/>">换货流程<i class="sj"></i></a>
                </dd>

                <dl class="ae">
                    <dt class="active" ><a href="#">服务保障<i class="add-icon"></i></a></dt>
                    <dd style="display: block">
                        <a href="<c:url value="/document/helpCenter?group=ec.zpbz"/>">正品保障<i class="sj"></i></a>
                        <a href="<c:url value="/document/helpCenter?group=ec.shzc"/>">售后政策<i class="sj"></i></a>
                    </dd>
                </dl>
                <dl class="ae">
                    <dt class="active"><a href="#">法律声明<i class="add-icon"></i></a></dt>
                    <dd style="display: block">
                        <a href="<c:url value="/document/helpCenter?group=ec.flsm"/>">法律声明<i class="sj"></i></a>
                        <a href="<c:url value="/document/helpCenter?group=ec.aqjyssm"/>">安全及隐私声明</a>
                    </dd>
                </dl>
            </div>
            <div class="right bk">
                <c:forEach items="${document}" var="document">
                    ${document.documentContent.content}
                </c:forEach>
            </div>
        </div>
    </div>
</div>
</body>
</html>
