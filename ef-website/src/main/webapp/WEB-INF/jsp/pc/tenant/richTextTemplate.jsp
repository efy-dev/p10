<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/10
  Time: 15:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- sidebar start -->


		<c:forEach items="${jnode.children}" var="childJnode">
			<%--<c:if test="${empty childJnode.children}">--%>
				<dl class="ae"><dt><a class="${childJnode.jnodeMatch('efy-active',currentJnode!=null?currentJnode:"")}"
					   href="<c:url value="${childJnode.url}"/>"></span> ${childJnode.text_zh_CN}</a></dt></dl>
			<%--</c:if>--%>
		</c:forEach>
