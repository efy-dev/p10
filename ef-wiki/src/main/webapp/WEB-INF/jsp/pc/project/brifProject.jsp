
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
<div class="craft-details">
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
          <span>已经被 <em id="gzNum">${project.fsAmount}</em> 个景泰蓝爱好者关注</span>
        </div>
      </div>
    </div>
  </div>
  <div class="ae">
    <ul class="craft-nav">
      <li class="active"><a href="<c:url value='/project/brifProject/${project.id}'/>">介&nbsp;绍</a></li>
      <li><a href="<c:url value='/project/brifMaster/${project.id}'/>">大&nbsp;师</a></li>
      <li><a href="<c:url value='/project/listProduct/${project.id}'/>">作&nbsp;品</a></li>
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
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js?uid=" charset="utf-8"></script>
</body>
</html>


