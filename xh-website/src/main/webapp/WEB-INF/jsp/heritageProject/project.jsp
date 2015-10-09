<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/25
  Time: 17:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
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
            <%--<div class="wh stone">--%>
            <%--<div class="tbar">申报批次：</div>--%>
            <%--<ul id="batch">--%>
            <%--<li><a href="#" class="active" title="全部" target="_self" onclick="batchClick(this, '全部');">全部</a>--%>
            <%--</li>--%>
            <%--<li><a href="#" title="第一批" target="_self" onclick="batchClick(this, '第一批');">第一批</a></li>--%>
            <%--<li><a href="#" title="第二批" target="_self" onclick="batchClick(this, '第二批');">第二批</a></li>--%>
            <%--<li><a href="#" title="第三批" target="_self" onclick="batchClick(this, '第三批');">第三批</a></li>--%>
            <%--</ul>--%>
            <%--</div>--%>
            <jsp:include flush="true"
                         page="/project/provinceList.do"/>


            <%--<div class="wh sjape">--%>
                <%--<div class="tbar">项目类别：</div>--%>
                <%--<ul id="type">--%>
                    <%--<li><a href="#" title="" class="active" target="_self" onclick="typeClick(this, '全部');">全部</a></li>--%>
                    <%--<c:forEach items="${projectList}" var="project">--%>
                        <%--<li><a href="#" title="" target="_self"--%>
                               <%--onclick="typeClick(this, '${project.type}');"><ming800:status name="level"--%>
                                                                                             <%--dataType="Project.type"--%>
                                                                                             <%--checkedValue="${project.type}"--%>
                                                                                             <%--type="normal"/></a></li>--%>
                    <%--</c:forEach>--%>
                    <%--&lt;%&ndash;<li><a href="#" title="" class="active" target="_self" onclick="typeClick(this, '全部');">全部</a></li>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<li><a href="#" title="" target="_self" onclick="typeClick(this, '民间文学');">民间文学</a></li>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<li><a href="#" title="" target="_self" onclick="typeClick(this, '传统音乐');">传统音乐</a></li>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<li><a href="#" title="" target="_self" onclick="typeClick(this, '传统舞蹈');">传统舞蹈</a></li>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<li><a href="#" title="" target="_self" onclick="typeClick(this, '传统戏剧');">传统戏剧</a></li>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<li><a href="#" title="" target="_self" onclick="typeClick(this, '曲艺');">曲艺</a></li>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<li><a href="#" title="" target="_self" onclick="typeClick(this, '传统体育、游艺与杂技');">传统体育、游艺与杂技</a></li>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<li><a href="#" title="" target="_self" onclick="typeClick(this, '传统美术');">传统美术</a></li>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<li><a href="#" title="" target="_self" onclick="typeClick(this, '传统技艺');">传统技艺</a></li>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<li><a href="#" title="" target="_self" onclick="typeClick(this, '传统医药');">传统医药</a></li>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<li><a href="#" title="" target="_self" onclick="typeClick(this, '民俗');">民俗</a></li>&ndash;%&gt;--%>
                <%--</ul>--%>
            <%--</div>--%>
        <%--</div>--%>
        <jsp:include flush="true"
                             page="/project/project.type.do"/>
        <!-- //End--filter-item-->
        <jsp:include flush="true"
                     page="/project/project.List.do"/>
        <!-- //End--div-list-->

        <!-- //End--pages-->
    </div>
    <!-- //End--slide-right-->
    <script type="text/javascript">
        function batchClick(object, val) {
            $("#batch a").removeClass("active");
            $(object).addClass("active");
            return false;
        }
        function projectClick(object, val) {
            $("#pro a").removeClass("active");
            $(object).addClass("active");
            return false;
        }
        function typeClick(object, val) {
            $("#type a").removeClass("active");
            $(object).addClass("active");
            return false;
        }
    </script>
</body>
</html>
