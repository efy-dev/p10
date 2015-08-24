<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/25
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>

<html>
<head>
    <title></title>
    <script type="text/javascript" src="<c:url value='/resources/jquery/jquery-1.11.1.min.js'/>"></script>
    <script type="text/javascript">
        function checkSerial(){
            var serial = document.getElementById("checkSerial").value;
            var reg = new RegExp("^[1-9]\\d*$");
            var qm = document.getElementById("qm").value;
            var conditions = document.getElementById("conditions").value;
            if(serial != null && serial.trim() != "" && reg.test(serial) && serial<=100000){
//                alert("序列号");
                window.location.href = "/basic/xm.do?qm="+qm+"Serial&conditions="+conditions+";serial:"+serial;
            }else{
                alert("请输入大于零小于十万的数字序列号");
//                window.location.href = "/basic/xm.do?qm="+qm+"&conditions="+conditions;
                <%--"<c:url value='/basic/xm.do'>" +--%>
                <%--"<c:param name='qm' value=''></c:param>" +--%>
                <%--"<c:param name='conditions' value=''></c:param>" +--%>
                <%--"</c:url>";--%>
            }
        }
    </script>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf">
        <strong class="am-text-primary am-text-lg">标签列表</strong>
    </div>
</div>
<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>
<%--<div>--%>
    <%--<div class="am-form-group" align="left">--%>
        <%--<label name="checkSerial" for="checkSerial" class="am-u-sm-3 am-form-label" style="width: auto">序列号:</label>--%>
        <%--<div class="am-u-sm-9" align="left" style="width: auto">--%>
            <%--<input type="text" name="checkSerial" id="checkSerial" placeholder="请出入查询序列号" value="${checkSerial}">--%>
        <%--</div>--%>
        <%--<div style="margin-left: 10px;width: auto" align="left">--%>
            <%--<input type="hidden" id="qm" value="${requestScope.qm}"/>--%>
            <%--<input type="hidden"  id="conditions" value="${requestScope.conditions}"/>--%>
            <%--<input onclick="checkSerial();"--%>
                   <%--type="button" class="am-btn am-btn-default am-btn-xs"--%>
                   <%--style="margin-bottom: 6px;width: 100px;margin-left:2px;height: 30px;"--%>
                   <%--value="查询" />--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</div>--%>
<div>
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr>
            <td>操作</td>
            <td>序列号</td>
            <td>防伪码</td>
            <td>标签批次</td>
            <td>商品</td>
            <td>商户</td>
            <td>状态</td>
            <td>第一次查询时间</td>
            <td>最近一次查询时间</td>
            <td>查询次数</td>
        </tr>

        <c:forEach items="${requestScope.pageInfo.list}" var="label">
            <tr>
                <td>
                    <div class="am-btn-toolbar">
                        <div class="am-btn-group am-btn-group-xs" style="width: 100%;" >
                            <button onclick="window.location.href='<c:url value="/basic/xm.do?qm=plistLabelCheckRecord_default&conditions=label.id:${label.id}"/>'"
                                    class="am-btn am-btn-default am-btn-xs">查询记录</button>
                        </div>
                    </div>
                </td>
                <td><a href="<c:url value='/basic/xm.do?qm=viewLabel&id=${label.id}'/>">${label.serial}</a></td>
                <td>${label.code}</td>
                <td>${label.labelBatch.setting}</td>
                <td>
                    <c:if test="${label.purchaseOrderLabel != null && not empty label.purchaseOrderLabel}">
                        <c:if test="${label.purchaseOrderLabel.product != null && not empty label.purchaseOrderLabel.product}">
                            ${label.purchaseOrderLabel.product.name}
                        </c:if>
                    </c:if>
                </td>
                <td>
                    <c:if test="${label.seller != null && !empty label.seller}">
                        ${label.seller.name}
                    </c:if>
                </td>
                <td>
                    <c:if test="${label.status == '2'}">
                        <font color="blue">已分配</font>
                    </c:if>
                    <c:if test="${label.status == '1'}">
                        <font color="green">未分配</font>
                    </c:if>
                    <c:if test="${label.status == '9'}">
                        <font color="red">已查询</font>
                    </c:if>
                </td>
                <td><fmt:formatDate value="${label.firstCheckDateTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                <td><fmt:formatDate value="${label.lastCheckDateTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                <td>${label.checkCount} 次</td>
            </tr>
        </c:forEach>
    </table>

    <div style="clear: both">
        <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="/basic/xm.do">
            <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
            <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
        </ming800:pcPageList>
    </div>

</div>
</body>
</html>
