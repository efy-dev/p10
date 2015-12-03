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

  <title>工艺详情介绍</title>

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
          <li><a href="<c:url value='/base/home.do'/>" title="首页">首页</a></li>
          <li><a href="javascript:void(0);" title="分类" id="acs">消&nbsp;息</a></li>
          <li><a href="http://i.efeiyi.com" title="个人中心">个&nbsp;人&nbsp;中&nbsp;心</a></li>
        </ul>
      </div>
    </div>
  </header>
  <div style="display: none" id="showMessage" class="pops-up">
    <div style="background: #fff;position: relative;z-index:2;"  data-am-widget="tabs" class="am-tabs am-tabs-default am-no-layout">
      <ul class="am-tabs-nav am-cf">
        <%-- <li class="am-active"><a href="[data-tab-panel-0]"><i class="bz-icon1"></i>
           <span style="float: left;margin-left: 10px;">关注</span><i class="sod-sr"></i></a></li>--%>
        <li class="am-active"><a href="[data-tab-panel-0]">
          <i class="bz-icon2"></i>
          <span style="float: left;margin-left: 10px;">评论</span><i class="sod-sr"></i>
        </a></li>
        <li class=""><a href="[data-tab-panel-1]">
          <i class="bz-icon3"></i>
          <span style="float: left;margin-left: 10px;">点赞</span>
        </a></li>
      </ul>
      <div class="am-tabs-bd" style="touch-action: pan-y; -webkit-user-select: none; -webkit-user-drag: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);">

        <div data-tab-panel-0="" class="am-tab-panel am-active">
          <div class="discuss">
            <ul class="discuss-2" id="newcommentList">

            </ul>
            <div class="more"><a href="javascript:void(0);" onclick="getCommentList()"><i class="time-1"></i>查看更多评论</a></div>
          </div>
        </div>
        <div data-tab-panel-1="" class="am-tab-panel ">
          <div class="discuss">
            <ul class="discuss-2" id="newPraiseList">

            </ul>
            <div class="more"><a href="javascript:void(0);" onclick="getPraiseList()"><i class="time-1"></i>查看更多点赞</a></div>
          </div>
        </div>
      </div>
    </div>
    <div class="bg" ></div>
  </div>
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
        <div class="sit-suit-img"><a href="#"><img src="http://pro.efeiyi.com/${project.picture_wap_url}"></a></div>
      </div>
    </div>

    <div data-am-widget="tabs"
         class="am-tabs am-tabs-default"
            >
      <ul class="am-tabs-nav am-cf" id="brif">
        <li class=""><a href="[data-tab-panel-2]"><i class="bz-icon1"></i>
          <span style="float: left;margin-left: 10px;">简介</span><i class="sod-sr"></i></a></li>
        <li class=""><a href="[data-tab-panel-1]">
          <i class="bz-icon2"></i>
          <span style="float: left;margin-left: 10px;" onclick="getData('<c:url value='/basic/xmj.do?qm=plistMasterProject_master&conditions=project.id:${project.id}&pageEntity.size=5&pageEntity.index='/>')">传承人</span><i class="sod-sr"></i>
        </a></li>
        <li class="am-active"><a href="[data-tab-panel-0]">
          <i class="bz-icon3"></i>
          <span style="float: left;margin-left: 10px;">作品</span></i>
        </a></li>
      </ul>
      <div class="am-tabs-bd">
        <div data-tab-panel-2 class="am-tab-panel ">
          <!--简介-->
          ${project.projectContents[0].content}
        </div>
        <div data-tab-panel-1 class="am-tab-panel ">
          <div class="vessel-inher">
            <!--传承人-->

          </div>
        </div>
        <div data-tab-panel-0 class="am-tab-panel am-active">
<%--          <div class="penel-container"  id="pubu">--%>
            <div class="penel-container">
            <div class="master-works">
              <div class="works-list"  id="waterfall">

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

    window.onload = function autoclick(){
      $("#showworks").trigger("click");
    }
    var startNumber =1;
    var startNumber2 =1;
    var ajaxkey =true;
    var ajaxkey2 =true;
    var isAttention = false;
    /*$(window).load(function(){
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
                  getData("<c:url value='/basic/xmj.do?qm=plistMasterProject_master&conditions=project.id:${project.id}&pageEntity.size=5&pageEntity.index='/>");//jquery的Ajax异步加载数据、需要从数据库加载的、需要调用该函数
                }
              }

              if($(element).children().eq(0).attr("href")=="[data-tab-panel-2]"){
                if(ajaxkey2){
                  getData2("<c:url value='/basic/xmj.do?qm=plistProduct_project&conditions=project.id:${project.id}&pageEntity.size=5&pageEntity.index='/>");//jquery的Ajax异步加载数据、需要从数据库加载的、需要调用该函数
                }
              }
            }
          });
        }
      });
    });*/

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
                      "<a href=\"http://"+data.list[i].master.name+".efeiyi.com\"><p class='itor-text-1'>"+data.list[i].master.fullName+"</p></a> " +
                      "<p class='itor-text-3'>"+levelName+"</p> " +
                      "<p class='itor-text-4' style='padding-bottom: 1.5rem'>"+data.list[i].master.brief+"</p> " +
                      "<a class='gz-fd-icon'about='"+opertation+"' id='"+data.list[i].master.id+"' href='javascript:void(0);' onclick='saveMasterFllow(\""+data.list[i].master.id+"\")'>"+word+"</a> <div class='gz-fd-img'><a href=\"http://"+data.list[i].master.name+".efeiyi.com\">" +
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

              var box = $(" <li class='item'> <a href='" +"<c:url value='/base/showProduct/"+data.list[i].id+"}'/> "+
                      "'>" +
                      "<img src='http://pro.efeiyi.com/"+data.list[i].picture_url+"'></a>" +
                      " <div class='txt'> <div class='name'>"+data.list[i].name+"</div> " +
                      "<div class='txt-info'> <a href='#'>" +
                      "<i class='icon good-1'></i>" +
                      "<em>"+data.list[i].amount+"</em></a> " +
                      "<a href='#'>" +
                      "<i class='icon good-2'>" +
                      "</i><em>"+data.list[i].fsAmount+"</em>" +
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
        url:"/base/attentionMaster.do?masterId="+masterId+"&oper="+oper,//设置请求的脚本地址
        data:"",
        async:true,
        dataType:"json",
        success:function(data){
          if(data=="false"){
            //alert("您还未登录，请登录后再操作");
            var go = window.confirm("去登录吧?");
            if(go==true){
              window.location.href ="<c:url value='/brifProject2/${project.id}'/>";
            }
            else{
              return false;//取消
            }
            return false;
          }
          if(data=="true"){
            if(oper=="add"){
              $("#"+masterId).attr("about","1");
            }
            if(val=="del"){
             $("#"+masterId).attr("about","0");
            }
            $("#"+masterId).html("取消关注");
            return true;
          }
          if(data=="del"){
            if(oper=="add"){
              $("#"+masterId).attr("about","1");
            }
            if(val=="del"){
              $("#"+masterId).attr("about","0");
            }
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

        }
      });
    }





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
        async:true,
        dataType:"json",
        success:function(data){
          if(data=="false"){
            //alert("您还未登录，请登录后再操作");
            var go = window.confirm("去登录吧?");
            if(go==true){
              window.location.href ="<c:url value='/brifProject2/${project.id}'/>";
            }
            else{
              return false;//取消
            }
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

    function transdate(endTime){
      var timestamp = Date.parse(new Date());
      var oldTime = parseInt(endTime);
      var intervalTime = (timestamp+1000 - oldTime)/1000/60;
      var showTime = "";
      if(intervalTime<=59){
        showTime=intervalTime.toFixed(0)+"分钟前";
      }else if(1<=(intervalTime/60) && (intervalTime/60)<24){
        showTime=(intervalTime/60).toFixed(0)+"小时前";
      }else if(1<=(intervalTime/60/24) && (intervalTime/60/24)<=30){
        showTime=(intervalTime/60/24).toFixed(0)+"天前";
      }else{
        showTime=new Date(oldTime).toLocaleString().replace(/:\d{1,2}$/,' ');
      }
      return showTime;
    }


  </script>







</div>







<SCRIPT>
  (function($){
    var
    //参数
            setting={
              column_width:140,//列宽
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
      if(num<2){ num=2; } //保证至少有一列
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
          //render(getElements(),true);
          $("#brif li").each(function(index,element){
            if($(element).attr("class")=="am-active"){
              if($(element).children().eq(0).attr("href")=="[data-tab-panel-1]"){
                if(ajaxkey){
                  getData("<c:url value='/basic/xmj.do?qm=plistMasterProject_master&conditions=project.id:${project.id}&pageEntity.size=5&pageEntity.index='/>");//jquery的Ajax异步加载数据、需要从数据库加载的、需要调用该函数
                }
              }

              if($(element).children().eq(0).attr("href")=="[data-tab-panel-0]"){
                if(ajaxkey2){
                  //getData2("<c:url value='/basic/xmj.do?qm=plistProduct_project&conditions=project.id:${project.id}&pageEntity.size=5&pageEntity.index='/>");//jquery的Ajax异步加载数据、需要从数据库加载的、需要调用该函数
                  render(getElements(),true);
                }
              }
            }
          });
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

      if(ajaxkey){
        var flag = false;
        $.ajax({
          type:"get",//设置get请求方式
          url:"<c:url value='/basic/xmj.do?qm=plistProduct_project&conditions=project.id:${project.id}&pageEntity.size=5&pageEntity.index='/>"+startNumber2,//设置请求的脚本地址
          data:"",//设置请求的数据
          async:false,

          dataType:"json",//设置请求返回的数据格式
          success:function(data){
            //var pubu = $("#pubu");
            if(data.list && data.list != null){
              for(i in data.list){


                /*html+= "<ul class=\"list-con\" id=\"pubu\"><li class=\"cell item\"> <a href=\"<c:url value='/project/showProduct/'/>"+data.list[i].id+"\">" +
                        "<img src=\"http://pro.efeiyi.com/"+data.list[i].picture_url+"\"></a> <div class=\"txt\"> " +
                        "<div class=\"name\">"+data.list[i].name+"</div> <div class=\"txt-info\"> " +
                        "<a href=\"#\"><i class=\"icon good-1\"></i><em>"+data.list[i].fsAmount+"</em></a> " +
                        "<a href=\"#\"><i class=\"icon good-2\"></i><em>"+data.list[i].amount+"</em></a> " +
                        "</div> </div> </li></ul>";*/
                html+= "<ul class=\"list-con\" id=\"pubu\"><li class=\"cell item\"> <a href=\"<c:url value='/project/showProduct/'/>"+data.list[i].id+"\">" +
                        "<img src=\"http://pro.efeiyi.com/"+data.list[i].picture_url+"\"></a> <div class=\"txt\"> " +
                        "<div class=\"name\">"+data.list[i].name+"</div> <div class=\"txt-info\"> " +
                        "<a href=\"javascript:void(0);\" onclick=\"savaUpAndDown('"+data.list[i].id+"')\" id=\""+data.list[i].id+"\" name=\"up\" ><i class=\"icon good-1\"></i><em>"+data.list[i].fsAmount+"</em></a> " +
                        "<a href=\"#\"><i class=\"icon good-2\"></i><em>"+data.list[i].amount+"</em></a> " +
                        "</div> </div> </li></ul>";


              }
              //return html;
            }else{
              flag = true;
            }
            //PBL("#pubu",".craft-page",2);
            startNumber2=startNumber2+1;
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




<script type="text/javascript">

 var commentNumber = 1;
 var praiseNumber = 1;
 function getCommentList(){
   $.ajax({
     type:"get",
     url:"<c:url value='/comment/getCommentList.do?pageEntity.size=5&pageEntity.index='/>"+commentNumber,
     data:"",
     dataType:"json",
     success:function(data){
       if(data && data.length>=1){
         for(i in data){
           var  pubu =$("#newcommentList");
           var cTime =transdate(data[i].createDateTime);
           var userName = data[i].user.name2;
           if(userName==null){
             userName ="匿名用户";
           }

           var box = $("<li class=\"review\"><div class=\"matter\"> <p class=\"text-h1\">" +
                   "<a href=\"#\">"+userName+"</a>回复了你</p> " +
                   "<p class=\"text-time\">"+cTime+"</p> <p class=\"text-content\">" +
                   "<a href=\"javascript:void(0);\" onclick=\"gotoWatch('"+data[i].id+"','"+data[i].product+"')\">"+data[i].content+"</a></p> " +
                   "<div class=\"owner\"><img class=\"am-circle\" src=\"/scripts/assets/images/120102-p1-11.jpg\"></div></div> </li>");
           pubu.append(box);

         }

       }else{
         flag = true;
       }

     },
     error:function(){
       alert("出错了，请联系管理员！！！");
       return false;
     },
     complete:function(){
       commentNumber =commentNumber+1;
     }
   });

 }
 function getPraiseList(){
   $.ajax({
     type:"get",
     url:"<c:url value='/praise/getPraiseList.do?pageEntity.size=10&pageEntity.index='/>"+praiseNumber,
     data:"",
     dataType:"json",
     success:function(data){
       if(data && data.length>=1){
         for(i in data){
           var  pubu =$("#newPraiseList");
           var cTime =transdate(data[i].createDateTime);
           var userName = data[i].user.name2;
           if(userName==null){
             userName ="匿名用户";
           }

           var box = $("<li class=\"review\"> <div class=\"matter\"> <p class=\"text-h1\">"+userName+"</p> " +
                   "<p class=\"text-time\">"+cTime+"</p> <p class=\"text-content\">" +
                   "<a href=\"javascript:void(0);\" onclick=\"watchPraise('"+data[i].id+"','"+data[i].product+"')\">觉得你的评论“还不错”很赞</a></p> <div class=\"owner\">" +
                   "<img class=\"am-circle\" src=\"/scripts/assets/images/120102-p1-11.jpg\"></div> </div> " +
                   "</li>");
           pubu.append(box);

         }

       }else{
         flag = true;
       }

     },
     error:function(){
       alert("出错了，请联系管理员！！！");
       return false;
     },
     complete:function(){
       praiseNumber =praiseNumber+1;
     }
   });

 }
 $(document).ready(function(){
   getCommentList();
   getPraiseList();
 });
 function gotoWatch(data1,data2){
   $.ajax({
     type:"get",
     url:"<c:url value='/comment/watchComment.do?commentId='/>"+data1,
     data:"",
     dataType:"json",
     success:function(o){
       window.location.href="<c:url value='/project/showProduct/'/>"+data2+"/"+data1;
     },
     error:function(){
       alert("出错了，请联系管理员！！！");
       return false;
     },
     complete:function(){
     }
   });
 }
 function watchPraise(data1,data2){
   $.ajax({
     type:"get",
     url:"<c:url value='/praise/watchPraise.do?commentId='/>"+data1,
     data:"",
     dataType:"json",
     success:function(o){
       window.location.href="<c:url value='/project/showProduct/'/>"+data2+"/"+data1;
     },
     error:function(){
       alert("出错了，请联系管理员！！！");
       return false;
     },
     complete:function(){
     }
   });
 }
 function savaUpAndDown(ds){
   var oper = $("#"+ds).attr("name");
   $.ajax({
     type:"get",
     url:"<c:url value='/base/saveThumbUp.do?productId='/>"+ds+"&operation="+oper,
     data:"",
     dataType:"json",
     success:function(data2){
       if(data2=="false"){
         //alert("您还未登录，请登录后再操作！！！");
         var go = window.confirm("去登录吧?");
         if(go==true){
           window.location.href ="<c:url value='/wapbrifProject/${project.id}'/>";
         }
         else{
           return false;//取消
         }
         return false;
       }
       if(data2=="repeat"){
         alert("您已经赞过了");
         return false;
       }
       if(data2=="true" && oper=='up'){
         //$("#em1").html(parseInt($("#em1").text())+1);
         $("#"+ds).children("em").eq(0).html(parseInt($("#"+ds).children("em").eq(0).text())+1);
         if($("#"+ds).attr("name")=="down"){
           $("#"+ds).attr("name","up");
         }else{
           $("#"+ds).attr("name","down");
         }
       }
       if(data2=="true" && oper=='down'){
         $("#"+ds).children("em").eq(0).html(parseInt($("#"+ds).children("em").eq(0).text())-1);
         // $("#em1").html(parseInt($("#em1").text())-1);
         if($("#"+ds).attr("name")=="down"){
           $("#"+ds).attr("name","up");
         }else{
           $("#"+ds).attr("name","down");
         }
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
</script>
<!--自定义js--End-->
</body>
</html>