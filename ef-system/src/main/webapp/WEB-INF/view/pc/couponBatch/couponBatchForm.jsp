<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <script>
        $(function(){
            var id = $("#id").val();
            if(id != ""){
                $("#sc").hide();
            }
        });
        function saveAndCreate(){
            $("#form").attr("action","<c:url value="/couponBatch/saveAndCreateCoupon.do"/>");
            $("#form").submit();
        }
    </script>
</head>
<body>
<div class="admin-content">
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8">
            <div class="am-panel am-panel-default">
            </div>
        </div>

        <div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
            <form action="<c:url value="/basic/xm.do"/>" method="post" class="am-form am-form-horizontal" id="form">
                <input type="hidden" value="saveOrUpdateCouponBatch" name="qm">
                <input type="hidden" name="id" id="id" value="${object.id}">
                <input type="hidden" name="isCreatedCoupon" value="1">

                <div class="am-form-group">
                    <label for="name" class="am-u-sm-3 am-form-label">批次名</label>

                    <div class="am-u-sm-9">
                        <input type="text" id="name" name="name" placeholder="批次名" value="${object.name}">
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="price" class="am-u-sm-3 am-form-label">优惠金额</label>

                    <div class="am-u-sm-9">
                        <input type="text" id="price" name="price" placeholder="优惠金额" value="${object.price}">
                    </div>
                </div>
                <div class="am-form-group">
                    <label for="priceLimit" class="am-u-sm-3 am-form-label">使用限制金额</label>

                    <div class="am-u-sm-9">
                        <input type="text" id="priceLimit" name="priceLimit" placeholder="使用限制金额" value="${object.priceLimit}">
                    </div>
                </div>
                <div class="am-form-group">
                    <label for="amount" class="am-u-sm-3 am-form-label">数量</label>

                    <div class="am-u-sm-9">
                        <input type="text" id="amount" name="amount" placeholder="数量" value="${object.amount}">
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="startDate" class="am-u-sm-3 am-form-label">生效日期</label>

                    <div class="am-u-sm-9">
                        <div class="am-form-group am-form-icon">
                            <i class="am-icon-calendar"></i>
                            <input type="text" id="startDate" name="startDate" class="am-form-field am-input-sm"
                                   placeholder="生效日期" value="${object.startDate}" data-am-datepicker readonly>
                        </div>
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="endDate" class="am-u-sm-3 am-form-label">失效日期</label>

                    <div class="am-u-sm-9">
                        <div class="am-form-group am-form-icon">
                            <i class="am-icon-calendar"></i>
                            <input type="text" id="endDate" name="endDate" class="am-form-field am-input-sm"
                                   placeholder="失效日期"  value="${object.endDate}" data-am-datepicker readonly>
                        </div>
                    </div>
                </div>
                <div class="am-form-group">
                    <div class="am-u-sm-9 am-u-sm-push-3">
                        <button type="submit" class="am-btn am-btn-primary">保存</button>
                        <button type="submit" id="sc" class="am-btn am-btn-primary" onclick="saveAndCreate()">保存并生成</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
