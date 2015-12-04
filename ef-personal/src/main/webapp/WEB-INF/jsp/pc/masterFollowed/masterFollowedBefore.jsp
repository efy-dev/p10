<%@ page import="com.efeiyi.ec.personal.AuthorizationUtil" %>
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
  <title>大师动态-关注前</title>
  <!-- Set render engine for 360 browser -->
  <meta name="renderer" content="webkit">
  <!-- No Baidu Siteapp-->
  <meta http-equiv="Cache-Control" content="no-siteapp"/>
  <link rel="icon" type="image/png" href="assets/i/favicon.png">
  <!-- Add to homescreen for Chrome on Android -->
  <meta name="mobile-web-app-capable" content="yes">
  <link rel="icon" sizes="192x192" href="assets/i/app-icon72x72@2x.png">
  <!-- Add to homescreen for Safari on iOS -->
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
  <link rel="apple-touch-icon-precomposed" href="assets/i/app-icon72x72@2x.png">
  <!-- Tile icon for Win8 (144x144 + tile color) -->
  <meta name="msapplication-TileImage" content="assets/i/app-icon72x72@2x.png">
  <meta name="msapplication-TileColor" content="#0e90d2">
  <%--<link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/pc/css/amazeui.min.css?v=20150831'/>">--%>
  <%--<link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/pc/css/app.css?v=20150831'/>">--%>
  <%--<link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/pc/css/leader.css?v=20150831'/>">--%>
  <%--<script src="<c:url value='/scripts/assets/pc/js/jquery.min.js'/> "></script>--%>
</head>
<body>
<%--<div class="topbar wh" data-am-sticky>--%>
  <%--<div class="hd">--%>
    <%--<ul class="ul-item">--%>
      <%--<li>--%>
        <%--<%if(AuthorizationUtil.getMyUser()!=null && AuthorizationUtil.getMyUser().getId() != null){ %>--%>
        <%--<strong><%=AuthorizationUtil.getMyUser().getUsername()%></strong><a href="<c:url value='/j_spring_cas_security_logout'/>">退出</a></li>--%>
      <%--<% } %>--%>
      <%--<%if(AuthorizationUtil.getMyUser()==null || AuthorizationUtil.getMyUser().getId() == null){ %>--%>
      <%--<li><a href="<c:url value='http://192.168.1.57/cas/login?service=http%3A%2F%2Flocalhost:8080%2Fj_spring_cas_security_check'/>" title="登录">请登录</a></li>--%>
      <%--<li><a href="" title="快速注册">快速注册</a></li>--%>
      <%--<% } %>--%>
      <%--<li class="btn-top-wechat">--%>
        <%--<a title="手机e飞蚁">手机e飞蚁</a>--%>
        <%--<span class="top-wechat"></span>--%>
      <%--</li>--%>
      <%--<li><a href="" title="个人中心">个人中心</a></li>--%>
    <%--</ul>--%>
  <%--</div>--%>
<%--</div>--%>
<%--<!-- //End--topbar-->--%>
<%--<div class="header wh">--%>
  <%--<div class="hd">--%>
    <%--<div class="logo"><a class="icon" href="" target="_blank" title="e飞蚁-爱非遗"></a></div>--%>
    <%--<div class="nav">--%>
      <%--<ul>--%>
        <%--<li><a href="" title="首页">e飞蚁首页</a></li>--%>
        <%--<li><a href="<c:url value='/masterMessage/index.do'/>" title="传承人">大师</a></li>--%>
        <%--<li><a href="" title="展览">工艺</a></li>--%>
      <%--</ul>--%>
    <%--</div>--%>
  <%--</div>--%>
<%--</div>--%>
<%--<!-- //End--header-->--%>
<div class="hd" style="width: 1000px;">
<div class="nav-bars ae">
  <ul class="bars">
    <li><a href="<c:url value='/masterMessage/index.do'/>">动&nbsp;态</a></li>
    <li class="active"><a href="<c:url value='/masterMessage/getFollowBeforeList.do'/>">关&nbsp;注</a></li>
    <li><a href="<c:url value='/masterMessage/classify.do'/>">发&nbsp;现</a></li>
  </ul>
</div>
</div>
<!--nav-bars-->
<div class="home-craft my">
  <div class="craft-details">
    <div class="cart-tabe">
      <div class="craft-zy" style="display: none">
        <!-- //End--craft-->
      </div>
      <div class="craft-gz ae" style="display: block">
        <div class="craft-ts ae"><span>您还没有关注任何大师，下面是我们为您推荐的几位大师</span></div>
        <div class="craft-list ae">
          <ul class="craft-l-page ae">
            <c:if test="${!empty list}">
              <c:forEach items="${list}" var="object">
                <li>
                  <dl class="add">
                    <dt><a href="<c:url value='/masterMessage/introView/${object.id}'/>"><img src="http://tenant.efeiyi.com/${object.favicon}@!master-favicon-view"> </a></dt>
                    <dd>
                      <p class="txt1">
                        <a href="<c:url value='/masterMessage/introView/${object.id}'/>">
                          ${object.masterName}
                        </a>
                      </p>
                      <p class="txt2">
                        <c:choose>
                          <c:when test="${object.level == '1'}">
                            国家级传承人
                          </c:when>
                          <c:when test="${object.level == '2'}">
                            省级传承人
                          </c:when>
                          <c:when test="${object.level == '3'}">
                            市级传承人
                          </c:when>
                          <c:otherwise>
                            县级传承人
                          </c:otherwise>
                        </c:choose>
                      </p>
                      <p class="txt3"></p>
                      <div class="gz2">
                        <div class="bt-gz">
                          <a class="btn-guan" name="masterFollow${object.id}" onclick="followMaster('${object.id}');">
                            <div class="gz-q">
                              <i class="gz-icon"></i>
                              <em>${object.followStatus}</em>
                            </div>
                          </a>
                        </div>
                      </div>
                    </dd>
                  </dl>
                </li>
              </c:forEach>
            </c:if>
          </ul>
        </div>
      </div>
    </div>
  </div>
</div>
<%--<div class="footer wh">--%>
  <%--<div class="service wh">--%>
    <%--<div class="icon phone"></div>--%>
    <%--<div class="line"></div>--%>
    <%--<div class="icon platform"><a href="" target="_blank" title="平台优势">平台优势</a></div>--%>
    <%--<div class="line"></div>--%>
    <%--<div class="icon chengbao"><a href="" target="_blank" title="诚品宝">诚品宝</a></div>--%>
    <%--<div class="line"></div>--%>
    <%--<div class="icon wechat"></div>--%>
  <%--</div>--%>
  <%--<div class="links wh">--%>
    <%--<a href="" target="_blank" title="关于我们">关于我们</a>--%>
    <%--<a class="line"></a>--%>
    <%--<a href="" target="_blank" title="联系我们">联系我们</a>--%>
    <%--<a class="line"></a>--%>
    <%--<a href="" target="_blank" title="诚聘英才">诚聘英才</a>--%>
    <%--<a class="line"></a>--%>
    <%--<a href="" target="_blank" title="意见反馈">意见反馈</a>--%>
    <%--<a class="line"></a>--%>
    <%--<a href="" target="_blank" title="帮助中心">帮助中心</a>--%>
    <%--<a class="line"></a>--%>
    <%--<a href="" target="_blank" title="诚信保障">诚信保障</a>--%>
    <%--<a class="line"></a>--%>
    <%--<a href="" target="_blank" title="新闻资讯">新闻资讯</a>--%>
  <%--</div>--%>
  <%--<div class="copyright wh">--%>
    <%--<div class="phone">--%>
      <%--<strong>商家入住热线</strong>--%>
      <%--<em>400-876-8766</em>--%>
    <%--</div>--%>
    <%--<div class="frlinks">--%>
      <%--<span>友情链接：</span>--%>
      <%--<a rel="nofollow" href="http://www.unesco.org.cn/" target="_blank" title="联合国教科文组织">联合国教科文组织</a>--%>
      <%--<a rel="nofollow" href="http://www.mcprc.gov.cn/" target="_blank" title="中国文化部">中国文化部</a>--%>
      <%--<a rel="nofollow" href="" target="_blank" title="中国文化部非物质文化遗产保护司">中国文化部非物质文化遗产保护司</a>--%>
      <%--<a rel="nofollow" href="" target="_blank" title="中国非物质文化遗产保护中心">中国非物质文化遗产保护中心</a>--%>
    <%--</div>--%>
    <%--<div class="info">Copyright © 2012-2022 永新华韵文化发展有限公司版权所有-京ICP备15032511号-1</div>--%>
  <%--</div>--%>
<%--</div>--%>
<script>
  function followMaster(masterId){
    var str;
    $.ajax({
      type: "post",//设置get请求方式
      url: "<c:url value='/masterMessage/followMaster.do'/>" ,//设置请求的脚本地址
      data: "masterId="+masterId,//设置请求的数据
      async: true,
      dataType: "json",//设置请求返回的数据格式
      success: function (data) {
        if(data == "noRole"){
          alert("您还未登录,请登录后操作!");
        }else if(data=="add"){
          str = "已关注";
          changeFollowStatus(masterId,str);
        }else if(data=="del"){
          str = "关注";
          changeFollowStatus(masterId,str);
        }
      }
    })
  }
  function changeFollowStatus(masterId,str){
    $("a[name='masterFollow"+masterId+"']").each(function(){
      $(this).find("em").html(str);
      if(str == "关注"){
        $(this).find('.gz-icon').show();
      }else if(str == "已关注"){
        $(this).find('.gz-icon').hide();
      }
    })
  }
</script>
<!-- //End--footer-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value='/scripts/assets/js/amazeui.ie8polyfill.min.js'/>"></script>
<![endif]-->
<script src="<c:url value='/scripts/assets/pc/js/system.js'/>"></script>
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
<script src="<c:url value='/scripts/assets/pc/js/cyclopedia.js'/>"></script>
</body>
</html>
