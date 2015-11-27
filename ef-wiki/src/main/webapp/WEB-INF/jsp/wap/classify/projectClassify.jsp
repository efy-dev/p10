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
  <h1 class="am-header-title"></h1>
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
<!--//End--header-->
<!--地区-->
<div class="dis-q1">
  <div class="dis-q2">
  <div data-am-widget="tabs"
       class="am-tabs am-tabs-default">
    <ul class="am-tabs-nav am-cf">
      <li class="am-active"><a href="[data-tab-panel-0]">分类</a></li>
      <li class=""><a href="[data-tab-panel-1]">级别</a></li>
      <li class=""><a href="[data-tab-panel-2]">地区</a></li>
    </ul>
    <div class="am-tabs-bd">
      <div data-tab-panel-0 class="am-tab-panel am-active">
        <div class="site">
          <div class="menu-page">
            <ul class="list-site">
              <li>
                <a href="<c:url value='/basic/xm.do?qm=plistProject_allCategory&conditions=&pageEntity.size=10&pageEntity.index=1'/>">全&nbsp;&nbsp;&nbsp;&nbsp;部</a></li>
              <c:if test="${!empty ProjectCategoryList}">
                <c:forEach var="projectcategory" items="${ProjectCategoryList}">
                  <li><a href="<c:url value='/basic/xm.do?qm=plistProject_Category&conditions=projectCategory.id:${projectcategory.id}&pageEntity.size=10&pageEntity.index=1'/>">${projectcategory.name}</a></li>
                </c:forEach>
              </c:if>
            </ul>
          </div>
        </div>
      </div>
      <div data-tab-panel-1 class="am-tab-panel ">
        <div class="site">
          <div class="menu-page">
            <ul class="list-site">
              <li><a href="<c:url value='/basic/xm.do?qm=plistProject_all&conditions=&pageEntity.size=10&pageEntity.index=1'/>">全&nbsp;&nbsp;部</a></li>
              <li><a href="<c:url value='/basic/xm.do?qm=plistProject_level&conditions=level:1&pageEntity.size=10&pageEntity.index=1'/>">国家级</a></li>
              <li><a href="<c:url value='/basic/xm.do?qm=plistProject_level&conditions=level:2&pageEntity.size=10&pageEntity.index=1'/>">省&nbsp;&nbsp;级</a></li>
              <li><a href="<c:url value='/basic/xm.do?qm=plistProject_level&conditions=level:3&pageEntity.size=10&pageEntity.index=1'/>">市&nbsp;&nbsp;级</a></li>
              <li><a href="<c:url value='/basic/xm.do?qm=plistProject_level&conditions=level:4&pageEntity.size=10&pageEntity.index=1'/>">县&nbsp;&nbsp;级</a></li>
            </ul>
          </div>
        </div>
      </div>
      <div data-tab-panel-2 class="am-tab-panel">
        <div class="site">
          <div class="menu-page">
            <ul class="list-site">
              <li><a href="<c:url value='/basic/xm.do?qm=plistProject_allDirt&conditions=&pageEntity.size=10&pageEntity.index=1'/>">全&nbsp;&nbsp;&nbsp;&nbsp;部</a></li>
              <c:if test="${!empty AddressProvinceList}">
                <c:forEach var="AddressProvince" items="${AddressProvinceList}">
                  <li><a href="<c:url value='/basic/xm.do?qm=plistProject_Dirt&conditions=addressDistrict.addressCity.addressProvince.id:${AddressProvince.id}&pageEntity.size=10&pageEntity.index=1'/>">${AddressProvince.name}</a></li>
                </c:forEach>
              </c:if>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</div>

<script>
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

</body>
</html>
