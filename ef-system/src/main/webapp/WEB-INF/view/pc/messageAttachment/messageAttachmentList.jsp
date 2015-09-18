<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title></title>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">传承人动态</strong> /
        <small>Master Message</small>
    </div>
</div>

<hr/>

<div class="am-g">
    <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8"><%--少了这个div就出错--%>
    </div>
    <div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
        <form action="<c:url value="/basic/xm.do"/>" method="post" class="am-form am-form-horizontal">
            <input type="hidden" value="saveOrUpdateMasterMessage" name="qm">
            <input type="hidden" name="master.id" value="${object.master.id}">
            <input  type="hidden" name="id" value="${object.id}"/>
            <c:forEach items="${objectList}" var="obj">
                <div class="am-form-group">
                    <label for="content" class="am-u-sm-3 am-form-label">短简介</label>
                        <div class="am-u-sm-9" style="text-align: left;">
                               <tr>
                                   <td>${obj.masterMessage.id}</td>
                               </tr>
                        </div>
                </div>
            </c:forEach>

        </form>
    </div>
</div>
</body>
</html>
