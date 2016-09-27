<%@ page import="com.efeiyi.ec.website.base.util.AuthorizationUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>首页</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/wap/css/amazeui.min.css"/>">
  <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/wap/css/home.css?t=20160413"/>">
</head>
<body>

<div class="home">
  <header class="bd">
    <a class="icon-home icon-logo" href=""></a>
    <div class="form">
      <form action="http://mall.efeiyi.com/search.do" class="bd"method="get">
        <input type="text" class="txt"  name="q"
               value="<c:if test="${searchParamBean.q != '*'}">${searchParamBean.q}</c:if>">
        <input type="submit" class="btn" value="">
        <input type="hidden" name="resultPage" value="/searchResult"/>
        <input type="hidden" name="facetFields" value="project_name"/>
        <input type="hidden" name="group" value="efeiyi"/>
        <input type="hidden" name="priceUD" value="0"/>
      </form>
    </div>
    <div class="icons">
      <% if (AuthorizationUtil.isAuthenticated()) {%>
      <a class="icon-home icon-cart" href="http://i.efeiyi.com/order/myEfeiyi/list.do" title=""><span><em></em></span></a>
      <%} else {%>
      <a class="icon-home icon-cart" href="<c:url value="/login"/>" title=""><span style="text-align: center;"><em id="cartAmount"></em></span></a>
      <%}%>
      <a class="icon-home icon-user" href="<c:url value="/cart/view"/>" title=""></a>
    </div>
  </header>
  <!--//End-->
  <div class="bd">
    <div data-am-widget="slider" class="am-slider am-slider-a4 img-slider" data-am-slider='{&quot;directionNav&quot;:false}' >
      <ul class="am-slides">
        <c:forEach items="${bannerList}" var="banner" varStatus="status">
          <li><img src="<c:url value="http://pro.efeiyi.com/${banner.imageUrl}@!home1-banner"/>"></li>
        </c:forEach>
      </ul>
    </div>
  </div>
  <!--//End--轮播图-->
  <div class="bd">
    <nav class="nav">
      <a href="http://master.efeiyi.com" title="非遗大师"><span class="bd"><i class="icon-home icon1"></i></span>非遗大师</a>
      <a href="http://minglu.efeiyi.com" title="非遗百科"><span class="bd"><i class="icon-home icon2"></i></span>非遗百科</a>
      <a href="http://gift.efeiyi.com" title="非遗礼品"><span class="bd"><i class="icon-home icon3"></i></span>非遗礼品</a>
      <a href="http://mall.efeiyi.com" title="非遗电商"><span class="bd"><i class="icon-home icon4"></i></span>非遗电商</a>
      <a href="http://www.315cheng.com" title="诚品宝"><span class="bd"><i class="icon-home icon5"></i></span>诚品宝</a>
    </nav>
  </div>
  <!--//End--nav-->
  <div class="bd">
    <dl class="plat">
      <dt>
        <strong>商品推荐</strong>
      </dt>
      <dd>
        <c:if test="${not empty marketingActivityQueryList&&fn:length(marketingActivityQueryList)>0}">
          <c:forEach items="${marketingActivityQueryList}" var="marketingActivity" begin="0" end="0">
            <div class="bd"><a href="${marketingActivity.redirect}"><img src="http://pro.efeiyi.com/${marketingActivity.img}@!pc-home-marketing-activity" alt=""></a></div>
          </c:forEach>
        </c:if>
        <div class="bd">
          <ul class="items">
            <c:if test="${not empty hotSaleList&&fn:length(hotSaleList)>0}">
              <c:forEach items="${hotSaleList}" var="hotSale" begin="0" end="3">
                <li>
                  <a href="${hotSale.redirect}" title="">
                    <img src="http://pro.efeiyi.com/${hotSale.img}@!home-project-picture">
                                <span class="info">
                                    <p class="t1">${hotSale.name}</p>
                                    <p class="t2">¥ ${hotSale.price}</p>
                                </span>
                  </a>
                </li>
              </c:forEach>
            </c:if>
          </ul>
        </div>
        <div class="bd">
          <a href="http://mall.efeiyi.com/productCategory.do" class="more" title="全部商品">全部商品&gt;</a>
        </div>
      </dd>
    </dl>
  </div>
  <!--//End--商品推荐-->
  <div class="bd">
    <dl class="plat">
      <dt>
        <strong>非遗礼品</strong>
      </dt>
      <dd>
        <c:if test="${subjectList != null && subjectList != ''}">
          <c:forEach items="${subjectList}" var="subject" begin="0" end="0">
            <div class="bd">
              <a href="http://gift.efeiyi.com/viewSubject/${subject.id}">
                        <span class="info">
                            <p class="t1">${subject.name}</p>
                            <p class="t2">${subject.content}</p>
                        </span>
                <img src="http://gift-oss.efeiyi.com/${subject.pictureUrl}" alt="">
              </a>
            </div>
          </c:forEach>
        </c:if>
        <div class="bd">
          <ul class="items">
            <c:if test="${advertisementList != null && advertisementList != ''}">
              <c:forEach items="${advertisementList}" var="advertisement" begin="0" end="3">
                <li>
                  <a href="${advertisement.wapRedirect}" title="">
                    <img src="http://pro.efeiyi.com/${advertisement.img}@!home-project-picture">
                                <span class="info">
                                    <p class="t1">${advertisement.name}</p>
                                    <p class="t2">¥ ${advertisement.price}</p>
                                </span>
                  </a>
                </li>
              </c:forEach>
            </c:if>
          </ul>
        </div>
        <div class="bd">
          <a href="http://gift.efeiyi.com/searchProductGift" class="more" title="全部礼品">全部礼品&gt;</a>
        </div>
      </dd>
    </dl>
  </div>
  <!--//End--非遗礼品-->
  <div class="bd">
    <dl class="plat master">
      <dt>
        <strong>大师推荐</strong>
      </dt>
      <dd>
        <div class="bd">
          <ul class="items">
            <c:if test="${not empty masterList&&fn:length(masterList)>0}">
              <c:forEach items="${masterList}" var="master" begin="0" end="1">
                <li>
                  <a href="http://${master.getName()}.efeiyi.com" title="">
                    <img src="http://tenant.efeiyi.com/${master.getFavicon()}" alt="">
                                <span class="master-info">
                                    <p class="t1">${master.name}</p>
                                    <p class="t2">${master.getTitle()}</p>
                                    <p class="t3">${master.getBrief()}</p>
                                </span>
                  </a>
                </li>
              </c:forEach>
            </c:if>
          </ul>
        </div>
        <div class="bd">
          <a href="http://master.efeiyi.com" class="more" title="所有大师">所有大师&gt;</a>
        </div>
      </dd>
    </dl>
  </div>
  <!--//End--大师推荐-->
  <div class="bd">
    <dl class="plat">
      <dt>
        <strong>非遗百科</strong>
      </dt>
      <dd>
        <div class="bd">
          <ul class="items">
            <c:forEach items="${artistryList}" var="artistry" begin="0" end="3">
              <li>
                <a href="http://minglu.efeiyi.com/project/${artistry.id}" title="">
                  <img src="http://wiki-oss.efeiyi.com/${artistry.getMainPicture().pictureUrl}@!wiki-project-picture">
                                <span class="info">
                                    <p class="t1">&nbsp;</p>
                                    <p class="t2">${artistry.name}</p>
                                </span>
                </a>
              </li>
            </c:forEach>
          </ul>
        </div>
        <div class="bd">
          <a href="http://minglu.efeiyi.com" class="more" title="百科">百科全书&gt;</a>
        </div>
      </dd>
    </dl>
  </div>
  <!--//End--非遗百科-->
  <div class="bd">
    <div class="cpb">
      <div class="bd"><img src="<c:url value="/scripts/wap/images/home-cpb1.png"/>" alt=""></div>
      <div class="bd">
        <form action="http://www.315cheng.com/checkLabelPc.do">
          <input type="text" class="ctxt" placeholder="请输入商品防伪码">
          <input type="submit" class="cbtn" value="查 询">
        </form>
      </div>
      <div class="bd" style="margin-top: 25px;"><img src="<c:url value="/scripts/wap/images/home-cpb2.png"/>" alt=""></div>
    </div>
  </div>
  <!--//End--诚品宝-->

  <div class="bd">
    <footer>
      <%
        if (AuthorizationUtil.getMyUser().getId() == null) {
      %>
      <div class="bd links">
        <a href="<c:url value="/sso.do"/>" title="登录">登&nbsp;&nbsp;录</a>
        <a href="http://passport.efeiyi.com/register?service=http://mall.efeiyi.com/sso.do?registeSuccess=/registerSuccess.do" title="注册">注&nbsp;&nbsp;册</a>
      </div>
      <%
        }
      %>
      <div class="bd item">
        <h3>战略合作伙伴</h3>
        <div class="bd icons">
          <span><a href="http://en.unesco.org/" title="联合国教科文组织"><em class="bd"><i class="icon-home icon1"></i></em>联合国教科文组织</a></span>
          <span><a href="http://mall.efeiyi.com" title="非物质文化遗产平台"><em class="bd"><i class="icon-home icon2"></i></em>非物质文化遗产平台</a></span>
          <span><a title="中国非物质文化遗产保护协会"><em class="bd"><i class="icon-home icon3"></i></em>中国非遗保护协会</a></span>
        </div>
      </div>
      <div class="bd content">
        <div class="bd wechat">
          <div class="bd"><div class="icon-home icon-logo"></div></div>
          <div class="bd"><h4>非物质文化遗产平台</h4></div>
          <div class="bd img"><img src="<c:url value="/scripts/images/icon-home-wechat.png"/>"></div>
          <div class="bd txt">
            <p>关注微信公众号</p>
            <p>领取超值代金券</p>
          </div>
        </div>
      </div>
      <div class="bd copyright">京ICP备15032511号-1</div>
    </footer>
  </div>
</div>
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