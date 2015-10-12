
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
        <li><a href="" title="展览">工艺</a></li>

      </ul>
    </div>
  </div>
</div>
<!-- //End--header-->
<div class="craft-details ">
  <div class="nav-bars ae">
    <ul class="bars">
      <li ><a href="<c:url value='/pc/index.do'/>">动&nbsp;态</a></li>
      <%if(AuthorizationUtil.getMyUser().getId()==null || "no".equalsIgnoreCase(request.getAttribute("isShow").toString()) ){%>
      <li><a href="<c:url value='/pc/beforeAttention.do'/>">关注</a></li>
      <%}%>
      <%
        if(AuthorizationUtil.getMyUser().getId()!=null && "ok".equalsIgnoreCase(request.getAttribute("isShow").toString()) ){
      %>
      <li ><a href="<c:url value='/pc/afterAttention.do'/>">已关注</a></li>
      <%}%>

      <li class="active"><a href="<c:url value='/category.do'/>">发&nbsp;现</a></li>
    </ul>
  </div>
</div>
<!--nav-bars-->
<div class="list-find">
  <div class="list-f-title">
    <p><a>工艺</a><i class="fu-icon"></i><span>发现</span></p>
  </div>
  <div class="list-f-select">
    <div class="f-select-group">
      <div class="select-head">
        <span>分类：</span>
        <strong><a href="#" class="" about="1" onclick="getData(this,'<c:url value='/pc/projectClassifyj.do?qm=plistProject_allCategory&conditions=&pageEntity.size=10&pageEntity.index='/>')">全部</a></strong>
      </div>
      <ul class="select-list">

        <c:if test="${!empty ProjectCategoryList}">
          <c:forEach var="catagory" items="${ProjectCategoryList}" varStatus="status">
            <c:if test="${status.index==0}">
              <li><a href="#" class="active" about="0" onclick="getData(this,'<c:url value='/pc/projectClassifyj.do?qm=plistProject_Category&conditions=&pageEntity.size=10&pageEntity.index='/>')">${catagory.name}</a></li>
            </c:if>
            <c:if test="${status.index!=0}">
              <li><a href="#" about="0" onclick="getData(this,'<c:url value='/pc/projectClassifyj.do?qm=plistProject_Category&conditions=&pageEntity.size=10&pageEntity.index='/>')">${catagory.name}</a></li>
            </c:if>
          </c:forEach>

        </c:if>
      </ul>
    </div>
    <div class="f-select-group">
      <div class="select-head">
        <span>级别：</span>
        <strong><a href="#" class="active" about="0" onclick="getData(this,'<c:url value='/pc/projectClassifyj.do?qm=plistProject_all&conditions=&pageEntity.size=10&pageEntity.index='/>')">全部</a></strong>
      </div>
      <ul class="select-list">
        <li><a href="#" class="" about="0" onclick="getData(this,'<c:url value='/pc/projectClassifyj.do?qm=plistProject_level&conditions=level:1&pageEntity.size=10&pageEntity.index='/>')">国家级</a></li>
        <li><a href="#" class="" about="0" onclick="getData(this,'<c:url value='/pc/projectClassifyj.do?qm=plistProject_level&conditions=level:2&pageEntity.size=10&pageEntity.index='/>')">省级</a></li>
        <li><a href="#" class="" about="0" onclick="getData(this,'<c:url value='/pc/projectClassifyj.do?qm=plistProject_level&conditions=level:3&pageEntity.size=10&pageEntity.index='/>')">市级</a></li>
        <li><a href="#" class="" about="0" onclick="getData(this,'<c:url value='/pc/projectClassifyj.do?qm=plistProject_level&conditions=level:4&pageEntity.size=10&pageEntity.index='/>')">县级</a></li>
      </ul>
    </div>
    <div class="f-select-group cl-act">
      <div class="select-head">
        <span>地区：</span>
        <strong><a href="#" class="active" about="0" onclick="getData(this,'<c:url value='/pc/projectClassifyj.do?qm=plistProject_allDirt&conditions=&pageEntity.size=10&pageEntity.index='/>')">全部</a></strong>
      </div>
      <ul class="select-list">
        <c:if test="${!empty AddressProvinceList}">
          <c:forEach var="ap" items="${AddressProvinceList}" varStatus="status">
            <li><a href="#" class="" about="0" onclick="getData(this,'<c:url value='/pc/projectClassifyj.do?qm=plistProject_Dirt&conditions=&pageEntity.size=10&pageEntity.index='/>')">${ap.name}</a></li>
          </c:forEach>
        </c:if>
      </ul>
    </div>
  </div>
  <div class="list-f-content">
    <div class="l-f-left">
      <ul class="grounp-f" id="classify">

      </ul>
    </div>
    <div class="l-f-right">
      <div class="f-right-gy ae">
        <div class="h4"><span>热门工艺</span></div>
        <ul class="gy-grounp ae" id="hot">

        </ul>
        <div class="f-r-gd ae"><a href="#" onclick="getMoreHotProject()"><span>更多工艺</span><i class="sp-icon"></i></a></div>
      </div>
      <div class="f-right-gy ae">
        <div class="h4"><span>新加入工艺</span></div>
        <ul class="gy-grounp ae" id="new">

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

<script>

  $(document).ready(function(){
    getData(object,"<c:url value='/pc/projectClassifyj.do?qm=plistProject_all&conditions=&pageEntity.size=10&pageEntity.index='/>");
    getData2("<c:url value='/pc/projectClassifyj.do?qm=plistProjectRecommended_default&conditions=&pageEntity.size=6&pageEntity.index='/>");
    getData3("<c:url value='/pc/projectClassifyj.do?qm=plistProjectRecommended_default&conditions=&pageEntity.size=6&pageEntity.index='/>");
  });

  function getData(e,url){
    judgeStartNum(e,url);
    var flag = false;
    $.ajax({
      type:"get",//设置get请求方式
      url:url+StartNum,//设置请求的脚本地址
      data:"",//设置请求的数据
      async:true,
      dataType:"json",//设置请求返回的数据格式
      success:function(data){
        var pubu = $("#classify");
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
              word="取消关注";
            }else{
              word="关注";
            }
         /*   var box = $("<li class='before'> <div class='eimg'><a href='#'><img src='"+data[i].picture_url+"'></a></div> " +
                    "<div class='etext'> <p class='dz'>"+data[i].addressDistrict+"</p> " +
                    "<h5>"+data[i].projectName+"</h5>  " +
                    "<p>"+levelName+"</p> " +
                    "<p><strong>"+data[i].works+" 件作品</strong>" +
                    "<strong>"+data[i].masters+" 位大师</strong></p> " +
                    "<a class='btn-guan' href='#' onclick='saveProjectFllow(\""+data[i].projectId+"\")'> " +
                    "<div class='gz-q'> <i class='gz-icon'></i> <em about='add' id='"+data[i].projectId+"'>"+word+"</em> </div> " +
                    "</a> </div> </li>");*/
           var box = $("<li> <dl> <dt><a href=\"#\"><img src=\""+data[i].picture_url+"\"></a> " +
                   "<div class=\"list-moods\"> <a href=\"#\"><i class=\"img-icon\"></i></a> " +
                   "<em>"+data[i].fsAmount+"</em> </div></dt> <dd> <div class=\"text1\"><span>"+data[i].addressDistrict+"</span></div> " +
                   "<div class=\"text2\"><span>"+data[i].projectName+"</span></div>  <p>"+levelName+"</p> " +
                   "<p style='height:112px;overflow: hidden'>"+data[i].description+"</p> " +
                   "<div class=\"text3\"><span>"+data[i].works+" 件作品</span>" +
                   "<span>"+data[i].masters+"位大师</span></div> " +
                   "<a href=\"#\" class=\"text4\" onclick='saveProjectFllow(\""+data[i].projectId+"\")'><em about='add' id='"+data[i].projectId+"'>"+word+"</em></a> " +
                   "</dd> </dl> </li> ");
            pubu.append(box);
            //PBL("#beforeAttention",".before",2);
          }

        }else{
          flag = true;
        }

        StartNum=StartNum+1;
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
  function getData2(url){
    var flag = false;
    $.ajax({
      type:"get",//设置get请求方式
      url:url+StartNum2,//设置请求的脚本地址
      data:"",//设置请求的数据
      async:true,
      dataType:"json",//设置请求返回的数据格式
      success:function(data){
        var pubu = $("#hot");
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
              word="取消关注";
            }else{
              word="关注";
            }

            var box = $("<li> <div class=\"text\"> <p class=\"p1\">"+data[i].projectName+"</p> <p class=\"p2\">"+levelName+"</p> </div> " +
                    "<div class=\"bt-gz\"> <a class=\"btn-guan\" href=\"#\" onclick='saveProjectFllow(\""+data[i].projectId+"\")'> <i class=\"gz-icon\"></i> " +
                    "<em about=\"add\" id=\""+data[i].projectId+"\">"+word+"</em> </a> </div> <div class=\"img-q\"> <a href=\"#\">" +
                    "<img src=\""+data[i].picture_url+"\"></a> </div>");
            pubu.append(box);

            //PBL("#beforeAttention",".before",2);
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
  function getData3(url){
    var flag = false;
    $.ajax({
      type:"get",//设置get请求方式
      url:url+StartNum2,//设置请求的脚本地址
      data:"",//设置请求的数据
      async:true,
      dataType:"json",//设置请求返回的数据格式
      success:function(data){
        var pubu = $("#new");
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
              word="取消关注";
            }else{
              word="关注";
            }

            var box = $("<li> <div class=\"text\"> <p class=\"p1\">"+data[i].projectName+"</p> <p class=\"p2\">"+levelName+"</p> </div> " +
                    "<div class=\"bt-gz\"> <a class=\"btn-guan\" href=\"#\" onclick='saveProjectFllow(\""+data[i].projectId+"\")'> <i class=\"gz-icon\"></i> " +
                    "<em about=\"add\" id=\""+data[i].projectId+"\">"+word+"</em> </a> </div> <div class=\"img-q\"> <a href=\"#\">" +
                    "<img src=\""+data[i].picture_url+"\"></a> </div>");
            pubu.append(box);

            //PBL("#beforeAttention",".before",2);
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
  //判断:当前元素是否是被筛选元素的子元素
  $.fn.isChildOf = function(b){
    return (this.parents(b).length > 0);
  };
  //判断:当前元素是否是被筛选元素的子元素或者本身
  $.fn.isChildAndSelfOf = function(b){
    return (this.closest(b).length > 0);
  };
// 判断是否属于统一标签
  function judgeStartNum(o,url){
   if($(o).isChildAndSelfOf(object)){

   }else{
     ajaxkey2=true;
     Baseurl =url;
     $("#classify").empty();
     StartNum = 1;
     $(object).attr("about","0");
     $(o).attr("about","1");
     object = o;
   }
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
        if(ajaxkey2){
          getData($("a[about='1']"),Baseurl);
        }

      }


    });




  });

  function saveProjectFllow(projectId){
    var oper = $("#"+projectId).attr("about");
    var mark = false;
    $.ajax({
      type:"get",
      url:"<c:url value='/base/attention.do?projectId='/>"+projectId+"oper"+oper,//设置请求的脚本地址
      data:"",
      dataType:"json",
      success:function(data){

        if(data=="false"){
          alert("您还未登陆，请登录后再操作");
          return false;
        }
        if(data=="true"){
          $("#"+projectId).html("取消关注");
          mark = true;
          return true;
        }
        if(data=="del"){
          $("#"+projectId).html("关注");
          mark = true;
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
        if(oper=="add" &&  mark == true){
          var val = $("#"+projectId).attr("about","del");
        }
        if(oper=="del" &&  mark == true){
          var val = $("#"+projectId).attr("about","add");
        }

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

  function getMoreHotProject(){
   if(ajaxkey == true){
     getData2("<c:url value='/pc/projectClassifyj.do?qm=plistProjectRecommended_default&conditions=&pageEntity.size=6&pageEntity.index='/>");
   }
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


