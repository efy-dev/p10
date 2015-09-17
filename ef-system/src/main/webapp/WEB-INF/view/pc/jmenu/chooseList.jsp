<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/9 0009
  Time: 14:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<div class="admin-content" style="height: auto">
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-6">
        </div>
        <div class="am-u-sm-12">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>
                    <th class="table-set">操作</th>
                    <th class="table-title">名称</th>
                </tr>
                </thead>
                <tbody>


                <c:forEach items="${requestScope.pageInfo.list}" var="obj">
                    <tr id="${obj.id}">
                        <td>
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs">
                                    <button id="${obj.id}" name="${obj.name}"
                                            class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                            url="<c:url value="/do/chooseItem.do"/> " data-efy-choose-btn
                                            param="${pageContext.request.getParameter("chooseId")}:${obj.id}"><span
                                            class="am-icon-trash-o">选中</span>
                                    </button>
                                </div>
                            </div>
                        </td>
                        <td class="am-hide-sm-only">${obj.name}</td>
                    </tr>

                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div style="clear: both">
        <c:url value="/do/generatePages.do" var="url"/>
        <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
            <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
            <ming800:pcPageParam name="chooseId" value="${pageContext.request.getParameter('chooseId')}"/>
            <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
            <ming800:pcPageParam name="resultPage" value="${pageContext.request.getParameter('resultPage')}"/>
        </ming800:pcPageList>
    </div>
</div>
<a id="initIframe" onclick="initIframe(this)"></a>
<script>

    var parentInputId = "";

    function init(divid) {
        parentInputId = divid;
    }

    function initIframe(element) {
        init($(element).attr("name"));
    }

    $().ready(function () {

        window.parent.iframeInit();

        $("[data-efy-choose-btn]").each(function () {
//            alert("test");
            $(this).click(function () {
//                console.log("test");
                window.parent.pChoosed(parentInputId, $(this).attr("id"), $(this).attr("name"))
            });
        });
    });
</script>
</body>
</html>
