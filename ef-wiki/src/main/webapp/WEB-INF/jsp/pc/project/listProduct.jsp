
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
<body style="float: left">
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
    <img src="http://ec-efeiyi.oss-cn-beijing.aliyuncs.com/${project.picture_url}">
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
      <li ><a href="<c:url value='/project/brifMaster/${project.id}'/>">大&nbsp;师</a></li>
      <li class="active"><a href="<c:url value='/project/listProduct/${project.id}'/>">作&nbsp;品</a></li>
    </ul>
    <div class="craft-work3 ae" style="display: block">

      <div class="river ae wait_photo" id="waterfall">
        <ul class="ae" id="pubu">

        </ul>
      </div>
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
          alert("未知错误，请联系管理员！！！");
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
    //getData2("<c:url value='/basic/xmj.do?qm=plistProduct_project&conditions=project.id:${project.id}&pageEntity.size=5&pageEntity.index='/>");
    //render(getElements(),true);
  });

  function getData2(url){
    var html="";
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
            var box = $("<ul><li class=\"cell craft-page\"><a href=\"<c:url value='/project/showProduct/'/>"+data.list[i].id+"\"> <img src=\"http://ec-efeiyi.oss-cn-beijing.aliyuncs.com/"+data.list[i].picture_url+"\"> " +
                    "</a><h4 class=\"ae\">"+data.list[i].name+"</h4> <div class=\"function-page ae\"> " +
                    "<div class=\"d-left\"> <a href=\"#\"> <i class=\"h-i-con\"></i> " +
                    "<span>"+data.list[i].fsAmount+"</span> </a> </div> <div class=\"d-right\"> " +
                    "<div class=\"right1\"> <a href=\"#\"> <i class=\"h-i-con2\"></i> " +
                    "<span>"+data.list[i].amount+"</span> </a> </div> <div class=\"right2\"> <a href=\"#\"> " +
                    "<i class=\"h-i-con3\"></i> </a> </div> </div> </div> </li> </ul>");


            pubu.append(box);
            html+="<li class=\"cell craft-page\"><a href=\"<c:url value='/project/showProduct/'/>"+data.list[i].id+"\"> <img src=\"http://ec-efeiyi.oss-cn-beijing.aliyuncs.com/"+data.list[i].picture_url+"\"> " +
                    "</a><h4 class=\"ae\">"+data.list[i].name+"</h4> <div class=\"function-page ae\"> " +
                    "<div class=\"d-left\"> <a href=\"#\"> <i class=\"h-i-con\"></i> " +
                    "<span>"+data.list[i].fsAmount+"</span> </a> </div> <div class=\"d-right\"> " +
                    "<div class=\"right1\"> <a href=\"#\"> <i class=\"h-i-con2\"></i> " +
                    "<span>"+data.list[i].amount+"</span> </a> </div> <div class=\"right2\"> <a href=\"#\"> " +
                    "<i class=\"h-i-con3\"></i> </a> </div> </div> </div> </li> "
          }
         //return html;
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




 /*$(window).load(function(){

   //PBL("#beforeAttention",".before",2);
   var winH = $(window).height(); //页面可视区域高度
   $(window).scroll(function(){
   var pageH = $(document.body).height();
   var scrollT = $(window).scrollTop(); //滚动条top
   var aa = (pageH - winH - scrollT) / winH;
   if(aa < 0.02){
   //alert(StartNum)
   if(ajaxkey){
  // getData2("<c:url value='/basic/xmj.do?qm=plistMasterProject_master&conditions=project.id:${project.id}&pageEntity.size=12&pageEntity.index='/>");
   getData2("<c:url value='/basic/xmj.do?qm=plistProduct_project&conditions=project.id:${project.id}&pageEntity.size=5&pageEntity.index='/>");
   }

   }


   });




   });*/



  function PBL(outer,boxs,style){//outer父级元素、boxs子级元素，style加载样式（ 1或者2 ）
    var pubu = $(outer);
    var box = $(boxs);
    //var num = Math.floor($(document.body).width()/box.outerWidth());//根据浏览器宽度获得显示的列的数量
    var num = Math.floor($(".craft-work3").width()/box.outerWidth());
    pubu.width(num*(box.outerWidth())+60);//给pubu的宽度赋值
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
<SCRIPT>
  (function($){
    var
    //参数
            setting={
              column_width:240,//列宽
              column_className:'waterfall_column',//列的类名
              column_space:10,//列间距
              cell_selector:'.cell',//要排列的砖块的选择器，context为整个外部容器
              img_selector:'img',//要加载的图片的选择器
              auto_imgHeight:true,//是否需要自动计算图片的高度
              fadein:true,//是否渐显载入
              fadein_speed:600,//渐显速率，单位毫秒
              insert_type:1, //单元格插入方式，1为插入最短那列，2为按序轮流插入
              getResource:function(index){ }  //获取动态资源函数,必须返回一个砖块元素集合,传入参数为加载的次数
            },
    //
            waterfall=$.waterfall={},//对外信息对象
            $waterfall=null;//容器
    waterfall.load_index=0, //加载次数
            $.fn.extend({
              waterfall:function(opt){
                opt=opt||{};
                setting=$.extend(setting,opt);
                $waterfall=waterfall.$waterfall=$(this);
                waterfall.$columns=creatColumn();
                render($(this).find(setting.cell_selector).detach(),false); //重排已存在元素时强制不渐显
                waterfall._scrollTimer2=null;
                $(window).bind('scroll',function(){
                  clearTimeout(waterfall._scrollTimer2);
                  waterfall._scrollTimer2=setTimeout(onScroll,300);
                });
                waterfall._scrollTimer3=null;
                $(window).bind('resize',function(){
                  clearTimeout(waterfall._scrollTimer3);
                  waterfall._scrollTimer3=setTimeout(onResize,300);
                });
                if( waterfall.load_index==0){
                  render(getElements(),true);
                }
              }
            });
    function creatColumn(){//创建列
      waterfall.column_num=calculateColumns();//列数
      //循环创建列
      var html='';
      for(var i=0;i<waterfall.column_num;i++){
        html+='<div class="'+setting.column_className+'" style="width:'+setting.column_width+'px; display:inline-block; *display:inline;zoom:1; margin-left:'+setting.column_space/2+'px;margin-right:'+setting.column_space/2+'px; vertical-align:top; overflow:hidden"></div>';
      }
      $waterfall.prepend(html);//插入列
      return $('.'+setting.column_className,$waterfall);//列集合
    }
    function calculateColumns(){//计算需要的列数
      var num=Math.floor(($waterfall.innerWidth())/(setting.column_width+setting.column_space));
      if(num<1){ num=1; } //保证至少有一列
      return num;
    }
    function render(elements,fadein){//渲染元素
      if(!$(elements).length) return;//没有元素
      var $columns = waterfall.$columns;
      $(elements).each(function(i){
        if(!setting.auto_imgHeight||setting.insert_type==2){//如果给出了图片高度，或者是按顺序插入，则不必等图片加载完就能计算列的高度了
          if(setting.insert_type==1){
            insert($(elements).eq(i),setting.fadein&&fadein);//插入元素
          }else if(setting.insert_type==2){
            insert2($(elements).eq(i),i,setting.fadein&&fadein);//插入元素
          }
          return true;//continue
        }
        if($(this)[0].nodeName.toLowerCase()=='img'||$(this).find(setting.img_selector).length>0){//本身是图片或含有图片
          var image=new Image;
          var src=$(this)[0].nodeName.toLowerCase()=='img'?$(this).attr('src'):$(this).find(setting.img_selector).attr('src');
          image.onload=function(){//图片加载后才能自动计算出尺寸
            image.onreadystatechange=null;
            if(setting.insert_type==1){
              insert($(elements).eq(i),setting.fadein&&fadein);//插入元素
            }else if(setting.insert_type==2){
              insert2($(elements).eq(i),i,setting.fadein&&fadein);//插入元素
            }
            image=null;
          }
          image.onreadystatechange=function(){//处理IE等浏览器的缓存问题：图片缓存后不会再触发onload事件
            if(image.readyState == "complete"){
              image.onload=null;
              if(setting.insert_type==1){
                insert($(elements).eq(i),setting.fadein&&fadein);//插入元素
              }else if(setting.insert_type==2){
                insert2($(elements).eq(i),i,setting.fadein&&fadein);//插入元素
              }
              image=null;
            }
          }
          image.src=src;
        }else{//不用考虑图片加载
          if(setting.insert_type==1){
            insert($(elements).eq(i),setting.fadein&&fadein);//插入元素
          }else if(setting.insert_type==2){
            insert2($(elements).eq(i),i,setting.fadein&&fadein);//插入元素
          }
        }
      });
    }
    function public_render(elems){//ajax得到元素的渲染接口
      render(elems,true);
    }
    function insert($element,fadein){//把元素插入最短列
      if(fadein){//渐显
        $element.css('opacity',0).appendTo(waterfall.$columns.eq(calculateLowest())).fadeTo(setting.fadein_speed,1);
      }else{//不渐显
        $element.appendTo(waterfall.$columns.eq(calculateLowest()));
      }
    }
    function insert2($element,i,fadein){//按序轮流插入元素
      if(fadein){//渐显
        $element.css('opacity',0).appendTo(waterfall.$columns.eq(i%waterfall.column_num)).fadeTo(setting.fadein_speed,1);
      }else{//不渐显
        $element.appendTo(waterfall.$columns.eq(i%waterfall.column_num));
      }
    }
    function calculateLowest(){//计算最短的那列的索引
      var min=waterfall.$columns.eq(0).outerHeight(),min_key=0;
      waterfall.$columns.each(function(i){
        if($(this).outerHeight()<min){
          min=$(this).outerHeight();
          min_key=i;
        }
      });
      return min_key;
    }
    function getElements(){//获取资源
      $.waterfall.load_index++;
      return setting.getResource($.waterfall.load_index,public_render);
    }
    waterfall._scrollTimer=null;//延迟滚动加载计时器
    function onScroll(){//滚动加载
      clearTimeout(waterfall._scrollTimer);
      waterfall._scrollTimer=setTimeout(function(){
        var $lowest_column=waterfall.$columns.eq(calculateLowest());//最短列
        var bottom=$lowest_column.offset().top+$lowest_column.outerHeight();//最短列底部距离浏览器窗口顶部的距离
        var scrollTop=document.documentElement.scrollTop||document.body.scrollTop||0;//滚动条距离
        var windowHeight=document.documentElement.clientHeight||document.body.clientHeight||0;//窗口高度

        if(scrollTop>=bottom-windowHeight){
          render(getElements(),true);
        }
      },100);
    }

    function onResize(){//窗口缩放时重新排列
      if(calculateColumns()==waterfall.column_num) return; //列数未改变，不需要重排
      var $cells=waterfall.$waterfall.find(setting.cell_selector);
      waterfall.$columns.remove();
      waterfall.$columns=creatColumn();
      render($cells,false); //重排已有元素时强制不渐显
    }

  })(jQuery);

</SCRIPT>

<SCRIPT>


  var html='';
  var opt={
    getResource:function(index,render){
      //index为已加载次数,render为渲染接口函数,接受一个dom集合或jquery对象作为参数。通过ajax等异步方法得到的数据可以传入该接口进行渲染，如 render(elem)
      if(index>=7) index=index%7+1;
      html=''
    /*  for(var i=20*(index-1);i<20*(index-1)+20;i++){
        var k='';
        for(var ii=0;ii<3-i.toString().length;ii++){
          k+='0';
        }
        k+=i;
        var src="http://cued.xunlei.com/demos/publ/img/P_"+k+".jpg";
        html+='<ul><li class="cell craft-page"><a href="#"><img src="'+src+'" /></a>  <h4 class="ae">双耳瓶</h4> <div class="function-page ae"> <div class="d-left"> <a href="#"> <i class="h-i-con"></i> <span>999999</span> </a> </div> <div class="d-right"> <div class="right1"> <a href="#"> <i class="h-i-con2"></i> <span>999999</span> </a> </div> <div class="right2"> <a href="#"> <i class="h-i-con3"></i> </a> </div> </div> </div> </li></ul>';


      }*/
      if(ajaxkey){
        var flag = false;
        $.ajax({
          type:"get",//设置get请求方式
          url:"<c:url value='/basic/xmj.do?qm=plistProduct_project&conditions=project.id:${project.id}&pageEntity.size=5&pageEntity.index='/>"+StartNum2,//设置请求的脚本地址
          data:"",//设置请求的数据
          async:false,

          dataType:"json",//设置请求返回的数据格式
          success:function(data){
            //var pubu = $("#pubu");
            if(data.list && data.list != null){
              for(i in data.list){
                /*var box = $("<li class=\"cell craft-page\"><a href=\"<c:url value='/project/showProduct.do?projectId=${project.id}&productId='/>"+data.list[i].id+"\"> <img src=\""+data.list[i].picture_url+"\"> " +
                        "</a><h4 class=\"ae\">"+data.list[i].name+"</h4> <div class=\"function-page ae\"> " +
                        "<div class=\"d-left\"> <a href=\"#\"> <i class=\"h-i-con\"></i> " +
                        "<span>"+data.list[i].fsAmount+"</span> </a> </div> <div class=\"d-right\"> " +
                        "<div class=\"right1\"> <a href=\"#\"> <i class=\"h-i-con2\"></i> " +
                        "<span>"+data.list[i].amount+"</span> </a> </div> <div class=\"right2\"> <a href=\"#\"> " +
                        "<i class=\"h-i-con3\"></i> </a> </div> </div> </div> </li> ");*/


                // pubu.append(box);
                html+="<ul><li class=\"cell craft-page\"><a href=\"<c:url value='/project/showProduct/'/>"+data.list[i].id+"\"> <img src=\"http://ec-efeiyi.oss-cn-beijing.aliyuncs.com/"+data.list[i].picture_url+"\"> " +
                        "</a><h4 class=\"ae\">"+data.list[i].name+"</h4> <div class=\"function-page ae\"> " +
                        "<div class=\"d-left\"> <a href=\"#\"> <i class=\"h-i-con\"></i> " +
                        "<span>"+data.list[i].fsAmount+"</span> </a> </div> <div class=\"d-right\"> " +
                        "<div class=\"right1\"> <a href=\"#\"> <i class=\"h-i-con2\"></i> " +
                        "<span>"+data.list[i].amount+"</span> </a> </div> <div class=\"right2\"> <a href=\"#\"> " +
                        "<i class=\"h-i-con3\"></i> </a> </div> </div> </div> </li></ul>"
              }
              //return html;
            }else{
              flag = true;
            }
            //PBL("#pubu",".craft-page",2);
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
      return $(html);
    },
    auto_imgHeight:true,
    insert_type:1
  }
  $('#waterfall').waterfall(opt);

</SCRIPT>





</body>
</html>


