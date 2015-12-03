
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

  <title>e飞蚁工艺秀</title>

</head>
<body>

<!-- //End--header-->
<div class="craft-details ">
  <div class="nav-bars ae">
    <ul class="bars">
      <li ><a href="<c:url value='/pc/index.do'/>">热&nbsp;门</a></li>
      <%if(AuthorizationUtil.getMyUser().getId()==null || "no".equalsIgnoreCase(request.getAttribute("isShow").toString()) ){%>
      <li class="active"><a href="<c:url value='/pc/beforeAttention.do'/>">关注</a></li>
      <%}%>
      <%
        if(AuthorizationUtil.getMyUser().getId()!=null && "ok".equalsIgnoreCase(request.getAttribute("isShow").toString()) ){
      %>
      <li class="active"><a href="<c:url value='/pc/afterAttention.do'/>">关注</a></li>
      <%}%>

      <li><a href="<c:url value='/pc/category'/>">发&nbsp;现</a></li>
    </ul>
  </div>
</div>
<!--nav-bars-->
<div class="home-craft">
  <div class="craft-details">

    <!-- //End--nav-->
    <div class="craft-gz ae" style="display: block" id="afterAttention">
      <!--标题-->
      <div class="craft-wz ae"><span>共关注${fsAmount}个工艺</span></div>
      <!-- 一个循环文件-->
      <%--<div class="craft-l-content ae">
        <!--左边名称文件-->

      </div>--%>

    </div>
  </div>
</div>



<script>

  $(document).ready(function(){
    getData("<c:url value='/pc/afterAtJ.do?qm=plistProjectFollowed2_isShow&conditions=&pageEntity.size=10&pageEntity.index='/>");
  });

  function getData(url){
    var flag = false;
    $.ajax({
      type:"get",//设置get请求方式
      url:url+StartNum2,//设置请求的脚本地址
      data:"",//设置请求的数据
      async:true,
      dataType:"json",//设置请求返回的数据格式
      beforeSend:function(){
        $("#loading").show();
      },
      success:function(data){
        var pubu = $("#afterAttention");
        if(data && data.length>=1){
          for(i in data){
           var container =$(" <div class=\"craft-l-content ae\"></div>");
            var box = $("<div class=\"craft-dt ae\"> <div class=\"img-dt\"> <a href=\"<c:url value='/project/brifProject/'/>"+data[i].projectModel.projectId+"\"><img src=\"http://pro.efeiyi.com/"+data[i].projectModel.picture_pc_url+"@!pc-after-attention\"></a>" +
                    "<a href=\"#\"> <div class=\"list-moods\"> <i class=\"img-icon\"></i> <em>"+data[i].projectModel.fsAmount+"</em> </div> " +
                    "</a> </div> <div class=\"img-txt\"> <p>"+data[i].projectModel.projectName+"</p> <div class=\"xz-max\"> " +
                    "<a href=\"<c:url value='/project/listProduct/'/>"+data[i].projectModel.projectId+"\"><div class=\"xz-left\">"+data[i].projectModel.works+"</div> </a><div class=\"xz-right\"> " +
                    "<div></div> <div>幅作品</div> </div> </div> " +
                    "<p class=\"p1\">&nbsp;<a href=\"<c:url value='/project/brifMaster/'/>"+data[i].projectModel.projectId+"\"><span>"+data[i].projectModel.masters+"</span></a>&nbsp;位大师</p> </div> " +
                    "</div>");

            container.append(box);
            var subBox = $("<div class=\"craft-dd ae\"> <ul></ul> </div>");
            if(data[i] && data[i].products.length>=1){

              for(j in data[i].products){
               var subChrildBox = ("<li><a href=\"<c:url value='/project/showProduct/'/>"+data[i].products[j].id+"/"+data[i].projectModel.projectId+"\"><img src=\"http://pro.efeiyi.com/"+data[i].products[j].picture_url+"@!pc-after-attention-1\"></a><p>"+
                        "<a href=\"#\">"+data[i].products[j].name+"</a></p></li> ");
                subBox.children().eq(0).append(subChrildBox);
              }

            }
            container.append(subBox);
            pubu.append(container);
            //PBL("#beforeAttention",".before",2);
          }

        }else{
          flag = true;
        }

        StartNum2=StartNum2+1;
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
      }
    })
  }

  $(window).load(function(){

    //PBL("#beforeAttention",".before",2);
    var winH = $(window).height(); //页面可视区域高度
    $(window).scroll(function(){
      var pageH = $(document.body).height();
      var scrollT = $(window).scrollTop(); //滚动条top
      var aa = (pageH - winH - scrollT) / winH;
      if(aa < 0.02){
        if(ajaxkey2){
          getData("<c:url value='/pc/afterAtJ.do?qm=plistProjectFollowed2_isShow&conditions=&pageEntity.size=10&pageEntity.index='/>");
        }

      }


    });




  });



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
  var StartNum2 = 1;
  var ajaxkey = true;//设置ajax请求的开关,如需动态加载、需要打开这个开关
  var ajaxkey2 = true;
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

</script>
<!-- //End--footer-->
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js?uid=" charset="utf-8"></script>
</body>
</html>


