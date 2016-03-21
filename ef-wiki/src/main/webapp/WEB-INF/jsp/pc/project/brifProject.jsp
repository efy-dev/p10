
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

  <title>【${project.name}】${project.name}-${project.addressDistrict.addressCity.addressProvince.name}-e飞蚁</title>
  <meta name="keywords" content="${project.name},${project.name}大全,中国${project.name},${project.name}教程,${project.name}艺术" />
  <meta name="description" content="${project.description}" />
</head>
<body>

<!-- //End--header-->
<%--<div class="craft-details">//20160302日修改
  <div class="craft-banner">
    <img src="http://pro.efeiyi.com/${project.picture_pc_url}@!pc-project-header">
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
       &lt;%&ndash; <div class="attention">
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
        </div>&ndash;%&gt;
        &lt;%&ndash;<div class="attention-page">
          <span>已经被 <em id="gzNum">${project.fsAmount}</em> 个景泰蓝爱好者关注</span>
        </div>&ndash;%&gt;
      </div>
    </div>
  </div>
  <div class="ae">
    <ul class="craft-nav">
      <li class="active"><a href="<c:url value='/project/brifProject/${project.id}'/>">介&nbsp;绍</a></li>
     &lt;%&ndash; <li><a href="<c:url value='/project/brifMaster/${project.id}'/>">大&nbsp;师</a></li>
      <li><a href="<c:url value='/project/listProduct/${project.id}'/>">作&nbsp;品</a></li>&ndash;%&gt;
    </ul>
    <div class="craft-max ae">
      <div class="craft-introduce1 ae" style="display: block">
        ${project.projectContents[0].content}
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
          //alert("您还未登陆，请登录后再操作");
          var go = window.confirm("去登录吧?");
          if(go==true){
            window.location.href ="<c:url value='/brifProject/'/>"+projectId;
          }
          else{
            return false;//取消
          }
          return false;
        }
        if(data=="true"){
          $("#"+projectId).empty();
          $("#"+projectId).append("<input id=\"saveProjectFllow\" type=\"hidden\" value=\"0\">  <em>已关注此工艺</em>");
          $("#gzNum").text((parseInt($("#gzNum").text())+1));
          mark = true;
          return true;
        }
        if(data=="del"){
          $("#"+projectId).empty();
          $("#"+projectId).append("<input id=\"saveProjectFllow\" type=\"hidden\" value=\"1\"> <i class=\"atten-icon\"></i> <em>关注此工艺</em>");
          $("#gzNum").text((parseInt($("#gzNum").text())-1));
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


</script>
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js?uid=" charset="utf-8"></script>--%>


<div class="ae">
  <div class="particulars">
    <div class="title ae">
      <h2>${project.name}</h2>
      <div class="label"><span>地区：<strong>${project.addressDistrict.addressCity.addressProvince.name}</strong></span><span>级别：
        <strong><c:choose>
          <c:when test="${project.level  eq '1'}">国家级非物质文化遗产</c:when>
          <c:when test="${project.level  eq '2'}">省级非物质文化遗产</c:when>
          <c:when test="${project.level  eq '3'}">市级非物质文化遗产</c:when>
          <c:otherwise>县级非物质文化遗产</c:otherwise>
        </c:choose></strong></span></div>
    </div>
    <div class="p-right">
      <div class="ae">${project.description}</div>
      <div class="recommend ae">
        <h5>您可能会喜欢的作品</h5>
        <ul class="rec-pic ae" id="tuijian">
          <%--<li>
            <a href="#">
              <img src="http://pro.efeiyi.com/product/zhutu120151111155544.jpg@!product-detail-pc-view" alt=""/>
              <p>喜庆富贵瓶</p>
            </a>
          </li>
          <li>
            <a href="#">
              <img src="http://pro.efeiyi.com/product/zhutu520151111155615.jpg@!product-detail-pc-view" alt=""/>
              <p>福禄寿喜财尊</p>
            </a>
          </li>
          <li>
            <a href="#">
              <img src="http://pro.efeiyi.com/product/zhutu320151111155556.jpg@!product-detail-pc-view" alt=""/>
              <p>景泰蓝吉福垒</p>
            </a>
          </li>
          <li>
            <a href="#">
              <img src="http://pro.efeiyi.com/product/zhutu620151111155624.jpg@!product-detail-pc-view" alt=""/>
              <p>富贵百龄瓶</p>
            </a>
          </li>--%>
        </ul>
      </div>
    </div>
  </div>
</div>
<script type="application/javascript">
  (function($){
    $.ajax({
      type:"get",
      url:"<c:url value='http://www.efeiyi.com/product/recommend/listProductModel.do?projectId=${project.id}'/>",
      data:"",
      dataType:"jsonp",
      jsonp:"jsonpcallback",
      success:function(data){
        if(data){
        if(  data.length>=1&& data.length<5){
        var tuijian = $("#tuijian");
          for(i in data){
            var li = $("<li> <a href=\"http://www.efeiyi.com/product/productModel/${project.id}\">" +
                    "<img src=\"http://pro.efeiyi.com/"+data[i].productModel_url+"\" alt=''>" +
                    "<p>"+data[i].name+"</p> </a> </li>");
            tuijian.append(li);
          }
        }else{
          var tuijian = $("#tuijian");
          for(i in data){
            if(i>=4){break;};
            var li = $("<li> <a href=\"http://www.efeiyi.com/product/productModel/${project.id}\"> " +
                    "<img src='http://pro.efeiyi.com/"+data[i].productModel_url+"' alt=''>" +
                    "<p>"+data[i].name+"</p> </a> </li>");
            tuijian.append(li);
          }
        }
        }
      },
      error:function(){
        console.log("出错了，请联系管理员！！！");
        return false;
      },
      complete:function(){
      }
    });
  })(jQuery);
</script>
</body>
</html>


