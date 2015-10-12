
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
  <script src="/scripts/assets/js/jquery-2.1.3.min.js" type="text/javascript"></script>
  <style>
    #pubu{
      margin:0 auto;
      position:relative;
    }
    #pubu  .cell{
      width:250px;
      height:auto;
      padding:10px;
      float:left;
    }
  </style>
</head>
<body>
<div class="topbar wh" data-am-sticky>
  <div class="hd">
    <ul class="ul-item">
      <li><strong>李先生8899</strong><a href="" title="退出">退出</a></li>
      <li><a href="" title="请登录">请登录</a></li>
      <li><a href="" title="快速注册">快速注册</a></li>
      <li><a href="" title="商家入驻">商家入驻</a></li>
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
        <li class="" >
          <a title="商品分类">商品分类</a>
          <span class="bgbor"></span>
          <div class="nav-links">
            <ul>
              <li class="title">陶 冶 烧 造</li>
              <li><a href="" target="_blank" title="">紫砂</a></li>
              <li><a href="" target="_blank" title="">景泰蓝</a></li>
              <li><a href="" target="_blank" title="">景德镇</a></li>
              <li><a href="" target="_blank" title="">钧瓷</a></li>
              <li><a href="" target="_blank" title="">龙泉青瓷</a></li>
            </ul>
            <ul>
              <li class="title">传 统 美 术</li>
              <li><a href="" target="_blank" title="">唐卡</a></li>
              <li><a href="" target="_blank" title="">剪纸</a></li>
              <li><a href="" target="_blank" title="">书法篆刻</a></li>
              <li><a href="" target="_blank" title="">陶瓷微书</a></li>
              <li><a href="" target="_blank" title="">脸谱</a></li>
              <li><a href="" target="_blank" title="">掐丝珐琅画</a></li>
            </ul>
            <ul>
              <li class="title">金 石 錾 锻</li>
              <li><a href="" target="_blank" title="">铜雕</a></li>
              <li><a href="" target="_blank" title="">花丝镶嵌</a></li>
            </ul>
            <ul>
              <li class="title">如胶似膝</li>
              <li><a href="" target="_blank" title="">平遥漆器</a></li>
              <li><a href="" target="_blank" title="">北京雕漆</a></li>
            </ul>
            <ul>
              <li class="title">织 染 印.绣</li>
              <li><a href="" target="_blank" title="">潮绣</a></li>
              <li><a href="" target="_blank" title="">苏绣</a></li>
              <li><a href="" target="_blank" title="">顾绣</a></li>
              <li><a href="" target="_blank" title="">沈绣</a></li>
              <li><a href="" target="_blank" title="">瑶族绣</a></li>
              <li><a href="" target="_blank" title="">京绣</a></li>
              <li><a href="" target="_blank" title="">云锦</a></li>
              <li><a href="" target="_blank" title="">蜀锦</a></li>
              <li><a href="" target="_blank" title="">漳缎</a></li>
              <li><a href="" target="_blank" title="">缂丝</a></li>
              <li><a href="" target="_blank" title="">蓝印花布</a></li>
              <li><a href="" target="_blank" title="">蜡染</a></li>
            </ul>
          </div>
        </li>
        <li><a href="" title="传承人">大师</a></li>
        <li><a href="<c:url value='/pc/index.do'/>" title="展览">工艺</a></li>

      </ul>
    </div>
  </div>
</div>
<!-- //End--header-->
<div class="craft-details">
  <div class="craft-banner">
    <img src="${project.picture_url}">
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
      <li ><a href="<c:url value='/project/brifProject.do?projectId=${project.id}'/>">介&nbsp;绍</a></li>
      <li ><a href="<c:url value='/project/brifMaster.do?projectId=${project.id}'/>">大&nbsp;师</a></li>
      <li class="active"><a href="<c:url value='/project/listProduct.do?projectId=${project.id}'/>">作&nbsp;品</a></li>
    </ul>
    <div class="craft-work3 ae" style="display: block">

      <div class="river ae wait_photo" id="waterfall">
        <ul class="ae" id="pubu">

        </ul>
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
  $(document).ready(function(){
    getData2("<c:url value='/basic/xmj.do?qm=plistProduct_project&conditions=project.id:${project.id}&pageEntity.size=5&pageEntity.index='/>");
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
        var pubu = $("#pubu");
        if(data.list && data.list != null){
          for(i in data.list){
            var box = $("<li class=\"cell craft-page\"><a href=\"<c:url value='/project/showProduct.do?productId='/>"+data.list[i].id+"\"> <img src=\""+data.list[i].picture_url+"\"> " +
                    "</a><h4 class=\"ae\">"+data.list[i].name+"</h4> <div class=\"function-page ae\"> " +
                    "<div class=\"d-left\"> <a href=\"#\"> <i class=\"h-i-con\"></i> " +
                    "<span>"+data.list[i].fsAmount+"</span> </a> </div> <div class=\"d-right\"> " +
                    "<div class=\"right1\"> <a href=\"#\"> <i class=\"h-i-con2\"></i> " +
                    "<span>"+data.list[i].amount+"</span> </a> </div> <div class=\"right2\"> <a href=\"#\"> " +
                    "<i class=\"h-i-con3\"></i> </a> </div> </div> </div> </li> ");


            pubu.append(box);

          }

        }else{
          flag = true;
        }
        PBL("#pubu",".craft-page",2);
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
   getData2("<c:url value='/basic/xmj.do?qm=plistMasterProject_master&conditions=project.id:${project.id}&pageEntity.size=12&pageEntity.index='/>");
   }

   }


   });




   });



  function PBL(outer,boxs,style){//outer父级元素、boxs子级元素，style加载样式（ 1或者2 ）
    var pubu = $(outer);
    var box = $(boxs);
    //var num = Math.floor($(document.body).width()/box.outerWidth());//根据浏览器宽度获得显示的列的数量
    var num = Math.floor(pubu.outerWidth()/box.outerWidth());
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
      url:"/base/Isattention.do?projectId="+projectId,
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
      url:"/base/IsattentionMaster.do?masterId="+masterId,
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
      url:"/base/attentionMaster.do?masterId="+masterId+"&oper="+oper,//设置请求的脚本地址
      data:"",
      dataType:"json",
      success:function(data){
        if(data=="false"){
          alert("您还未登陆，请登录后再操作");
          return false;
        }
        if(data=="true"){
          $("#"+masterId).html("取消关注");
          return true;
        }
        if(data=="del"){
          $("#"+masterId).html("关注");
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
        if(oper=="0"){
          var val = $("#"+masterId).attr("about","1");
        }
        if(oper=="1"){
          var val = $("#"+masterId).attr("about","0");
        }
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
          "left":left+10*(index+1),
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

