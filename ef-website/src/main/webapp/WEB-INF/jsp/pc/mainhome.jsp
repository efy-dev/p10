<%@ page import="com.efeiyi.ec.website.base.util.AuthorizationUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>首页</title>
  <link type="text/css" rel="stylesheet" href="<c:url value="/resources/assets/css/amazeui.min.css"/>">
  <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/css/layout.css?v=20160601"/>">
  <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/css/home.css?v=20160601"/>">
</head>
<body style="background:#fff;">
<div class="top2016">
  <div class="hd">
    <ul class="fr">
      <li><a href="http://j.efeiyi.com/ef-person/" title="大师入驻">大师入驻</a></li>
      <li><a href="http://mall.efeiyi.com/document/helpCenter?group=ec.rzlc" title="商家入驻">商家入驻</a></li>
      <li>
        <%
          if (AuthorizationUtil.isAuthenticated()) {
        %>
        <a href="http://i.efeiyi.com" title="个人中心"><%=AuthorizationUtil.getCurrentSampleUsername()%>
        </a>
        <a href="<c:url value='/j_spring_security_logout'/>" title="退出">退出</a>
        <%
         } else {
        %>
        <a href="<c:url value="/sso.do"/>" title="e飞蚁登录">登录</a>
        <em>&nbsp;/&nbsp;</em>
        <a href="http://passport.efeiyi.com/register?service=http://mall.efeiyi.com/sso.do?registeSuccess=/registerSuccess.do" title="e飞蚁注册">注册</a>
        <%
          }
        %>

      </li>
      <li class="cart"><a href="<c:url value="/cart/view"/> " title=""><i class="icon-cart"></i><span class="icon-num"><i id="cartAmount"></i></span></a></li>

    </ul>
  </div>
</div>
<!--//End--头部-->
<div class="header2016 newhead">
  <div class="hd">
    <a href="http://www.efeiyi.com" class="logo"></a>
    <ul class="nav">
      <li><a href="http://www.efeiyi.com" title="e飞蚁首页">首页</a></li>
      <li><a href="http://mall.efeiyi.com" title="e飞蚁商城">非遗电商</a></li>
      <li><a href="http://master.efeiyi.com" title="非遗大师">非遗大师</a></li>
      <li><a href="http://minglu.efeiyi.com" title="非遗百科">非遗百科</a></li>
      <li><a href="http://gift.efeiyi.com" title="非遗礼品">非遗礼品</a></li>
      <li><a href="http://www.315cheng.com" title="诚品宝">诚品宝</a></li>
      <li><a href="http://ryt.efeiyi.com" title="融艺投">融艺投</a></li>
    </ul>
    <form action="http://mall.efeiyi.com/search.do" method="get">
      <input type="text" value="" name="q" id="q" placeholder="搜索" class="txt">
      <input type="submit" value="" class="btn">
      <input type="hidden" id="resultPage" name="resultPage" value="/searchResult">
      <input type="hidden" id="facetFields" name="facetFields" value="project_name">
      <input type="hidden" id="group" name="group" value="efeiyi">
      <input type="hidden" id="priceUD" name="priceUD" value="0">
    </form>
  </div>
</div>
<!--//End--logo和搜索-->
<div id="slide2016" class="slide2016">
    <div data-am-widget="slider" class="am-slider am-slider-default" data-am-slider='{"controlNav":false}' data-am-flexslider="{playAfterPaused: 2000}" data-am-slider='{&quot;directionNav&quot;:false}'>
      <ul class="am-slides" >
        <li><a href="http://master.efeiyi.com/html/master_home.html"><img src="http://tenant.oss-cn-beijing.aliyuncs.com/index_banner/%E6%88%BF%E5%BF%97%E8%BE%BEbanner.jpg" ></a></li>
        <c:if test="${not empty bannerList&&fn:length(bannerList)>0}">
        <c:forEach items="${bannerList}" var="banner">
        <li><a href="<c:url value="${banner.directUrl}"/>"><img src="http://pro.efeiyi.com/${banner.imageUrl}" ></a></li>
        </c:forEach>
          </c:if>
      </ul>
    </div>
</div>
<!--//End--slide2016-->
<div class="home">
  <div class="hd">
    <div class="box recommend">
      <div class="title">
        <div class="cate" id="cate">
            <div class="dt"><span href="" title="">全部商品<i class="icon-arrow"></i></span></div>
            <div class="dd" style="display:none;">
            <c:forEach items="${categoryList}" var="projectCategory">
              <div class="layer">
                <ul>
                  <li class="title"><a href="/project/list/idzi58opd4r51iza"
                                       title="陶冶烧造"><strong>${projectCategory.name}：</strong></a></li>
                  <c:forEach items="${projectMap.get(projectCategory.id)}" var="project">
                    <li><a href="<c:url value="/product/list/${project.id}"/>" title="${project.name}">${project.name}</a></li>
                  </c:forEach>
                </ul>
              </div>
            </c:forEach>
            </div>
        </div>
        <div  style="float:right" class="enter">
          <form action="http://seller.efeiyi.com/sign/toRegister.do">
            <input type="submit"  class="enterbtn" value="入驻商城" />
            <div class="mform" style="border: 0;padding: 0;margin-right: 10px;background: none">
              <div class="fr wb" style="position: relative;width: 240px;">
                <div class="select">企业入驻</div>
                <ul class="option" style="display: none">
                  <li>企业入驻</li>
                  <li>个体入驻</li>
                  <li>个人入驻</li>
                </ul>
              </div>
            </div>
          </form>
        </div>
      </div>
      <ul class="pro">
        <c:if test="${not empty marketingActivityQueryList&&fn:length(marketingActivityQueryList)>0}">
        <c:forEach items="${marketingActivityQueryList}" var="marketingActivity" begin="0" end="0">
        <li class="big">
          <a href="${marketingActivity.redirect}" title="" target="_blank">
            <p class="img"><img class="imgbg" src="http://pro.efeiyi.com/${marketingActivity.img}@!pc-main-marketing-picture" alt=""></p>
          </a>
        </li>
         </c:forEach>
        </c:if>
      <c:if test="${not empty hotSaleList&&fn:length(hotSaleList)>0}">
      <c:forEach items="${hotSaleList}" var="hotSale" begin="0" end="5">
        <li>
          <a href="${hotSale.redirect}" title="" target="">
            <div class="img"><img class="imgbg" src="http://pro.efeiyi.com/${hotSale.img}@!pc-main-product-picture" alt=""></div>
            <div class="info">
              <p class="txt">${hotSale.name}</p>
              <p class="price">¥ ${hotSale.price}</p>
            </div>
          </a>
        </li>
      </c:forEach>
      </c:if>
      </ul>
    </div>
    <!--//End--商品推荐-->

    <!--//End--搜索-->
    <div class="mofg box">
      <div class="mhead" style="padding-top: 0">
        <h5>大师推荐</h5>
      </div>
      <div class="mbody">
        <div class="mlist">
          <c:if test="${not empty masterList&&fn:length(masterList)>0}">
            <div class="intl"><img src="<c:url value="/scripts/images/intl-efeiyi.png"/>" alt=""/></div>
          <div class="list" style="padding: 26px 20px">
            <dt class="dhead"><a href="http://${masterList.get(0).getName()}.efeiyi.com"><img src="http://tenant.efeiyi.com/${masterList.get(0).getFavicon()}@!pc-main-master-picture" alt=""/></a></dt>
            <dd class="dbody">
              <div class="mtext">
                <h4>${masterList.get(0).getFullName()}</h4>
                <p class="rank">${masterList.get(0).getTitle()}</p>
                <p class="content">${masterList.get(0).getBrief()}</p>
              </div>
              <ul class="mtime">
                <c:forEach items="${masterNewsMap.get(masterList.get(0))}" var="news" begin="0" end="2">
                <li class="tlist">
                  <a href="http://yaohuifen.efeiyi.com/info/${news.id}">
                    <div class="time"><fmt:formatDate value="${news.createDateTime}" pattern="dd/MM/yyyy"/></div>
                    <div class="txt">${news.brief}</div>
                  </a>
                </li>
                </c:forEach>
              </ul>
            </dd>
          </div>
          </c:if>
        </div>
        <div class="mform">
          <h4>我要注册为大师</h4>
          <form action="http://j.efeiyi.com/ef-person/forwardPage">
            <input class="mpage" type="text" name="username" placeholder="姓名"/>
            <input class="mpage" type="text" name ="projectName"placeholder="非遗项目"/>
            <select  name="level" value="1" class="select" >
                <option value="1">国家级</option>
                <option value="2">省级</option>
                <option value="3">市级</option>
                <option value="4">县级</option>
            </select>
<%--            <div class="fl wb" style="position: relative">
              <div class="select">传承人级别</div>
              <ul class="option" style="display: none">
                <li>世界级</li>
                <li>国家级</li>
                <li>省级</li>
                <li>市级</li>
              </ul>
            </div>--%>
            <input class="mpage" type="text" name="phoneNum"placeholder="电话"/>
            <input class="mbtn" type="submit" value="立即入驻"/>
          </form>
        </div>
      </div>

    </div>
    <!--//End--大师推荐-->
    <div class="mofg wm">
      <div class="mhead">
        <h5>非遗礼品</h5>
      </div>
      <div class="mbody">
        <ul class="strategy-list">
          <c:forEach items="${subjectList}" var="subject" begin="0" end="1">
          <li>
            <a href="http://gift.efeiyi.com/viewSubject/${subject.id}">
              <img src="http://gift-oss.efeiyi.com/${subject.pictureUrl}@!pc-main-gift-picture" alt="">
              <div class="list-content">
                <p class="name">${subject.name}</p>
                <p class="content">
                    ${subject.content}</p>
              </div>
            </a>
          </li>
          </c:forEach>
        </ul>
        <div class="mform">
          <h4>我要送礼</h4>
          <%--<form action="http://gift.efeiyi.com/getProductGiftpList">--%>
            <c:forEach items="${map}" var="map">
              <div class="fl wb mgift">
                <h5>${map.key}：</h5>
                <div class="fl wb" style="position: relative">
                  <div class="select">${map.value.get(0).value}</div>
                  <ul class="option" style="display: none">
                  <c:forEach items="${map.value}" var="productGiftTagValue">
                    <li><a href="http://gift.efeiyi.com/getProductGiftpList?value=${productGiftTagValue.value}&minPrice=&maxPrice=">${productGiftTagValue.value}</a></li>
                  </c:forEach>
                  </ul>
                </div>
              </div>
            </c:forEach>
              <div class="fl wb mgift">
                <h5>商品价格</h5>
                <div class="fl wb" style="position: relative">
                  <div class="select" href="http://gift.efeiyi.com/getProductGiftpList?value=&minPrice=0&maxPrice=100"><a>百元以内</a></div>
                  <ul class="option" style="display: none">
                    <li><a href="http://gift.efeiyi.com/getProductGiftpList?value=&minPrice=0&maxPrice=100">百元以内</a></li>
                    <li><a href="http://gift.efeiyi.com/getProductGiftpList?value=&minPrice=100&maxPrice=1000">100~1000</a></li>
                    <li><a href="http://gift.efeiyi.com/getProductGiftpList?value=&minPrice=1000&maxPrice=5000">1000~5000</a></li>
                    <li><a href="http://gift.efeiyi.com/getProductGiftpList?value=&minPrice=5000&maxPrice=10000">5000~1万</a></li>
                    <li><a href="http://gift.efeiyi.com/getProductGiftpList?value=&minPrice=10000&maxPrice=100000">1万~10万</a></li>
                    <li><a href="http://gift.efeiyi.com/getProductGiftpList?value=&minPrice=100000&maxPrice=1000000000">10万以上</a></li>
                  </ul>
                </div>
              </div>
            <input class="mbtn" type="submit" value="查找礼品" onclick="location.href='http://gift.efeiyi.com/getProductGiftpList'" style="margin: 12px 0;"/>
          <%--</form>--%>
        </div>
      </div>

    </div>
    <!--//End--非遗礼品-->
    <div class="box wiki">
      <div class="title">
        <h5>非遗百科</h5>
      </div>
      <div class="partl" id="wiki-pro">
        <ul class="pro">
          <c:forEach items="${artistryList}" var="artistry">
          <li>
            <a href="http://minglu.efeiyi.com/minglu/project/${artistry.id}" title="" target="">
              <div class="img"> <img class="imgbg" src="http://wiki-oss.efeiyi.com/${artistry.getMainPicture().pictureUrl}@!pc-main-artistry-picture" alt=""></div>
              <div class="info">
                <p class="txt">${artistry.name}</p>
                <p class="txt2"><ming800:status name="level" dataType="Project.level"
                                             checkedValue="${artistry.getLevel()}" type="normal"></ming800:status>非遗项目</p>

              </div>
              <div class="intl"><img src="<c:url value="/scripts/images/intl-efeiyi.png"/>" alt=""/></div>
            </a>
          </li>
          </c:forEach>
        </ul>
        <a href="" class="btn prev" title="上一个"></a>
        <a href="" class="btn next" title="下一个"></a>
      </div>
      <!--//End--产品列表-->
      <div class="partr">
        <dl class="qa">
          <dt>端午节吃什么？</dt>
          <dd>A、粽子 B、汤圆 C、月饼 D、元宵</dd>
        </dl>
        <div class="wechat"><img src="<c:url value="/scripts/images/home-wechat.jpg"/>" alt=""></div>
      </div>
      <!--//End--微信答题-->

    </div>
    <!--//End--非遗百科-->
    <div class="box cpb" style="margin-top: 25px;">
      <div class="cpimg">
        <a><img class="logo" src="<c:url value="/scripts/images/es-logo.png"/>" alt="诚品宝"/></a>
        <img src="<c:url value="/scripts/images/easy.png"/>" alt="" class="ryts"/>
      </div>
      <div class="cptext">
        <p class="chead">打造非遗作品有据可查“身份证”，让非遗作品真假可辨，流传有序</p>
        <p class="cbody">
          诚品宝价值：非遗作品集合二维码、防伪芯片、非遗作品DNA等高科技手段,为非遗作品打造一张数字“身份证”；由非遗大师授权认可，是大师高附加值真品的见证；消费者随时随地可查询非遗作品的真伪及溯源信息。</p>
        <div class="csearch">
          <form action="http://www.315cheng.com/checkLabelPc.do">
            <input type="text" class="ctxt" placeholder="请输入商品防伪码"/>
            <input type="submit" class="cbtn" value=""/>
          </form>
        </div>
      </div>
    </div>
    <!--//End--诚品宝-->
    <%--<!--//End--非遗百科-->--%>
    <%--<div class="box cpb" style="margin-top: 25px;">--%>
      <%--<div class="cpimg">--%>
        <%--<a href="http://www.315cheng.com/"><img class="logo" src="<c:url value="/scripts/images/es-logo.png"/>" alt="诚品宝"/></a>--%>
        <%--<img class="es-logo" src="<c:url value="/scripts/images/easy.png"/>" alt="融易投"/>--%>
        <%--<p class="es-yard"><img src="<c:url value="/scripts/images/easy2.png"/>" alt="融易投扫码"/><span>扫码关注订阅号</span></p>--%>
      <%--</div>--%>
      <%--<div class="cptext">--%>
        <%--<p class="chead">打造非遗作品有据可查“身份证”，让非遗作品真假可辨，流传有序</p>--%>
        <%--<p class="cbody">--%>
          <%--诚品宝价值：非遗作品集合二维码、防伪芯片、非遗作品DNA等高科技手段,为非遗作品打造一张数字“身份证”；由非遗大师授权认可，是大师高附加值真品的见证；消费者随时随地可查询非遗作品的真伪及溯源信息。</p>--%>
        <%--<div class="csearch">--%>
          <%--<form action="http://www.315cheng.com/checkLabelPc.do">--%>
            <%--<input type="text" class="ctxt" name="serial" placeholder="请输入商品防伪码"/>--%>
            <%--<input type="submit" class="cbtn" value=""/>--%>
          <%--</form>--%>
        <%--</div>--%>
        <%--<div class="ryt"></div>--%>
        <%--<p class="cbody">融艺投，作为一款面向艺术家和大众的艺术交流与投资的社交APP，引领互联网+艺术新模式。</p>--%>
      <%--</div>--%>
    <%--</div>--%>
    <%--<!--//End--诚品宝-->--%>
  </div>
</div>
<!--//End--home-->
<div class="footernew wh">
  <div class="servicenew wh">
    <div class="hd tct">
      <div class=" foremax">
        <div class="foretop"></div>
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
      </div>
    </div>
  </div>
  <div class="max-links wh">
    <div class="copyright wh">
      <div class="frlinksimg">
        <div class="simgbox">
          <strong>战略合作伙伴</strong>
          <a class="icon1" href="http://en.unesco.org/" title="联合国教科文组织" target="_blank"></a><em
                class="line"></em><a class="icon3" title="中国非物质文化遗产保护协会"></a><em class="line"></em><a
                class="icon2" title="中国非物质文化遗产保护协会" href="http://www.chinaich.org/" target="_blank"></a>
        </div>
      </div>

    </div>
    <div class="links wh">
      <a href="/document/aboutUs?group=ec.gywm" target="_blank" title="关于我们">关于我们</a>
      <a class="line"></a>
      <a href="/document/aboutUs?group=ec.ptys" target="_blank" title="平台优势">平台优势</a>
      <a class="line"></a>
      <a href="/document/aboutUs?group=ec.cpyc" target="_blank" title="诚聘英才">诚聘英才</a>
      <a class="line"></a>
      <a href="/document/aboutUs?group=ec.lxwm" target="_blank" title="联系我们">联系我们</a>
      <a class="line"></a>
      <a href="/document/aboutUs?group=ec.yjfk" target="_blank" title="意见反馈">意见反馈</a>
      <a class="line"></a>
      <a href="/document/aboutUs?group=ec.fyjj" target="_blank" title="非遗简介">非遗简介</a>
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
      <a href="http://www.miitbeian.gov.cn" target="_blank" title=""> <img class="imgfilter"
                                                                           src="<c:url value="/scripts/images/authentication-0.png"/>"
                                                                           alt=""></a>
      <a href="http://www.miitbeian.gov.cn" target="_blank" title="网站域名备案"> <img class="imgfilter"
                                                                                 src="<c:url value="/scripts/images/authentication-1.png"/>"
                                                                                 alt="网站域名备案"></a>
      <a href="http://www.baic.gov.cn/" target="_blank" title="企业信用信息备案"> <img class="imgfilter"
                                                                               src="<c:url value="/scripts/images/authentication-2.png"/>"
                                                                               alt="企业信用信息备案"></a>
      <a href="/scripts/images/license.jpg" target="_blank" title="企业营业执照"> <img class="imgfilter"
                                                                                 src="<c:url value="/scripts/images/authentication-3.png"/>"
                                                                                 alt="企业营业执照 "></a>
      <div class="info">Copyright © 2012-2022 永新华韵文化发展有限公司版权所有-京ICP备15032511号-1</div>
    </div>
  </div>
  <div class="newphone">
    <div class="efy-icon"></div>
  </div>
</div>
<!--//End--footernew-->

<!--[if (gte IE 9)|!(IE)]><!-->
<script src="<c:url value="/scripts/js/jquery.min.js"/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value="/scripts/js/amazeui.ie8polyfill.min.js"/>"></script>
<![endif]-->
<script src="<c:url value="/scripts/js/home.js"/>"></script>
<script>

  $().ready(function () {
    var success = function (data) {
        $("#cartAmount").html(data);
    }
    ajaxRequest("<c:url value="/cart/cartAmount.do"/>", {}, success, function () {
    }, "post");
  });

</script>
</body>
</html>
