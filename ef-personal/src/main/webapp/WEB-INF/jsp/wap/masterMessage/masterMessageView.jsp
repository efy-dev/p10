<%@ page import="com.efeiyi.ec.personal.AuthorizationUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>120102大师动态-图-文</title>
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
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/css/amazeui.min.css?v=20150831'/>">
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/css/app.css?v=20150831'/>">
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/css/cyclopedia.css?v=20150831'/>">
  <script src="<c:url value='/resources/jquery/jquery-1.11.1.min.js'/>"></script>
  <script src="<c:url value='/scripts/assets/js/jquery.min.js'/>"></script>
</head>
<body>
<div class="great">
  <header class="am-header custom-header">
    <div class="am-header-left am-header-nav"> <a href="javascript:history.go(-1);" class="chevron-left"></a> </div>
    <!-- //End--chevron-left-->
    <h1 class="am-header-title">大师</h1>
    <!-- //End--title-->
    <div class="am-header-right am-header-nav am-header-right1"> <a href="#chevron-right" class="chevron-right" id="menu"> <i class="icon icon-user"></i> </a> </div>
  </header>
  <!--//End--header-->
  <!--地区-->
  <div class="dis-q1">
    <div class="tabs-bd">
      <div class="am-tab-panel am-active">
        <!--大师动态-->
        <div class="suit">
          <div class="dynamic">
            <div class="dynamic-hd"> <a class="suit-tx"><img class="am-circle" src="/scripts/assets/upload/120102-p1-1.jpg"></a>
              <div class="suit-name"><a href="#"><span>${object.master.fullName}</span></a></div>
              <a class="suit-gz" onclick="changeStatus(this,'${object.master.id}');"><span>${object.master.followStatus}</span></a> </div>
            <div class="dynamic-st">
              <div class="dynamic-suit-st-img">
                <p><img src="/scripts/assets/upload/120102-p1-2.jpg"></p>
                <p class="txt">${object.content}</p>
                <p><img src="/scripts/assets/upload/120102-p1-3.jpg"></p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="review">
  <div class="dialogue">
    <h4 class="pl-name">评论</h4>

  </div>
  <div class="more"><a href="#"><i class="time-1"></i>查看更多评论</a></div>
  <input type="hidden" name="" id="content" value="" />
</div>
<div class="suspend">
  <div class="great">
    <div class="dynamic-ft">
      <a href="#" onclick="savaUP('${object.id}')" id="good-1" class="ft-a" name="up"> <i class="good-1"></i> <em>${object.fsAmount}</em></a>
      <i class="s-solid ft-a"></i>
      <a onclick="showModel();" class="ft-a"> <i class="good-2"></i> <em>${object.amount}</em> </a>
      <i class="s-solid ft-a"></i>
      <a href="#" class="ft-a" onclick="storeWork('${object.id}')"> <i class="good-3"></i> </a>
      <i class="s-solid ft-a"></i>
      <a href="#" class="ft-a"> <i class="good-4"></i> </a>
    </div>
  </div>
</div>
<!--地区-->
<div class="login-reg">
  <%if(AuthorizationUtil.getMyUser()!=null && AuthorizationUtil.getMyUser().getId() != null){ %>
  <div class="bd logined"><%=AuthorizationUtil.getMyUser().getUsername()%><a class="btn-exit" href="<c:url value='/j_spring_cas_security_logout'/>">退出</a></div>
  <% } %>
  <%if(AuthorizationUtil.getMyUser()==null || AuthorizationUtil.getMyUser().getId() == null){ %>
  <a href="<c:url value='http://192.168.1.57/cas/login?service=http%3A%2F%2Flocalhost:8080%2Fj_spring_cas_security_check'/>" class="btn-login" title="登录">登&nbsp;&nbsp;&nbsp;&nbsp;录</a>
  <a href="#reg" class="btn-reg">注&nbsp;&nbsp;&nbsp;&nbsp;册</a>
  <% } %>

</div>
<!--//End--login-reg-->
<footer class="bd footer">
  <div class="bd info"> <a class="icon"></a>
    <div class="txt">中&nbsp;&nbsp;国&nbsp;&nbsp;非&nbsp;&nbsp;遗&nbsp;&nbsp;电&nbsp;&nbsp;商&nbsp;&nbsp;平&nbsp;&nbsp;台</div>
    <div class="wechat"></div>
    <div class="txt">关注微信公众号</div>
    <div class="txt">领取超值代金券</div>
  </div>
  <div class="bd copyright">京ICP备15032511号-1</div>
</footer>
<!--//End--footer-->
</div>
<script>

  var startNum=1;
  $(document).ready(function(){
    getData();

    function  getData(){
      $.ajax({
        type:"get",
        url:"<c:url value='/basic/xmj.do?qm=plistMasterComment_message&conditions=masterMessage.id:${object.id}&pageEntity.size=3&pageEntity.index='/>"+startNum,
        data:"",
        dataType:"json",
        success:function(data){
          console.log(data);
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
              var userName = data.list[i].user.name2;
              if(userName==null){
                userName ="匿名用户";
              }

              var box = $("<div class='matter' id='"+data.list[i].id+"'> " +
                      "<p class='text-h1'>"+userName+"</p> " +
                      "<p class='text-time'>"+cTime+"</p> " +
                      "<p class='text-content'>" +
                      "<a href='#'onclick='showModal2(this)' about='"+data.list[i].id+"'>"+data.list[i].content+"</a></p> " +
                      "<div class='owner'><img class='am-circle' src='/scripts/assets/images/120102-p1-11.jpg'/></div> " +
                      "<div class='owner-good'>" +
                      "<a href='#' onclick=\"commentUpAndDown(this,'"+data.list[i].id+"')\" about='${work.id}' name='up'><i class='good-1'></i><em>"+amout1+"</em></a></div> ");
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

  function getReply(fatherId){
    var flag =false;
    $.ajax({
      type:"get",
      url:"<c:url value='/basic/xmj.do?qm=plistMasterComment_message&conditions=masterMessage.id:${object.id};fatherComment.id:"+fatherId+"&pageEntity.size=20&pageEntity.index=1'/>",
      data:"",
      dataType:"json",
      success:function(data){
        if(data.list && data.list != null){
          for(i in data.list){
            var  pubu =$("#"+fatherId);
            var cTime =transdate(data.list[i].createDateTime);
            var amout1;
            if(data.list[i].amount==null){
              amout1 =0;
            }else{
              amout1 =data.list[i].amount;
            }
            var userName = data.list[i].user.name2;
            if(userName==null){
              userName ="匿名用户";
            }

            var box = $("<div class='respond' id='"+data.list[i].id+"'> <p><span class='txt-name'>" +
                    "<a href='#'> "+userName+"：</a>" +
                    "</span><span class='txt-content' onclick='showmodal2(this)' about='"+data.list[i].id+"'>"+data.list[i].content+"</span></p> </div> ");
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

  function savaUP(workId){
    var oper = $("#good-1").attr("name");
    $.ajax({
      type:"get",
      url:"<c:url value='/masterMessage/saveThumbUp.do?msgId='/>"+workId+"&operation="+oper,
      data:"",
      dataType:"json",
      success:function(data2){
        if(data2=="false"){
          alert("您还未登陆，请登录后再操作！！！");
          return false;
        }
        if(data2=="repeat"){
          alert("请不要重复操作！！！");
          return false;
        }
        if(data2=="true" && oper=='up'){
          $("#em1").html(parseInt($("#em1").text())+1);
        }
        if(data2=="true" && oper=='down'){
          $("#em1").html(parseInt($("#em1").text())-1);
        }
      },
      error:function(){
        alert("出错了，请联系管理员！！！");
        return false;
      },
      complete:function(){
        if($("#good-1").attr("name")=="down"){
          $("#good-1").attr("name","up");
        }else{
          $("#good-1").attr("name","down");
        }


      }
    });
  }

  function commentUpAndDown(data,commentId){
    var oper = $(data).attr("name");
    var workId = $(data).attr("about");
    $.ajax({
      type:"get",
      url:"<c:url value='/masterMessage/commentUpAndDown.do?msgId='/>"+workId+"&operation="+oper+"&commentId="+commentId,
      data:"",
      async: true,
      dataType:"json",
      success:function(data2){
        if(data2=="false"){
          alert("您还未登陆，请登录后再操作！！！");
          return false;
        }
        if(data2=="repeat"){
          alert("您已经点过赞了！！！");
          return false;
        }
        if(data2=="true" && oper=='up'){
          $(data).children().eq(1).html(parseInt( $(data).children().eq(1).text())+1);
        }
        if(data2=="true" && oper=='down'){
          $(data).children().eq(1).html(parseInt( $(data).children().eq(1).text())-1);
        }
      },
      error:function(){
        alert("出错了，请联系管理员！！！");
        return false;
      },
      complete:function(){

        if( $(data).attr("name")=="up"){
          $(data).attr("name","down");
        }else{
          $(data).attr("name","up");
        }
      }
    });
  }

  function storeWork(workId){

    $.ajax({
      type:"get",
      url:"<c:url value='/masterMessage/storeWork.do?msgId='/>"+workId,//设置请求的脚本地址
      data:"",
      dataType:"json",
      success:function(data){
        if(data=="false"){
          alert("您还未登陆，请登录后再操作");
          return false;
        }
        if(data=="repeat"){
          alert("您已收藏过了！")
          return true;
        }
        if(data=="true"){
          alert("您好，收藏成功！")
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

  <%--function getMoreComment(){--%>
    <%--$.ajax({--%>
      <%--type:"post",--%>
      <%--url:"<c:url value='/masterMessage/getMoreComment.do?msgId='/>"${object.id},//设置请求的脚本地址--%>
      <%--data:"",--%>
      <%--dataType:"json",--%>
      <%--success:function(data){--%>
        <%--if(data=="false"){--%>
          <%--alert("您还未登陆，请登录后再操作");--%>
          <%--return false;--%>
        <%--}--%>
        <%--if(data=="repeat"){--%>
          <%--alert("您已收藏过了！")--%>
          <%--return true;--%>
        <%--}--%>
        <%--if(data=="true"){--%>
          <%--alert("您好，收藏成功！")--%>
          <%--return true;--%>
        <%--}--%>

      <%--},--%>
      <%--error:function(){--%>

        <%--alert("出错了，请联系管理员！！！");--%>
        <%--return false;--%>
      <%--},--%>
      <%--complete:function(){--%>

      <%--}--%>
    <%--});--%>
  <%--}--%>


  function showModel(){
    window.open("<c:url value='/comment.jsp'/>");

  }
  function showModal2(data){
    $("#content").attr("name",$(data).attr("about"));
    window.open("<c:url value='/comment2.jsp'/>");

  }
  function setValue(data){
    var ret =document.getElementById("content").value = data;
    if(ret && ret.toString().length>=1){
      var CommentValue=$("#content").val();
      if(CommentValue==null || CommentValue==""){
        alert("你未发表任何评论，请评论");
        return false;
      }
      $.ajax({
        type:"get",
        url:"<c:url value='/masterMessage/workComment.do?msgId=${object.id}'/>",
        data:"&content="+CommentValue,
        dataType:"json",
        async:true,
        success:function(data){
          if(data==false){
            alert("您还未登陆，请登录后再操作！！！");
            return false;
          }
          $(".dialogue").append("<div class='matter'> <p class='text-h1'>${myUser.name2}</p> " +
                  "<p class='text-time'>刚刚</p> <p class='text-content'>" +
                  "<a href='#' >"+CommentValue+"</a></p> <div class='owner'>" +
                  "<img class='am-circle' src='/scripts/assets/images/120102-p1-11.jpg'/>" +
                  "</div> <div class='owner-good'><a href='#'>" +
                  "<i class='good-1'></i><em>0</em></a></div> " + "</div>");
        },
        error:function(){
          alert("出错了，请联系管理员！！！");
          return false;
        },
        complete:function(){

        }
      });
    }
  }

  function setValue2(data){
    var ret =document.getElementById("content").value = data;
    var contentId = $("#content").attr("name");
    if(ret && ret.toString().length>=1){
      var CommentValue=$("#content").val();
      if(CommentValue==null || CommentValue==""){
        alert("你未发表任何评论，请评论");
        return false;
      }
      $.ajax({
        type:"get",
        url:"<c:url value='/masterMessage/commentOther.do?msgId=${object.id}'/>"+"&content="+CommentValue+"&contentId="+contentId,
        data:"",
        dataType:"json",
        async: true,
        success:function(data){
          if(data==false){
            alert("您还未登陆，请登录后再操作！！！");
            return false;
          }
          $("#"+contentId).append("<div class='respond'> <p><span class='txt-name'>" +
                  "<a href='#'> ${myUser.name2}：</a>" +
                  "</span><span class='txt-content'>"+CommentValue+"</span></p> </div> ");
        },
        error:function(){
          alert("出错了，请联系管理员！！！");
          return false;
        },
        complete:function(){

        }
      });
    }
  }

  function transdate(endTime){
    var timestamp = Date.parse(new Date());
    var oldTime = parseInt(endTime);
    var intervalTime = (timestamp - oldTime)/1000/60;
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

  function changeStatus(o,masterId){
    var status = "";
    var str = $(o).find("span").html();
    if(str == "已关注"){
      status = "2";
    }else if(str == "关注"){
      status = "1";
    }
    $.ajax({
      type: "POST",
      url: "<c:url value='/masterFollow/followed.do'/>",
      data:"masterId="+masterId+"&status="+status,
      async:false,
      dataType:"json",
      error:function(){alert("操作失败.请联系系统管理员!")},
      success:function(msg){
        if(msg == "1"){
          $(o).find("span").html("关注");
        }else if(msg == "2"){
          $(o).find("span").html("已关注");
        }
      }
    })
  }
</script>

<!--[if lte IE 8 ]>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value='/scripts/assets/js/amazeui.ie8polyfill.min.js'/>"></script>
<![endif]-->
<script src="<c:url value='/scripts/assets/js/amazeui.min.js'/>"></script>
<!--自定义js--Start-->
<script src="<c:url value='/scripts/assets/js/system.js?v=20150831'/>"></script>
<script src="<c:url value='/scripts/assets/js/cyclopedia.js?v=20150831'/>"></script>
<!--自定义js--End-->
</body>
</html>