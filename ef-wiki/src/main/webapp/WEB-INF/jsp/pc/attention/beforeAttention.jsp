
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
  <link rel="icon" type="image/x-icon" href="<c:url value='/scripts/assets/images/favicon.ico'/>">
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
<%--<div class="topbar wh" data-am-sticky>
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
        <li><a href="" title="展览">工艺</a></li>

      </ul>
    </div>
  </div>
</div>--%>
<!-- //End--header-->
<div class="craft-details ">
  <div class="nav-bars ae">
    <ul class="bars">
      <li ><a href="<c:url value='/pc/index.do'/>">热&nbsp;门</a></li>
      <%if(AuthorizationUtil.getMyUser().getId()==null || "no".equalsIgnoreCase(request.getAttribute("isShow").toString()) ){%>
      <li class="active"><a href="<c:url value='/pc/beforeAttention.do'/>">关注</a></li>
      <%}%>
      <%
        if(AuthorizationUtil.getMyUser().getId()!=null && "ok".equalsIgnoreCase(request.getAttribute("isShow").toString()) ){
      %>
      <li class="active"><a href="<c:url value='/pc/afterAttention.do'/>">关注</a></li>
      <%}%>

      <li><a href="<c:url value='/pc/category'/>">发&nbsp;现</a></li>
    </ul>
  </div>
</div>
<!--nav-bars-->
<div class="home-craft">
  <div class="craft-details">
    <%--<div class="focus wh">
      <!--轮播图-->
      <ul class="slider-main">
        <c:if test="${! empty bannerList}">
          <c:forEach var="banner" items="${bannerList}" varStatus="status">
            <c:if test="${status.index==0}">
              <li style="display: block;"><a href="#"><img src="http://ec-efeiyi.oss-cn-beijing.aliyuncs.com/${banner.imageUrl}" ></a></li>
            </c:if>
            <c:if test="${status.index!=0}">
              <li><a href="#"><img src="${banner.imageUrl}" ></a></li>
            </c:if>
          </c:forEach>

        </c:if>
      </ul>
      <ul class="slider-nav">
        <li class="active"></li>
        <li></li>
        <li></li>
      </ul>
    </div>--%>
    <!-- //End--nav-->
    <div class="cart-tabe">

      <div class="craft-gz ae" style="display: block">
        <div class="craft-wz ae"><span>共关注${fsAmount}个工艺</span></div>
        <div class="craft-ts ae"><span>您还没有关注任何工艺，下面是我们为您推荐的工艺项目</span></div>
        <div class="craft-list ae">
          <ul class="craft-l-page ae" id="beforeAttention">

          </ul>
        </div>
      </div>
    </div>
  </div>
</div>



<script>

  $(document).ready(function(){
    getData("<c:url value='/pc/prj.do?qm=plistProjectRecommended_default&conditions=&pageEntity.size=10&pageEntity.index='/>");
  });

  function getData(url){
    var flag = false;
    $.ajax({
      type:"get",//设置get请求方式
      url:url+StartNum2,//设置请求的脚本地址
      data:"",//设置请求的数据
      async:true,
      dataType:"json",//设置请求返回的数据格式
      beforeSend:function(){
        $("#loading").show();
      },
      success:function(data){
        var pubu = $("#beforeAttention");
        if(data && data.length>=1){
          for(i in data){
            var levelName="";
            switch(data[i].level)
            {
              case "1":levelName="国家级非物质文化遗产";break;
              case "2":levelName="省级非物质文化遗产";break;
              case "3":levelName="市级非物质文化遗产";break;
              default:levelName="县级非物质文化遗产";
            }
            var isA = checkIsAttention("'"+data[i].projectId+"'");
            var word ="";
            if(isA==true){
              word="<em about=\"add\" id=\""+data[i].projectId+"\">已关注</em>";
            }else{
              word="<i class=\"gz-icon\"></i> <em about=\"add\" id=\""+data[i].projectId+"\">关注</em>";
            }
              var box = $("<li class='before'> <div class='eimg'><a href=\"<c:url value='/project/brifProject/'/>"+data[i].projectId+"\"><img src='http://ec-efeiyi.oss-cn-beijing.aliyuncs.com/"+data[i].picture_pc_url+"@!pc-before-attention'></a></div> " +
                      "<div class='etext'> <p class='dz'>"+data[i].addressDistrict+"</p> " +
                      "<a href=\"<c:url value='/project/brifProject/'/>"+data[i].projectId+"\"><h5>"+data[i].projectName+"</h5></a>  " +
                      "<p>"+levelName+"</p> " +
                      "<p><a href=\"<c:url value='/project/listProduct/'/>"+data[i].projectId+"\"><strong>"+data[i].works+" 件作品</strong></a>" +
                      "<a href=\"<c:url value='/project/brifMaster/'/>"+data[i].projectId+"\"><strong>"+data[i].masters+" 位大师</strong></p></a> " +
                      "<a class='btn-guan' href='javascript:void(0);' onclick='saveProjectFllow(\""+data[i].projectId+"\")'> " +
                      "<div class='gz-q'>"+word+" </div> " +
                      "</a> </div> </li>");

            pubu.append(box);
            //PBL("#beforeAttention",".before",2);
          }

        }else{
          flag = true;
        }

        StartNum2=StartNum2+1;
        $("#loading").hide();
      },
      error:function(){

        alert("出错了，请联系管理员！！！");
        return false;
      },
      complete:function(){
        if(flag==true) {
          ajaxkey2 = false;
        }
      }
    })
  }

  $(window).load(function(){

    //PBL("#beforeAttention",".before",2);
    var winH = $(window).height(); //页面可视区域高度
    $(window).scroll(function(){
      var pageH = $(document.body).height();
      var scrollT = $(window).scrollTop(); //滚动条top
      var aa = (pageH - winH - scrollT) / winH;
      if(aa < 0.02){
        if(ajaxkey2){
          getData("<c:url value='/pc/prj.do?qm=plistProjectRecommended_default&conditions=&pageEntity.size=10&pageEntity.index='/>");
        }

      }


    });




  });

  function saveProjectFllow(projectId){
   var oper = $("#"+projectId).attr("about");
    var mark = false;
    $.ajax({
      type:"get",
      url:"<c:url value='/base/attention.do?projectId='/>"+projectId+"&oper="+oper,//设置请求的脚本地址
      data:"",
      dataType:"json",
      success:function(data){
         var parentElement =$("#"+projectId).parent().parent();
        if(data=="false"){
          //alert("您还未登陆，请登录后再操作");
          //window.location.href ="http://passport.efeiyi.com/login?service=http://master.efeiyi.com/ef-wiki/sso.do";
          var go = window.confirm("去登陆吧?");
          if(go==true){
            window.location.href ="<c:url value='/beforeAttention.do'/>";
          }
          else{
            return false;//取消
          }
          return false;
        }
        if(data=="true"){
          //$("#"+projectId).html("取消关注");
          mark = true;
          parentElement.empty();
          if(oper=="add" &&  mark == true){
            parentElement.append("<div class=\"gz-q\"> <em about=\"del\" id=\""+projectId+"\">已关注</em> </div>");
          }
          if(oper=="del" &&  mark == true){
            parentElement.append("<div class=\"gz-q\"><i class=\"gz-icon\"></i> <em about=\"add\" id=\""+projectId+"\">已关注</em> </div>");
          }


          return true;
        }
        if(data=="del"){
          //$("#"+projectId).html("关注");
          parentElement.empty();
          mark = true;
          if(oper=="add" &&  mark == true){
            parentElement.append("<div class=\"gz-q\"> <em about=\"del\" id=\""+projectId+"\">已关注</em> </div>");
          }
          if(oper=="del" &&  mark == true){
            parentElement.append("<div class=\"gz-q\"><i class=\"gz-icon\"></i> <em about=\"add\" id=\""+projectId+"\">已关注</em> </div>");
          }
          return true;
        }
        if(data=="error"){
          alert("未知错误，请联系管理员！！！");
          return false;
        }
      },
      error:function(){

        alert("出错了，请联系管理员！！！");
        return false;
      },
      complete:function(){
        /*if(oper=="add" &&  mark == true){
          var val = $("#"+projectId).attr("about","del");
        }
        if(oper=="del" &&  mark == true){
          var val = $("#"+projectId).attr("about","add");
        }*/
      }
    });
  }

  function PBL(outer,boxs,style){//outer父级元素、boxs子级元素，style加载样式（ 1或者2 ）
    var pubu = $(outer);
    var box = $(boxs);
    var num = Math.floor($(document.body).width()/box.outerWidth());//根据浏览器宽度获得显示的列的数量
    pubu.width(num*(box.outerWidth()));//给pubu的宽度赋值
    var allHeight = [];//定义一个数组存储所有列的高度
    for(var i=0;i<box.length;i++){
      if (i<num) {
        allHeight[i]=box.eq(i).outerHeight();
      }else{
        var minHeight = Math.min.apply({},allHeight);//获得所有的列中高度最小的列的高度
        var sy = getSy(minHeight,allHeight);//获取高度最小的列的索引
        getStyle(box.eq(i),minHeight,sy*box.eq(i).outerWidth(),i,style);
        allHeight[sy] += box.eq(i).outerHeight();
      }
    }
  }
  //获取高度最小的列的索引
  function getSy(minH,allH){
    for(sy in allH){
      if(allH[sy]==minH) return sy;
    }
  }

  function checkIsAttention(projectId){
    isAttention = false;
    $.ajax({
      type:"get",
      url:"<c:url value='/base/Isattention/'/>"+projectId,
      data:"",
      async:false,
      dataType:"json",
      success:function(data){
        if(data==false){
          isAttention = false;
          return false;
        }
        if(data==true){
          isAttention=true;
          return true;
        }
      },
      error:function(){

        alert("出错了，请联系管理员！！！");
        return false;
      },
      complete:function(){

      }
    })

  }




  //判断请求数据的开关
  function getDataCheck(){
    var pubu = $("#pubu");
    var box = $("#box");
    var lastboxHeight = $(box[box.length-1]).offset().top+Math.floor($(box[box.length-1]).outerHeight()/2);
    var documentHeight = $(window).height();
    var scrollTop = $(document).scrollTop();
    return lastboxHeight<documentHeight+scrollTop?true:false;
  }
  //存储开始请求数据条数的位置
  var getStartNum = 0;
  var StartNum2 = 1;
  var ajaxkey = true;//设置ajax请求的开关,如需动态加载、需要打开这个开关
  var ajaxkey2 = true;
  var  isAttention = false;
  //设置请求数据加载的样式
  function getStyle(boxs,top,left,index,style){
    if (getStartNum>=index) {
      return;
    }
    boxs.css("position","absolute");
    switch(style){
      case 1:
        boxs.css({
          "top":top+$(window).height(),
          "left":left
        });
        boxs.stop().animate({
          "top":top,
          "left":left
        },999);
        break;
      case 2:
        boxs.css({
          "top":top,
          "left":left,
          "opacity":"0"
        });
        boxs.stop().animate({
          "opacity":"1"
        },999);
    }
    getStartNum = index;//更新请求数据的条数位置

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


