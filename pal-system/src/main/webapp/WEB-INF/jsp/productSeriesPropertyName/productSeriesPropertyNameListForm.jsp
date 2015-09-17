<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/30
  Time: 17:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title></title>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf">
        <strong class="am-text-primary am-text-lg">非遗项目-属性名</strong> / <small>&nbsp;&nbsp;&nbsp;${productSeries.name}</small>
    </div>
</div>
<div style="text-align: left;margin-left: 10px;" >
    <input onclick="addNewNode();"
           type="button" class="am-btn am-btn-default am-btn-xs"
           style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;"
           value="新增" />
</div>
<hr/>
<div class="am-g">
    <form action="<c:url value='/productSeriesPropertyName/savePropertyNameList.do'/>" method="post" class="am-form am-form-horizontal" >
        <input type="hidden" name="qm" value="saveOrUpdateProductSeriesPropertyName">
        <input type="hidden" name="productSeries.id" value="${productSeries.id}"/>
        <input type="hidden" name="count" id="count" value="${PSPNListSize}">
        <div  id="pNameForm">
            <% int i = 1;%>
            <c:forEach items="${productSeries.productSeriesPropertyNameList}" var="productSeriesPropertyName">
                <div>
                    <input type="hidden" name="propertyNameId<%=i %>" value="${productSeriesPropertyName.id}">
                </div>
                <div id="divPP<%=i %>">
                    <div class="am-form-group" style="child-align: left">
                        <label name="name<%=i %>" for="name<%=i %>" class="am-u-sm-3 am-form-label" style="width: auto"><%=i %>、</label>
                        <div class="am-u-sm-9">
                            <input type="text" name="name<%=i %>" id="name<%=i %>" value="${productSeriesPropertyName.name}" required>
                        </div>
                        <div style="text-align: left;margin-left: 10px;">
                            <input onclick="deleteNode('divPP<%=i %>');"
                                   type="button" class="am-btn am-btn-default am-btn-xs am-text-danger"
                                   style="margin-bottom: 6px;margin-left:2px;height: 35px;"
                                   value="删除" />
                        </div>
                    </div>
                </div>
                <% i += 1;%>
            </c:forEach>
        </div>
        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
                <input id="submit" type="submit" class="am-btn am-btn-primary" value="保存"/>
            </div>
        </div>
    </form>
</div>
</body>
</html>
