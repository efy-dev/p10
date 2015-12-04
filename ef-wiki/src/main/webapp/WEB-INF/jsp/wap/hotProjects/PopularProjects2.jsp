<%@ page import="com.efeiyi.ec.wiki.organization.util.AuthorizationUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/14
  Time: 9:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.lang.*" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html class="no-js">
<head>

  <title>热门工艺</title>

</head>
<body style=" overflow: scroll; ">
<script>

</script>

<div class="great">
  <header class="am-header custom-header">
    <div class="am-header-left am-header-nav">
      <a href="javascript:window.history.go(-1);" class="chevron-left"></a>
    </div>
    <!-- //End--chevron-left-->
    <h1 class="am-header-title">工艺</h1>
    <!-- //End--title-->
    <div class="am-header-right am-header-nav am-header-right1">
      <a href="#chevron-right" class="chevron-right" id="menu">
        <i class="icon icon-user"></i>
      </a>
    </div>
  </header>
  <!--//End--header-->
  <!--地区-->
  <div class="dis-q1">
    <div class="dis-q1-tabs">
      <ul class="tabs-nav tabs-nav-1" id="wikiNav">
        <li class="item" id="0">热门</li>
        <li class="item active" id="1">关注</li>
        <li class="item-class"><a href="<c:url value='/category.do'/>">分类</a></li>
      </ul>
      <ul class="tabs-nav tabs-nav-2">
        <li class="item active">分类</li>
        <li class="item">级别</li>
        <li class="item">地区</li>
      </ul>
      <div class="tabs-bd">
        <div class="am-tab-panel" style="padding:10px 0 15px 0;width: 100%;float: left;display: none;" id="pubu">
          <c:if test="${!empty  popularProjectsList}">
            <c:forEach var="ppj" items="${popularProjectsList}">
              <ul class="hot" id="box">
                <li>
                  <a href="<c:url value='/base/brifProject/${ppj.project.id}/1'/>"><img src="http://pro.efeiyi.com/${ppj.project.picture_wap_url}"></a>
                  <div class="hot-poge">
                    <span style="margin-right: 1rem">人气</span>
                 <%-- <span>${fn:length(ppj.project.projectFolloweds)}</span>--%>
                    <span><c:if test="${ppj.project.fsAmount == null}">0</c:if><c:if test="${ppj.project.fsAmount != null}">${ppj.project.fsAmount}</c:if></span>
                  </div>
                </li>
              </ul>
            </c:forEach>
          </c:if>
        </div>
        <div class="am-tab-panel am-active" >
          <div class="suit">
            <div class="dynamic" style="border-bottom: 0;">

              <%if(AuthorizationUtil.getMyUser().getId()==null || "no".equalsIgnoreCase(request.getAttribute("isShow").toString()) ){%>

                <div class="suit">
                    <div class="dynamic" style="border-bottom:0;">
                        <div class="suit-focus">
                            <div class="title">您可能喜欢的工艺:</div>
                            <div class="div-list">

                                <c:if test="${!empty  attentionProjectsList}">
                                 <ul>
                                    <c:forEach var="apj" items="${attentionProjectsList}">
                                    <li>
                                        <p class="tb">
                                            <a href="<c:url value='/base/brifProject/${apj.project.id}/1'/>"><img src="http://pro.efeiyi.com/${apj.project.picture_wap_url}"></a>
                                            <c:if test="${apj.attention=='0'}">
                                            <a class="icon-guanzu" id="${apj.project.id}" href="javascript:void(0);" onclick="saveProjectFllow('${apj.project.id}')" about="0">关注</a>
                                            </c:if>
                                            <c:if test="${apj.attention=='1'}">
                                                <a class="icon-guanzu" id="${apj.project.id}" href="javascript:void(0);" onclick="saveProjectFllow('${apj.project.id}')" about="1">已关注</a>
                                            </c:if>
                                        </p>
                                        <P>${apj.project.name}</P>
                                    </li>
                                    </c:forEach>
                                 </ul>
                                </c:if>
                            </div>
                            <a href="#上一页" title="上一页" class="btn-gz top-btn"></a>
                            <a href="#下一页" title="下一页" class="btn-gz bot-btn"></a>
                        </div>
                        <div class="attention">
                            <p>以下是您关注的相关工艺的最新动态</p>
                        </div>
                        <div class="dynamic">
                            <%if(AuthorizationUtil.getMyUser().getId()!=null){%>
                            <ul class="suit-zt-2" id="hadAttentionProjects">

                            </ul>
                            <%}%>

                        </div>
                    </div>
                </div>


              <%}%>
              <c:if test="${isShow =='no'}">
                <input id="flag" type="hidden" name="flag" value="front" />
              </c:if>
              <c:if test="${isShow =='ok'}">
                <input id="flag" type="hidden" name="flag" value="back" />
              </c:if>
              <%
                if(AuthorizationUtil.getMyUser().getId()!=null && "ok".equalsIgnoreCase(request.getAttribute("isShow").toString()) ){

              %>

              <div class="dynamic" id="after">
                <ul class="suit-zt-2" id="attention">


                </ul>
              </div>
              <%}%>
            </div>
          </div>

        </div>
      </div>
    </div>
    <!--地区-->
<%--     <div class="login-reg">
         <%if(AuthorizationUtil.getMyUser()!=null && AuthorizationUtil.getMyUser().getId() != null){ %>
         <div class="bd logined"><%=AuthorizationUtil.getMyUser().getUsername()%><a class="btn-exit" href="<c:url value='/j_spring_cas_security_logout'/>">退出</a></div>
         <% } %>
         <%if(AuthorizationUtil.getMyUser()==null || AuthorizationUtil.getMyUser().getId() == null){ %>
         <a href="<c:url value='/sso.do'/>" class="btn-login" title="登录">登&nbsp;&nbsp;&nbsp;&nbsp;录</a>
         <a href="http://passport.efeiyi.com/register?service=http://http://master.efeiyi.com/ef-wiki/sso.do" class="btn-reg">注&nbsp;&nbsp;&nbsp;&nbsp;册</a>
         <% } %>

    </div>--%>
</div>
</div>
<script>

    $(window).load(function(){
        //getData("<c:url value='/basic/xmj.do?qm=plistProjectRecommended_default&conditions=&pageEntity.size=10&pageEntity.index='/>");
        PBL("#pubu","#box",2);
        //var ajaxkey = true;
        var winH = $(window).height(); //页面可视区域高度
        $(window).scroll(function(){
            var pageH = $(document.body).height();
            var scrollT = $(window).scrollTop(); //滚动条top
            var aa = (pageH - winH - scrollT) / winH;
            //alert(aa)
            if(aa < 0.02){
                // if (getDataCheck() && ajaxkey) {
                //if (ajaxkey) {
                $("#wikiNav li").each(function(index,element){

                    if($(element).attr("class")=="item active"){

                        //if($(element).children().attr("href")=="[data-tab-panel-0]"){
                        if($(element).attr("id")=="0"){
                            if(ajaxkey1){
                                PBL("#pubu","#box",2);
                                getData1("<c:url value='/basic/xmj.do?qm=plistProjectRecommended_default&conditions=&pageEntity.size=10&pageEntity.index='/>");//jquery的Ajax异步加载数据、需要从数据库加载的、需要调用该函数

                            }

                        }
                        if($(element).attr("id")=="1"){
                            var flag = $("#flag").val();
                            //alert(flag)
                            if(ajaxkey && flag=="front"){
                                //PBL("#recommends","#recommend",2);
                                //getData("<c:url value='/basic/xmj.do?qm=plistProjectRecommended_default&conditions=&pageEntity.size=10&pageEntity.index='/>");
                            }
                            if(ajaxkey2 && flag=="back"){
                                PBL("#after","#attention",2);
                                getData4("<c:url value='/base/afterAttention.do?conditions=&pageEntity.size=10&pageEntity.index='/>");
                            }
                        }
                        if($(element).attr("id")=="2"){

                        }
                    }

                });
                // getData("/basic/xmj.do?qm=plistProjectRecommended_default&conditions=&pageEntity.size=10&pageEntity.index=");//jquery的Ajax异步加载数据、需要从数据库加载的、需要调用该函数

                // };

            }


        });




    });

    function saveProjectFllow(projectId){

        var ab = $("#"+projectId).attr("about");
        var oper;
        if(ab=='0'){
            oper ='add';
        }else{
            oper ='del';
        }
        $.ajax({
            type:"get",
            url:"<c:url value='/base/attention.do?projectId='/>"+projectId+"&oper="+oper,//设置请求的脚本地址
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
                    $("#"+projectId).html("已关注");
                    $("#"+projectId).attr("about","1");
                    return true;
                }
                if(data=="del"){
                    $("#"+projectId).html("关注");
                    $("#"+projectId).attr("about","0");
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

            }
        });
    }

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
                    return false;
                }
                if(data==true){
                    isAttention=true;
                    return true;
                }
            },
            error:function(){

                alert("出错了，请联系管理员！！！");
                return false;
            },
            complete:function(){

            }
        })

    }





    //请求数据的方法
    function getData(url){
        var flag = false;
        $.ajax({
            type:"get",//设置get请求方式
            url:url+StartNum2,//设置请求的脚本地址
            data:"",//设置请求的数据
            dataType:"json",//设置请求返回的数据格式
            success:function(data){
                var pubu = $("#recommend");
                if(data.list && data.list != null){
                    for(i in data.list){

                        var projectid = data.list[i].project.id;
                        var word ="关注";
                        var at='0';
                        checkIsAttention(projectid);
                        if(isAttention==true){
                            word = "已关注";
                            at='1';
                        }
                        var box = $("<li> <div class='suit-list-bt'>" +
                                "<a href=\"<c:url value='/base/brifProject/'/>"+data.list[i].project.id+"/1\"> <img src='http://pro.efeiyi.com/"+data.list[i].project.picture_wap_url+"'></a>" +
                                " <a class='gz-fd-icon' about='"+at+"' id='"+projectid+"' href='#' onclick='saveProjectFllow(\""+projectid+"\")'>" +
                                word +
                                "</a> </div> </li>");

                        pubu.append(box);

                    }

                }else{
                    flag = true;
                }
                PBL("#recommends","#recommend",2);
                StartNum2=StartNum2+1;
            },
            error:function(){

                alert("出错了，请联系管理员！！！");
                return false;
            },
            complete:function(){
                if(flag==true)
                    ajaxkey = false;
            }
        });


    }

    //请求数据的方法
    function getData1(url){
        var flag = false;
        $.ajax({
            type:"get",//设置get请求方式
            url:url+StartNum,//设置请求的脚本地址
            data:"",//设置请求的数据
            dataType:"json",//设置请求返回的数据格式
            success:function(data){
                var pubu = $("#pubu");
                if(data.list && data.list != null){
                    for(i in data.list){

                        var moods = data.list[i].project.fsAmount;
                        if(moods==null) moods=0;
                        var box = $("<ul class='hot' id='box'>" +
                                "<li><a href=\"<c:url value='/base/brifProject/'/>"+data.list[i].project.id+"/1\"><img src='http://pro.efeiyi.com/"+data.list[i].project.picture_wap_url+"'></a> " +
                                "<div class='hot-poge'> <span style='margin-right: 1rem'>人气</span> " +
                                "<span>"+moods+"</span> " +
                                "</div></li> </ul>");
                        pubu.append(box);
                    }

                }else{
                    //alert("no data!!!");
                    flag = true;
                }
                PBL("#pubu","#box",2);
                StartNum=StartNum+1;
            },
            error:function(){

                alert("出错了，请联系管理员！！！");
                return false;
            },
            complete:function(){
                if(flag==true) {
                    ajaxkey1 = false;}
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
    var afterNum2=2;
    var ajaxkey2=true;
    //请求数据的方法
    function getData4(url){
        var flag = false;
        $.ajax({
            type:"get",//设置get请求方式
            url:url+afterNum2,//设置请求的脚本地址
            data:"",//设置请求的数据
            dataType:"json",//设置请求返回的数据格式
            success:function(data){
                var pubu = $("#attention");

                if(data && data.length>=1){
                    for(i in data){
                        for(var key in data[i]){
                            var box = $(" <li> <div class=\"suit-zt--2-img am-u-sm-5 am-u-end\">" +
                                    " <a href=\"<c:url value='/base/brifProject/'/>"+data[i][key].project.id+"/1\"><img src=\"http://pro.efeiyi.com/"+data[i][key].project.picture_wap_url+"\"> " +
                                    "<div class=\"tp-bg-0\"> " +
                                    "<table> <tr><td>" +
                                    "<div style=\"padding: 0 1rem;\">"+data[i][key].project.name+"</div></td></tr> </table> " +
                                    "</div></a> </div> <div class=\"suit-zt--2-text am-u-sm-7 am-u-end\"> " +
                                    "<h4>"+data[i][key].project.name+"详情更新了</h4> <p>" +
                                    "<a href=\"<c:url value='/base/brifProject/'/>"+data[i][key].project.id+"/2\"> 增加相关作品"+key+"幅</a></p> </div> </li> </ul>");

                        }

                        pubu.append(box);

                    }

                }else{
                    flag = true;
                }
                PBL("#after","#attention",2);
                afterNum2=afterNum2+1;
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

    $(function(){
    //动态--关注--分类导航
    var tabsNav=$('.dis-q1-tabs .tabs-nav-1');
    var tabsBd=$('.tabs-bd .am-tab-panel');
    tabsNav.find('.item').click(function(){
        var index=$(this).index();
        $(this).addClass('active').siblings('.item').removeClass('active');
        tabsBd.eq(index).show().siblings('.am-tab-panel').hide();

        $.ajax({
            type:"get",//设置get请求方式
            url:"<c:url value='/base/afterAttention.do?conditions=&pageEntity.size=10&pageEntity.index=1'/>",
            data:"",//设置请求的数据
            async:false,
            dataType:"json",
            success:function(data){
                var pubu = $("#hadAttentionProjects");
                pubu.empty();
                if(data && data.length>=1){
                    for(i in data){
                        for(var key in data[i]){
                            var box = $(" <li> <div class=\"suit-zt--2-img am-u-sm-5 am-u-end\">" +
                                    " <a href=\"<c:url value='/base/brifProject/'/>"+data[i][key].project.id+"/1\"><img src=\"http://pro.efeiyi.com/"+data[i][key].project.picture_wap_url+"\"> " +
                                    "<div class=\"tp-bg-0\"> " +
                                    "<table> <tr><td>" +
                                    "<div style=\"padding: 0 1rem;\">"+data[i][key].project.name+"</div></td></tr> </table> " +
                                    "</div></a> </div> <div class=\"suit-zt--2-text am-u-sm-7 am-u-end\"> " +
                                    "<h4>"+data[i][key].project.name+"详情更新了</h4> <p>" +
                                    "<a href=\"<c:url value='/base/brifProject/'/>"+data[i][key].project.id+"/2\"> 增加相关作品"+key+"幅</a></p> </div> </li> </ul>");

                        }

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

            }
        })




        //自定义加载数据函数
        $("#wikiNav li").each(function(index,element){

            if($(element).attr("class")=="item active"){
                if($(element).attr("id")=="1"){
                    var flag = $("#flag").val();

                    if(flag=="back"){
                        PBL("#after","#attention",2);
                        getData3("<c:url value='/base/afterAttention.do?conditions=&pageEntity.size=10&pageEntity.index='/>");
                    }
                }

            }

        });
    })
    })
</script>

</body>
</html>