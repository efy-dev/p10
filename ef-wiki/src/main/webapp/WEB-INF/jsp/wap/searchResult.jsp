<%@ page import="com.efeiyi.ec.wiki.organization.util.AuthorizationUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html class="no-js">
<head>
    <title></title>
    <link rel="stylesheet" href="<c:url value="/scripts/assets/wap/css/myorder.css?t=20160520"/>">
</head>
<body>
<header id="header" class="am-header custom-header index-header newheader">
    <div class="logo"><a class="icon" style="background:none;width:110px;" href="" title="e飞蚁"><img style="width:100%;top: -10px;position: relative;" src="<c:url value="/scripts/assets/wap/images/ef-logo-craft.png?t=20160520"/>" alt=""/></a></div>
    <!-- //End--logo-->
    <div class="newsearch">
        <form action="<c:url value='/artistrySearch.do'/>" method="get">
            <input type="text" class="newsebox" placeholder="搜" name="q">
            <input type="submit" class="newsebut" value="搜">
        </form>
    </div>
    <div class="am-header-right am-header-nav">
        <% if (AuthorizationUtil.getMyUser().getId() != null) {%>
        <a href="http://i.efeiyi.com/order/myEfeiyi/list.do" class="icon icon-user"></a>
        <%} else {%>
        <a href="<c:url value="/sso.do"/>" class="icon icon-user"></a>
        <%}%>
    </div>
</header>
<div class="craft">
    <div class="list bd">
        <%--<div class="title"></div>--%>
        <ul class="ul-col-2" id="artistryId">
            <c:forEach items="${artistryList}" var="artistry" begin="0" end="7">
                <li>
                    <a href="<c:url value="/project/${artistry.id}"/>" title="">
                        <img src="http://wiki-oss.efeiyi.com/${artistry.getMainPicture().pictureUrl}@!wiki-project-picture" alt="">
                    <span class="txt">
                        <p>${artistry.name}</p>
                        <p><ming800:status name="level" dataType="Project.level" checkedValue="${artistry.getLevel()}" type="normal"/>非遗项目</p>
                    </span>
                    </a>
                </li>
            </c:forEach>
        </ul>
    </div>
     <c:if test="${fn:length(artistryList)>8}">
    <div align="center"><a onclick="moreArtistry()"><span style="color: black">下拉了解更多...</span></a></div>
     </c:if>
</div>

<script type="text/javascript">
    function htmlGenerater(it /**/) {
        var out = '';
        for (var i = 0; i < it.length; i++) {
            out += '<li> <a href="<c:url value="/project/"/>' + (it[i].id) + '"><img src="http://wiki-oss.efeiyi.com/' + (it[i].pictureUrl) + '@!wiki-project-picture"></a><span class="txt"><p>';
            out += it[i].name;
            out += '</p><p>';
            switch(it[i].level){
                case 1:out+='国家级非遗项目';
                       break;
                case 2: out+='省级非遗项目';
                       break;
                case 3: out+='市级非遗项目';
                        break;
                case 4: out+='县级非遗项目';
                        break;
                default : out+='非遗项目';
            }
            out += '</p></span></a></li>';
        }
        return out;
    }
    var count = 2;
    function moreArtistry(){
        var url = "<c:url value='/artistrySearch.do/'/>";
        getArtistryList(url);
    }
    function getArtistryList(url){
        $.ajax({
            type: "get",//设置get请求方式
            url: url+count,//设置请求的脚本地址
            data: {name:'${name}'},//设置请求的数据
            async: true,
            dataType: "json",//设置请求返回的数据格式
            success: function (data) {
                console.log(data);
                count = count + 1;
                if(data != null && data.length > 0) {
                    var box = htmlGenerater(data);
                    $("#artistryId").append(box);
                }
            }
        })
    }
</script>
</body>
</html>
