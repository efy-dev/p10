<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/15
  Time: 18:31
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>

  <title>工艺-分类</title>

</head>
<body>

  <header class="am-header custom-header">
    <div class="am-header-left am-header-nav">
      <a href="javascript:window.history.go(-1);" class="chevron-left"></a>
    </div>
    <!-- //End--chevron-left-->
    <h1 class="am-header-title">传统技艺</h1>
    <!-- //End--title-->
    <div class="am-header-right am-header-nav">
      <a href="#chevron-right" class="chevron-right" id="menu">
        <i class="line"></i>
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
<input type="hidden" name="addType" id="addType" value="<%=request.getAttribute("addType")%>">
<!--//End--header-->
<!--传统技艺-->
<div class="classify" id="pubu">
  <c:if test="${!empty  pageInfo.list}">
    <c:forEach var="ppj" items="${pageInfo.list}">
      <ul class="hot" id="box">
        <li>
          <a href="<c:url value='/base/brifProject/${ppj.id}/1'/>"><img src="http://pro.efeiyi.com/${ppj.picture_wap_url}"></a>
          <div class="hot-poge">
            <span style="margin-right: 1rem">人气</span>
              <%-- <span>${fn:length(ppj.project.projectFolloweds)}</span>--%>
            <span><c:if test="${ppj.fsAmount == null}">0</c:if><c:if test="${ppj.fsAmount != null}">${ppj.fsAmount}</c:if></span>
          </div>
        </li>
      </ul>
    </c:forEach>
  </c:if>
<c:if test="${empty  pageInfo.list}">
  暂时未上架，敬请期待！！！
</c:if>
</div>
<!--传统技艺-->
<script>

  var startNumber =2;
  var ajaxkey1 = true;
  $(window).load(function(){
    PBL("#pubu","#box",2);
    var winH = $(window).height(); //页面可视区域高度
    $(window).scroll(function(){
      var pageH = $(document.body).height();
      var scrollT = $(window).scrollTop(); //滚动条top
      var aa = (pageH - winH - scrollT) / winH;
      if(aa < 0.02){
       var addType = $("#addType").val();
       if(addType=="allCategory" && ajaxkey1==true){
         getData1("<c:url value='/basic/xmj.do?qm=plistProject_allCategory&conditions=&pageEntity.size=10&pageEntity.index='/>");
       }else if(addType=="Category" && ajaxkey1==true){
         getData1("<c:url value='/basic/xmj.do?qm=plistProject_Category&conditions=projectCategory.id:${query}&pageEntity.size=10&pageEntity.index='/>");
       }else if(addType=="all" && ajaxkey1==true){
         getData1("<c:url value='/basic/xmj.do?qm=plistProject_all&conditions=&pageEntity.size=10&pageEntity.index='/>");
       }else if(addType=="level" && ajaxkey1==true){
         getData1("<c:url value='/basic/xmj.do?qm=plistProject_level&conditions=level:${query}&pageEntity.size=10&pageEntity.index='/>");
       }else if(addType=="allDirt" && ajaxkey1==true){
         getData1("<c:url value='/basic/xmj.do?qm=plistProject_allDirt&conditions=&pageEntity.size=10&pageEntity.index='/>");
       }else if(addType=="Dirt" && ajaxkey1==true){
         getData1("<c:url value='/basic/xmj.do?qm=plistProject_Dirt&conditions=addressDistrict.addressCity.addressProvince.id:${query}&pageEntity.size=10&pageEntity.index='/>");
       }else{

       }

      }
    });
  });


  /************************************************* ↓ 函数 ↓ */
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







  //请求数据的方法
  function getData1(url){
    var flag = false;
    $.ajax({
      type:"get",//设置get请求方式
      url:url+startNumber,//设置请求的脚本地址
      data:"",//设置请求的数据
      dataType:"json",//设置请求返回的数据格式
      success:function(data){
        var pubu = $("#pubu");
        if(data.list && data.list != null){
          for(i in data.list){

            var moods =0;
            if(data.list[i].fsAmount!=null) {moods = data.list[i].fsAmount;}
            var box = $("<ul class='hot' id='box'>" +
                    "<li><a href='<c:url value='/base/brifProject/'/>"+data.list[i].id+"/1'><img src='http://pro.efeiyi.com/"+data.list[i].picture_wap_url+"'></a> " +
                    "<div class='hot-poge'> <span style='margin-right: 1rem'>人气</span> " +
                    "<span>"+moods+"</span> " +
                    "</div></li> </ul>");
            pubu.append(box);
          }

        }else{
          flag = true;
        }
        PBL("#pubu","#box",2);
        startNumber=startNumber+1;
      },
      error:function(){

        alert("出错了，请联系管理员！！！");
        return false;
      },
      complete:function(){
        if(flag==true) {
          ajaxkey1 = false;
        }
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
  var StartNum = 1;
  var StartNum2 = 1;
  var ajaxkey = true;//设置ajax请求的开关,如需动态加载、需要打开这个开关
  var ajaxkey1 = true;
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
            var userName = data[i].user.name2;
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


<!--<![endif]-->

</body>
</html>
