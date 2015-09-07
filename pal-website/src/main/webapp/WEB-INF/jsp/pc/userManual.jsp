<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/layouts/public.jsp"%>
<!doctype html>
<html class="no-js">
<%--<head>--%>
  <%--<meta charset="utf-8">--%>
  <%--<meta http-equiv="X-UA-Compatible" content="IE=edge">--%>
  <%--<meta name="description" content="">--%>
  <%--<meta name="keywords" content="">--%>
  <%--<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">--%>
  <%--<title>使用须知</title>--%>
  <%--<!-- Set render engine for 360 browser -->--%>
  <%--<meta name="renderer" content="webkit">--%>
  <%--<!-- No Baidu Siteapp-->--%>
  <%--<meta http-equiv="Cache-Control" content="no-siteapp"/>--%>
  <%--<link rel="icon" type="image/png" href="<c:url value='/images/pal_icon.png'/>">--%>
  <%--<!-- Add to homescreen for Chrome on Android -->--%>
  <%--<meta name="mobile-web-app-capable" content="yes">--%>
  <%--<link rel="icon" sizes="192x192" href="<c:url value='/resources/assets/i/app-icon72x72@2x.png'/>">--%>
  <%--<!-- Add to homescreen for Safari on iOS -->--%>
  <%--<meta name="apple-mobile-web-app-capable" content="yes">--%>
  <%--<meta name="apple-mobile-web-app-status-bar-style" content="black">--%>
  <%--<meta name="apple-mobile-web-app-title" content="Amaze UI"/>--%>
  <%--<link rel="apple-touch-icon-precomposed" href="<c:url value='/resources/assets/i/app-icon72x72@2x.png'/>">--%>
  <%--<!-- Tile icon for Win8 (144x144 + tile color) -->--%>
  <%--<meta name="msapplication-TileImage" content="assets/i/app-icon72x72@2x.png">--%>
  <%--<meta name="msapplication-TileColor" content="#0e90d2">--%>
  <%--<link rel="stylesheet" href="<c:url value='/css/amazeui.min.css'/>">--%>
  <%--<link rel="stylesheet" href="<c:url value='/resources/css/pc.css'/>">--%>
<%--</head>--%>
<body>
<div class="search-list">
  <div class="search-home">
    <div class="logo">
      <h1><a href="<c:url value='<%=basePath%>'/>"><img src="<c:url value='/resources/images/logo.png'/>"
                                                        width="160" height="72"/></a></h1>
    </div>
    <form id="form" method="get" action="<c:url value='/checkLabelPc.do'/>">
      <div class="title"><a class="active">真伪查询</a></div>
      <label for="">
        <%--<input class="txt" type="text" name="serial" id="serial" value="" placeholder="请输入名称查询,如:”苏绣”"/>--%>
        <input class="txt" type="text" name="serial" id="serial" value="" placeholder="请输入12位防伪码"/>
        <input class="btn" type="submit" value="查 询"/>
      </label>
    </form>
  </div>
</div>
<!--//End--search-list-->
<div class="hd">
  <div class="about">
    <div class="menu">
      <a href="<c:url value='/aboutUs.do'/>">关于诚品宝</a>
      <a href="<c:url value='/userManual.do'/>" class="active">使用前必读</a>
    </div>
    <div class="notice">
      <h1>“诚品宝”使用须知</h1>
      <div class="part1">
        <p class="t1">尊敬的消费者：</p>
        <p class="t2">如您通过e飞蚁平台购买非物质文化遗产相关的商品，可以通过e飞蚁平台开发的“诚品宝”进行商品质量的防伪查询。</p>
      </div>
      <div class="part2">
        <p class="t1">一、使用方法</p>
        <p class="t2">“诚品宝”提供两种防伪查询方法：（1）扫描二维码查询；（2）网站查询</p>
        <P class="t3">（1）扫描二维码查询</p>
        <P class="t3">1、刮开防伪标签涂层，获得一个防伪二维码；</p>
        <P class="t3">2、使用智能手机中的微信“扫一扫”功能扫描标签上的二维码(需开启数据网络或WiFi环境下)；</p>
        <P class="t3">3、如果是第一次扫描，系统会提示关注“e飞蚁电商平台”公众号，点击关注；</p>
        <P class="t3">4、关注后系统自动返回防伪查询结果，点击可查看详情；</p>
        <P class="t3">结果一：编码有效,请放心购买</p>
        <P class="t3">结果二：编码无效,请核实后重试</p>
        <P class="t3">结果三：多次查询,请谨防假冒</p>
        <p class="t3 mt30">（2）网站查询：</p>
        <p class="t3">1、刮开防伪标签涂层，获得一个防伪码（位于二维码下方，10位，数字字母混排）；</p>
        <p class="t3">2、在电脑浏览器中输入“http://www.315cheng.com”, 打开诚品宝网站；</p>
        <p class="t3">3、在页面正中的输入框中输入标签上的防伪码（大小写不敏感）；</p>
        <p class="t3">4、点击查询按钮，系统会返回防伪查询结果；</p>
        <p class="t3">结果一：编码有效,请放心购买</p>
        <p class="t3">结果二：编码无效,请核实后重试</p>
        <p class="t3">结果三：多次查询,请谨防假冒</p>
        <p class="t3 mt30"><img src="<c:url value='/images/about-notice.jpg'/>" alt="" /></p>
      </div>
      <div class="part3">
        <p class="t1">二、免责声明</p>
        <p class="t2">诚品宝提醒您：在使用诚品宝系统前，请您务必仔细阅读并透彻理解本声明。您可以选择不使用诚品宝，但如果您使用诚品宝，您的使用行为将被视为对本声明全部内容的认可。</p>
        <p class="t3">1、诚品宝并不对非遗商品的质量和品质构成任何形式的保证、承诺或担保，无需因此而向您承担任何形式的法律责任。</p>
        <p class="t3 mt30">2、您应该对使用诚品宝的结果自行承担风险。诚品宝不做任何形式的保证：不保证查询结果满足您的要求，不保证查询服务不中断，不保证查询结果的及时性。因网络状况、通讯线路、第三方网站等任何原因而导致您不能正常使用诚品宝，诚品宝不承担任何法律责任。</p>
      </div>
      <div class="part3">
        <p class="t1 mt30">三、知识产权声明</p>
        <p class="t2">诚品宝拥有本网站内所有资料的版权。</p>
        <p class="t3">未经诚品宝许可，任何人不得擅自（包括但不限于：以非法的方式复制、传播、展示、镜像、上载、下载）使用，或通过非常规方式影响诚品宝的正常服务，任何人不得擅自以软件程序自动获得诚品宝数据。否则，诚品宝将依法追究法律责任。</p>
      </div>
      <div class="part3">
        <p class="t1 mt30">四、隐私权保护</p>
        <p class="t2">诚品宝尊重并保护所有使用诚品宝用户的个人隐私权，您注册的用户名、电子邮件地址等个人资料，非经您亲自许可或根据相关法律、法规的强制性规定，诚品宝不会主动地泄露给第三方。</p>
      </div>
    </div>
  </div>
  <!--//End--about-->
</div>

<%--<div class="footer footer-list">--%>
  <%--<div class="hd">--%>
    <%--<p>--%>
      <%--<a href="" title="关于诚品宝">关于诚品宝</a>--%>
      <%--<a href="" title="使用前必读">使用前必读</a>--%>
      <%--<strong>商家入住热线</strong>--%>
      <%--<em>400-876-8766</em>--%>
    <%--</p>--%>
    <%--<p class="copyright">Copyright © 2012-2022 永新华韵文化发展有限公司版权所有-京ICP备15032511号-1</p>--%>
  <%--</div>--%>
<%--</div>--%>
<!--//End--footer-->


<!--[if (gte IE 9)|!(IE)]><!-->
<%--<script src="js/jquery.min.js"></script>--%>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<!--<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>-->
<%--<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>--%>
<%--<script src="assets/js/amazeui.ie8polyfill.min.js"></script>--%>
<![endif]-->
<%--<script src="js/amazeui.min.js"></script>--%>
<%--<script src="js/cpbjs.js"></script>--%>
</body>
</html>