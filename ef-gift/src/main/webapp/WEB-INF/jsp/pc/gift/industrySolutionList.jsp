<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>企业礼品</title>
  <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/css/amazeui.min.css"/>">
  <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/css/layout.css"/>">
  <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/css/gift.css"/>">
</head>
<body>
<div class="top2016">
  <div class="hd">
    <div class="tips fl"><i class="min-logo"></i>汇聚东方工艺精粹</div>
    <div class="search-gift">
      <form action="">
        <input type="text" value="" placeholder="搜索" class="ipt">
        <input type="submit" value="" class="icon2016-gift btn">
      </form>
      <div class="gift-link">
        <a href="">剪纸</a>
        <span class="icon2016-gift"></span>
        <a href="">景泰蓝</a>
        <span class="icon2016-gift"></span>
        <a href="">湘绣</a>
        <span class="icon2016-gift"></span>
        <a href="">苏绣</a>
        <span class="icon2016-gift"></span>
        <a href="">铜雕</a>
        <span class="icon2016-gift"></span>
        <a href="">鼻烟壶</a>
        <span class="icon2016-gift"></span>
        <a href="">金银丝镶嵌</a>
      </div>
    </div>
  </div>
</div>
<!--//End--topbar-->
<div class="nav2016 bgc">
  <div class="hd bgf">
    <div id="cate" class="cate">
      <div class="dt"><span href="" title="">全部商品<i class="icon2016 icon-arrow"></i></span></div>
      <div class="dd" style="display:none">
        <c:if test="${map != null && map != ''}">
          <c:forEach items="${map}" var="map">
            <div class="layer">
              <ul>
                <li class="title"><strong>${map.key}：</strong></li>
                <c:forEach items="${map.value}" var="productGiftTagValue">
                  <li><a href="">${productGiftTagValue.value}</a></li>
                </c:forEach>
              </ul>
            </div>
          </c:forEach>
        </c:if>
      </div>
    </div>
    <!--//End--分类-->
    <div class="navitems">
      <ul>
        <li><a href="<c:url value="/home.do"/>" title="">首页</a></li>
        <li><a href="<c:url value="/industrySolution.do"/>" title="">企业礼品</a></li>
        <li><a href="" title="">国礼轶事</a></li>
        <li><a href="" title="">礼尚往来</a></li>
        <li><a href="" title="">礼品专区</a></li>
      </ul>
    </div>
    <!--//End--导航-->

    <!--//End--搜索-->
  </div>
</div>
<!--//End--nav2016-->
<div id="slide2016" class="slide2016">
  <div class="img">
    <div class="click prev"></div>
    <ul>
      <c:if test="${bannerList != null && bannerList != ''}">
        <c:forEach items="${bannerList}" var="banner">
          <li><a href="" title=""><img src="http://wiki-oss.efeiyi.com/${banner.imageUrl}" alt=""></a></li>
        </c:forEach>
      </c:if>
    </ul>
    <div class="click next"></div>
  </div>
  <div class="num">
    <ul>
      <li class="active"></li>
      <li></li>
      <li></li>
    </ul>
  </div>
</div>
<!--//End--slide2016-->
<div class="gift2016">
  <div class="gift-home company">
    <div class="customization2016">
      <c:if test="${industrySolutionMap != null && industrySolutionMap != ''}">
        <c:forEach items="${industrySolutionMap}" var="industrySolution">
          <div class="customization-list">
            <div class="title">
              <h5>${industrySolution.key.solutionName}</h5>
              <p class="organization">${industrySolution.key.introduction}</p>
            </div>
            <ul class="list delete-mg">
              <c:forEach items="${industrySolution.value}" var="productGiftIndustrySolution">
                <li>
                  <a href="">
                    <img src="http://wiki-oss.efeiyi.com/${productGiftIndustrySolution.productGift.product.picture_url}" alt="">
                    <div class="list-content delete-pd">
                      <p class="name">${productGiftIndustrySolution.productGift.product.name}</p>
                      <p class="title">${productGiftIndustrySolution.productGift.product.subName}</p>
                    </div>
                  </a>
                </li>
              </c:forEach>
            </ul>
            <div class="btn">
              <a class="scheme" href="<c:url value="/industrySolutionRequest.do"/>">定制方案</a>
            </div>
          </div>
        </c:forEach>
      </c:if>
    </div>
    <div class="flow">
      <h5>定制流程</h5>
      <div class="flow-pic">
        <img src="<c:url value="/scripts/images/gift/flow.jpg"/>" alt="流程">
        <div class="flow-content">
          <div class="consult">
            <a href="" class="z-btn">马上咨询</a>
          </div>
          <p class="phone">咨询热线：4008768766</p>
        </div>
      </div>
    </div>
  </div>
</div>
<!--//End--craft2016-->
<div class="footernew wh">
  <div class="servicenew wh">
    <div class="hd tct">
      <div class=" foremax">
        <dl class="fore">
          <dt>帮助中心</dt>
          <dd><a href="/document/helpCenter?group=ec.gwlc" target="_blank">购物流程</a></dd>
          <dd><a href="/document/helpCenter?group=ec.zffs" target="_blank">支付方式</a></dd>
          <dd><a href="/document/helpCenter?group=ec.psfs" target="_blank">配送方式</a></dd>
        </dl>
        <dl class="fore">
          <dt>商家服务</dt>
          <dd><a href="/document/helpCenter?group=ec.rzxz" target="_blank">入驻须知</a></dd>
          <dd><a href="/document/helpCenter?group=ec.rzlc" target="_blank">入驻流程</a></dd>
          <dd><a href="/document/helpCenter?group=ec.rzzx" target="_blank">入驻咨询</a></dd>
        </dl>
        <dl class="fore">
          <dt>售后流程</dt>
          <dd><a href="/document/helpCenter?group=ec.thlc" target="_blank">退货流程</a></dd>
          <dd><a href="/document/helpCenter?group=ec.hhlc" target="_blank">换货流程</a></dd>
        </dl>
        <dl class="fore">
          <dt>服务保障</dt>
          <dd><a href="/document/helpCenter?group=ec.zpbz" target="_blank">正品保障</a></dd>
          <dd><a href="/document/helpCenter?group=ec.shzc" target="_blank">售后政策</a></dd>
        </dl>
        <dl class="fore">
          <dt>法律声明</dt>
          <dd><a href="/document/helpCenter?group=ec.flsm" target="_blank">法律声明</a></dd>
          <dd><a href="/document/helpCenter?group=ec.aqjyssm" target="_blank">安全及隐私声明</a></dd>
        </dl>
        <div class="wechatnew" title="手机e飞蚁">
          <i class="inro-icon0"></i>
          <i class="inro-icon"></i>
        </div>
      </div>
    </div>
  </div>
  <div class="max-links wh">
    <div class="links wh">
      <a href="/document/aboutUs?group=ec.gywm" target="_blank" title="关于我们"><i class="icon"></i>关于我们</a>
      <a href="/document/aboutUs?group=ec.ptys" target="_blank" title="平台优势"><i class="icon"></i>平台优势</a>
      <a href="/document/aboutUs?group=ec.cpyc" target="_blank" title="诚聘英才"><i class="icon"></i>诚聘英才</a>
      <a href="/document/aboutUs?group=ec.lxwm" target="_blank" title="联系我们"><i class="icon"></i>联系我们</a>
      <a href="/document/aboutUs?group=ec.yjfk" target="_blank" title="意见反馈"><i class="icon"></i>意见反馈</a>
      <a href="/document/aboutUs?group=ec.fyjj" target="_blank" title="非遗简介"><i class="icon"></i>非遗简介</a>
    </div>
    <div class="copyright wh">
      <div class="frlinksimg">
        <div class="simgbox">
          <strong>战略合作伙伴</strong>
          <a class="icon1" href="http://en.unesco.org/" title="联合国教科文组织" target="_blank"></a><em class="line"></em><a class="icon3" title="中国非物质文化遗产保护协会
"></a><em class="line"></em><a class="icon2" title="中国非物质文化遗产保护协会"></a>
        </div>
      </div>

    </div>
    <!--<div class="copyright wh">
        <div class="phone">
            <strong>商家入驻热线</strong>
            <em>400-876-8766</em>
        </div>
        <div class="frlinks">
            <span>友情链接：</span>
            <a rel="nofollow" href="http://www.unesco.org.cn/" target="_blank" title="联合国教科文组织">联合国教科文组织</a>
            <a rel="nofollow" href="http://www.mcprc.gov.cn/" target="_blank" title="中国文化部">中国文化部</a>
            <a rel="nofollow" href="" target="_blank" title="中国文化部非物质文化遗产保护司">中国文化部非物质文化遗产保护司</a>
            <a rel="nofollow" href="" target="_blank" title="中国非物质文化遗产保护中心">中国非物质文化遗产保护中心</a>
        </div>
        <div class="info">Copyright ? 2012-2022 永新华韵文化发展有限公司版权所有-京ICP备15032511号-1</div>
    </div>-->
    <div class="wh authentication">
      <div class="info">Copyright © 2012-2022 永新华韵文化发展有限公司版权所有-京ICP备15032511号-1</div>
      <a href="http://www.miitbeian.gov.cn" target="_blank" title=""> <img class="imgfilter" src="/scripts/images/authentication-0.png" alt=""></a>
      <a href="http://www.miitbeian.gov.cn" target="_blank" title="网站域名备案"> <img class="imgfilter" src="/scripts/images/authentication-1.png" alt="网站域名备案"></a>
      <a href="http://www.baic.gov.cn/" target="_blank" title="企业信用信息备案"> <img class="imgfilter" src="/scripts/images/authentication-2.png" alt="企业信用信息备
案"></a>
      <a href="/scripts/images/license.jpg" target="_blank" title="企业营业执照"> <img class="imgfilter" src="/scripts/images/authentication-3.png" alt="企业营业执照 "></a>
    </div>
  </div>
</div>
<!--//End--homenew-->
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="<c:url value="/scripts/js/jquery.min.js"/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="/scripts/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->



<script src="<c:url value="/scripts/js/system.js"/>"></script>
</body>
</html>
