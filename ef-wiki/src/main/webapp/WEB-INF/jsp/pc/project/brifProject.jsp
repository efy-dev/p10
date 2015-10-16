
<%@ page import="com.efeiyi.ec.wiki.organization.util.AuthorizationUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/10/9
  Time: 10:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>e飞蚁工艺秀</title>
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
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/pc/css/amazeui.min.css?v=20150831'/>">
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/pc/css/app.css?v=20150831'/>">
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/pc/css/cyclopedia.css?v=20150831'/>">
  <script src="<c:url value='/resources/jquery/jquery-2.1.3.min.js'/>"></script>
</head>
<body>
<div class="topbar wh" data-am-sticky>
  <div class="hd">
    <ul class="ul-item">
      <li><strong>李先生8899</strong><a href="" title="退出">退出</a></li>
      <li><a href="" title="请登录">请登录</a></li>
      <li><a href="" title="快速注册">快速注册</a></li>
      <li class="btn-top-wechat">
        <a title="手机e飞蚁">手机e飞蚁</a>
        <span class="top-wechat"></span>
      </li>
      <li class="cart">
        <a href="" title="购物车"><i class="icon"></i>购物车</a>
        <span class="tips"><em>0</em></span>
      </li>
    </ul>
  </div>
</div>
<!-- //End--topbar-->
<div class="header wh">
  <div class="hd">
    <div class="logo"><a class="icon" href="" target="_blank" title="e飞蚁-爱非遗"></a></div>
    <div class="nav">
      <ul>
        <li><a href="" title="首页">首页</a></li>

        <li><a href="" title="传承人">大师</a></li>
        <li><a href="<c:url value='/pc/index.do'/>" title="展览">工艺</a></li>

      </ul>
    </div>
  </div>
</div>
<!-- //End--header-->
<div class="craft-details">
  <div class="craft-banner">
    <img src="http://pro.efeiyi.com/${project.picture_url}">
    <div class="cart-b-page">
      <h5 class="ae">${project.name}</h5>
      <c:choose>
        <c:when test="${project.level =='1'}">
           <p class="ae">国家非物质文化遗产</p>
        </c:when>
        <c:when test="${project.level =='2'}">
          <p class="ae">省级非物质文化遗产</p>
        </c:when>
        <c:when test="${project.level =='3'}">
         <p class="ae">市级非物质文化遗产</p>
        </c:when>
        <c:otherwise>
            <p class="ae">县级非物质文化遗产</p>
        </c:otherwise>
      </c:choose>
      <div class="max-atten ae">
        <div class="attention">
          <a href="#" id="${project.id}" class="cgz-r-1" onclick="saveProjectFllow('${project.id}')">
            <c:if test="${flag ==true}">
              <input id="saveProjectFllow" type="hidden" value="0">
              <em>已关注此工艺</em>
            </c:if>
            <c:if test="${flag ==false}">
              <input id="saveProjectFllow" type="hidden" value="1">
              <i class="atten-icon"></i>
              <em>关注此工艺</em>
            </c:if>

          </a>
        </div>
        <div class="attention-page">
          <span>已经被 ${project.fsAmount} 个景泰蓝爱好者关注</span>
        </div>
      </div>
    </div>
  </div>
  <div class="ae">
    <ul class="craft-nav">
      <li class="active"><a href="<c:url value='/project/brifProject.do?projectId=${project.id}'/>">介&nbsp;绍</a></li>
      <li><a href="<c:url value='/project/brifMaster.do?projectId=${project.id}'/>">大&nbsp;师</a></li>
      <li><a href="<c:url value='/project/listProduct.do?projectId=${project.id}'/>">作&nbsp;品</a></li>
    </ul>
    <div class="craft-max ae">
      <div class="craft-introduce1 ae" style="display: block">
        ${project.projectContents[0].content}
      </div>
    </div>
  </div>
</div>
<div class="footer wh">
  <div class="service wh">
    <div class="icon phone"></div>
    <div class="line"></div>
    <div class="icon platform"><a href="" target="_blank" title="平台优势">平台优势</a></div>
    <div class="line"></div>
    <div class="icon chengbao"><a href="" target="_blank" title="诚品宝">诚品宝</a></div>
    <div class="line"></div>
    <div class="icon wechat"></div>
  </div>
  <div class="links wh">
    <a href="" target="_blank" title="关于我们">关于我们</a>
    <a class="line"></a>
    <a href="" target="_blank" title="联系我们">联系我们</a>
    <a class="line"></a>
    <a href="" target="_blank" title="诚聘英才">诚聘英才</a>
    <a class="line"></a>
    <a href="" target="_blank" title="意见反馈">意见反馈</a>
    <a class="line"></a>
    <a href="" target="_blank" title="帮助中心">帮助中心</a>
    <a class="line"></a>
    <a href="" target="_blank" title="诚信保障">诚信保障</a>
    <a class="line"></a>
    <a href="" target="_blank" title="新闻资讯">新闻资讯</a>
  </div>
  <div class="copyright wh">
    <div class="phone">
      <strong>商家入住热线</strong>
      <em>400-876-8766</em>
    </div>
    <div class="frlinks">
      <span>友情链接：</span>
      <a rel="nofollow" href="http://www.unesco.org.cn/" target="_blank" title="联合国教科文组织">联合国教科文组织</a>
      <a rel="nofollow" href="http://www.mcprc.gov.cn/" target="_blank" title="中国文化部">中国文化部</a>
      <a rel="nofollow" href="" target="_blank" title="中国文化部非物质文化遗产保护司">中国文化部非物质文化遗产保护司</a>
      <a rel="nofollow" href="" target="_blank" title="中国非物质文化遗产保护中心">中国非物质文化遗产保护中心</a>
    </div>
    <div class="info">Copyright © 2012-2022 永新华韵文化发展有限公司版权所有-京ICP备15032511号-1</div>
  </div>
</div>
<!-- //End--footer-->


<script>
  function saveProjectFllow(projectId){
    var val = $("#saveProjectFllow").val();
    var mark = false;
    var oper;
    if(val=='0'){
      oper="del";
    }else if(val=='1'){
      oper="add";
    }
    $.ajax({
      type:"get",
      url:"<c:url value='/base/attention.do?projectId='/>"+projectId+"&oper="+oper,//设置请求的脚本地址
      data:"",
      dataType:"json",
      success:function(data){
        if(data=="false"){
          alert("您还未登陆，请登录后再操作");
          return false;
        }
        if(data=="true"){
          $("#"+projectId).empty();
          $("#"+projectId).append("<input id=\"saveProjectFllow\" type=\"hidden\" value=\"0\">  <em>已关注此工艺</em>");
          mark = true;
          return true;
        }
        if(data=="del"){
          $("#"+projectId).empty();
          $("#"+projectId).append("<input id=\"saveProjectFllow\" type=\"hidden\" value=\"1\"> <i class=\"atten-icon\"></i> <em>关注此工艺</em>");
          mark = true;
          return true;
        }
        if(data=="error"){
          showAlert("提示","未知错误，请联系管理员！！！");
          return false;
        }
      },
      error:function(){

        alert("出错了，请联系管理员！！！");
        return false;
      },
      complete:function(){
        if(oper=="0" &&  mark == true){
          var val = $("#saveProjectFllow").val("1");
        }
        if(oper=="1" &&  mark == true){
          var val = $("#saveProjectFllow").val("0");
        }

      }
    });
  }


</script>
<!-- //End--footer-->
<!--[if (gte IE 9)|!(IE)]><!-->
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<!--自定义js--Start-->
<script src="<c:url value='/scripts/assets/pc/js/system.js?v=20150831'/>"></script>
<script src="<c:url value='/scripts/assets/pc/js/cyclopedia.js?v=20150831'/>"></script>
</body>
</html>


