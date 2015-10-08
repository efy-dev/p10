<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.efeiyi.ec.wiki.organization.util.AuthorizationUtil" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/22
  Time: 19:19
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
  <title>12010703大师分类-地区</title>
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
  <script type="text/javascript">
    $(document).ready(function(){
      $(".zoom,.ilike").hide();

      $(".zoom").each(function(){//遍历所有对象
        var src=$(this).siblings("img").attr("src");
        $(this).attr({href:src});
      });

      $("#nav li").click(function(){
        $("#nav a").removeClass("hover");
        $(this).find("a").addClass("hover");
      });

      $("#waterfall li").mouseover(function(){
        $(this).addClass("hover");
        $(this).find(".zoom,.ilike").show();
      });

      $("#waterfall li").mouseout(function(){
        $(this).removeClass("hover");
        $(this).find(".zoom,.ilike").hide();
      });
    });
  </script>
  <style>
    .list-con{
      margin:0 auto;
      position:relative;
    }
    .list-con .item{
      width:48%;
      height:auto;
      padding:5px;
      float:left;
    }

  </style>
</head>
<body style="position: relative">
<!--分享倒影临时-->
<div class="fxq" id="fxq" style="display: none">
  <div class="share-tip">
    <div class="tip"><a href="#" id="gb"></a><img src="<c:url value='/scripts/assets/images/bg-icon.png'/>"></div>
  </div>
  <div class="bg"></div>
</div>
<div class="great">
  <header class="am-header custom-header">
    <div class="am-header-left am-header-nav">
      <a href="javascript:window.history.go(-1);" class="chevron-left"></a>
      <%--<a href="#" class="chevron-left"></a>--%>
</div>
    <!-- //End--chevron-left-->
    <h1 class="am-header-title">${project.name}</h1>
    <!-- //End--title-->
    <div class="am-header-right am-header-nav">
      <a href="#chevron-right" class="chevron-right" id="menu">
        <i class="line"></i>
      </a>
    </div>
    <!-- //End--chevron-left-->
    <div class="menu-list" id="menu-list">
      <div class="menu-page">
        <ul class="bd">
          <li><a href="" title="首页">首页</a></li>
          <li><a href="" title="分类">消&nbsp;息</a></li>
          <li><a href="" title="个人中心">个&nbsp;人&nbsp;中&nbsp;心</a></li>
        </ul>
      </div>
    </div>
  </header>
  <!--//End--header-->
  <div class="sit-page">
    <div class="sit-suit-head">
      <div class="sit-suit-text">
        <div class="sit-suit-content">
          <div class="sit-suit-cgz">
            <div class="sit-suit-cgz-l"><a href="#" id="${project.id}" class="cgz-r-1" onclick="saveProjectFllow('${project.id}')">
              <c:if test="${flag ==true}">
                <input id="saveProjectFllow" type="hidden" value="0">
                已关注
              </c:if>
              <c:if test="${flag ==false}">
                <input id="saveProjectFllow" type="hidden" value="1">
                关注
              </c:if>
              </a></div>
            <div class="sit-suit-cgz-r"><a href="#" id="fx" class="cgz-r-r">分享</a></div>
          </div>
          <div class="sit-suit-twz"><p>${project.description}</p></div>
        </div>
        <div class="sit-suit-img"><a href="#"><img src="${project.picture_url}"></a></div>
      </div>
    </div>

    <div data-am-widget="tabs"
         class="am-tabs am-tabs-default"
            >
      <ul class="am-tabs-nav am-cf" id="brif">
        <li class="am-active"><a href="[data-tab-panel-0]"><i class="bz-icon1"></i>
          <span style="float: left;margin-left: 10px;">简介</span><i class="sod-sr"></i></a></li>
        <li class=""><a href="[data-tab-panel-1]">
          <i class="bz-icon2"></i>
          <span style="float: left;margin-left: 10px;" onclick="getData('/basic/xmj.do?qm=plistMasterProject_master&conditions=project.id:${project.id}&pageEntity.size=5&pageEntity.index=')">传承人</span><i class="sod-sr"></i>
        </a></li>
        <li class=""><a href="[data-tab-panel-2]">
          <i class="bz-icon3"></i>
          <span style="float: left;margin-left: 10px;" onclick="getData2('/basic/xmj.do?qm=plistProduct_project&conditions=project.id:${project.id}&pageEntity.size=5&pageEntity.index=')">作品</span></i>
        </a></li>
      </ul>
      <div class="am-tabs-bd">
        <div data-tab-panel-0 class="am-tab-panel am-active">
          <!--简介-->
          ${project.projectContents[0].content}
        </div>
        <div data-tab-panel-1 class="am-tab-panel ">
          <div class="vessel-inher">
            <!--传承人-->

          </div>
        </div>
        <div data-tab-panel-2 class="am-tab-panel ">
<%--          <div class="penel-container"  id="pubu">--%>
            <div class="penel-container">
            <div class="master-works">
              <div class="works-list">
                <ul class="list-con">

                  <%--<li class="item">
                    <a href="http://www.baidu.com"><img src="/scripts/assets/images/120119-6.jpg"></a>
                    <div class="txt">
                      <div class="name">春梅</div>
                      <div class="txt-info">
                        <a href="#"><i class="icon good-1"></i><em>9999</em></a>
                        <a href="#"><i class="icon good-2"></i><em>9999</em></a>
                      </div>
                    </div>
                  </li>
                 --%>



                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>


  </div>
  <!--地区-->

  <!--//End--login-reg-->

  <!--//End--footer-->
  <script>
    var startNumber =1;
    var startNumber2 =1;
    var ajaxkey =true;
    var ajaxkey2 =true;
    var isAttention = false;
    $(window).load(function(){
      var winH = $(window).height(); //页面可视区域高度
      $(window).scroll(function(){
        var pageH = $(document.body).height();
        var scrollT = $(window).scrollTop(); //滚动条top
        var aa = (pageH - winH - scrollT) / winH;
        if(aa < 0.02){
          $("#brif li").each(function(index,element){
            if($(element).attr("class")=="am-active"){
              if($(element).children().eq(0).attr("href")=="[data-tab-panel-1]"){
                if(ajaxkey){
                  getData("/basic/xmj.do?qm=plistMasterProject_master&conditions=project.id:${project.id}&pageEntity.size=5&pageEntity.index=");//jquery的Ajax异步加载数据、需要从数据库加载的、需要调用该函数
                }
              }

              if($(element).children().eq(0).attr("href")=="[data-tab-panel-2]"){
                if(ajaxkey2){
                  getData2("/basic/xmj.do?qm=plistProduct_project&conditions=project.id:${project.id}&pageEntity.size=5&pageEntity.index=");//jquery的Ajax异步加载数据、需要从数据库加载的、需要调用该函数
                }
              }
            }
          });
        }
      });
    });

    //请求数据的方法
    function getData(url){
      var flag = false;
      $.ajax({
        type:"get",//设置get请求方式
        url:url+startNumber,//设置请求的脚本地址
        data:"",//设置请求的数据
        dataType:"json",//设置请求返回的数据格式
        success:function(data){
          var  pubu =$(".vessel-inher");
          if(data.list && data.list != null){
            for(i in data.list){

              var masterid = data.list[i].master.id;
              var word ="关注";
              var opertation ="0";
              checkIsAttentionMaster(masterid);
              if(isAttention==true){
                word = "取消关注";
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
              var box = $("<div class='inheritor'> " +
                      "<div class='inheritor-text'> " +
                      "<p class='itor-text-1'>"+data.list[i].master.fullName+"</p> " +
                      "<p class='itor-text-3'>"+levelName+"</p> " +
                      "<p class='itor-text-4' style='padding-bottom: 1.5rem'>"+data.list[i].master.brief+"</p> " +
                      "<a class='gz-fd-icon'about='"+opertation+"' id='"+data.list[i].master.id+"' href='#' onclick='saveMasterFllow(\""+data.list[i].master.id+"\")'>"+word+"</a> <div class='gz-fd-img'><a href='#'>" +
                      "<img src='"+data.list[i].master.favicon+"'></a></div> </div> </div>");

              pubu.append(box);
            }

          }else{
            flag = true;
          }
          startNumber=startNumber+1;
        },
        error:function(){
          alert("出错了，请联系管理员！！！");
          return false;
        },
        complete:function(){
          if(flag==true)
            ajaxkey = false;
        }
      });


    }
    //请求数据的方法
    function getData2(url){

      var flag = false;
      $.ajax({
        type:"get",//设置get请求方式
        url:url+startNumber2,//设置请求的脚本地址
        //url:url+1,//设置请求的脚本地址
        data:"",//设置请求的数据
        dataType:"json",//设置请求返回的数据格式
        success:function(data){
          var  pubu =$(".list-con");
          if(data.list && data.list != null){
            for(i in data.list){

              var box = $(" <li class='item'> <a href='" +"<c:url value='/base/showProduct.do?productId="+data.list[i].id+"'/> "+
                      "'>" +
                      "<img src='"+data.list[i].picture_url+"'></a>" +
                      " <div class='txt'> <div class='name'>"+data.list[i].name+"</div> " +
                      "<div class='txt-info'> <a href='#'>" +
                      "<i class='icon good-1'></i>" +
                      "<em>9999</em></a> " +
                      "<a href='#'>" +
                      "<i class='icon good-2'>" +
                      "</i><em>9999</em>" +
                      "</a> </div> </div> </li>");

              pubu.append(box);
              //imgload();
            }

          }else{
            flag = true;
          }
          //PBL(".list-con",".item",1);
          startNumber2=startNumber2+1;

        },
        error:function(){
          alert("出错了，请联系管理员！！！");
          return false;
        },
        complete:function(){

          if(flag==true)
            ajaxkey2 = false;
        }
      });


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





    function saveProjectFllow(projectId){
      var val = $("#saveProjectFllow").val();
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
            $("#"+projectId).html("取消关注");
            return true;
          }
          if(data=="del"){
            $("#"+projectId).html("关注");
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
            var val = $("#saveProjectFllow").val("1");
          }
          if(oper=="1"){
            var val = $("#saveProjectFllow").val("0");
          }

        }
      });
    }

    var getStartNum=0;
    //瀑布流主函数
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
</div>
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="<c:url value='/scripts/assets/wap/js/jquery.min.js?v=20150831'/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value='/scripts/assets/js/amazeui.ie8polyfill.min.js?v=20150831'/>"></script>
<![endif]-->
<script src="<c:url value='/scripts/assets/wap/js/amazeui.min.js?v=20150831'/>"></script>
<!--自定义js--Start-->

<script src="<c:url value='/scripts/assets/js/system.js?v=20150831'/>"></script>
<script src="<c:url value='/scripts/assets/js/cyclopedia.js?v=20150831'/>"></script>
<script type="text/javascript">
 /* $(function(){

    var $waterfall = $('#waterfall');

    $waterfall.masonry({
      columnWidth: 230
    });

  });*/
 function  imgload(){
   var box = $('.item');
   var boxHeight = {
     leftBox:[],
     centerBox:[],
     rightBox:[]
   }

   for(var i=0;i<box.length;i++){
     var now = i%3;		//now的值为0，1，2

     switch(now){
       case 0:
         box.eq(i).css('left','10px');
         boxHeight.leftBox.push(box.eq(i).height());
         var now2 = Math.floor(i/3);

         if(now2==0){
           box.eq(i).css('top',0);
         }else{
           var total = 0;
           for(var j=0;j<now2;j++){
             total += boxHeight.leftBox[j]+10;
           }
           box.eq(i).css('top',total+'px')
         }

         break;

       case 1:
         box.eq(i).css('left','270px');
         boxHeight.centerBox.push(box.eq(i).height());
         var now2 = Math.floor(i/3);

         if(now2==0){
           box.eq(i).css('top',0);
         }else{
           var total = 0;
           for(var j=0;j<now2;j++){
             total += boxHeight.centerBox[j]+10;
           }
           box.eq(i).css('top',total+'px')
         }
         break;

       case 2:
         box.eq(i).css('left','530px');
         boxHeight.rightBox.push(box.eq(i).height());
         var now2 = Math.floor(i/3);

         if(now2==0){
           box.eq(i).css('top',0);
         }else{
           var total = 0;
           for(var j=0;j<now2;j++){
             total += boxHeight.rightBox[j]+10;
           }
           box.eq(i).css('top',total+'px')
         }
         break;
     }
   }

 }

</script>
<!--自定义js--End-->
</body>
</html>