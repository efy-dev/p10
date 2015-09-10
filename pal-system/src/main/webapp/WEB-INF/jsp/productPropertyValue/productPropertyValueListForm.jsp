<%@ page import="org.jgroups.protocols.pbcast.GmsImpl" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/4
  Time: 17:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title></title>
    <%request.setCharacterEncoding("utf-8");%>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf">
        <strong class="am-text-primary am-text-lg">商品的非遗项目属性</strong>
    </div>
</div>
<div class="am-g">
    <form action="<c:url value='/productPropertyValue/saveProductPropertyValueList.do'/>" method="post" class="am-form am-form-horizontal" >
        <input type="hidden" name="product.id" value="${product.id}"/>
        <input type="hidden" name="count" id="count" value="${PSPNListSize}">
        <div  id="pNameForm">
            <% int i = 1; %>
            <c:forEach items="${PSPNList}" var="productSeriesPropertyName">
                <%int tag = 0;%>
                <input type="hidden" name="propertyNameId<%=i %>" value="${productSeriesPropertyName.id}">
                <div class="am-form-group">
                    <label name="value<%=i %>" for="value<%=i %>" class="am-u-sm-3 am-form-label">${productSeriesPropertyName.name} <small>*</small></label>
                    <div class="am-u-sm-9">

                        <c:if test="${empty PPVList}">
                            <input type="hidden" name="propertyValueId<%=i %>" id="propertyValueId<%=i %>">
                            <input type="text" name="value<%=i %>" id="value<%=i %>" placeholder="属性值" required>
                        </c:if>
                        <c:if test="${not empty PPVList}">
                            <c:forEach items="${PPVList}" var="productPropertyValue">
                                <c:if test="${ productPropertyValue.productSeriesPropertyName.id == productSeriesPropertyName.id}">
                                    <% tag = 1; %>
                                    <input type="hidden" name="propertyValueId<%=i %>" id="propertyValueId<%=i %>" value="${productPropertyValue.id}">
                                    <input type="text" name="value<%=i %>" id="value<%=i %>" value="${productPropertyValue.value}" required>
                                </c:if>
                            </c:forEach>
                            <% if (tag == 0){ %>
                                <input type="hidden" name="propertyValueId<%=i %>" id="propertyValueId<%=i %>">
                                <input type="text" name="value<%=i %>" id="value<%=i %>" placeholder="属性值" required>
                            <% } %>
                        </c:if>
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
