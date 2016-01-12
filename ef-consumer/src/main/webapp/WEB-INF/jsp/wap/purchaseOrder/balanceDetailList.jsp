<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
	<title>账号余额</title>

</head>
<body>
<div class="detail-money"><span class="detail-h1">可用余额</span><span class="detail-h2">￥<em>${balance}</em></span></div>
<div class="detail-list ">
	<div class="detail-title ae">余额明细</div>
	<div class="detail ae">
		<table width="100%">
			<tr>
				<td>时间</td>
				<td>存入</td>
				<td>支出</td>
				<td>备注</td>
			</tr>
			<c:forEach items="${balanceDetailList}" var="balanceDetailList">
			<tr>
				<td><p><fmt:formatDate value="${balanceDetailList.createDateTime}"
									   pattern="yyyy-MM-dd"/></p><p><fmt:formatDate value="${balanceDetailList.createDateTime}" pattern="H:mm:ss"/></p></td>
				<c:if test="${balanceDetailList.status==3}">
					<td>￥${balanceDetailList.changeBalance}</td>
					<td>--</td>
				</c:if>
				<c:if test="${balanceDetailList.status==4}">
					<td>--</td>
					<td>￥${balanceDetailList.changeBalance}</td>
				</c:if>
                <c:if test="${balanceDetailList.status==4}">
					<td>购买商品使用</td>
				</c:if>
				<c:if test="${balanceDetailList.status==3}">
					<td>${balanceDetailList.type}</td>
				</c:if>

			</tr>
			</c:forEach>
		</table>
	</div>
</div>

</body>
</html>