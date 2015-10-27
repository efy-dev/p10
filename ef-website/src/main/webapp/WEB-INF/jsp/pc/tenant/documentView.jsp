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
                    <dt ><a href="#">帮助中心<i class="add-icon"></i></a></dt>
                    <dd style="display: none">
                        <a href="<c:url value="/document/richTextView?group=ec.gwlc"/>">购物流程<i class="sj"></i></a>
                        <a href="<c:url value="/document/richTextView?group=ec.zffs"/>">支付方式<i class="sj"></i></a>
                        <a href="<c:url value="/document/richTextView?group=ec.psfs"/>">配送方式<i class="sj"></i></a>
                    </dd>
                </dl>
                <dl class="ae">
                    <dt><a href="#">服务保障<i class="add-icon"></i></a></dt>
                    <dd style="display: none">
                        <a href="<c:url value="/document/richTextView?group=ec.zpbz"/>">正品保障<i class="sj"></i></a>
                        <a href="<c:url value="/document/richTextView?group=ec.shzc"/>">售后正常<i class="sj"></i></a>
                        <a href="<c:url value="/document/richTextView?group=ec.thhlc"/>">退换货流程<i class="sj"></i></a>
                    </dd>
                </dl>
                <dl class="ae">
                    <dt><a href="<c:url value="/document/richTextView?group=ec.gywm"/>">关于我们</a></dt>
                </dl>
                <dl class="ae">
                    <dt><a href="<c:url value="/document/richTextView?group=ec.ptys"/>">平台优势</a></dt>
                </dl>
                <dl class="ae">
                    <dt><a href="<c:url value="/document/richTextView?group=ec.lxwm"/>">联系我们</a></dt>
                </dl>
                <dl class="ae">
                    <dt><a href="<c:url value="/document/richTextView?group=ec.cpyc"/>">诚聘英才</a></dt>
                </dl>
                <dl class="ae">
                    <dt><a href="<c:url value="/document/richTextView?group=ec.yjfk"/>">意见反馈</a></dt>
                </dl>
                <dl class="ae">
                    <dt><a href="#">法律声明<i class="add-icon"></i></a></dt>
                    <dd style="display: none">
                        <a href="<c:url value="/document/richTextView?group=ec.flsm"/>">法律声明<i class="sj"></i></a>
                        <a href="<c:url value="/document/richTextView?group=ec.aqjyssm"/>">安全及隐私声明</a>
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
