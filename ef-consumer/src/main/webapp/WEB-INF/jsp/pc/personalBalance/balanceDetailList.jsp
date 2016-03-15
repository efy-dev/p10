<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head></head>
<body>
<div class="layout-col">
	<div class="mt wh1">
		<div class="extra-l addextra-l">
			<strong>账户余额</strong>
		</div>
		<div class="extra-b ae">

			<div class="extra-titie ae">可用余额：￥<span>${balance}</span></div>
			<div class="extra-list ae">
				<table>
					<tr>
						<td>时间</td>
						<td>存入</td>
						<td>支出</td>
						<td>备注</td>
					</tr>
					<c:forEach items="${balanceDetailList}" var="balanceDetailList">

						<tr>
							<td width="146">
								<p><fmt:formatDate value="${balanceDetailList.createDateTime}"
												   pattern="yyyy-MM-dd"/></p>

								<p><fmt:formatDate value="${balanceDetailList.createDateTime}" pattern="H:mm:ss"/></p>
							</td>
							<c:if test="${balanceDetailList.status==2}">
								<td width="146">￥<span>${balanceDetailList.changeBalance}</span></td>
								<td width="146">--</td>

							</c:if>
							<c:if test="${balanceDetailList.status==3}">
								<td width="146">--</td>

								<td width="146">￥<span>${balanceDetailList.changeBalance}</span></td>
							</c:if>
							<c:if test="${balanceDetailList.status==2}">
								<td width="357"><ming800:status name="type" dataType="BalanceRecord.type" checkedValue="${balanceDetailList.type}" type="normal"/></td>
							</c:if>
							<c:if test="${balanceDetailList.status==3}">
								<td width="357">购买商品使用</td>
							</c:if>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
</div>

</body>

</html>