<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/11/18 0018
  Time: 10:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
    <title>秒杀-详情页-已开始</title>
</head>
<body>
<header class="am-header custom-header">
    <div class="am-header-left am-header-nav">
        <a href="<c:url value="/miao/list"/>" class="chevron-left"></a>
    </div>
    <!-- //End--chevron-left-->
    <h1 class="am-header-title">${seckillProduct.productModel.name}</h1>
    <!-- //End--title-->
    <div class="am-header-right am-header-nav">
        <a href="#chevron-right" class="chevron-right" id="menu">
            <i class="line"></i>
        </a>
    </div>
    <!-- //End--chevron-left-->
    <div class="menu-list">
        <ul class="bd">
            <li><a href="<c:url value="/miao/list"/>" title="首页">首页</a></li>
            <li><a href="http://i.efeiyi.com" title="个人中心">个&nbsp;人&nbsp;中&nbsp;心</a></li>
        </ul>
    </div>
</header>
<!--//End--header-->
<article class="custom">
    <div data-am-widget="slider" class="bd am-slider am-slider-a1" data-am-slider='{&quot;directionNav&quot;:false}'>
        <ul class="am-slides">
            <c:forEach items="${seckillProduct.productModel.product.productPictureList}" var="pic">
                <c:if test="${pic.status=='1'}">
                    <li><img src="http://pro.efeiyi.com/${pic.pictureUrl}@!miao-product-view"></li>
                </c:if>
            </c:forEach>
            <%--<li><img src="../shop2015/upload/seckill1.jpg"></li>--%>
            <%--<li><img src="../shop2015/upload/seckill1.jpg"></li>--%>
        </ul>
    </div>
    <!--//End--am-slider-->
    <div class="bd details">
        <div class="bd des-title">
            <strong class="bd txt">${seckillProduct.productModel.name}</strong>
            <a href="#分享" class="share">
                <i class="icon icon-share"></i>

                <p>分享</p>
            </a>

            <div id="cover"><em class="bg"></em><img src="<c:url value="/scripts/wap/upload/guide-share.png"/>" alt="">
            </div>
            <%--<a href="#收藏" class="addfav">--%>
            <%--<i class="icon icon-addfav"></i>--%>

            <%--<p>收藏</p>--%>
            <%--</a>--%>
        </div>
        <!-- //End--des-title-->
        <div class="bd des-price des-price-seckill">
            <p class="bd t0"><span>秒杀价：</span><em>￥</em><strong>${seckillProduct.price}</strong></p>

            <p class="bd t1"><span>飞蚁价：</span>
                <del>￥${seckillProduct.productModel.price}</del>
            </p>
            <c:if test="${!empty seckillProduct.productModel.product.tenant}">
                <p class="bd t2">
                    <span>服&nbsp;&nbsp;&nbsp;务：</span>由${seckillProduct.productModel.product.tenant.name}（${seckillProduct.productModel.product.tenant.address}）发货并提供服务
                </p>
            </c:if>

            <%--<p class="bd tnum">--%>
            <%--<strong>购买数量</strong>--%>
            <%--<em class="sub"></em>--%>
            <%--<input class="txt" type="text" value="1">--%>
            <%--<em class="add"></em>--%>
            <%--</p>--%>

            <p class="bd t3">每件商品限抢购一件</p>

            <p class="bd t3">秒杀倒计时： <strong><font id="time-h">00</font>:<font id="time-m">00</font>:<font
                    id="time-s">00</font></strong></p>

            <p class="bd t3">秒杀规则：下单成功后请在15分钟内完成支付</p>
            <c:if test="${miaoStatus=='2'}">
                <div class="bd btn-bg" id="miaoBuy"><a href="<c:url value="/miao/buy/${seckillProduct.id}/1"/>"
                                                       title="立即抢购">立即抢购</a>
                </div>
            </c:if>
            <c:if test="${miaoStatus=='1'}">
                <div class="bd btn-bg" id="miaoBuy" style="display: none"><a href="<c:url value="/miao/buy/${seckillProduct.id}/1"/>"
                                                       title="立即抢购">立即抢购</a>
                </div>
            </c:if>
            <c:if test="${miaoStatus=='3'}">
                <div class="bd btn-bg-no">秒杀结束</div>
            </c:if>

        </div>
        <!-- //End--des-price-seckill-->
    </div>
    <!-- //End---->
</article>

<script>
    $().ready(function () {
        show_time();
    })

    function timeEnd() {
//        $("#miaoStatus").html("本场秒杀正火热进行中...");
        $("#miaoBuy").show();
    }

    function show_time() {
        var time_start = new Date().getTime(); //设定当前时间
        var time_end = new Date("<fmt:formatDate value="${seckillProduct.startDatetime}" pattern="20YY/MM/dd HH:mm:ss"/>").getTime(); //设定目标时间
        // 计算时间差
        var time_distance = time_end - time_start;

        if (time_distance < 0) {
            timeEnd();
        } else {


            // 时
            var int_hour = Math.floor(time_distance / 3600000)
            time_distance -= int_hour * 3600000;
            // 分
            var int_minute = Math.floor(time_distance / 60000)
            time_distance -= int_minute * 60000;
            // 秒
            var int_second = Math.floor(time_distance / 1000)
            // 时分秒为单数时、前面加零
            if (int_hour < 10) {
                int_hour = "0" + int_hour;
            }
            if (int_minute < 10) {
                int_minute = "0" + int_minute;
            }
            if (int_second < 10) {
                int_second = "0" + int_second;
            }
            // 显示时间
            $("#time-h").html(int_hour);
            $("#time-m").html(int_minute);
            $("#time-s").html(int_second);
            // 设置定时器
            setTimeout("show_time()", 1000);
        }
    }
</script>

</body>
</html>
