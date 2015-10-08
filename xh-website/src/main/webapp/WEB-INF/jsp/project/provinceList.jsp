<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/10/8
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="wh theme">
  <div class="tbar">申报地区：</div>
  <ul id="pro">
    <li><a href="" class="active" title="">全部</a></li>
    <c:forEach items="${objectList}" var="province">
      <li><a href="#" title="" target="_self"
             onclick="projectClick(this, '${province.id}');">${province.name}</a></li>
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
