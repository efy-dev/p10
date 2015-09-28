<%@ page import="com.efeiyi.ec.wiki.organization.util.AuthorizationUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/14
  Time: 9:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>工艺</title>
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
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/wap/css/amazeui.min.css?v=20150831'/>">
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/wap/css/app.css?v=20150831'/>">
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/wap/css/cyclopedia.css?v=20150831'/>">
  <script src="/scripts/assets/js/jquery-2.1.3.min.js" type="text/javascript"></script>
  <script type="text/javascript" src="/scripts/assets/js/pubu.js"></script>
</head>
<body style=" overflow: scroll; ">
<script>

</script>

<div class="great">
  <header class="am-header custom-header">
    <div class="am-header-left am-header-nav">
      <a href="javascript:window.history.go(-1);" class="chevron-left"></a>
    </div>
    <!-- //End--chevron-left-->
    <h1 class="am-header-title">工艺</h1>
    <!-- //End--title-->
    <div class="am-header-right am-header-nav am-header-right1">
      <a href="#chevron-right" class="chevron-right" id="menu">
        <i class="icon icon-user"></i>
      </a>
    </div>
  </header>
  <!--//End--header-->
  <!--地区-->
  <div class="dis-q1">
    <div class="dis-q1-tabs">
      <ul class="tabs-nav tabs-nav-1" id="wikiNav">
        <li class="item active" id="0">热门</li>
        <li class="item" id="1">关注</li>
        <li class="item-class"><a href="<c:url value='/category.do'/>">分类</a></li>
      </ul>
      <ul class="tabs-nav tabs-nav-2">
        <li class="item active">分类</li>
        <li class="item">级别</li>
        <li class="item">地区</li>
      </ul>
      <div class="tabs-bd">
        <div class="am-tab-panel am-active" style="padding:10px 0 15px 0;width: 100%;float: left;display: block;" id="pubu">
          <c:if test="${!empty  popularProjectsList}">
            <c:forEach var="ppj" items="${popularProjectsList}">
              <ul class="hot" id="box">
                <li>
                  <a href="<c:url value='/base/brifProject.do?projectId=${ppj.project.id}'/>"><img src="${ppj.project.picture_url}"></a>
                  <div class="hot-poge">
                    <span style="margin-right: 1rem">人气</span>
                 <%-- <span>${fn:length(ppj.project.projectFolloweds)}</span>--%>
                    <span><c:if test="${ppj.project.fsAmount == null}">0</c:if><c:if test="${ppj.project.fsAmount != null}">${ppj.project.fsAmount}</c:if></span>
                  </div>
                </li>
              </ul>
            </c:forEach>
          </c:if>
        </div>
        <div class="am-tab-panel " style="display:none;">
          <div class="suit">
            <div class="dynamic" style="border-bottom: 0;">
              <% System.out.println(AuthorizationUtil.getMyUser().getId());
                System.out.println(request.getAttribute("isShow"));
              %>
              <%if(AuthorizationUtil.getMyUser().getId()==null || "no".equalsIgnoreCase(request.getAttribute("isShow").toString()) ){%>
              <div class="suit">
                <div class="dynamic" id="recommends">
                  <div class="attention">
                    <p>您还没有关注任何工艺,下面是我们为你推荐的几项具体工艺项目</p>
                  </div>
                  <c:if test="${!empty  attentionProjectsList}">
                    <ul class="dynamic-list-suit" id="recommend">
                    <c:forEach var="apj" items="${attentionProjectsList}">

                        <!--只显示9个-->
                        <li>
                          <div class="suit-list-bt">
                            <a href="#"><img src="${apj.project.picture_url}"></a>
                            <a class="gz-fd-icon" href="#" onclick="saveProjectFllow('${apj.project.id}')">关注</a>
                          </div>
                        </li>
                    </c:forEach>



                    </ul>

                  </c:if>

                </div>
                <a href="#" class="state-btn" style="color: #000;" onclick="getData('/basic/xmj.do?qm=plistProjectRecommended_default&conditions=&pageEntity.size=10&pageEntity.index=')">查看更多工艺</a>
              </div>
              <%}%>
              <c:if test="${isShow =='no'}">
                <input id="flag" type="hidden" name="flag" value="front" />
              </c:if>
              <c:if test="${isShow =='ok'}">
                <input id="flag" type="hidden" name="flag" value="back" />
              </c:if>
              <%if(AuthorizationUtil.getMyUser().getId()!=null && "ok".equalsIgnoreCase(request.getParameter("isShow")) ){%>

              <div class="dynamic">
                <ul class="suit-zt-2">
                  <li>
                    <div class="suit-zt--2-img am-u-sm-5 am-u-end">
                      <a href="#"><img src="../shop2015/upload/120211-tx-1.jpg">
                        <div class="tp-bg-0">
                          <table>
                            <tr><td><div style="padding: 0 1rem;">铜胎掐丝珐琅景泰蓝</div></td></tr>
                          </table>
                        </div></a>
                    </div>
                    <div class="suit-zt--2-text am-u-sm-7 am-u-end">
                      <h4>景泰蓝工艺详情更新了</h4>
                      <p><a href="#"> 增加相关大师5位</a></p>
                    </div>
                  </li>
                  <li>
                    <div class="suit-zt--2-img am-u-sm-5 am-u-end">
                      <a href="www.baidu.com"><img src="../shop2015/upload/120211-tx-1.jpg">
                        <div class="tp-bg-0">
                          <table>
                            <tr><td><div style="padding: 0 1rem;">铜胎掐丝珐琅景泰蓝</div></td></tr>
                          </table>
                        </div></a>
                    </div>
                    <div class="suit-zt--2-text am-u-sm-7 am-u-end">
                      <h4>景泰蓝工艺详情更新了</h4>
                      <p><a href="#"> 增加相关大师5位</a></p>
                    </div>
                  </li>
                </ul>
              </div>
              <%}%>
            </div>
          </div>

        </div>
      </div>
    </div>
    <!--地区-->
     <div class="login-reg">
      <%if(AuthorizationUtil.getMyUser()!=null && AuthorizationUtil.getMyUser().getId() != null){ %>
      <div class="bd logined"><%=AuthorizationUtil.getMyUser().getUsername()%><a class="btn-exit" href="<c:url value='/j_spring_cas_security_logout'/>">退出</a></div>
      <% } %>
      <%if(AuthorizationUtil.getMyUser()==null || AuthorizationUtil.getMyUser().getId() == null){ %>
      <a href="<c:url value='http://192.168.1.57/cas/login?service=http%3A%2F%2Flocalhost:8082%2Fj_spring_cas_security_check'/>" class="btn-login" title="登录">登&nbsp;&nbsp;&nbsp;&nbsp;录</a>
      <a href="#reg" class="btn-reg">注&nbsp;&nbsp;&nbsp;&nbsp;册</a>
      <% } %>

    </div>
</div>
</div>
<!--[if (gte IE 9)|!(IE)]><!-->
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<!--自定义js--Start-->
<script src="<c:url value='/scripts/assets/js/system.js?v=20150831'/>"></script>
<script src="<c:url value='/scripts/assets/js/cyclopedia.js?v=20150831'/>"></script>
<!--自定义js--End-->
</body>
</html>