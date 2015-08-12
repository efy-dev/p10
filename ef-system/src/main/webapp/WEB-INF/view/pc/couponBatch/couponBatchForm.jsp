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
</head>
<body>
<div class="admin-content">
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8">
            <div class="am-panel am-panel-default">
            </div>
        </div>

        <div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
            <form action="/basic/xm.do" method="post" class="am-form am-form-horizontal">
                <input type="hidden" value="saveOrUpdateCouponBatch" name="qm">
                <input type="hidden" name="id" value="${object.id}">

                <div class="am-form-group">
                    <label for="name" class="am-u-sm-3 am-form-label">批次名 / Name</label>

                    <div class="am-u-sm-9">
                        <input type="text" id="name" name="name" placeholder="批次名 / Name" value="${object.name}">
                        <small>输入你要保存的名字</small>
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="price" class="am-u-sm-3 am-form-label">金额 / Price</label>

                    <div class="am-u-sm-9">
                        <input type="text" id="price" name="price" placeholder="金额 / Price" value="${object.price}">
                        <small>输入你要保存的金额</small>
                    </div>
                </div>
                <div class="am-form-group">
                    <label for="amount" class="am-u-sm-3 am-form-label">数量 / Amount</label>

                    <div class="am-u-sm-9">
                        <input type="text" id="amount" name="amount" placeholder="数量 / Amount" value="${object.amount}">
                        <small>输入你要保存的数量</small>
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="startDate" class="am-u-sm-3 am-form-label">生效日期</label>

                    <div class="am-u-sm-9">
                        <div class="am-form-group am-form-icon">
                            <i class="am-icon-calendar"></i>
                            <input type="text" id="startDate" name="startDate" class="am-form-field am-input-sm"
                                   placeholder="生效日期" value="${object.startDate}">
                        </div>
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="endDate" class="am-u-sm-3 am-form-label">失效日期</label>

                    <div class="am-u-sm-9">
                        <div class="am-form-group am-form-icon">
                            <i class="am-icon-calendar"></i>
                            <input type="text" id="endDate" name="endDate" class="am-form-field am-input-sm"
                                   placeholder="失效日期" value="${object.endDate}">
                        </div>
                    </div>
                </div>
                <div class="am-form-group">
                    <div class="am-u-sm-9 am-u-sm-push-3">
                        <button type="submit" class="am-btn am-btn-primary">保存</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
