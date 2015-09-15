<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ming
  Date: 12-11-10
  Time: 上午11:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@ include file="/common/taglibs.jsp" %>--%>
<script type="text/javascript" src="<c:url value="/scripts/doQuery.js?m=2.4"/>"></script>
<script type="text/javascript" src="<c:url value="/scripts/function.js?m=2.4"/>"></script>
<%--<script type="text/javascript" src="<c:url value="/scripts/m8u/jquery.m8u2.min.js"/>"></script>--%>


<%--<div id="tabsQuery">--%>
<%--<c:forEach items="${requestScope.doQueryList}" var="doQuery">--%>
<%--<c:set var="queryModel" value="${requestScope.tempDo.name}_${doQuery.name}"/>--%>
<%--<c:set var="doQueryStr" value="${pageScope.doQueryStr}${doQuery.name},${doQuery.label},${doQuery.type};"/>--%>
<%--<div id="${doQuery.name}" title="${doQuery.label}"--%>
<%--<c:if test="${doQuery.label == requestScope.tabTitle}">selected="true"</c:if>--%>
<%-->--%>
<%--</div>--%>
<%--</c:forEach>--%>
<%--<input type="hidden" id="doQueryStr" value="${pageScope.doQueryStr}"/>--%>
<%--</div>--%>

<%--<script type="text/javascript">--%>
<%--selectTabs('${requestScope.tempDo.name}', '${requestScope.tempDo.label}', '${requestScope.conditions}', '${requestScope.tabTitle}', '${requestScope.tempDo.xentity.model}', $("#doQueryStr").val());--%>
<%--</script>--%>


<div class="am-tabs" data-am-tabs="{noSwipe: 1}" id="doc-tab-demo-1">
    <ul class="am-tabs-nav am-nav am-nav-tabs">
        <c:forEach items="${doQueryList}" var="doQuery">
            <c:if test="${doQuery.name=='default'}">
                <c:if test="${tabTitle==doQuery.label}">
                    <li class="am-active" id="${doQuery.name}"><a
                            href="<c:url value="/basic/xm.do?qm=${requestScope.tempDo.name}_default"/>">${doQuery.label}</a>
                        <script>
                            $('#${doQuery.name}').find('a').on('opened.tabs.amui', function (e) {
                                window.location.href = "<c:url value="/basic/xm.do?qm=${requestScope.tempDo.name}_default"/>";
                            })
                        </script>
                    </li>
                </c:if>
                <c:if test="${tabTitle!=doQuery.label}">
                    <li id="${doQuery.name}"><a
                            href="<c:url value="/basic/xm.do?qm=${requestScope.tempDo.name}_default"/>">${doQuery.label}</a>
                        <script>
                            $('#${doQuery.name}').find('a').on('opened.tabs.amui', function (e) {
                                window.location.href = "<c:url value="/basic/xm.do?qm=${requestScope.tempDo.name}_default"/>";
                            })
                        </script>
                    </li>
                </c:if>
            </c:if>
            <c:if test="${doQuery.name!='default'}">
                <c:if test="${tabTitle==doQuery.label}">
                    <li class="am-active"><a href="javascript: void(0)">${doQuery.label}</a></li>
                </c:if>
                <c:if test="${tabTitle!=doQuery.label}">
                    <li><a href="javascript: void(0)">${doQuery.label}</a></li>
                </c:if>
            </c:if>
        </c:forEach>
    </ul>

    <div class="am-tabs-bd">
        <c:forEach items="${doQueryList}" var="doQuery">
            <c:if test="${tabTitle==doQuery.label}">
                <div class="am-tab-panel am-active" id="${doQuery.name}">

                </div>
            </c:if>
            <c:if test="${tabTitle!=doQuery.label}">
                <div class="am-tab-panel" id="${doQuery.name}">
                </div>
            </c:if>
        </c:forEach>
    </div>
</div>
<br/>
<%--<button type="button" class="am-btn am-btn-primary js-append-tab">插入 Tab</button>--%>
<script>

    var paramList = new Object();

    <c:forEach items="${paramMap}" var="item">
    paramList['${item.key}'] = '${item.value}';
    </c:forEach>

    <c:forEach items="${doQueryList}" var="doQuery">
    <c:if test="${doQuery.name!='default'}">
    generateCondition('<c:url value="/do/listCondition.do"/>', '${doQuery.name}', '${requestScope.tempDo.name}', '${doQuery.label}', '${requestScope.conditions}', '${requestScope.tempDo.xentity.model}', '${doQuery.label}', '<c:url value="/"/>', paramList)
    </c:if>
    </c:forEach>

</script>





