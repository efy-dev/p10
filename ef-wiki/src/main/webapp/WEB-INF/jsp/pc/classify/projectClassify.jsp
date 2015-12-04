
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

  <title>e飞蚁工艺</title>

</head>
<body>

<!-- //End--header-->
<div class="craft-details ">
  <div class="nav-bars ae">
    <ul class="bars">
      <li ><a href="<c:url value='/pc/index.do'/>">热&nbsp;门</a></li>
      <%if(AuthorizationUtil.getMyUser().getId()==null || "no".equalsIgnoreCase(request.getAttribute("isShow").toString()) ){%>
      <li><a href="<c:url value='/pc/beforeAttention.do'/>">关注</a></li>
      <%}%>
      <%
        if(AuthorizationUtil.getMyUser().getId()!=null && "ok".equalsIgnoreCase(request.getAttribute("isShow").toString()) ){
      %>
      <li ><a href="<c:url value='/pc/afterAttention.do'/>">关注</a></li>
      <%}%>

      <li class="active"><a href="<c:url value='/pc/category'/>">发&nbsp;现</a></li>
    </ul>
  </div>
</div>
<!--nav-bars-->

<div class="list-find">
  <%--<div class="list-f-title">
    <p><a>工艺</a><i class="fu-icon"></i><span>发现</span></p>
  </div>--%>
  <div class="list-f-select">
    <div class="f-select-group">
      <div class="select-head">
        <span>分类：</span>
        <strong><a href="javascript:void(0);" class="active" about="1" onclick="getData(this,'<c:url value='/pc/projectClassifyj.do?qm=plistProject_allCategory&conditions=&pageEntity.size=10&pageEntity.index='/>')">全部</a></strong>
      </div>
      <ul class="select-list">

        <c:if test="${!empty ProjectCategoryList}">
          <c:forEach var="catagory" items="${ProjectCategoryList}" varStatus="status">
            <c:if test="${status.index==0}">
              <li><a href="javascript:void(0);" class="" about="0" onclick="getData(this,'<c:url value='/pc/projectClassifyj.do?qm=plistProject_Category&conditions=projectCategory.id:${catagory.id}&pageEntity.size=10&pageEntity.index='/>')">${catagory.name}</a></li>
            </c:if>
            <c:if test="${status.index!=0}">
              <li><a href="javascript:void(0);" about="0" onclick="getData(this,'<c:url value='/pc/projectClassifyj.do?qm=plistProject_Category&conditions=projectCategory.id:${catagory.id}&pageEntity.size=10&pageEntity.index='/>')">${catagory.name}</a></li>
            </c:if>
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
        <div class="f-r-gd ae"><a href="javascript:void(0);" onclick="getMoreHotProject()"><span>更多工艺</span><i class="sp-icon"></i></a></div>
      </div>
      <div class="f-right-gy ae">
        <div class="h4"><span>新加入工艺</span></div>
        <ul class="gy-grounp ae" id="new">

        </ul>
      </div>
    </div>
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
      beforeSend:function(){
        $("#loading").show();
      },
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
            var isA = checkIsAttention(""+data[i].projectId);
            var word ="";
            var opertation1="";
            if(isA==true){
              word="已关注";
              opertation1="del"
            }else{
              word="关注";
              opertation1="add";
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
           var box = $("<li> <dl> <dt><a href=\"<c:url value='/project/brifProject/'/>"+data[i].projectId+"\"><img src=\"http://pro.efeiyi.com/"+data[i].picture_pc_url+"@!pc-classify-left\"></a> " +
                   "<div class=\"list-moods\"> <a href=\"#\"><i class=\"img-icon\"></i></a> " +
                   "<em>"+data[i].fsAmount+"</em> </div></dt> <dd> <div class=\"text1\"><span>"+data[i].addressDistrict+"</span></div> " +
                   "<div class=\"text2\"><a href=\"<c:url value='/project/brifProject/'/>"+data[i].projectId+"\"><span>"+data[i].projectName+"</span></a></div>  <p>"+levelName+"</p> " +
                   "<div class='text5'>"+data[i].description+"</div> " +
                   "<div class=\"text3\"><a href=\"<c:url value='/project/listProduct/'/>"+data[i].projectId+"\"><span>"+data[i].works+" 件作品</span></a>" +
                   "<span><a href=\"<c:url value='/project/brifMaster/'/>"+data[i].projectId+"\">"+data[i].masters+"位大师</span></a></div> " +
                   "<a href=\"javascript:void(0);\" class=\"text4\" onclick='saveProjectFllow(\""+data[i].projectId+"\")'><em about='"+opertation1+"' id='"+data[i].projectId+"'>"+word+"</em></a> " +
                   "</dd> </dl> </li> ");
            pubu.append(box);
            //PBL("#beforeAttention",".before",2);
          }

        }else{
          flag = true;
        }

        StartNum=StartNum+1;
      $("#loading").hide();
      },
      error:function(){

        alert("出错了，请联系管理员！！！");
        return false;
      },
      complete:function(){
        if(flag==true) {
          ajaxkey2 = false;
        }
        //$("#loading").show();
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
            var isA = checkIsAttention(""+data[i].projectId);
            var word ="";
            var insert ="";
            if(isA==true){
              word="2";
              //insert ="<em about=\"add\" id=\""+data[i].projectId+"\">已关注</em>";
            }else{
              word="1";
              // insert="<i class=\"gz-icon\"></i> <em about=\"add\" id=\""+data[i].projectId+"\">关注</em>";
            }

            if(word=="2"){
              var box = $("<li> <div class=\"text\"> <a href=\"<c:url value='/project/brifProject/'/>"+data[i].projectId+"\"><p class=\"p1\">"+data[i].projectName+"</p></a> <p class=\"p2\">"+levelName+"</p> </div> " +
                      "<div class=\"bt-gz\"> <a class=\"btn-guan\" href=\"javascript:void(0);\" onclick='saveProjectFllow(\""+data[i].projectId+"\")'> "
                      +" <em about=\"add\" id=\""+data[i].projectId+"\">已关注</em></a> </div> <div class=\"img-q\"> <a href=\"<c:url value='/project/brifProject/'/>"+data[i].projectId+"\">" +
                      "<img src=\"http://pro.efeiyi.com/"+data[i].picture_pc_url+"@!pc-find-recommend\"></a> </div>");
            }else{
              var box = $("<li> <div class=\"text\"> <a href=\"<c:url value='/project/brifProject/'/>"+data[i].projectId+"\"><p class=\"p1\">"+data[i].projectName+"</p></a> <p class=\"p2\">"+levelName+"</p> </div> " +
                      "<div class=\"bt-gz\"> <a class=\"btn-guan\" href=\"javascript:void(0);\" onclick='saveProjectFllow(\""+data[i].projectId+"\")'> "
                      +" <i class=\"gz-icon\"></i> <em about=\"add\" id=\""+data[i].projectId+"\">关注</em> </a> </div> <div class=\"img-q\"> <a href=\"<c:url value='/project/brifProject/'/>"+data[i].projectId+"\">" +
                      "<img src=\"http://pro.efeiyi.com/"+data[i].picture_pc_url+"@!pc-find-recommend\"></a> </div>");
            }

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
      url:url+StartNum3,//设置请求的脚本地址
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
            var isA = checkIsAttention(""+data[i].projectId);
            var word ="";
            var insert ="";
            if(isA==true){
              word="已关注";
              insert =  " <em about=\"add\" id=\""+data[i].projectId+"\">"+word+"</em>";
            }else{
              word="关注";
              insert =  "<i class=\"gz-icon\"></i> <em about=\"add\" id=\""+data[i].projectId+"\">"+word+"</em>";
            }

            var box = $("<li> <div class=\"text\"><a href=\"<c:url value='/project/brifProject/'/>"+data[i].projectId+"\"> <p class=\"p1\">"+data[i].projectName+"</p> </a><p class=\"p2\">"+levelName+"</p> </div> " +
                    "<div class=\"bt-gz\"> <a class=\"btn-guan\" href=\"javascript:void(0);\" onclick='saveProjectFllow(\""+data[i].projectId+"\")'> " +insert+
                    " </a> </div> <div class=\"img-q\"> <a href=\"<c:url value='/project/brifProject/'/>"+data[i].projectId+"\">" +
                    "<img src=\"http://pro.efeiyi.com/"+data[i].picture_pc_url+"@!pc-find-recommend\"></a> </div>");
            pubu.append(box);

            //PBL("#beforeAttention",".before",2);
          }

        }else{
          flag = true;
        }

        StartNum3=StartNum3+1;
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
     $(object).attr("class","");
     $(o).attr("about","1");
     $(o).attr("class","active");
     object = o;
   }
  }



  $(window).load(function(){

    //PBL("#beforeAttention",".before",2);
    var winH = $(window).height(); //页面可视区域高度
    $(window).scroll(function(){
      var pageH = $(document).height();
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
      url:"<c:url value='/base/attention.do?projectId='/>"+projectId+"&oper="+oper,//设置请求的脚本地址
      data:"",
      dataType:"json",
      success:function(data){

        if(data=="false"){

          var go = window.confirm("去登录吧?");
          if(go==true){
            window.location.href ="<c:url value='/find.do'/>";
          }
          else{
            return false;//取消
          }
          return false;
        }
        if(data=="true"){

            var parent = $("#"+projectId).parent();
            parent.empty();
            parent.append("<em about=\"del\" id=\""+projectId+"\">已关注</em> </a>");

          return true;
        }
        if(data=="del"){
            var parent = $("#"+projectId).parent();
            parent.empty();
            parent.append("<i class=\"gz-icon\"></i> <em about=\"add\" id=\""+projectId+"\">关注</em> </a>");
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

        /*if(oper=="add" ){
          var parent = $("#"+projectId).parent();
          parent.empty();
          parent.append(" <em about=\"del\" id=\""+projectId+"\">已关注</em> </a>");
        }
        if(oper=="del"){
          var parent = $("#"+projectId).parent();
          parent.empty();
          parent.append("<i class=\"gz-icon\"></i> <em about=\"add\" id=\""+projectId+"\">关注</em> </a>");
        }*/
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
      url:"<c:url value='/base/Isattention/'/>"+projectId,
      data:"",
      async:false,
      dataType:"json",
      success:function(data){
        if(data==false){
          isAttention = false;
          //return false;
        }
        if(data==true){
          isAttention=true;
          //return true;
        }
      },
      error:function(){

        alert("出错了，请联系管理员！！！");
        return false;
      },
      complete:function(){

      }
    });
    return isAttention;
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
  var StartNum3 = 1;
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
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js?uid=" charset="utf-8"></script>
</body>
</html>