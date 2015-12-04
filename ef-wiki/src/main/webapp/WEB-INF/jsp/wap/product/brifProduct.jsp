<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

  <title>作品详情</title>

</head>
<body style="position: relative;">

<header class="am-header custom-header">
  <div class="am-header-left am-header-nav">
    <a href="javascript:window.history.go(-1);" class="chevron-left"></a>
  </div>
  <!-- //End--chevron-left-->
  <h1 class="am-header-title">景泰蓝工艺</h1>
  <!-- //End--title-->
  <div class="am-header-right am-header-nav">
    <a href="#chevron-right" class="chevron-right" id="menu" style="display: block;">
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
    <a href="http://www.efeiyi.com/product/productModel/${product.productModelList[0].id}">我&nbsp;要&nbsp;购&nbsp;买</a>
  </div>
  <!--购买-->
  <div class="inheritor ">

    <div class="inheritor-text">
      <c:if test="${!empty product.master}">
      <a href="http://${product.master.name}.efeiyi.com"><p class="itor-text-1">${product.master.fullName}</p></a>

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
      <a class="gz-fd-icon" href="javascript:void(0);" onclick="saveMasterFllow('${product.master.id}')" id="${product.master.id}">
        <c:if test="${flag == true}">
          <input id="saveMasterFllow" type="hidden" value="0">
          取消关注
        </c:if>
        <c:if test="${flag == false}">
          <input id="saveMasterFllow" type="hidden" value="1">
          关注
        </c:if>

      </a>

      <div class="gz-fd-img"><a href="http://${product.master.name}.efeiyi.com"><img src="${product.master.favicon}"></a>
      </div>
      </c:if>
    </div>

  </div>
  <!--评论-->
  <div class="review">
    <div class="dialogue">
      <h4 class="pl-name">评论</h4>
      </div>
    <div class="more"><a href="javascript:void(0);" onclick="getData()"><i class="time-1"></i>查看更多评论</a></div>
    </div>

    <input type="hidden" name="" id="content" value="" />
</div>
  <!--评论-->
</div>
<!--悬浮-->
<div class="suspend">
  <div class="great">
    <div class="dynamic-ft">
      <a href="#" onclick="savaUP('${product.id}')" id="good-1" class="ft-a" name="up"> <i class="good-1"></i> <em id="em1">${product.amount}</em></a>
      <i class="s-solid ft-a"></i>
      <a href="#"  class="ft-a" onclick="showmodal()"> <i class="good-2"></i> <em>${product.fsAmount}</em> </a>
      <i class="s-solid ft-a"></i>
      <a href="#" class="ft-a" onclick="storeProduct('${product.id}')"> <i class="good-3"></i> </a>
      <i class="s-solid ft-a"></i>
      <a href="javascript:void(0);" class="ft-a" id="io"  style="position:relative">
        <i class="good-4" id="good-4"></i>
        <div class="nr-share" id="nr-share" style="display: none">
        <div class="nr-bg">
          <div class="jiathis_style">
            <a class="jiathis_button_weixin"   style="width: 2rem" title="分享到微信"></a>
            <a class="jiathis_button_tqq"   style="width: 2rem" title="分享到腾讯微博"></a>
            <a class="jiathis_button_tsina"  style="width: 2rem" title="分享到新浪微博"></a>
            <a class="jiathis_button_cqq"  style="width: 2rem" title="分享到QQ好友"></a>

          </div>
        </div>
        </div>
      </a>
    </div>
  </div>
</div>
</div>
<!--悬浮-->
<script>
  //var productId =${product};
  function saveMasterFllow(masterId){
    var val = $("#saveMasterFllow").val();
    var oper;
    if(val=='0'){
      oper="del";
    }else if(val=='1'){
      oper="add";
    }

    $.ajax({
      type:"get",
      url:"/base/attentionMaster.do?masterId="+masterId+"&oper="+oper,//设置请求的脚本地址
      data:"",
      dataType:"json",
      success:function(data){
        if(data=="false"){
          var go = window.confirm("去登录吧?");
          if(go==true){
            window.location.href ="<c:url value='/wapShowProduct/${product.id}'/>";
          }
          else{
            return false;//取消
          }
          return false;
        }
        if(data=="true"){
          $("#"+masterId).html("取消关注");
          if(oper=="0"){
            var val = $("#saveMasterFllow").val("1");
          }
          if(oper=="1"){
            var val = $("#saveMasterFllow").val("0");
          }
          return true;
        }
        if(data=="del"){
          $("#"+masterId).html("关注");
          if(oper=="0"){
            var val = $("#saveMasterFllow").val("1");
          }
          if(oper=="1"){
            var val = $("#saveMasterFllow").val("0");
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

var startNum=1;
  $(document).ready(function(){
    getData();
  });
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
              var userName = data.list[i].user.username.toString().substring(0,3)+"****"+data.list[i].user.username.toString().substring(7,11);
              if(userName==null){
                userName ="匿名用户";
              }

              var box = $("<div class='matter' id='"+data.list[i].id+"'> " +
                      "<p class='text-h1'>"+userName+"</p> " +
                      "<p class='text-time'>"+cTime+"</p> " +
                      "<p class='text-content'>" +
                      "<a href='#'onclick='showmodal2(this)' about='"+data.list[i].id+"'>"+data.list[i].content+"</a></p> " +
                      "<div class='owner'><img class='am-circle' src='<c:url value='/scripts/assets/images/120102-p1-11.jpg'/>'/></div> " +
                      "<div class='owner-good'>" +
                      "<a href='javascript:void(0);' onclick='commentUpAndDown(this,\""+data.list[i].id+"\")' about='${product.id}' name='up'><i class='good-1'></i><em>"+amout1+"</em></a></div> ");
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
               var  pubu =$("#"+fatherId);
               var cTime =transdate(data.list[i].createDateTime);
               var amout1;
               if(data.list[i].amount==null){
                 amout1 =0;
               }else{
                 amout1 =data.list[i].amount;
               }
               var userName = data.list[i].user.username.toString().substring(0,3)+"****"+data.list[i].user.username.toString().substring(7,11);
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
function savaUP(productId){
  var oper = $("#good-1").attr("name");
  $.ajax({
    type:"get",
    url:"<c:url value='/base/saveThumbUp.do?productId='/>"+productId+"&operation="+oper,
    data:"",
    async:true,
    dataType:"json",
    success:function(data2){
     if(data2=="false"){
       var go = window.confirm("去登录吧?");
       if(go==true){
         window.location.href ="<c:url value='/wapShowProduct/${product.id}'/>";
       }
       else{
         return false;//取消
       }
       return false;
     }
      if(data2=="repeat"){
        alert("请不要重复操作！！！");
        return false;
      }
      if(data2=="true" && oper=='up'){
        $("#em1").html(parseInt($("#em1").text())+1);
        if($("#good-1").attr("name")=="down"){
          $("#good-1").attr("name","up");
        }else{
          $("#good-1").attr("name","down");
        }
      }
      if(data2=="true" && oper=='down'){
        $("#em1").html(parseInt($("#em1").text())-1);
        if($("#good-1").attr("name")=="down"){
          $("#good-1").attr("name","up");
        }else{
          $("#good-1").attr("name","down");
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


  function showmodal(){
    window.open("<c:url value='/comment.jsp'/>");

  }
  function showmodal2(data){
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
      url:"<c:url value='/product/saveComment.do?productId=${product.id}'/>"+"&content="+CommentValue,
      data:"",
      dataType:"json",
      async:true,
      success:function(data){
        if(data==false){
          var go = window.confirm("去登录吧?");
          if(go==true){
            window.location.href ="<c:url value='/wapShowProduct/${product.id}'/>";
          }
          else{
            return false;//取消
          }
          return false;
        }
        $(".dialogue").append("<div class='matter'> <p class='text-h1'>${fn:substring(myUser.username, 0,3 )}****${fn:substring(myUser.username,7,11)}</p> " +
                "<p class='text-time'>刚刚</p> <p class='text-content'>" +
                "<a href='#' onclick='showmodal2(this)' about='"+data.id+"'>"+CommentValue+"</a></p> <div class='owner'>" +
                "<img class='am-circle' src='<c:url value='/scripts/assets/images/120102-p1-11.jpg'/>'/>" +
                "</div> <div class='owner-good'><a href='javascript:void(0);' onclick='commentUpAndDown(this,\""+data.id+"\")' about='${product.id}' name='up'>" +
                "<i class='good-1'></i><em>"+data.amount+"</em></a></div> " + "</div>");
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
        url:"<c:url value='/product/saveComment2.do?productId=${product.id}'/>"+"&content="+CommentValue+"&contentId="+contentId,
        data:"",
        dataType:"json",
        async: true,
        success:function(data){
          if(data==false){
            var go = window.confirm("去登录吧?");
            if(go==true){
              window.location.href ="<c:url value='/wapShowProduct/${product.id}'/>";
            }
            else{
              return false;//取消
            }
            return false;
          }
          $("#"+contentId).append("<div class='respond'> <p><span class='txt-name'>" +
                  "<a href='#'> ${fn:substring(myUser.username, 0,3 )}****${fn:substring(myUser.username,7,11)}：</a>" +
                  "</span><span class='txt-content' onclick='showmodal2(this)' about='"+data.id+"'>"+CommentValue+"</span></p> </div> ");
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


  function commentUpAndDown(data,commentId){
    var oper = $(data).attr("name");
    var productId = $(data).attr("about");
    //alert($(data).children().eq(1).text());
    $.ajax({
      type:"get",
      url:"<c:url value='/base/commentUpAndDown.do?productId='/>"+productId+"&operation="+oper+"&commentId="+commentId,
      data:"",
      async:true,
      dataType:"json",
      success:function(data2){
        if(data2=="false"){
          var go = window.confirm("去登录吧?");
          if(go==true){
            window.location.href ="<c:url value='/wapShowProduct/'/>"+productId;
          }
          else{
            return false;//取消
          }
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



  function storeProduct(productId){

    $.ajax({
      type:"get",
      url:"<c:url value='/base/storeProduct.do?productId='/>"+productId,//设置请求的脚本地址
      data:"",
      dataType:"json",
      success:function(data){
        if(data=="false"){
          var go = window.confirm("去登录吧?");
          if(go==true){
            window.location.href ="<c:url value='/wapShowProduct/${product.id}'/>";
          }
          else{
            return false;//取消
          }
          return false;
        }
        if(data=="repeat"){
          showAlert("提示","您好，取消收藏成功！")
          return true;
        }
        if(data=="true"){
         showAlert("提示","您好，收藏成功！")
          return true;
        }

      },
      error:function(){

        showAlert("error","出错了，请联系管理员！！！");
        return false;
      },
      complete:function(){

      }
    });
  }
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
            var userName = data[i].user.username.toString().substring(0,3)+"****"+data[i].user.username.toString().substring(7,11);
            if(userName==null){
              userName ="匿名用户";
            }

            var box = $("<li class=\"review\"><div class=\"matter\"> <p class=\"text-h1\">" +
                    "<a href=\"#\">"+userName+"</a>回复了你</p> " +
                    "<p class=\"text-time\">"+cTime+"</p> <p class=\"text-content\">" +
                    "<a href=\"javascript:void(0);\" onclick=\"gotoWatch('"+data[i].id+"','"+data[i].product+"')\">"+data[i].content+"</a></p> " +
                    "<div class=\"owner\"><img class=\"am-circle\" src=\"<c:url value='/scripts/assets/images/120102-p1-11.jpg'/>\"></div></div> </li>");
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
            var userName = data[i].user.username.toString().substring(0,3)+"****"+data.list[i].user.username.toString().substring(7,11);;;
            if(userName==null){
              userName ="匿名用户";
            }

            var box = $("<li class=\"review\"> <div class=\"matter\"> <p class=\"text-h1\">"+userName+"</p> " +
                    "<p class=\"text-time\">"+cTime+"</p> <p class=\"text-content\">" +
                    "<a href=\"javascript:void(0);\" onclick=\"watchPraise('"+data[i].id+"','"+data[i].product+"')\">觉得你的评论“还不错”很赞</a></p> <div class=\"owner\">" +
                    "<img class=\"am-circle\" src=\"<c:url value='/scripts/assets/images/120102-p1-11.jpg'/>\"></div> </div> " +
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
</script>

<!--//End--footer-->
</div>

<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>

<!--自定义js--End-->
</body>
</html>
