<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/11/18 0018
  Time: 9:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
    <title>秒杀—即将开始</title>
</head>
<body>
<header class="am-header custom-header">
    <h1 class="am-header-title">抢购最便宜</h1>

    <div class="am-header-right am-header-nav">
        <a href="#chevron-right" class="chevron-right" id="menu">
            <i class="line"></i>
        </a>
    </div>
    <!-- //End--chevron-left-->
    <div class="menu-list">
        <ul class="bd">
            <li><a href="http://www.efeiyi.com" title="首页">首页</a></li>
            <li><a href="<c:url value="/miao/list"/>" title="秒杀首页">秒杀首页</a></li>
            <li><a href="http://i.efeiyi.com" title="个人中心">个&nbsp;人&nbsp;中&nbsp;心</a></li>
        </ul>
    </div>

</header>
<!--//End--header-->

<c:if test="${!empty productList}">

    <article class="seckill">
        <div class="bd seckill-pro">
            <c:if test="${miaoStatus=='2'}">
                <div class="bd start">
                    <h1 class="bd">本场秒杀正火热进行中...</h1>
                </div>
            </c:if>
            <c:if test="${miaoStatus=='1'&& !isShowTime}">
                <div class="bd start">
                    <h1 class="bd"><fmt:formatDate value="${productList.get(0).startDatetime}"
                                                   pattern="MM月dd日 HH:mm:ss"/>
                        开始秒杀</h1>
                </div>
            </c:if>
            <c:if test="${miaoStatus=='1'&& isShowTime}">
                <div class="bd start">
                    <h1 class="bd">距秒杀开始还有</h1>

                    <div class="bd s-time">
                        <ul>
                            <li id="time_h">00</li>
                            <li id="time_m">00</li>
                            <li id="time_s">00</li>
                        </ul>
                    </div>
                </div>
            </c:if>
            <!-- //End--time-->
            <div class="bd bigimg">
                <img src="http://pro.efeiyi.com/${productList.get(0).productModel.productModel_url}@!miao-product-view">

                <p class="mask">关注度：${productList.get(0).attentionAmount}</p>
            </div>
            <!--//End--bigimg-->
            <div class="bd bigbuy">
                <div class="title">${productList.get(0).productModel.product.name}</div>
                <div class="price">
                    <p class="p1"><span>原&nbsp;&nbsp;&nbsp;价：</span>
                        <del>￥${productList.get(0).productModel.price}</del>
                    </p>
                    <p class="p2"><span>秒杀价：</span><em>￥</em><strong>${productList.get(0).price}</strong></p>
                    <c:if test="${miaoStatus=='2'}">
                        <a class="btn-buy" href="<c:url value="/miao/${productList.get(0).id}"/>" title="立即抢购"
                           id="miaoBuy">立即抢购</a>
                    </c:if>
                    <c:if test="${miaoStatus=='1'}">
                        <a class="btn-buy" href="<c:url value="/miao/${productList.get(0).id}"/>" title="立即抢购"
                           id="miaoBuy">查看商品</a>
                    </c:if>
                </div>
            </div>
            <!--//End--price-buy-->
        </div>
        <!-- //End--seckill-pro-->
        <c:forEach items="${productList}" begin="1" var="product">
            <div class="bd seckill-pro">
                <div class="bd start">
                    <h1 class="bd"><fmt:formatDate value="${product.startDatetime}" pattern="MM月dd日 HH:mm:ss"/>
                        开始秒杀</h1>
                </div>
                <!-- //End--time-->
                <div class="bd bigimg">
                    <img src="http://pro.efeiyi.com/${product.productModel.productModel_url}@!miao-product-view">

                    <p class="mask">关注度：${product.attentionAmount}</p>
                </div>
                <!--//End--bigimg-->
                <div class="bd bigbuy">
                    <div class="title">${productList.get(0).productModel.product.name}</div>
                    <div class="price">
                        <p class="p1"><span>原&nbsp;&nbsp;&nbsp;价：</span>
                            <del>￥${productList.get(0).productModel.price}</del>
                        </p>
                        <p class="p2"><span>秒杀价：</span><em>￥</em><strong>${productList.get(0).price}</strong></p>
                        <a class="btn-buy" title="敬请期待">敬请期待</a>
                    </div>
                </div>
                <!--//End--price-buy-->
            </div>
        </c:forEach>
    </article>


    <script>
        $().ready(function () {
            show_time();
        })

        function timeEnd() {
            $("#miaoStatus").html("本场秒杀正火热进行中...");
            $("#miaoBuy").html("立即抢购");
        }

        function show_time() {
            var time_start = new Date().getTime(); //设定当前时间
            var time_end = new Date("<fmt:formatDate value="${productList.get(0).startDatetime}" pattern="20YY/MM/dd HH:mm:ss"/>").getTime(); //设定目标时间
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
                $("#time_h").html(int_hour);
                $("#time_m").html(int_minute);
                $("#time_s").html(int_second);
                // 设置定时器
                setTimeout("show_time()", 1000);
            }
        }
    </script>

</c:if>
</body>
</html>
