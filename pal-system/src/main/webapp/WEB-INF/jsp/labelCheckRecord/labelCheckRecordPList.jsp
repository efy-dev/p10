<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/25
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title></title>
</head>
<body style="height: auto">
<div class="am-cf am-padding">
    <div class="am-fl am-cf">
        <strong class="am-text-primary am-text-lg">标签防伪查询记录</strong>
    </div>
</div>
<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>
<div class="am-g">
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr>
            <td>标签序列号</td>
            <td>标签防伪码</td>
            <td>标签批次</td>
            <td>商品名称</td>
            <td>商户名称</td>
            <td>防伪验证IP</td>
            <td>IP归属地</td>
            <td>验证时间</td>
        </tr>

        <c:forEach items="${requestScope.pageInfo.list}" var="record" varStatus="x">
            <tr>
                <td>
                    <a href="<c:url value='/basic/xm.do?qm=viewLabel&record=record&id=${record.label.id}'/>">${record.label.serial}</a>
                </td>
                <td>${record.label.code}</td>
                <td>
                    <a href="<c:url value='/basic/xm.do?qm=viewLabelBatch&record=record&id=${record.label.labelBatch.id}'/>">${record.label.labelBatch.setting}</a>
                </td>
                <td>
                    <a href="<c:url value='/basic/xm.do?qm=viewProduct&record=record&id=${record.product.id}'/>">${record.product.name}</a>
                </td>
                <td>
                    <a href="<c:url value='/basic/xm.do?qm=viewTenant&record=record&id=${record.product.tenant.id}'/>">${record.product.tenant.name}</a>
                </td>
                <td>
                    <div id="ip${x.index}" name="IP">${record.IP}</div>
                </td>
                <td>
                    <div id="ipAddress${x.index}" ></div>
                </td>
                <td><fmt:formatDate value="${record.createDatetime}" pattern="yyyy-MM-dd HH:mm"/></td>
            </tr>
        </c:forEach>
    </table>
</div>
<div style="clear: both">
    <c:url value="/basic/xm.do" var="url" />
    <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
        <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
        <ming800:pcPageParam name="record" value="${record}"/>
        <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
    </ming800:pcPageList>
</div>

<script type="text/javascript">
    var url = "http://api.map.baidu.com/location/ip?ak=zKrEDoOM6VCNjYDcBgpufSWR&ip=";
    var count = 0;
    var ipDiv = document.getElementById("ip0");
    window.onload = ajax1(ipDiv);
    function ajax1(div1) {
        if(div1!=null){
            $.ajax({
                type: "get",
                url: url + div1.innerHTML,
                contentType: "application/json; charset=utf-8",
                cache: false,
                dataType: "jsonp",
                jsonp: "callback",
                jsonpCallback: "jsonpCallback",
                success: success1,
                error: error1,
            });
        }
    }
    function success1(data) {
        var ipAddressDiv = document.getElementById("ipAddress" + count);
        if (data.status == 0) {

            var text = data.address.split("|");
            ipAddressDiv.innerHTML = text[0] + " " + text[1] + " " + text[2];
        }
        else {
            ipAddressDiv.innerHTML = "未知";
        }
        count++;
        ipDiv = document.getElementById("ip" + count);
        ajax1(ipDiv);
    }
    function error1(Object, b, c) {
        var ipAddressDiv = document.getElementById("ipAddress"+count);
        ipAddressDiv.innerHTML = "未知";
        count++;
        ipDiv = document.getElementById("ip" + count);
        ajax1(ipDiv);
    }
</script>

</body>
</html>
