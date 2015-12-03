<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/11/30 0030
  Time: 11:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<div class="seckill-share">
    <div class="bd icon-s"></div>
    <div class="bd info">
        <p>恭喜您秒杀成功</p>

        <p>快呼唤小伙伴们一起来抢购吧！</p>

        <p id="btn" class="btn-share">分 享</p>

        <div id="cover"><em class="bg"></em><img src="<c:url value="/scripts/wap/upload/guide-share.png"/>" alt="">
        </div>
    </div>
    <div class="bd fotchat">
        <p>关注微信公众号掌握实时秒杀动态</p>

        <p>更多优惠活动等着您</p>

        <p><img src="<c:url value="/scripts/wap/images/icon-wechat.png"/>" alt=""></p>
    </div>
    <div class="bd btns">
        <a href="http://www.efeiyi.com">返回商城首页</a>
        <a href="http://a.efeiyi.com/miao">查看更多秒杀商品</a>
    </div>
</div>
</body>
</html>
