<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/24
  Time: 10:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <link href="<c:url value="/scripts/css/myorder.css"/>" type="text/css " rel="stylesheet">
</head>
<body>
<p>您已成功提交付款</p>

<p>
    <a href="http://i.efeiyi.com/order/myEfeiyi/view/${order.id}">查看订单</a>
    <a href="<c:url value="/"/> ">首页</a>
</p>
<script type="text/javascript">
    <c:if test="${empty subOrderList}">
    var _gaq = _gaq || [];

    _gaq.push(['_setAccount', 'UA-70772829-1']);

    _gaq.push(['_trackPageview']);

    _gaq.push(['_addTrans',

        '${order.id}', // order ID - required-订单ID

        '${order.tenant.name}', // affiliation or store name-店名

        '${order.total}', // total - required-订单总金额

        '0', // tax-税款统一填0

        '0', // shipping-运费统一填0

//        'San Jose', // city-用户收货地址中的城市
//
//        'California', // state or province-用户收货地址中的省

        'China' // country-统一中国

    ]);

    _gaq.push(
            <c:forEach items="${order.purchaseOrderProductList}" var="product">
            ['_addItem',

                '${order.id}', // order ID - required-对应的子订单ID

                '${product.productModel.id}', // SKU/code - required-对应的商品规格ID

                '${product.productModel.name}', // product name-对应的商品名称[规格名]

                '${product.productModel.product.price}', // unit price - required-对应的商品价格

                '${product.productModel.amount}' // quantity - required-对应的商品购买数量
            ]
            </c:forEach>
    );
    </c:if>
    <c:if test="${!empty subOrderList}">

    var _gaq = _gaq || [];

    _gaq.push(['_setAccount', 'UA-69796169-1']);

    _gaq.push(['_trackPageview']);

    _gaq.push(
            <c:forEach items="${subOrderList}" var="subOrder">
            ['_addTrans',

                '${subOrder.id}', // order ID - required-订单ID

                '${subOrder.tenant.name}', // affiliation or store name-店名

                '${subOrder.total}', // total - required-订单总金额

                '0', // tax-税款统一填0

                '0', // shipping-运费统一填0

//      'San Jose', // city-用户收货地址中的城市
//
//      'California', // state or province-用户收货地址中的省

                'China' // country-统一中国
            ]
            </c:forEach>
    );

    _gaq.push(
            <c:forEach items="${subOrderList}" var="subOrder">
            <c:forEach items="${submOrder.purchaseOrderProductList}" var="product">
            ['_addItem',

                '${suborder.id}', // order ID - required-对应的子订单ID

                '${product.productModel.id}', // SKU/code - required-对应的商品规格ID

                '${product.productModel.name}', // product name-对应的商品名称[规格名]

                '${product.prodcutModel.product.price}', // unit price - required-对应的商品价格

                '${product.productModel.amount}' // quantity - required-对应的商品购买数量
            ]
            </c:forEach>
            </c:forEach>
    );

    </c:if>


    _gaq.push(['_trackTrans']); //submits transaction to the Analytics servers

    (function() {

        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;

        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';

        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);

    })();

</script>
</body>
</html>
