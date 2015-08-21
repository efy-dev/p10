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

    <ul class="layout-li">
      <c:forEach items="${jnode.children}" var="childJnode">
        <c:if test="${!empty childJnode.children&& childJnode.children.size()>0}">
           <li>
              <a class="am-cf" data-am-collapse="{target: '#${childJnode.id}'}"><span
                      class="am-icon-file"></span> ${childJnode.text_zh_CN}</a>


            <ul class="layout-li" id="${childJnode.id}">
              <c:forEach items="${childJnode.children}" var="childchildJnode">
                <li class="aborder">
                  <a href="<c:url value="${childchildJnode.url}"/>"
                     class="am-cf ${childchildJnode.jnodeMatch('efy-active',currentJnode!=null?currentJnode:"")}">${childchildJnode.text_zh_CN}</a>
                </li>
              </c:forEach>
            </ul>
          </li>
        </c:if>

        <c:if test="${empty childJnode.children}">


          <li><a class="${childJnode.jnodeMatch('efy-active',currentJnode!=null?currentJnode:"")}" href="<c:url value="${childJnode.url}"/>"></span> ${childJnode.text_zh_CN}</a></li>
          <%--</c:if>--%>
        </c:if>
      </c:forEach>
    </ul>

