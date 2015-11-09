
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
  <link rel="icon" type="image/x-icon" href="/scripts/assets/images/favicon.ico">
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
        <li><a href="<c:url value='/pc/index.do'/>" title="展览">工艺</a></li>

      </ul>
    </div>
  </div>
</div>--%>
<!-- //End--header-->
<div class="craft-details">
  <div class="craft-banner">
    <img src="http://ec-efeiyi.oss-cn-beijing.aliyuncs.com/${project.picture_pc_url}">
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
      <li ><a href="<c:url value='/project/brifProject/${project.id}'/>">介&nbsp;绍</a></li>
      <li class="active"><a href="<c:url value='/project/brifMaster/${project.id}'/>">大&nbsp;师</a></li>
      <li><a href="<c:url value='/project/listProduct/${project.id}'/>">作&nbsp;品</a></li>
    </ul>
    <div class="craft-master2 ae" style="display: block">
      <ul class="ae" id="master">

      </ul>
    </div>

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
          var go = window.confirm("去登陆吧?");
          if(go==true){
            window.location.href ="<c:url value='/brifMaster/${project.id}'/>";
          }
          else{
            return false;//取消
          }
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
  $(document).ready(function(){
    getData2("<c:url value='/basic/xmj.do?qm=plistMasterProject_master&conditions=project.id:${project.id}&pageEntity.size=12&pageEntity.index='/>");
  });

  function getData2(url){
    var flag = false;
    $.ajax({
      type:"get",//设置get请求方式
      url:url+StartNum2,//设置请求的脚本地址
      data:"",//设置请求的数据
      async:true,
      dataType:"json",//设置请求返回的数据格式
      success:function(data){
        var pubu = $("#master");
        if(data.list && data.list != null){
          for(i in data.list){

            var masterid = data.list[i].master.id;
            var word ="<i class=\"gz-icon\"></i><em>关注</em>";
            var opertation ="0";
            checkIsAttentionMaster(masterid);
            if(isAttention==true){
              word = "<em>已关注</em>";
              opertation ="1";
            }
            var level=data.list[i].master.level;
            var levelName="";
            switch (parseInt(level))
            {
              case 1:
                levelName="国家级非遗传承人";
                break;
              case 2:
                levelName="省级非遗传承人";
                break;
              case 3:
                levelName="市级非遗传承人";
                break;
              case 4:
                levelName="县级非遗传承人";
                break;

            }
            /*var box = $("<div class='inheritor'> " +
                    "<div class='inheritor-text'> " +
                    "<p class='itor-text-1'>"+data.list[i].master.fullName+"</p> " +
                    "<p class='itor-text-3'>"+levelName+"</p> " +
                    "<p class='itor-text-4' style='padding-bottom: 1.5rem'>"+data.list[i].master.brief+"</p> " +
                    "<a class='gz-fd-icon'about='"+opertation+"' id='"+data.list[i].master.id+"' href='#' onclick='saveMasterFllow(\""+data.list[i].master.id+"\")'>"+word+"</a> <div class='gz-fd-img'><a href='#'>" +
                    "<img src='"+data.list[i].master.favicon+"'></a></div> </div> </div>");*/

            var box = $(" <li> <div class=\"text\"> <h4>"+data.list[i].master.fullName+"</h4> " +
                    "<p>"+levelName+"</p> <p><span>"+data.list[i].master.brief+"</span></p> " +
                    "<a class=\"btn-guan\" href=\"#\"  about=\""+opertation+"\" onclick=\"saveMasterFllow('"+data.list[i].master.id+"')\"    id=\""+data.list[i].master.id+"\">"+word+"</a> </div> " +
                    "<div class=\"img\"><img src=\""+data.list[i].master.favicon+"\"></div> </li>");


            pubu.append(box);
          }

        }else{
          flag = true;
        }

        StartNum2=StartNum2+1;
      },
      error:function(){

        alert("出错了，请联系管理员！！！");
        return false;
      },
      complete:function(){
        if(flag==true) {
          ajaxkey = false;
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
        //alert(StartNum)
        if(ajaxkey){
          getData("<c:url value='/basic/xmj.do?qm=plistMasterProject_master&conditions=project.id:${project.id}&pageEntity.size=12&pageEntity.index='/>");
        }

      }


    });




  });



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

  function checkIsAttentionMaster(masterId){
    isAttention = false;
    $.ajax({
      type:"get",
      url:"<c:url value='/base/IsattentionMaster.do?masterId='/>"+masterId,
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


  function saveMasterFllow(masterId){
    var val = $("#"+masterId).attr("about");
    var oper;
    if(val=='1'){
      oper="del";
    }else if(val=='0'){
      oper="add";
    }
    $.ajax({
      type:"get",
      url:"<c:url value='/base/attentionMaster.do?masterId='/>"+masterId+"&oper="+oper,//设置请求的脚本地址
      data:"",
      dataType:"json",
      success:function(data){
        if(data=="false"){
          //alert("您还未登陆，请登录后再操作");
          //window.location.href ="http://passport.efeiyi.com/login?service=http://master.efeiyi.com/ef-wiki/sso.do";
          var go = window.confirm("去登陆吧?");
          if(go==true){
            window.location.href ="<c:url value='/brifMaster/${project.id}'/>";
          }
          else{
            return false;//取消
          }
          return false;
        }
        if(data=="true"){
          //$("#"+masterId).html("取消关注");
          $("#"+masterId).empty();
          $("#"+masterId).append("<em>已关注</em>");
          if(oper=="add"){
            var val = $("#"+masterId).attr("about","1");
          }
          if(oper=="del"){
            var val = $("#"+masterId).attr("about","0");
          }
          return true;
        }
        if(data=="del"){
          $("#"+masterId).empty();
          $("#"+masterId).append("<i class=\"gz-icon\"></i><em>关注</em>");
          if(oper=="add"){
            var val = $("#"+masterId).attr("about","1");
          }
          if(oper=="del"){
            var val = $("#"+masterId).attr("about","0");
          }
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

      }
    });
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
  var StartNum = 1;
  var StartNum2 = 1;
  var ajaxkey = true;//设置ajax请求的开关,如需动态加载、需要打开这个开关
  var ajaxkey2 = true;
  var isAttention = false;
  var Baseurl = "<c:url value='/pc/projectClassifyj.do?qm=plistProject_all&conditions=&pageEntity.size=10&pageEntity.index='/>";
  var  object = $("a[about='1']");
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


