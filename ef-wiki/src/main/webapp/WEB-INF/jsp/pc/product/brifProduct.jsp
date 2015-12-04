
<%@ page import="com.efeiyi.ec.wiki.organization.util.AuthorizationUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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

<div class="list-find">
  <!--头部-->
  <div class="list-f-title">
    <p><a href="<c:url value='/pc/index.do'/>">工艺</a><i class="fu-icon"></i><a href="<c:url value='/project/brifProject/'/><%=request.getAttribute("projectId")%>">${product.project.name}</a><i class="fu-icon"></i><a href="<c:url value='/project/listProduct/'/><%=request.getAttribute("projectId")%>">作品列表</a><i class="fu-icon"></i><span>作品详情</span></p>
  </div>
  <div class="ae">
    <div class="details ae">
      <div class="detaile-left">
        <div class="detaile-img"><a href="#"><img src="http://pro.efeiyi.com/${product.picture_url}@!pc-product-header"></a></div>
        <div class="detaile-share ae" style="height: auto;z-index: 200;">
          <!-- JiaThis Button BEGIN -->
          <div class="jiathis_style" style="background: #fff;border: 0;float: left;padding: 30px 0;">
            <a class="jiathis_button_weixin"></a>
            <a class="jiathis_button_tqq"></a>
            <a class="jiathis_button_tsina"></a>
            <a class="jiathis_button_cqq"></a>
          </div>
          <!-- JiaThis Button END -->
          <div class="thumb-up">
            <div class="thump-assist">
              <a href="javascript:void(0)" onclick="savaUpAndDown('${product.id}')" id="good-1" name="up"><i class="z-icon"></i><em id="em1">${product.amount}</em></a>
            </div>
            <div class="thump-collect">
              <c:if test="${hasStore ==true}" >
                <a href="javascript:void(0)" onclick="storeProduct('${product.id}')"><i class="s-icon"></i><em>已收藏</em></a>
              </c:if>
              <c:if test="${hasStore ==false}" >
                <a href="javascript:void(0)" onclick="storeProduct('${product.id}')"><i class="s-icon"></i><em>收藏</em></a>
              </c:if>
            </div>
            <%--<div class="thump-enquiry">
              <a href="#" id="btn-xj">询价</a>
            </div>--%>
          </div>
        </div>
        <!--弹出框-->
        <div class="word" style="display: none;" id="word">
          <div class="leave">
            <div class="close ae">
              <div class="pic1"><img src="../shop2015/upload/110209-1img1.png"></div>
              <dl class="name">
                <dt><img src="../shop2015/upload/pep-2.jpg"></dt>
                <dd><h4>张同禄</h4><p>最美景泰蓝</p></dd>
              </dl>
              <div class="word-note">
                <form>
                  <div class="content-pg">
                    <label>留言：</label>
                    <textarea class="worde-r" placeholder="给大师的留言"></textarea>
                  </div>
                  <div class="content-pg">
                    <label></label>
                    <input type="submit" class="btn" value="确&nbsp;&nbsp;&nbsp;定">
                  </div>
                </form>
              </div>
              <div class="shut" id="shut-btn"></div>
            </div>
          </div>
          <div class="leave-bg"></div>
        </div>
        <div class="detaile-intro ae">
          <ul class="intro-matter ae">
            <li class="active">简介</li>
            <li>规格</li>
          </ul>
          <div class="detaile-content">
            <div class="master-tab intro">
              <p>
              ${product.productDescription.content}
              </p>
            </div>
            <div class="master-tab norms" style="display: none">
              <p>作品名称：${product.name}</p>
              <p>意&nbsp;&nbsp; &nbsp; &nbsp;        境：${product.subName}</p>
              <p>创作时间：<fmt:formatDate value="${product.createDateTime}" pattern="yyyy年MM月dd日 HH点mm分ss秒" />
              </p>
              <p>类&nbsp;&nbsp; &nbsp; &nbsp;        别：${product.project.projectCategory.name}</p>
            </div>
          </div>
        </div>
        <!--评论-->
        <div class="detaile-comment ae">
          <form>
            <h4>评论</h4>
            <ul class="comment ae" id="commentAll">


            </ul>
            <div class="review ae">
              <textarea></textarea>
              <div class="btn1 ae">
                <input type="button" onclick="saveProductComment('${product.id}')" class="btn" value="评论" id="commentForProduct">
                <!--<a href="#">取消</a>-->
              </div>
            </div>
          </form>
        </div>
      </div>

      <div class="detaile-right">
        <div class="f-right-gy ae">
          <div class="h4"><span>传承人</span></div>
          <div class="craft-master2">
            <c:if test="${!empty product.master}">
            <ul class="rf">
              <li>
                <div class="text">
                  <a href="http://${product.master.name}.efeiyi.com"><h4>${product.master.fullName}</h4></a>
                  <p>${product.name}</p>
                  <c:choose>
                    <c:when test="${product.master.level =='1'}">
                      <p><span>国家级传承人</span></p>
                    </c:when>
                    <c:when test="${product.master.level =='2'}">
                      <p><span>省级级传承人</span></p>
                    </c:when>
                    <c:when test="${product.master.level =='3'}">
                      <p><span>市级传承人</span></p>
                    </c:when>
                    <c:otherwise>
                      <p><span>县级传承人</span></p>
                    </c:otherwise>
                  </c:choose>
                  <a class="btn-guan" href="javascript:void(0);" onclick="saveMasterFllow('${product.master.id}')">

                    <c:if test="${flag == true}">
                      <input id="saveMasterFllow" type="hidden" value="0">
                      <em>已关注</em>
                    </c:if>
                    <c:if test="${flag == false}">
                      <input id="saveMasterFllow" type="hidden" value="1">
                      <i class="gz-icon"></i><em>关注</em>
                    </c:if>
                  </a>
                </div>
                <div class="img"><a href="http://${product.master.name}.efeiyi.com"><img src="${product.master.favicon}@!pc-project-master"></a></div>
              </li>
            </ul>
            </c:if>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>


<!-- //End--footer-->


<script>
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
      url:"<c:url value='/base/attentionMaster.do?masterId='/>"+masterId+"&oper="+oper,//设置请求的脚本地址
      data:"",
      dataType:"json",
      success:function(data){
        var parentE = $("#saveMasterFllow").parent();
        if(data=="false"){
          var go = window.confirm("去登录吧?");
          if(go==true){
            window.location.href ="<c:url value='/showProduct/${product.id}'/>"+"/${projectId}";
          }
          else{
            return false;//取消
          }
          return false;
        }
        if(data=="true"){
          parentE.empty();
          parentE.append("<input id=\"saveMasterFllow\" type=\"hidden\" value=\"0\"> <em>已关注</em>");
          return true;
        }
        if(data=="del"){
          //var parentE = $("#saveMasterFllow").parent();
            parentE.empty();
            parentE.append("<input id=\"saveMasterFllow\" type=\"hidden\" value=\"1\"> <i class=\"gz-icon\"></i> <em>关注</em>");

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
       /* if(val=="0"){
          //var val = $("#saveMasterFllow").val("1");
          parentE.append("<input id=\"saveMasterFllow\" type=\"hidden\" value=\"1\"> <i class=\"gz-icon\"></i> <em>关注</em>");
        }
        if(val=="1"){
          //var val = $("#saveMasterFllow").val("0");
          parentE.append("<input id=\"saveMasterFllow\" type=\"hidden\" value=\"0\"> <em>已关注</em>");
        }*/
      }
    });
  }
  var startNum=1;
  $(document).ready(function(){
    getData();

    function  getData(){
      $.ajax({
        type:"get",
        url:"<c:url value='/basic/xmj.do?qm=plistProductComment_coment&conditions=product.id:${product.id}&pageEntity.size=5&pageEntity.index='/>"+startNum,
        data:"",
        dataType:"json",
        success:function(data){
          if(data.list && data.list != null){
            for(i in data.list){
              var  pubu =$("#commentAll");
              var cTime =transdate(data.list[i].createDateTime);
              var amout1;
              if(data.list[i].amount==null){
                amout1 =0;
              }else{
                amout1 =data.list[i].amount;
              }
              var userName = data.list[i].user.username.substring(0,3)+"****"+data.list[i].user.username.substring(7,11);
              if(userName==null){
                userName ="匿名用户";
              }

             /* var box = $("<div class='matter' id='"+data.list[i].id+"'> " +
                      "<p class='text-h1'>"+userName+"</p> " +
                      "<p class='text-time'>"+cTime+"</p> " +
                      "<p class='text-content'>" +
                      "<a href='#'onclick='showmodal2(this)' about='"+data.list[i].id+"'>"+data.list[i].content+"</a></p> " +
                      "<div class='owner'><img class='am-circle' src='/scripts/assets/images/120102-p1-11.jpg'/></div> " +
                      "<div class='owner-good'>" +
                      "<a href='#' onclick='commentUpAndDown(this,\""+data.list[i].id+"\")' about='${product.id}' name='up'><i class='good-1'></i><em>"+amout1+"</em></a></div> ");
*/
              var box = $("<li class=\"ae\" id=\""+data.list[i].id+"\" about=\"matter\"> <div class=\"img\"><a href=\"#\"><img class=\"am-circle\" src=\"<c:url value='/scripts/assets/images/120102-p1-11.jpg'/>\"></a></div> " +
                      "<div class=\"text\"><span>" +
                      "<a href=\"#\">"+userName+" ：</a></span>" +
                      "<span>"+data.list[i].content+"</span></div> " +
                      "<div class=\"status ae\"> <div class=\"status-left\">" +
                      "<span>"+cTime+"</span></div> <div class=\"status-right\"> " +
                      "<div class=\"hf\"><a href=\"javascript:void(0)\" onclick=\"getHfProduct(this)\">回复</a></div> " +
                      "<div class=\"zan\"> <a href=\"javascript:void(0)\" onclick='commentUpAndDown(this,\""+data.list[i].id+"\")' about='${product.id}' name='up'><i class=\"icon\"></i> <em>"+amout1+"</em></a> </div>" +
                      " </div> </div> <div class=\"review ae\" style=\"display: none;\"> " +
                      "<textarea></textarea> <div class=\"btn1 ae\"> " +
                      "<input type=\"button\" onclick=\"saveComment2Comment('0', this,'"+userName+"','"+data.list[i].id+"')\" name=\""+data.list[i].id+"\" class=\"btn\" value=\"评论\">  </div> </div> </li> ");

              pubu.append(box);

              //获取盖楼式回复
              getReply(data.list[i].id,userName,true);

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
    var intervalTime = (timestamp + 500 - oldTime)/1000/60;
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

  function commentUpAndDown(data,commentId){
    var oper = $(data).attr("name");
    var productId = $(data).attr("about");
    //alert($(data).children().eq(1).text());
    $.ajax({
      type:"get",
      url:"<c:url value='/base/commentUpAndDown.do?productId='/>"+productId+"&operation="+oper+"&commentId="+commentId,
      data:"",
      async: true,
      dataType:"json",
      success:function(data2){
        if(data2=="false"){
          var go = window.confirm("去登录吧?");
          if(go==true){
            window.location.href ="<c:url value='/showProduct/${product.id}'/>"+"/${projectId}";
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

  function getReply(fatherId,name,flaag){
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
            var userName = data.list[i].user.username.substring(0,3)+"****"+data.list[i].user.username.substring(7,11);
            if(userName==null){
              userName ="匿名用户";
            }

            /*var box = $("<div class='respond' id='"+data.list[i].id+"'> <p><span class='txt-name'>" +
                    "<a href='#'> "+userName+"：</a>" +
                    "</span><span class='txt-content' onclick='showmodal2(this)' about='"+data.list[i].id+"'>"+data.list[i].content+"</span></p> </div> ");*/
            if(flaag==true){
              var box =$(" <ul style=\"position: relative;float:left;margin: 0;\" id=\""+data.list[i].id+"\" about=\"matter\" class=\"commentP\">" +
                      "<li style=\"margin: 0;border-bottom: 0;\" class=\"ae\"  >"
                      +"<div class=\"ae\" > <div class=\"img\"><a href=\"#\"><img class=\"am-circle\" src=\"<c:url value='/scripts/assets/images/120102-p1-11.jpg'/>\"></a></div> " +
                      "<div class=\"text\"><span>" +
                      "<a href=\"#\">"+userName+" 回复 "+name+"：</a></span>" +
                      "<span>"+data.list[i].content+"</span></div> " +
                      "<div class=\"status ae\"> <div class=\"status-left\">" +
                      "<span>"+cTime+"</span></div> <div class=\"status-right\"> " +
                      "<div class=\"ef\"><a href=\"javascript:void(0)\" onclick=\"getHfProduct2(this)\">回复</a></div> " +
                      "<div class=\"zan\"> <a href=\"javascript:void(0)\" onclick='commentUpAndDown(this,\""+data.list[i].id+"\")' about='${product.id}' name='up'><i class=\"icon\"></i> <em>"+amout1+"</em></a> </div>" +
                      " </div> </div> <div class=\"review-sr ae\" style=\"display: none;\"> " +
                      "<textarea></textarea> <div class=\"btn1 ae\"> " +
                      "<input type=\"button\" onclick=\"saveComment2Comment('1', this,'"+userName+"','"+data.list[i].id+"')\" name=\""+data.list[i].id+"\"  class=\"btn\" value=\"评论\">  </div> </div> </div></li></ul> ");
              pubu.append(box);
            }
            if(flaag==false){
              var box =$("  <li style=\"margin: 0;border-bottom: 0;\" class=\"ae\" id=\""+data.list[i].id+"\" about=\"matter\"" +
                      ">"
              +"<div class=\"ae\" > <div class=\"img\"><a href=\"#\"><img class=\"am-circle\" src=\"<c:url value='/scripts/assets/images/120102-p1-11.jpg'/>\"></a></div> " +
                      "<div class=\"text\"><span>" +
                      "<a href=\"#\">"+userName+" 回复 "+name+"：</a></span>" +
                      "<span>"+data.list[i].content+"</span></div> " +
                      "<div class=\"status ae\"> <div class=\"status-left\">" +
                      "<span>"+cTime+"</span></div> <div class=\"status-right\"> " +
                      "<div class=\"ef\"><a href=\"javascript:void(0)\" onclick=\"getHfProduct2(this)\">回复</a></div> " +
                      "<div class=\"zan\"> <a href=\"javascript:void(0)\" onclick='commentUpAndDown(this,\""+data.list[i].id+"\")' about='${product.id}' name='up'><i class=\"icon\"></i> <em>"+amout1+"</em></a> </div>" +
                      " </div> </div> <div class=\"review-sr ae\" style=\"display: none;\"> " +
                      "<textarea></textarea> <div class=\"btn1 ae\"> " +
                      "<input type=\"button\" onclick=\"saveComment2Comment('1', this,'"+userName+"','"+data.list[i].id+"')\"  name=\""+data.list[i].id+"\" class=\"btn\" value=\"评论\">  </div> </div> </div> ");
              //$("#"+fatherId).parent(".commentP").append(box);
              $(".commentP").append(box);
            }

            //获取盖楼式回复
            getReply(data.list[i].id,userName,false);

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
function getHfProduct(e){

    $(e).parent().parent().parent().parent().find('.review').slideToggle();
    return false;

}

  function getHfProduct2(e){

    $(e).parent().parent().parent().parent().find(".review-sr").slideToggle();
    return false;

  }

  function saveProductComment(data){
    var CommentValue = $("#commentForProduct").parent().parent().children().eq(0).val();
    if(CommentValue==null || CommentValue==""){
      alert("你未发表任何评论，请评论");
      return false;
    }
    $.ajax({
      type:"get",
      url:"<c:url value='/product/saveComment.do?productId='/>"+data+"&content="+CommentValue,
      data:"",
      dataType:"json",
      async:true,
      success:function(o){
        if(o==false){
          var go = window.confirm("去登录吧?");
          if(go==true){
            window.location.href ="<c:url value='/showProduct/'/>"+data+"/"+"${projectId}";
          }
          else{
            return false;//取消
          }
          return false;
        }
        var amout1;
        if(o.amount==null){
          amout1 =0;
        }else{
          amout1 =o.amount;
        }
        $("#commentAll").append("<li class=\"ae\" id=\""+o.id+"\" about=\"matter\"> <div class=\"img\"><a href=\"#\"><img class=\"am-circle\" src=\"<c:url value='/scripts/assets/images/120102-p1-11.jpg'/>\"></a></div> " +
                "<div class=\"text\"><span>" +
                "<a href=\"#\">${fn:substring(myUser.username, 0,3 )}****${fn:substring(myUser.username,7,11)} ：</a></span>" +
                "<span>"+CommentValue+"</span></div> " +
                "<div class=\"status ae\"> <div class=\"status-left\">" +
                "<span>刚刚</span></div> <div class=\"status-right\"> " +
                "<div class=\"hf\"><a href=\"javascript:void(0)\" onclick=\"getHfProduct(this)\">回复</a></div> " +
                "<div class=\"zan\"> <a href=\"javascript:void(0)\" onclick='commentUpAndDown(this,\""+o.id+"\")' about='${product.id}' name='up'><i class=\"icon\"></i> <em>"+amout1+"</em></a> </div>" +
                " </div> </div> <div class=\"review ae\" style=\"display: none;\"> " +
                "<textarea></textarea> <div class=\"btn1 ae\"> " +
                "<input type=\"submit\" name=\""+o.id+"\" class=\"btn\" value=\"评论\">  </div> </div> </li>");
      },
      error:function(){
        alert("出错了，请联系管理员！！！");
        return false;
      },
      complete:function(){
        $("#commentForProduct").parent().parent().children().eq(0).val("");
      }
    });
  }

  function saveComment2Comment(fag,e,name,data){
    var CommentValue = $(e).parent().parent().children().eq(0).val();
    if(CommentValue==null || CommentValue==""){
      alert("你未发表任何评论，请评论");
      return false;
    }
    $.ajax({
      type:"get",
      url:"<c:url value='/product/saveComment2.do?productId=${product.id}'/>"+"&content="+CommentValue+"&contentId="+data,
      data:"",
      dataType:"json",
      async:true,
      success:function(o){
        if(o==false){
          var go = window.confirm("去登录吧?");
          if(go==true){
            window.location.href ="<c:url value='/showProduct/${product.id}'/>"+"/${projectId}";
          }
          else{
            return false;//取消
          }
          return false;
        }
        var amout1;
        if(o.amount==null){
          amout1 =0;
        }else{
          amout1 =o.amount;
        }
        if(fag=='0'){
          $("#"+data).append("<ul style=\"position: relative;float:left;margin: 0;\" id=\""+o.id+"\" about=\"matter\" class=\"commentP\">" +
                  "<li style=\"margin: 0;border-bottom: 0;\" class=\"ae\"  >"
                  +"<div class=\"ae\" > <div class=\"img\"><a href=\"#\"><img class=\"am-circle\" src=\"<c:url value='/scripts/assets/images/120102-p1-11.jpg'/>\"></a></div> " +
                  "<div class=\"text\"><span>" +
                  "<a href=\"#\">${fn:substring(myUser.username, 0,3 )}****${fn:substring(myUser.username,7,11)} 回复 "+name+"：</a></span>" +
                  "<span>"+CommentValue+"</span></div> " +
                  "<div class=\"status ae\"> <div class=\"status-left\">" +
                  "<span>刚刚" +
                  "</span></div> <div class=\"status-right\"> " +
                  "<div class=\"ef\"><a href=\"javascript:void(0)\" onclick=\"getHfProduct2(this)\">回复</a></div> " +
                  "<div class=\"zan\"> <a href=\"javascript:void(0)\" onclick='commentUpAndDown(this,\""+o.id+"\")' about='${product.id}' name='up'><i class=\"icon\"></i> <em>"+amout1+"</em></a> </div>" +
                  " </div> </div> <div class=\"review-sr ae\" style=\"display: none;\"> " +
                  "<textarea></textarea> <div class=\"btn1 ae\"> " +
                  "<input type=\"button\" onclick=\"saveComment2Comment('1', this,'"+name+"','"+data+"')\"  name=\""+o.id+"\" class=\"btn\" value=\"评论\">  </div> </div> </div></li></ul>");
        }
        if(fag=='1'){
          $("#"+data).append("" +
                  "<li style=\"margin: 0;border-bottom: 0;\" class=\"ae\" id=\""+o.id+"\" about=\"matter\" >"
                  +"<div class=\"ae\" > <div class=\"img\"><a href=\"#\"><img class=\"am-circle\" src=\"<c:url value='/scripts/assets/images/120102-p1-11.jpg'/>\"></a></div> " +
                  "<div class=\"text\"><span>" +
                  "<a href=\"#\">${fn:substring(myUser.username, 0,3 )}****${fn:substring(myUser.username,7,11)} 回复 "+name+"：</a></span>" +
                  "<span>"+CommentValue+"</span></div> " +
                  "<div class=\"status ae\"> <div class=\"status-left\">" +
                  "<span>刚刚" +
                  "</span></div> <div class=\"status-right\"> " +
                  "<div class=\"ef\"><a href=\"javascript:void(0)\" onclick=\"getHfProduct2(this)\">回复</a></div> " +
                  "<div class=\"zan\"> <a href=\"javascript:void(0)\" onclick='commentUpAndDown(this,\""+o.id+"\")' about='${product.id}' name='up'><i class=\"icon\"></i> <em>"+amout1+"</em></a> </div>" +
                  " </div> </div> <div class=\"review-sr ae\" style=\"display: none;\"> " +
                  "<textarea></textarea> <div class=\"btn1 ae\"> " +
                  "<input type=\"button\" onclick=\"saveComment2Comment('1', this,'"+name+"','"+data+"')\"  name=\""+o.id+"\" class=\"btn\" value=\"评论\">  </div> </div> </div></li></ul>");
        }

      },
      error:function(){
        alert("出错了，请联系管理员！！！");
        return false;
      },
      complete:function(){
        $(e).parent().parent().children().eq(0).val("");
        $(e).parents().find('.review-sr').slideUp();
        $(e).parents().find('.review').slideUp();
      }
    });
  }


  function savaUpAndDown(ds){
    var oper = $("#good-1").attr("name");
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
            window.location.href ="<c:url value='/showProduct/'/>"+ds+"/${projectId}";
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
          if($("#good-1").attr("name")=="down"){
            $("#good-1").attr("name","up");
          }else{
            $("#good-1").attr("name","down");
          }
          $("#em1").html(parseInt($("#em1").text())+1);
        }
        if(data2=="true" && oper=='down'){
          if($("#good-1").attr("name")=="down"){
            $("#good-1").attr("name","up");
          }else{
            $("#good-1").attr("name","down");
          }
          $("#em1").html(parseInt($("#em1").text())-1);
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

  function commentUpAndDown(data,commentId){
    var oper = $(data).attr("name");
    var productId = $(data).attr("about");
    //alert($(data).children().eq(1).text());
    $.ajax({
      type:"get",
      url:"<c:url value='/base/commentUpAndDown.do?productId='/>"+productId+"&operation="+oper+"&commentId="+commentId,
      data:"",
      async: true,
      dataType:"json",
      success:function(data2){
        if(data2=="false"){
          //alert("您还未登录，请登录后再操作！！！");
          var go = window.confirm("去登录吧?");
          if(go==true){
            window.location.href ="<c:url value='/showProduct/'/>"+productId+"/${projectId}";
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
          if( $(data).attr("name")=="up"){
            $(data).attr("name","down");
          }else{
            $(data).attr("name","up");
          }
        }
        if(data2=="true" && oper=='down'){
          $(data).children().eq(1).html(parseInt( $(data).children().eq(1).text())-1);
          if( $(data).attr("name")=="up"){
            $(data).attr("name","down");
          }else{
            $(data).attr("name","up");
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

  function storeProduct(productId){

    $.ajax({
      type:"get",
      url:"<c:url value='/base/storeProduct.do?productId='/>"+productId,//设置请求的脚本地址
      data:"",
      dataType:"json",
      success:function(data){
        if(data=="false"){
          //alert("您还未登录，请登录后再操作");
          //window.location.href ="http://passport.efeiyi.com/login?service=http://master.efeiyi.com/ef-wiki/sso.do";
          var go = window.confirm("去登录吧?");
          if(go==true){
            window.location.href ="<c:url value='/showProduct/'/>"+productId+"/${projectId}";
          }
          else{
            return false;//取消
          }
          return false;
        }
        if(data=="repeat"){
          //alert("您已收藏过了！");
          $('.details .detaile-left .detaile-share .thumb-up .thump-collect a').find('em').html('收藏');
          return true;
        }
        if(data=="true"){
          //alert("您好，收藏成功！");
          $('.details .detaile-left .detaile-share .thumb-up .thump-collect a').find('em').html('已收藏');
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
</script>
<!-- //End--footer-->
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js?uid=" charset="utf-8"></script>
</body>
</html>


