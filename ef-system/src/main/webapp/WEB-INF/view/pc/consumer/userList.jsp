<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 14:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <script src="<c:url value="/scripts/jquery-1.11.1.min.js"/>"></script>
    <script>
        function createQRCode(userID) {
            jQuery.ajax({
                type:"GET",
                url:'<c:url value="/userGift/createQRCode.do"/>',
                data:{userID:userID},
                dataType:"json",
                success:function(data){
                    alert("文件已经下载到c盘:文件名："+data)
                }
            });
        }
    </script>
    <title></title>
</head>
<body>
<table>


</table>

<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>
<div class="admin-content" style="height: auto">
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-6">
        </div>
        <div class="am-u-sm-12">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>

                    <td class="table-set">用户ID</td>
                    <td class="table-set">用户名</td>
                    <td class="table-set">操作</td>

                </tr>
                </thead>
                <tbody>
                <c:forEach items="${objectList}" var="user">
                    <tr>
                        <td class="am-hide-sm-only">${user.id}</td>
                        <td class="am-hide-sm-only">${user.username}</td>
                        <td class="am-hide-sm-only"><a
                                class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                onclick="createQRCode('${user.id}')"/><span class="am-icon-trash-o">生成二维码</span>
                            </a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>
