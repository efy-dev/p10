<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
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
</head>
<body>
<c:if test="${empty object || object.id == null || object.id==''}">
    <div align="center">
        <h3>新建标签批次</h3>
    </div>
</c:if>
<c:if test="${!empty object && object.id != null && object.id != '' }">
    <div align="center">
        <h3>修改标签批次</h3>
    </div>
</c:if>
<div align="center">
    <form action="/basic/xm.do" method="post">
        <table>
            <tr>
                <td colspan="2"><input type="hidden" name="id" id="id" value="${object.id}"></td>
            </tr>
            <tr>
                <td>集合：</td>
                <td><input type="text" name="setting" id="setting" value="${object.setting}"></td>
            </tr>
            <tr>
                <td>开始：</td>
                <td><input type="text" name="start" id="start" value="${object.start}"></td>
            </tr>
            <tr>
                <td>数量：</td>
                <td><input type="text" name="amount" id="amount" value="${object.amount}"></td>
            </tr>
            <tr>
                <td>状态：</td>
                <td><input type="text" name="status" id="status" value="${object.status}"></td>
            </tr>
            <tr>
                <td>商品：</td>
                <td><input type="text" name="product.id" id="product.id" value="${object.product.id}"></td>
                <%--<td>--%>
                    <%--<select name="product.id" id="product.id">--%>
                        <%--<c:forEach items="${productList}" var="product">--%>
                            <%--<c:if test="${product.id.equals(object.product.id)}">--%>
                                <%--<option value="${product.id}" selected="selected">${product.name}</option>--%>
                            <%--</c:if>--%>
                            <%--<c:if test="${!product.id.equals(object.product.id)}">--%>
                                <%--<option value="${product.id}">${product.name}</option>--%>
                            <%--</c:if>--%>
                        <%--</c:forEach>--%>
                        <%--&lt;%&ndash;<option value="${object.product.id}" selected="selected">${object.product.name}</option>&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<option value="0001">0001</option>&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<option value="0002">0002</option>&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<option value="0003">0003</option>&ndash;%&gt;--%>
                    <%--</select>--%>
                <%--</td>--%>
            </tr>
            <tr>
                <td>大师：</td>
                <td><input type="text" name="tenant.id" id="tenant.id" value="${object.tenant.id}"></td>
            </tr>
            <tr>
                <td>订单：</td>
                <td><input type="text" name="purchaseOrder.id" id="purchaseOrder.id" value="${object.purchaseOrder.id}"></td>
            </tr>
            <tr>
                <td colspan="2"><input type="hidden" value="saveOrUpdateLabelBatch" name="qm"></td>
            </tr>
            <tr>
                <td align="center" colspan="2"><input type="submit" value="保存"></td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>
