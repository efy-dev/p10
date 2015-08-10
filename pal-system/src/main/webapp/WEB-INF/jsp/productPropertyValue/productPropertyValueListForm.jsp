<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/4
  Time: 17:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title></title>
    <script type="text/javascript" src="<c:url value='/resources/jquery/jquery-1.11.1.min.js'/>"></script>
</head>
<body>
<div class="am-cf am-padding">
    <c:if test="${empty product.productPropertyValueList}">
        <div class="am-fl am-cf">
            <strong class="am-text-primary am-text-lg">新建商品属性</strong> / <small>New ProductPropertyValue</small>
        </div>
    </c:if>
    <c:if test="${!empty product.productPropertyValueList}">
        <div class="am-fl am-cf">
            <strong class="am-text-primary am-text-lg">编辑商品属性</strong> / <small>Edit ProductPropertyValue</small>
        </div>
    </c:if>
</div>

<div class="am-g">
    <form action="<c:url value='/productPropertyValue/saveProductPropertyValueList.do'/>" method="get" class="am-form am-form-horizontal" >
        <input type="hidden" name="qm" value="saveOrUpdateProductPropertyValue">
        <input type="hidden" name="product.id" value="${product.id}"/>
        <input type="hidden" name="count" id="count" value="${PSPNListSize}">
        <div  id="pNameForm">
            <% int i = 1;%>
            <c:forEach items="${PSPNList}" var="productSeriesPropertyName">
                <input type="hidden" name="propertyNameId<%=i %>" value="${productSeriesPropertyName.id}">
                <div class="am-form-group">
                    <label name="value<%=i %>" for="value<%=i %>" class="am-u-sm-3 am-form-label">${productSeriesPropertyName.name} <small>*</small></label>
                    <div class="am-u-sm-9">

                        <c:if test="${empty PPVList}">
                            <input type="hidden" name="propertyValueId<%=i %>" id="propertyValueId<%=i %>">
                            <input type="text" name="value<%=i %>" id="value<%=i %>" placeholder="属性值">
                        </c:if>
                        <c:forEach items="${PPVList}" var="productPropertyValue">
                            <c:if test="${ productPropertyValue.productSeriesPropertyName.id == productSeriesPropertyName.id}">
                                <input type="hidden" name="propertyValueId<%=i %>" id="propertyValueId<%=i %>" value="${productPropertyValue.id}">
                                <input type="text" name="value<%=i %>" id="value<%=i %>" value="${productPropertyValue.value}">
                            </c:if>
                        </c:forEach>

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
