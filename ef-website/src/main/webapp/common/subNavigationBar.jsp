<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/3/19
  Time: 11:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:if test="${!empty shotType && shotType.getType()!=211&& shotType.getType()!=212&& shotType.getType()!=21}">
    <div class="topNav2">
        <div class="topnav_2"><a class="red" href="/${shotType.name}">${shotType.label}</a>|<a
                href="/${shotType.name}/photographer/list?orderBy=listIndex_desc">选摄影师</a> <a href="/${shotType.name}/work/list">看作品</a> <a
                href="/${shotType.name}/package/list">特色套系</a></div>
    </div>
</c:if>
