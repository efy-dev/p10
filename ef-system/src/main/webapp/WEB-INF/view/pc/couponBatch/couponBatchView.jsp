<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title></title>
    <script>
        function sendCoupon() {
            var username = $("#username").val();
            var startBindDate = $("#startBindDate").val();
            var endBindDate = $("#endBindDate").val();
            var couponBatchId = $("#id").val();
            $.ajax({
                type: 'post',
                async: false,
                url: '<c:url value="/couponBatch/sendCoupon.do"/>',
                dataType: 'json',
                data: {
                    username: username,
                    startBindDate: startBindDate,
                    endBindDate: endBindDate,
                    couponBatchId: couponBatchId
                },
                success: function (data) {
                    if(data == 'Less'){
                        alert("可用的优惠券太少！")
                    }else{
                        alert("给"+data+"个用户发放优惠券成功");
                    }
                    window.location.reload();
                },
            });
        }

        function searchUserNum(){
            var username = $("#username").val();
            var startBindDate = $("#startBindDate").val();
            var endBindDate = $("#endBindDate").val();
            $.ajax({
                type: 'post',
                async: false,
                url: '<c:url value="/couponBatch/searchUserNum.do"/>',
                dataType: 'json',
                data: {
                    username: username,
                    startBindDate: startBindDate,
                    endBindDate: endBindDate
                },
                success: function (data) {
                    $("#userNum").val(data);
                },
            });
        }
    </script>
</head>
<body>
<div class="am-g" style="margin-top: 30px;">
    <div class="am-u-md-12">
        <table class="am-table am-table-bordered">
            <thead>
            <tr>
                <th>优惠券批次</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">名字</td>
                <td class="am-u-md-3">${object.name}</td>
                <td class="am-primary am-u-md-3">优惠券总数量</td>
                <td class="am-u-md-3">${object.amount}</td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">优惠价格</td>
                <td class="am-u-md-3"><fmt:formatNumber type="number" value="${object.price}"
                                                                    maxFractionDigits="2" minFractionDigits="2"/></td>
                <td class="am-primary am-u-md-3" style="color:#F00;">可使用优惠券数量</td>
                <td class="am-u-md-3">${lastCoupon}</td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">兑换码</td>
                <td class="am-u-md-3">
                    <c:if test="${object.deliverType != 1}">${object.uniqueKey}</c:if>
                </td>
                <td class="am-primary am-u-md-3">优惠券发放方式</td>
                <td class="am-u-md-3">
                    <ming800:status name="coupon" dataType="coupon.deliverType"
                                    checkedValue="${object.deliverType}"
                                    type="normal"/>
                </td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">生效日期</td>
                <td class="am-u-md-3">
                    <fmt:formatDate value="${object.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </td>
                <td class="am-primary am-u-md-3">失效日期</td>
                <td class="am-u-md-3">
                    <fmt:formatDate value="${object.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </td>
            </tr>

            </tbody>
        </table>
        <input type="hidden" name="id" id="id" value="${object.id}">
    </div>
</div>

<div class="am-g">
    <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8">
    </div>

    <div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
        <form class="am-form am-form-horizontal" id="form">
            <div class="am-form-group">
                <label for="username" class="am-u-sm-3 am-form-label">注册账号</label>

                <div class="am-u-sm-9">
                    <input type="text" id="username" name="username" placeholder="绑定账号">
                </div>
            </div>

            <div class="am-form-group">
                <label class="am-u-sm-3 am-form-label">注册时间</label>

                <div class="am-u-sm-9">
                    <div class="am-form-group am-form-icon" style="width: 150px;float: left">
                        <i class="am-icon-calendar"></i>
                        <input type="text" id="startBindDate" name="endBindDate" class="am-form-field am-input-sm"
                               placeholder="注册时间起" data-am-datepicker readonly>
                    </div>
                    <div style="float: left">&nbsp;&nbsp;至&nbsp;&nbsp;</div>
                    <div class="am-form-group am-form-icon" style="width: 150px;float: left">
                        <i class="am-icon-calendar"></i>
                        <input type="text" id="endBindDate" name="endBindDate" class="am-form-field am-input-sm"
                               placeholder="注册时间止" data-am-datepicker readonly>
                    </div>
                </div>
            </div>

            <div class="am-form-group">
                <label for="userNum" class="am-u-sm-3 am-form-label">选定用户数</label>

                <div class="am-u-sm-9">
                    <input type="text" id="userNum" name="userNum" placeholder="选定用户数" disabled="disabled">
                </div>
            </div>

            <div class="am-form-group">
                <div class="am-u-sm-9 am-u-sm-push-3">
<security:authorize ifAnyGranted="admin,operational,o_operational">
                    <input type="button" onclick="searchUserNum()" value="查询用户">
                    <input type="button" onclick="sendCoupon()" value="发送优惠券">
    </security:authorize>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>
