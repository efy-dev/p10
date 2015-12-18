<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/14
  Time: 10:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <style>
        p{
            text-indent: 2em;
        }
    </style>
</head>
<body>
<h3 style="text-align: center;">1、店铺管理</h3>
<div style="margin-left: 30%">
<h3>1.1&nbsp;查看及修改店铺信息</h3>
<p>商户后台-账号管理-基本信息，用户可查看店铺信息，点击修改后，可对店铺基本信息进行修改，详情如下：</p>
<p><img src="<c:url value="/scripts/images/help_1.png"/>"/> </p>
<p>上传店铺信息基本要求：</p>
<p style="color: red;">1、店铺Logo:支持jpg、png</p>
<p style="color: red;">2、商品首页图片：支持jpg、png</p>
<p style="color: red;">3、商家简介：商铺简介将显示在店铺列表中，限制200个字以内</p>
<p>对应的前台展示效果为：</p>
<p><img src="<c:url value="/scripts/images/help_2.png"/>"/> </p>
<p>图1：店铺Logo   &nbsp;    图2：商家名称     &nbsp;     图3：商家首页图片</p>
<h3>1.2&nbsp;修改密码</h3>
<p>商户后台-账号管理-修改密码，用户通过可设置新密码。</p>
<p><img src="<c:url value="/scripts/images/help_3.png"/>"/> </p>
<h3 style="text-align: center;">2、编辑商品信息</h3>
<h3>2.1&nbsp;添加新商品</h3>
<p>商户后台-商品管理-商品列表-新建商品，添加商品的步骤为：添加商品信息-商品规格-上传商品图片。</p>
<h3>2.1.1&nbsp;商品信息</h3>
<p>用户需要填写商品名称，并选择商品类型及所关联的大师、工艺，填写完整后，点击“下一步”即可。</p>
<p><img src="<c:url value="/scripts/images/help_4.png"/>"/> </p>
<h3>2.1.2&nbsp;商品规格</h3>
<p>用户可填写商品名称、库存、价格（元）、市场价格（元），或点击“自定义规格”，输入商品规格，填写完整后，点击“保存，并查看商品详情”即可。商品规格在前台的展示位置见2.1.3。
</p>
<p><img src="<c:url value="/scripts/images/help_5.png"/>"/> </p>
<h3>2.1.3&nbsp;上传商品图片</h3>
<p>1、商品图片：用户上传3-8张图片至服务器，依次选择不同的商品规格，并设置某一图片为主图片，作为商品详情页的首图，此外，用户可通过“左移”、“右移”设置商品图片在前台页面的排序。
<p><img src="<c:url value="/scripts/images/help_6.png"/>"/> </p>
其前台展示效果如下，其中主推图对应后台设置的主图片。
</p>
<p><img src="<c:url value="/scripts/images/help_7.png"/>"/> </p>
<p>图1：商品图片   &nbsp;  图2：商品规格</p>
<p>2、商品详情图片：详细介绍部分，是对商品的详细介绍，用户可以把商品详情图片上传此处。详情图片应尽量包括商品属性、文化传承、商品详情、典故传说、材质用料、大师简介、制作流程、保养方法，用户可通过上下移动图片，设置其在前台的展示效果，也可删除图片。
<p><img src="<c:url value="/scripts/images/help_8.png"/>"/> </p>
详情图片在前台的展示效果如下：
</p>
<p><img src="<c:url value="/scripts/images/help_9.png"/>"/> </p>
<h3>2.2&nbsp;上下架及删除商品</h3>
<p>商户后台-商品管理-商品列表，用户点击“上架”、“下架”实现对应商品的上、下架，上架商品客户可直接通过e飞蚁平台购买，下架商品则无法购买；用户也可通过点击“删除”删掉该商品的信息。
</p>
<p><img src="<c:url value="/scripts/images/help_10.png"/>"/> </p>
<h3 style="text-align: center">3、如何关联大师、项目</h3>
<p>店铺可选择关联大师、项目（非必填项），若店铺内没有与e飞蚁平台提供的大师、项目相关的商品，用户可不与其关联；若店铺有其他（非e飞蚁平台提供）可关联的大师、项目，用户可通过拨打e飞蚁客服电话：400-876-8766，申请平台建立该大师、项目的相关信息，以便于您与之关联。</p>
<h3>3.1&nbsp;店铺如何关联大师、项目</h3>
<p>商户后台-账号管理-基本信息，用户通过点击“关联大师”或“关联项目”，实现该店铺与大师、项目的关联.</p>
<p><img src="<c:url value="/scripts/images/help_11.png"/>"/> </p>
<h3>3.2&nbsp;商品如何关联大师、项目</h3>
<p>商户后台-商品管理-商品列表-新建商品，店铺与大师、项目关联，并不代表店铺内所有商品都与该大师、项目关联，用户可针对具体商品选择其所关联的大师、项目.
</p>
<p><img src="<c:url value="/scripts/images/help_12.png"/>"/> </p>
<h3 style="text-align: center">4、库存管理</h3>
<p>商户后台-商品管理-库存管理，用户可查询并管理商品库存。</p>
<p>库存预警即库存数达到0后，就会在“商家后台-相关商品-库存预警”中显示已低于预警数的商品数。系统将提供库存预警功能，以便于用户及时补充货源。</p>
<h3 style="text-align: center">5、促销活动
因平台上所有促销活动由e飞蚁统一管理，届时我们将第一时间告知活动详情，用户可关注站内公告，积极参与活动。</h3>
<h3 style="text-align: center">6、订单管理</h3>
<h3>6.1&nbsp;订单处理</h3>
<p>商务后台-业务管理-订单管理，订单处理流程：</p>
<p><img src="<c:url value="/scripts/images/help_13.png"/>"/> </p>
<p>系统将顾客已经支付完毕或未支付的订单发至商家后台，商户维护订单状态。商家可以对订单执行操作，对于状态为已付款的订单，用户直接点击“发货”后，即可对该订单下的商品发货，同时，下单人可通过个人中心看到对应的物流信息。
</p>
<p><img src="<c:url value="/scripts/images/help_14.png"/>"/> </p>
<h3>6.2&nbsp;订单详情</h3>
<p>商务后台-业务管理-订单管理-查看详情，用户可查看某一具体订单的订单信息、下单人信息、商品信息、支付情况及物流信息。</p>
<p><img src="<c:url value="/scripts/images/help_15.png"/>"/> </p>
<h3>6.3&nbsp;如何填写发货信息</h3>
<p>商务后台-业务管理-订单管理-查看详情-发货记录，用户点击“编辑”后，即可输入对应的物流公司及物流单号，输入完成后点击“提交”即可，详情如下：
</p>
<p><img src="<c:url value="/scripts/images/help_16.png"/>"/> </p>
<p>用户点击“物流追踪”后即可查看物流记录，详情如下：
</p>
<p><img src="<c:url value="/scripts/images/help_17.png"/>"/> </p>
<h3>6.4&nbsp;查看发货记录</h3>
<p>商务后台-业务管理-发货记录管理，用户可查看发货记录详情，也可通过发货状态、订单号、发货时间查找对应订单的发货状态。
</p>
<p><img src="<c:url value="/scripts/images/help_18.png"/>"/> </p>
<h3>6.5&nbsp;结算</h3>
<p>对于乙方通过e飞蚁平台对外销售的销售款，甲方依据消费者向乙方购买的商品价格、数量等信息，以实际销售商品、数量等信息为准，以一个自然月为基数定期与乙方进行货款的结算，结算销售款=实际销售单价×实际销售数量×（1-实时划扣技术服务费费率）。该结算销售款中，不包括退货的商品价款，也不包括快递等运输费用。销售款的具体结算方式如下：双方对于商品的销售款结算，以一个自然月及甲方实际收取到的销售款为基础。每月15日前，甲方向乙方发出对账单，双方于5日内完成审核确认，对账单经甲乙双方确认无误后，由甲方于每月25日前将上个月的销售款支付给乙方。如遇国家法定节假日，则结算日作相应顺延至节假日后的第一个工作日。</p>
<h3 style="text-align: center">7、退换货</h3>
<p>客户可拨打e飞蚁客服电话400-876-8766申请退换货，在我们与客户协调后，将第一时间向您反馈沟通情况。</p>
</div>



</body>
</html>
