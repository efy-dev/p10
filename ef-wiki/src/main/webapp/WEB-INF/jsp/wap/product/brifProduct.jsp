<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/24
  Time: 11:07
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
  <title>商品详情</title>
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
</head>
<body style="position: relative;">
<%--<header class="am-header custom-header">--%>
  <%--<div class="am-header-left am-header-nav">--%>
    <%--<a href="javascript:window.history.go(-1);" class="chevron-left"></a>--%>
  <%--</div>--%>
  <%--<!-- //End--chevron-left-->--%>
  <%--<h1 class="am-header-title">${product.project.name}</h1>--%>
  <%--<!-- //End--title-->--%>
  <%--<div class="am-header-right am-header-nav">--%>
    <%--<a href="#chevron-right" class="chevron-right" id="menu">--%>
      <%--<i class="line"></i>--%>
    <%--</a>--%>
  <%--</div>--%>
  <%--<!-- //End--chevron-left-->--%>
  <%--<div class="menu-list">--%>
    <%--<div class="menu-page">--%>
      <%--<ul class="bd">--%>
        <%--<li><a href="" title="首页">首页</a></li>--%>
        <%--<li><a href="" title="分类">消&nbsp;息</a></li>--%>
        <%--<li><a href="" title="个人中心">个&nbsp;人&nbsp;中&nbsp;心</a></li>--%>
      <%--</ul>--%>
    <%--</div>--%>
  <%--</div>--%>
<%--</header>--%>
<header class="am-header custom-header">
  <div class="am-header-left am-header-nav">
    <a href="javascript:window.history.go(-1);" class="chevron-left"></a>
  </div>
  <!-- //End--chevron-left-->
  <h1 class="am-header-title">景泰蓝工艺</h1>
  <!-- //End--title-->
  <div class="am-header-right am-header-nav">
    <a href="#chevron-right" class="chevron-right" id="menu">
      <i class="line"></i>
    </a>
    <a href="#chevron-right" class="chevron-right" id="menu2" style="display: none;">
      <i class="line active"></i>
    </a>
  </div>
  <!-- //End--chevron-left-->
  <div class="menu-list">
    <div class="menu-page">
      <ul class="bd">
        <li><a href="" title="首页">首页</a></li>
        <li><a href="" title="分类">消&nbsp;息</a></li>
        <li><a href="" title="个人中心">个&nbsp;人&nbsp;中&nbsp;心</a></li>
      </ul>
    </div>
  </div>
</header>

<div class="work-details" id="work-details">
  <p class="ptext1">${product.subName}</p>
  <c:if test="${!empty product.productPictureList}">
    <c:forEach items="${product.productPictureList}" var="productPictureList">
      <div class="pimg1"><img src="${productPictureList.pictureUrl}"></div>
    </c:forEach>
  </c:if>
${product.productDescription.content}
  <!--购买-->
  <div class="purchase-inheritor">
    <a href="#">我&nbsp;要&nbsp;购&nbsp;买</a>
  </div>
  <!--购买-->
  <div class="inheritor ">

    <div class="inheritor-text">
      <p class="itor-text-1">${product.master.fullName}</p>

      <p class="itor-text-2">${product.name}</p>

      <p class="itor-text-3">
        <c:choose>
          <c:when test="${product.master.level == '1'}">
            国家级非遗传承人
          </c:when>
          <c:when test="${product.master.level == '2'}">
            省级非遗传承人
          </c:when>
          <c:when test="${product.master.level == '3'}">
            市级非遗传承人
          </c:when>
          <c:otherwise>
            县级非遗传承人
          </c:otherwise>
        </c:choose>

      </p>

      <p class="itor-text-4">${product.master.brief}</p>
      <a class="gz-fd-icon" href="#" onclick="saveMasterFllow(${product.master.id})">
        <c:if test="${flag == true}">
          已关注
        </c:if>
        <c:if test="${flag == false}">
          关注
        </c:if>

      </a>

      <div class="gz-fd-img"><a href="#"><img src="${product.master.favicon}"></a>
      </div>
    </div>
  </div>
  <!--评论-->
  <div class="review">
    <div class="dialogue">
      <h4 class="pl-name">评论</h4>
      </div>

    </div>
    <div class="more"><a href="#"><i class="time-1"></i>查看更多评论</a></div>
  </div>
  <!--评论-->
</div>
<!--悬浮-->
<div class="suspend">
  <div class="great">
    <div class="dynamic-ft">
      <a href="#" onclick="savaUP(${product.id})" id="good-1" class="ft-a" name="up"> <i class="good-1"></i> <em>${product.fsAmount}</em></a>
      <i class="s-solid ft-a"></i>
      <a href="#" class="ft-a"> <i class="good-2"></i> <em>${product.amount}</em> </a>
      <i class="s-solid ft-a"></i>
      <a href="#" class="ft-a"> <i class="good-3"></i> </a>
      <i class="s-solid ft-a"></i>
      <a href="#" class="ft-a"> <i class="good-4"></i> </a>
    </div>
  </div>
</div>
</div>
<!--悬浮-->
<script>
  //var productId =${product};
  function saveMasterFllow(masterId){

    $.ajax({
      type:"get",
      url:"/base/attentionMaster.do?masterId="+masterId,//设置请求的脚本地址
      data:"",
      dataType:"json",
      success:function(data){
        if(data==false){
          alert("您还未登陆，请登录后再操作");
          return false;
        }
        if(data==true){
          $("#"+masterId).html("已关注");
          return true;
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

var startNum=1;
  $(document).ready(function(){
    getData();

    function  getData(){
      $.ajax({
        type:"get",
        url:"<c:url value='/basic/xmj.do?qm=plistProductComment_coment&conditions=product.id:${product.id}&pageEntity.size=3&pageEntity.index='/>"+startNum,
        data:"",
        dataType:"json",
        success:function(data){
          if(data.list && data.list != null){
            for(i in data.list){
              var  pubu =$(".dialogue");
              var cTime =transdate(data.list[i].createDateTime);
              var amout1;
              if(data.list[i].amount==null){
                amout1 =0;
              }else{
                amout1 =data.list[i].amount;
              }


              var box = $("<div class='matter' id='"+data.list[i].id+"'> " +
                      "<p class='text-h1'>"+data.list[i].user.name2+"</p> " +
                      "<p class='text-time'>"+cTime+"</p> " +
                      "<p class='text-content'>" +
                      "<a href='#' >"+data.list[i].content+"</a></p> " +
                      "<div class='owner'><img class='am-circle' src='/scripts/assets/images/120102-p1-11.jpg'/></div> " +
                      "<div class='owner-good'>" +
                      "<a href='#'><i class='good-1'></i><em>"+amout1+"</em></a></div> ");
              pubu.append(box);

              //获取盖楼式回复
                 getReply(data.list[i].id);

              //imgload();
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
          startNum =startNum+1;
        }
      });

    }


  });
  function transdate(endTime){
    var timestamp = Date.parse(new Date());
    var oldTime = parseInt(endTime);
    var intervalTime = (timestamp - oldTime)/1000/60;
    var showTime = "";
    if(intervalTime<=59){
      showTime=intervalTime.toFixed(0)+"分钟前";
    }else if(1<=(intervalTime/60) && (intervalTime/60)<24){
      showTime=(intervalTime/60).toFixed(0)+"小时前";
    }else{
      showTime=(intervalTime/60/24).toFixed(0)+"天前";
    }
     return showTime;
  }

     function getReply(fatherId){
       var flag =false;
       $.ajax({
         type:"get",
         url:"<c:url value='/basic/xmj.do?qm=plistProductComment_coment&conditions=product.id:${product.id};fatherComment.id:"+fatherId+"&pageEntity.size=20&pageEntity.index=1'/>",
         data:"",
         dataType:"json",
         success:function(data){
           if(data.list && data.list != null){
             for(i in data.list){
               var  pubu =$("#fatherId");
               var cTime =transdate(data.list[i].createDateTime);
               var amout1;
               if(data.list[i].amount==null){
                 amout1 =0;
               }else{
                 amout1 =data.list[i].amount;
               }


               var box = $("<div class='respond'> <p><span class='txt-name'>" +
                       "<a href='#'> "+data.list[i].user.name2+"：</a>" +
                       "</span><span class='txt-content'>"+data.list[i].content+"</span></p> </div> ");
               pubu.append(box);

               //获取盖楼式回复
               getReply(data.list[i].id);

               //imgload();
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
          if(flag ==true){
            return false;
          }
         }
       });

     }
function savaUP(productId){
  var oper = $("#good-1").attr("name");
  $.ajax({
    type:"get",
    url:"<c:url value='/basic/saveThumbUp.do?productId='/>"+productId+"&operation="+oper,
    data:"",
    dataType:"json",
    success:function(data){
     if(data==false){
       alert("您还未登陆，请登录后再操作！！！");
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

</script>

<!--//End--footer-->
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

<!--自定义js--End-->
</body>
</html>
