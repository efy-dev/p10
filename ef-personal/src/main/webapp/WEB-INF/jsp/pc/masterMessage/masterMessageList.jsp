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
</head>
<body style="float: left">
<div class="hd" style="width: 1000px;">
    <div class="nav-bars ae">
        <ul class="bars">
            <li class="active"><a href="<c:url value='/masterMessage/index.do'/>">推&nbsp;荐</a></li>
            <%--<li class="active"><a href="#">动&nbsp;态</a></li>--%>
            <%--<c:if test="${result == 'show'}">--%>
            <%--<li><a href="<c:url value='/masterMessage/forwardUrl'/>">关注</a></li>--%>
            <%--</c:if>--%>
            <%--<c:if test="${result == 'hide'}">--%>
            <%--<li><a href="<c:url value='/masterMessage/getFollowBeforeList'/>">关注</a></li>--%>
            <%--</c:if>--%>
            <li><a href="<c:url value='/masterMessage/classify'/>">发&nbsp;现</a></li>
        </ul>
    </div>
</div>
<div class="home-craft">
    <div class="craft-details">
        <div class="cart-tabe">
            <div class="craft-zy" style="display: block">
                <c:if test="${!empty masters}">
                    <c:forEach items="${masters}" var="pc" varStatus="status">
                        <div class="craft-content ae">
                            <h4>${pc.key}</h4>
                            <a href="#" class="left-icon"></a>
                            <div class="commodity-list ae">
                                <ul>
                                    <c:if test="${!empty pc.key}">
                                        <c:forEach items="${pc.value}" var="master" varStatus="status">
                                            <li>
                                                <div class="commodity-img">
                                                    <a href="<c:url value='/masterMessage/masterDetails/${master.id}'/>"><img
                                                            src="http://tenant.efeiyi.com/${master.favicon}"></a>
                                                    <a href="#">
                                                        <div class="list-moods">
                                                            <i class="img-icon"></i>
                                                            <%--<em>${master.fullName}</em>--%>
                                                        </div>
                                                    </a>
                                                </div>
                                                <div class="commodity-txt">
                                                    <h4><a href="#">${master.fullName}</a></h4></p>
                                                    <p>第一批
                                                        <c:choose>
                                                            <c:when test="${master.level == '1'}">
                                                                国家级
                                                            </c:when>
                                                            <c:when test="${master.level == '2'}">
                                                                省级
                                                            </c:when>
                                                            <c:when test="${master.level == '3'}">
                                                                市级
                                                            </c:when>
                                                            <c:otherwise>
                                                                县级
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                    <p>${master.originProvince.name}</p>
                                                </div>
                                            </li>
                                        </c:forEach>
                                    </c:if>
                                </ul>
                            </div>
                            <a href="#" class="right-icon"></a>
                        </div>
                    </c:forEach>
                </c:if>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function(){
        $("#pages").html("推荐大师 - e飞蚁");
    })
</script>
<!--nav-bars-->
<%--<div class="ae">--%>
<%--<div class="pc-dynamic" >--%>
<%--<div class="p-dy-left" style="margin-bottom: 102px;">--%>
<%--<ul class="list-dynamic ae" id="pubu">--%>
<%----%>
<%--</ul>--%>
<%--<div align="center" id="loding" style="display: none;"><img src="<c:url value='/scripts/assets/images/loding-1.gif'/>"></div>--%>
<%--</div>--%>
<%--<div class="p-dy-right">--%>
<%--<div class="f-right-gy ae">--%>
<%--<div class="h4"><span>热门大师</span></div>--%>
<%--<ul class="gy-grounp ae" id="hotMaster">--%>

<%--</ul>--%>
<%--<div class="f-r-gd ae"><a href="<c:url value='/masterMessage/classify'/>"><span>更多大师</span><i class="sp-icon"></i></a></div>--%>
<%--</div>--%>
<%--<div class="f-right-gy ae">--%>
<%--<div class="h4"><span>新加入大师</span></div>--%>
<%--<ul class="gy-grounp ae" id="newInsert">--%>

<%--</ul>--%>
<%--<div class="f-r-gd ae"><a href="<c:url value='/masterMessage/classify'/>"><span>更多大师</span><i class="sp-icon"></i></a></div>--%>
<%--</div>--%>
<%--</div>--%>
<%--</div>--%>
<%--</div>--%>
<%--<script>--%>
    <%--//存储开始请求数据条数的位置--%>
    <%--var StartMessageNum = 1;--%>
    <%--var StartMasterNum = 1;--%>
    <%--var StartRecommendNum = 1;--%>
    <%--var ajaxKey = true;//设置ajax请求的开关,如需动态加载、需要打开这个开关--%>
    <%--$(document).ready(function () {--%>
        <%--$("#pages").html("大师动态 - e飞蚁");--%>
        <%--getData("<c:url value='/masterMessage/mainData/plistMasterMessage_default/0/4/'/>");--%>
        <%--getData2("<c:url value='/masterMessage/subMaster/plistMaster_default/6/'/>");--%>
        <%--getData3("<c:url value='/masterMessage/hotMaster/plistMasterRecommend_group/6/'/>");--%>
    <%--});--%>

    <%--$(window).load(function () {--%>
        <%--var winH = $(window).height(); //页面可视区域高度--%>
        <%--$(window).scroll(function () {--%>
            <%--var pageH = $(document).height();--%>
            <%--var scrollT = $(window).scrollTop(); //滚动条top--%>
            <%--var aa = (pageH - winH - scrollT) / winH;--%>
            <%--if (aa < 0.02) {--%>
                <%--if (ajaxKey) {--%>
                    <%--getData("<c:url value='/masterMessage/mainData/plistMasterMessage_default/0/4/'/>");--%>
                <%--}--%>
            <%--}--%>
        <%--});--%>
    <%--});--%>
    <%--function transdate(endTime) {--%>
        <%--var timestamp = Date.parse(new Date());--%>
        <%--var oldTime = parseInt(endTime);--%>
        <%--var intervalTime = (timestamp - oldTime) / 1000 / 60;--%>
        <%--var showTime = "";--%>
        <%--if (intervalTime <= 59) {--%>
            <%--showTime = intervalTime.toFixed(0) + "分钟前";--%>
        <%--} else if (1 <= (intervalTime / 60) && (intervalTime / 60) < 24) {--%>
            <%--showTime = (intervalTime / 60).toFixed(0) + "小时前";--%>
        <%--} else if (1 <= (intervalTime / 60 / 24) && (intervalTime / 60 / 24) <= 30) {--%>
            <%--showTime = (intervalTime / 60 / 24).toFixed(0) + "天前";--%>
        <%--} else {--%>
            <%--showTime = new Date(oldTime).toLocaleString().replace(/:\d{1,2}$/, ' ');--%>
        <%--}--%>
        <%--return showTime;--%>
    <%--}--%>
    <%--function getData(url) {--%>
        <%--var flag = false;--%>
        <%--$.ajax({--%>
            <%--type: "get",//设置get请求方式--%>
            <%--url: url + StartMessageNum,//设置请求的脚本地址--%>
            <%--data: "",//设置请求的数据--%>
            <%--dataType: "json",//设置请求返回的数据格式--%>
            <%--success: function (data) {--%>
                <%--StartMessageNum = StartMessageNum + 1;--%>
                <%--var pubu = $("#pubu");--%>
                <%--console.log(data);--%>
                <%--if (data != null && data.length > 0) {--%>
                    <%--for (var i in data) {--%>
                        <%--var cTime = transdate(data[i].createDateTime);--%>
                        <%--var levelName = "";--%>
                        <%--if (data[i].level == "1") {--%>
                            <%--levelName = "国际级";--%>
                        <%--} else if (data[i].level == "2") {--%>
                            <%--levelName = "国家级";--%>
                        <%--} else if (data[i].level == "3") {--%>
                            <%--levelName = "省级";--%>
                        <%--} else if (data[i].level == "4") {--%>
                            <%--levelName = "市级";--%>
                        <%--} else if (data[i].level == "5") {--%>
                            <%--levelName = "县级";--%>
                        <%--}--%>

                        <%--if (data[i].projectName != null) {--%>
                            <%--var projectName = "<p>" + data[i].projectName + "</p>";--%>
                        <%--} else {--%>
                            <%--var projectName = "";--%>
                        <%--}--%>
                        <%--var sub = "<li>" +--%>
                                <%--"                    <div class=\"pc-dy-txt ae\">" +--%>
                                <%--"                        <div class=\"pc-dy-pic \">" +--%>
                                <%--"                            <div class=\"pc-d-pic\"><a href=\"<c:url value='/masterMessage/masterView/'/>" + data[i].masterId + "\"><img  class=\"am-circle\"  src=\"http://tenant.efeiyi.com/" + data[i].favicon + "@!tenant-mobile-view-icon\"></a></div>" +--%>
                                <%--"                            <div class=\"pc-gz gz-pc\">" +--%>
                                <%--"                                <div class=\"bt-gz act-1\">" +--%>
                                <%--"                                    <a class=\"btn-guan\" name=\"masterFollow" + data[i].masterId + "\" onclick=\"followMaster('" + data[i].masterId + "');\">" +--%>
                                <%--"                                        <div class=\"gz-q\">";--%>
                        <%--if (data[i].followStatus == "已关注") {--%>
                            <%--sub += "<i class=\"gz-icon\" style='display: none'></i>";--%>
                        <%--} else {--%>
                            <%--sub += "<i class=\"gz-icon\"></i>";--%>
                        <%--}--%>
                        <%--sub += "                                      <em>" + data[i].followStatus + "</em>" +--%>
                                <%--"                                        </div>" +--%>
                                <%--"                                    </a>" +--%>
                                <%--"                                </div>" +--%>
                                <%--"                            </div>" +--%>
                                <%--"                        </div>" +--%>
                                <%--"                        <div class=\"pc-dy-box\">" +--%>
                                <%--"                            <h5><a href=\"<c:url value='/masterMessage/masterView/'/>" + data[i].masterId + "\">" + data[i].masterName + "</a></h5>" +--%>
                                <%--"                            <p>" + projectName + "</p>" +--%>
                                <%--"                            <p>" + levelName + "非遗传承人</p>" +--%>
                                <%--"                            <div class=\"pc-dy-content\">" +--%>
                                <%--"                                <a href=\"<c:url value='/masterMessage/getMessageView/'/>" + data[i].id + "\"><p>" + data[i].remark + "</p></a>";--%>
                        <%--var attr = data[i].messageAttachmentLists;--%>
                        <%--if (attr != null && attr.length == 1) {--%>
                            <%--sub += "<div class=\"one-pic\"><a href=\"<c:url value='/masterMessage/getMessageView/'/>" + data[i].id + "\"><img src=\"http://tenant.efeiyi.com/" + attr.pictureUrl + "@!master-message-little-more\"></a></div>";--%>
                        <%--} else if (attr != null && attr.length > 1) {--%>
                            <%--if (attr.length < 5) {--%>
                                <%--sub += "<div class=\"two-pic w-active\"><ul class=\"sudoku\">";--%>
                            <%--} else {--%>
                                <%--sub += "<div class=\"two-pic\"><ul class=\"sudoku\">";--%>
                            <%--}--%>
                            <%--for (var j in attr) {--%>
                                <%--sub += "<li><a href=\"<c:url value='/masterMessage/getMessageView/'/>" + data[i].id + "\"><img src=\"http://tenant.efeiyi.com/" + attr[j].pictureUrl + "@!master-message-little-more\"></a></li>";--%>
                            <%--}--%>
                            <%--sub += "</ul></div>";--%>
                        <%--}--%>
                        <%--sub += "                                <div class=\"one-tiem\"><span>" + cTime + "</span><span>来自&nbsp;" + data[i].dataSource + "</span></div>" +--%>
                                <%--"                            </div>" +--%>
                                <%--"                        </div>" +--%>
                                <%--"                    </div>" +--%>
                                <%--"                    <div class=\"one-state\">" +--%>
                                <%--"                        <ul class=\"state\" >" +--%>
                                <%--"                            <li>" +--%>
                                <%--"                                <a onclick=\"praiseMessage(this,'" + data[i].id + "');\">" +--%>
                                <%--"                                    <span class=\"pos\">" +--%>
                                <%--"                                        <span class=\"line noline\">" +--%>
                                <%--"                                            <i class=\"dnc-icon zq\"></i>" +--%>
                                <%--"                                            <em>赞" + data[i].praiseNum + "</em>" +--%>
                                <%--"                                        </span>" +--%>
                                <%--"                                    </span>" +--%>
                                <%--"                                </a>" +--%>
                                <%--"                            </li>" +--%>
                                <%--"                            <li>" +--%>
                                <%--"                                <a href=\"<c:url value='/masterMessage/getMessageView/'/>" + data[i].id + "\">" +--%>
                                <%--"                                    <span class=\"pos\">" +--%>
                                <%--"                                        <span class=\"line\">" +--%>
                                <%--"                                            <i class=\"dnc-icon-2 zq\"></i>" +--%>
                                <%--"                                            <em>评论" + data[i].amount + "</em>" +--%>
                                <%--"                                        </span>" +--%>
                                <%--"                                    </span>" +--%>
                                <%--"                                </a>" +--%>
                                <%--"                            </li>" +--%>
                                <%--"                            <li>" +--%>
                                <%--"                                <a name='store" + data[i].id + "' onclick=\"storeMessage(this,'" + data[i].id + "');\">" +--%>
                                <%--"                                    <span class=\"pos\">" +--%>
                                <%--"                                        <span class=\"line\">" +--%>
                                <%--"                                            <i class=\"dnc-icon-3 zq\"></i>" +--%>
                                <%--"                                            <em>" + data[i].storeStatus + "</em>" +--%>
                                <%--"                                        </span>" +--%>
                                <%--"                                    </span>" +--%>
                                <%--"                                </a>" +--%>
                                <%--"                            </li>" +--%>
                                <%--"                            <li style=\"position: relative\">" +--%>
                                <%--"                                <a onclick=\"showJiathis(this);\">" +--%>
                                <%--"                                    <span class=\"pos\">" +--%>
                                <%--"                                        <span class=\"line\">" +--%>
                                <%--"                                            <i class=\"dnc-icon-4 zq\"></i>" +--%>
                                <%--"                                            <em>分享</em>" +--%>
                                <%--"                                        </span>" +--%>
                                <%--"                                    </span>" +--%>
                                <%--"                                </a>" +--%>
                                <%--"                                <div style='display: none;' class=\"nr-share\">" +--%>
                                <%--"                                    <div class=\"nr-bg\">" +--%>
                                <%--"                                        <div class=\"jiathis_style\">" +--%>
                                <%--"                                            <a class=\"jiathis_button_weixin\"></a>" +--%>
                                <%--"                                            <a class=\"jiathis_button_tqq\"></a>" +--%>
                                <%--"                                            <a class=\"jiathis_button_tsina\"></a>" +--%>
                                <%--"                                            <a class=\"jiathis_button_cqq\"></a>" +--%>
                                <%--"                                        </div>" +--%>
                                <%--"                                    </div>" +--%>
                                <%--"                                </div><script type=\"text/javascript\" src=\"http://v3.jiathis.com/code/jia.js\" charset=\"utf-8\"/>" +--%>
                                <%--"                            </li>" +--%>
                                <%--"                        </ul>" +--%>
                                <%--"                    </div>" +--%>
                                <%--"                </li>";--%>
                        <%--pubu.append(sub);--%>
                    <%--}--%>
                <%--} else {--%>
                    <%--flag = true;--%>
                <%--}--%>
            <%--},--%>
            <%--complete: function () {--%>
                <%--$("#loding").hide();--%>
                <%--if (flag == true) {--%>
                    <%--ajaxKey = false;--%>
                <%--}--%>
            <%--}, beforeSend: function () {--%>
                <%--$("#loding").show();--%>
            <%--}--%>
        <%--})--%>
    <%--}--%>
    <%--function showJiathis(o) {--%>
        <%--var next = $(o).parent().find(".nr-share");--%>
        <%--if ($(next).is(":hidden")) {--%>
<%--//          $(next).attr("style","display:block");--%>
            <%--$(next).show();--%>
        <%--} else {--%>
<%--//          $(next).attr("style","display:none");--%>
            <%--$(next).hide();--%>
        <%--}--%>
    <%--}--%>

    <%--function getData2(url) {--%>
        <%--var flag = false;--%>
        <%--$.ajax({--%>
            <%--type: "get",//设置get请求方式--%>
            <%--url: url + StartMasterNum,//设置请求的脚本地址--%>
            <%--data: "",//设置请求的数据--%>
            <%--async: true,--%>
            <%--dataType: "json",//设置请求返回的数据格式--%>
            <%--success: function (data) {--%>
                <%--StartMasterNum = StartMasterNum + 1;--%>
                <%--var rightUp = $("#newInsert");--%>
                <%--if (data != null && data.length > 0) {--%>
                    <%--for (var i in data) {--%>
                        <%--var levelName = "";--%>
                        <%--if (data[i].level == "1") {--%>
                            <%--levelName = "国家级";--%>
                        <%--} else if (data[i].level == "2") {--%>
                            <%--levelName = "省级";--%>
                        <%--} else if (data[i].level == "3") {--%>
                            <%--levelName = "市级";--%>
                        <%--} else if (data[i].level == "4") {--%>
                            <%--levelName = "县级";--%>
                        <%--}--%>
                        <%--var box = "<li>" +--%>
                                <%--"            <div class=\"text\">" +--%>
                                <%--"              <p class=\"p1\"><a href=\"<c:url value='/masterMessage/introView/'/>" + data[i].id + "\">" + data[i].masterName + "</a></p>" +--%>
                                <%--"              <p class=\"p2\">" + data[i].projectName + "</p>" +--%>
                                <%--"              <p class=\"p2\">" + levelName + "非遗传承人</p>" +--%>
                                <%--"            </div>" +--%>
                                <%--"            <div class=\"bt-gz\">" +--%>
                                <%--"              <a class=\"btn-guan\" name=\"masterFollow" + data[i].id + "\" onclick=\"followMaster('" + data[i].id + "');\">" +--%>
                                <%--"                <div class=\"gz-q\">";--%>
                        <%--if (data[i].followStatus == "已关注") {--%>
                            <%--box += "<i class=\"gz-icon\" style='display: none'></i>";--%>
                        <%--} else {--%>
                            <%--box += "<i class=\"gz-icon\"></i>";--%>
                        <%--}--%>
                        <%--box += "<em>" + data[i].followStatus + "</em>" +--%>
                                <%--"                </div>" +--%>
                                <%--"              </a>" +--%>
                                <%--"            </div>" +--%>
                                <%--"            <div class=\"img-q\">" +--%>
                                <%--"              <a href=\"<c:url value='/masterMessage/introView/'/>" + data[i].id + "\"><img src=\"http://tenant.efeiyi.com/" + data[i].favicon + "@!tenant-mobile-tenant-list\"></a>" +--%>
                                <%--"            </div>" +--%>
                                <%--"          </li>";--%>
                        <%--rightUp.append(box);--%>
                    <%--}--%>
                <%--} else {--%>
                    <%--flag = true;--%>
                <%--}--%>
            <%--},--%>
            <%--complete: function () {--%>
                <%--if (flag == true) {--%>
                    <%--ajaxkey = false;--%>
                <%--}--%>
            <%--}--%>
        <%--})--%>
    <%--}--%>
    <%--function moreMaster() {--%>
        <%--var url = "<c:url value='/masterMessage/subMaster/plistMaster_default/6/'/>";--%>
        <%--getData2(url);--%>
    <%--}--%>

    <%--function getData3(url) {--%>
        <%--var flag = false;--%>
        <%--$.ajax({--%>
            <%--type: "get",//设置get请求方式--%>
            <%--url: url + StartRecommendNum,//设置请求的脚本地址--%>
            <%--data: "",//设置请求的数据--%>
            <%--async: true,--%>
            <%--dataType: "json",//设置请求返回的数据格式--%>
            <%--success: function (data) {--%>
                <%--StartRecommendNum = StartRecommendNum + 1;--%>
                <%--var rightDown = $("#hotMaster");--%>
                <%--if (data != null && data.length > 0) {--%>
                    <%--for (var i in data) {--%>
                        <%--var levelName = "";--%>
                        <%--if (data[i].level == "1") {--%>
                            <%--levelName = "国家级";--%>
                        <%--} else if (data[i].level == "2") {--%>
                            <%--levelName = "省级";--%>
                        <%--} else if (data[i].level == "3") {--%>
                            <%--levelName = "市级";--%>
                        <%--} else if (data[i].level == "4") {--%>
                            <%--levelName = "县级";--%>
                        <%--}--%>
                        <%--var box = "<li>" +--%>
                                <%--"            <div class=\"text\">" +--%>
                                <%--"              <p class=\"p1\"><a href=\"<c:url value='/masterMessage/introView/'/>" + data[i].id + "\">" + data[i].masterName + "</a></p>" +--%>
                                <%--"              <p class=\"p2\">" + data[i].projectName + "</p>" +--%>
                                <%--"              <p class=\"p2\">" + levelName + "非遗传承人</p>" +--%>
                                <%--"            </div>" +--%>
                                <%--"            <div class=\"bt-gz\">" +--%>
                                <%--"              <a class=\"btn-guan\" name=\"masterFollow" + data[i].id + "\" onclick=\"followMaster('" + data[i].id + "');\">" +--%>
                                <%--"                <div class=\"gz-q\">";--%>
                        <%--if (data[i].followStatus == "已关注") {--%>
                            <%--box += "<i class=\"gz-icon\" style='display: none'></i>";--%>
                        <%--} else {--%>
                            <%--box += "<i class=\"gz-icon\"></i>";--%>
                        <%--}--%>
                        <%--box += "<em>" + data[i].followStatus + "</em>" +--%>
                                <%--"                </div>" +--%>
                                <%--"              </a>" +--%>
                                <%--"            </div>" +--%>
                                <%--"            <div class=\"img-q\">" +--%>
                                <%--"              <a href=\"<c:url value='/masterMessage/introView/'/>" + data[i].id + "\"><img src=\"http://tenant.efeiyi.com/" + data[i].favicon + "@!tenant-mobile-tenant-list\"></a>" +--%>
                                <%--"            </div>" +--%>
                                <%--"          </li>";--%>
                        <%--rightDown.append(box);--%>
                    <%--}--%>
                <%--} else {--%>
                    <%--flag = true;--%>
                <%--}--%>
            <%--},--%>
            <%--complete: function () {--%>
                <%--if (flag == true) {--%>
                    <%--ajaxkey = false;--%>
                <%--}--%>
            <%--}--%>
        <%--})--%>
    <%--}--%>
    <%--function moreHotMaster() {--%>
        <%--var url = "<c:url value='/masterMessage/hotMaster/plistMasterRecommend_group/6/'/>";--%>
        <%--getData3(url);--%>
    <%--}--%>

    <%--function followMaster(masterId) {--%>
        <%--var str;--%>
        <%--$.ajax({--%>
            <%--type: "post",//设置get请求方式--%>
            <%--url: "<c:url value='/masterMessage/followMaster.do'/>",//设置请求的脚本地址--%>
            <%--data: "masterId=" + masterId,//设置请求的数据--%>
            <%--async: true,--%>
            <%--dataType: "json",//设置请求返回的数据格式--%>
            <%--success: function (data) {--%>
                <%--if (data == "noRole") {--%>
                    <%--alert("您还未登录,请登录后操作!");--%>
                <%--} else if (data == "add") {--%>
                    <%--str = "已关注";--%>
                    <%--//$(this).find('.gz-icon').hide();--%>
                    <%--changeFollowStatus(masterId, str);--%>
                <%--} else if (data == "del") {--%>
                    <%--str = "关注";--%>
                    <%--changeFollowStatus(masterId, str);--%>
                <%--}--%>
            <%--}--%>
        <%--})--%>
    <%--}--%>
    <%--function changeFollowStatus(masterId, str) {--%>
        <%--$("a[name='masterFollow" + masterId + "']").each(function () {--%>
            <%--$(this).find("em").html(str);--%>
            <%--if (str == "关注") {--%>
                <%--$(this).find('.gz-icon').show();--%>
            <%--} else if (str == "已关注") {--%>
                <%--$(this).find('.gz-icon').hide();--%>
            <%--}--%>
        <%--})--%>
    <%--}--%>

    <%--function praiseMessage(o, msgId) {--%>
        <%--$.ajax({--%>
            <%--type: "get",//设置get请求方式--%>
            <%--url: "<c:url value='/masterMessage/praiseMessage.do'/>",//设置请求的脚本地址--%>
            <%--data: "msgId=" + msgId,//设置请求的数据--%>
            <%--async: true,--%>
            <%--dataType: "json",//设置请求返回的数据格式--%>
            <%--success: function (data) {--%>
                <%--var next = $(o).find("em");--%>
                <%--var amount = parseInt(next.html().substring(1, next.html().length));--%>
                <%--console.log(next.html() + "----" + amount);--%>
                <%--if (data == "noRole") {--%>
                    <%--alert("您还没有登录,请登录后操作!");--%>
                <%--} else if (data == "add") {--%>
                    <%--next.html("赞" + (amount + 1));--%>
                <%--} else if (data == "del") {--%>
                    <%--next.html("赞" + (amount - 1));--%>
                <%--}--%>
            <%--}--%>
        <%--})--%>
    <%--}--%>

    <%--function storeMessage(o, msgId) {--%>
        <%--$.ajax({--%>
            <%--type: "get",//设置get请求方式--%>
            <%--url: "<c:url value='/masterMessage/storeMessage.do'/>",//设置请求的脚本地址--%>
            <%--data: "msgId=" + msgId,//设置请求的数据--%>
            <%--async: true,--%>
            <%--dataType: "json",//设置请求返回的数据格式--%>
            <%--success: function (data) {--%>
                <%--if (data == "noRole") {--%>
                    <%--alert("您还没有登录,请登录后操作!");--%>
                <%--} else if (data == "add") {--%>
                    <%--$(o).find("em").html("已收藏");--%>
                <%--} else if (data == "del") {--%>
                    <%--$(o).find("em").html("收藏");--%>
                <%--}--%>
            <%--}--%>
        <%--})--%>
    <%--}--%>

<%--</script>--%>

<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value='/scripts/assets/js/amazeui.ie8polyfill.min.js'/>"></script>
<![endif]-->
<script src="<c:url value='/scripts/assets/pc/js/system.js'/>"></script>
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
<script src="<c:url value='/scripts/assets/pc/js/cyclopedia.js'/>"></script>
</body>
</html>

