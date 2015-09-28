<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/25
  Time: 17:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html class="no-js">
<head>
    <title>非遗名录</title>
</head>
<body>
<!-- //End--slide-left-->
<div class="slide-right">
    <div class="title">国家非物质文化遗产国家名录项目</div>
    <div class="div-list">
        <div class="filter-item">
            <div class="wh stone">
                <div class="tbar">申报批次：</div>
                <ul id="batch">
                    <li><a href="#" class="active" title="全部" target="_self" onclick="batchClick(this, '全部');">全部</a></li>
                    <li><a href="#" title="第一批" target="_self" onclick="batchClick(this, '第一批');">第一批</a></li>
                    <li><a href="#" title="第二批" target="_self" onclick="batchClick(this, '第二批');">第二批</a></li>
                    <li><a href="#" title="第三批" target="_self" onclick="batchClick(this, '第三批');">第三批</a></li>
                </ul>
            </div>
            <div class="wh theme">
                <div class="tbar">申报地区：</div>
                <ul id="pro">
                    <li><a href="" class="active" title="">全部</a></li>
                    <c:forEach items="${provinceList}" var="province">
                        <li><a href="#" title="" target="_self" onclick="projectClick(this, '${province.id}');">${province.name}</a></li>
                    </c:forEach>
                    <%--<li><a href="" title="">北京</a></li>
                    <li><a href="" title="">天津</a></li>
                    <li><a href="" title="">河北</a></li>
                    <li><a href="" title="">山西</a></li>
                    <li><a href="" title="">辽宁</a></li>
                    <li><a href="" title="">吉林</a></li>
                    <li><a href="" title="">上海</a></li>
                    <li><a href="" title="">江苏</a></li>
                    <li><a href="" title="">浙江</a></li>
                    <li><a href="" title="">安徽</a></li>
                    <li><a href="" title="">福建</a></li>
                    <li><a href="" title="">江西</a></li>
                    <li><a href="" title="">山东</a></li>
                    <li><a href="" title="">河南</a></li>
                    <li><a href="" title="">湖北</a></li>
                    <li><a href="" title="">湖南</a></li>
                    <li><a href="" title="">广东</a></li>
                    <li><a href="" title="">广西</a></li>
                    <li><a href="" title="">海南</a></li>
                    <li><a href="" title="">重庆</a></li>
                    <li><a href="" title="">四川</a></li>
                    <li><a href="" title="">贵州</a></li>
                    <li><a href="" title="">云南</a></li>
                    <li><a href="" title="">西藏</a></li>
                    <li><a href="" title="">陕西</a></li>
                    <li><a href="" title="">甘肃</a></li>
                    <li><a href="" title="">青海</a></li>
                    <li><a href="" title="">宁夏</a></li>
                    <li><a href="" title="">新疆</a></li>
                    <li><a href="" title="">香港</a></li>
                    <li><a href="" title="">澳门</a></li>
                    <li><a href="" title="">台湾</a></li>
                    <li><a href="" title="">内蒙古</a></li>
                    <li><a href="" title="">黑龙江</a></li>--%>
                </ul>
            </div>
            <div class="wh sjape">
                <div class="tbar">项目类别：</div>
                <ul id="type">
                    <li><a href="#" title="" class="active" target="_self" onclick="typeClick(this, '全部');">全部</a></li>
                    <li><a href="#" title="" target="_self" onclick="typeClick(this, '民间文学');">民间文学</a></li>
                    <li><a href="#" title="" target="_self" onclick="typeClick(this, '传统音乐');">传统音乐</a></li>
                    <li><a href="#" title="" target="_self" onclick="typeClick(this, '传统舞蹈');">传统舞蹈</a></li>
                    <li><a href="#" title="" target="_self" onclick="typeClick(this, '传统戏剧');">传统戏剧</a></li>
                    <li><a href="#" title="" target="_self" onclick="typeClick(this, '曲艺');">曲艺</a></li>
                    <li><a href="#" title="" target="_self" onclick="typeClick(this, '传统体育、游艺与杂技');">传统体育、游艺与杂技</a></li>
                    <li><a href="#" title="" target="_self" onclick="typeClick(this, '传统美术');">传统美术</a></li>
                    <li><a href="#" title="" target="_self" onclick="typeClick(this, '传统技艺');">传统技艺</a></li>
                    <li><a href="#" title="" target="_self" onclick="typeClick(this, '传统医药');">传统医药</a></li>
                    <li><a href="#" title="" target="_self" onclick="typeClick(this, '民俗');">民俗</a></li>
                </ul>
            </div>
        </div>
        <!-- //End--filter-item-->
        <div id="show" class="list-table">
            <table>
                <tr>
                    <td>协会</td>
                    <td>传承人</td>
                    <td>类别</td>
                </tr>
                <%--<tr>
                    <td>刺绣委员会</td>
                    <td>姚惠芬</td>
                    <td>织染印秀</td>
                </tr>
                <tr>
                    <td>刺绣委员会</td>
                    <td>姚惠芬</td>
                    <td>织染印秀</td>
                </tr>
                <tr>
                    <td>刺绣委员会</td>
                    <td>姚惠芬</td>
                    <td>织染印秀</td>
                </tr>
                <tr>
                    <td>刺绣委员会</td>
                    <td>姚惠芬</td>
                    <td>织染印秀</td>
                </tr>
                <tr>
                    <td>刺绣委员会</td>
                    <td>姚惠芬</td>
                    <td>织染印秀</td>
                </tr>
                <tr>
                    <td>刺绣委员会</td>
                    <td>姚惠芬</td>
                    <td>织染印秀</td>
                </tr>
                <tr>
                    <td>刺绣委员会</td>
                    <td>姚惠芬</td>
                    <td>织染印秀</td>
                </tr>
                <tr>
                    <td>刺绣委员会</td>
                    <td>姚惠芬</td>
                    <td>织染印秀</td>
                </tr>--%>
            </table>
        </div>
    </div>
    <!-- //End--div-list-->
    <div class="pages wh">
        <ul class="am-pagination am-pagination-centered">
            <li><a href="">首页</a></li>
            <li><a href="">上一页</a></li>
            <li class="am-active"><a href="">1</a></li>
            <li><a href="">2</a></li>
            <li><a href="">3</a></li>
            <li><a href="">4</a></li>
            <li><a href="">5</a></li>
            <li><a href="">...</a></li>
            <li><a href="#">9</a></li>
            <li><a href="#">10</a></li>
            <li class="am-disabled bigRound"><a href="#">下一页</a></li>
            <li class="pages-total">共135条</li>
            <li class="pages-nums">第01/35页</li>
        </ul>
    </div>
    <!-- //End--pages-->
</div>
<!-- //End--slide-right-->
<script type="text/javascript">
    function batchClick(object, val){
        $("#batch a").removeClass("active");
        $(object).addClass("active");
        return false;
    }
    function projectClick(object, val){
        $("#pro a").removeClass("active");
        $(object).addClass("active");
        return false;
    }
    function typeClick(object, val){
        $("#type a").removeClass("active");
        $(object).addClass("active");
        return false;
    }
</script>
</body>
</html>
