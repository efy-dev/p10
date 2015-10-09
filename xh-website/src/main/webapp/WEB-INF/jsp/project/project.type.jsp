<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/10/8
  Time: 18:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<div class="wh sjape">
  <div class="tbar">项目类别：</div>
  <ul id="type">
    <li><a href="#" title="" class="active" target="_self" onclick="typeClick(this, '全部');">全部</a></li>
    <c:forEach items="${projectList}" var="project">
      <li><a href="#" title="" target="_self"
             onclick="typeClick(this, '${project.type}');"><ming800:status name="level"
                                                                           dataType="Project.type"
                                                                           checkedValue="${project.type}"
                                                                           type="normal"/></a></li>
    </c:forEach>
    <%--<li><a href="#" title="" class="active" target="_self" onclick="typeClick(this, '全部');">全部</a></li>--%>
    <%--<li><a href="#" title="" target="_self" onclick="typeClick(this, '民间文学');">民间文学</a></li>--%>
    <%--<li><a href="#" title="" target="_self" onclick="typeClick(this, '传统音乐');">传统音乐</a></li>--%>
    <%--<li><a href="#" title="" target="_self" onclick="typeClick(this, '传统舞蹈');">传统舞蹈</a></li>--%>
    <%--<li><a href="#" title="" target="_self" onclick="typeClick(this, '传统戏剧');">传统戏剧</a></li>--%>
    <%--<li><a href="#" title="" target="_self" onclick="typeClick(this, '曲艺');">曲艺</a></li>--%>
    <%--<li><a href="#" title="" target="_self" onclick="typeClick(this, '传统体育、游艺与杂技');">传统体育、游艺与杂技</a></li>--%>
    <%--<li><a href="#" title="" target="_self" onclick="typeClick(this, '传统美术');">传统美术</a></li>--%>
    <%--<li><a href="#" title="" target="_self" onclick="typeClick(this, '传统技艺');">传统技艺</a></li>--%>
    <%--<li><a href="#" title="" target="_self" onclick="typeClick(this, '传统医药');">传统医药</a></li>--%>
    <%--<li><a href="#" title="" target="_self" onclick="typeClick(this, '民俗');">民俗</a></li>--%>
  </ul>
</div>
</div>