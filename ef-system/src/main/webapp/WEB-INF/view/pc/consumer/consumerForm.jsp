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
                <input type="hidden" value="saveOrUpdateConsumer" name="qm">
                <input type="hidden" name="id" value="${object.id}">

                <div class="am-form-group">
                    <label for="deposit" class="am-u-sm-3 am-form-label">账户余额</label>

                    <div class="am-u-sm-9">
                        <input type="text" id="deposit" name="deposit" placeholder="账户余额" value="${object.deposit}">
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="score" class="am-u-sm-3 am-form-label">积分</label>

                    <div class="am-u-sm-9">
                        <input type="text" id="score" name="score" placeholder="积分" value="${object.score}">
                    </div>
                </div>
                <div class="am-form-group">
                    <label for="username" class="am-u-sm-3 am-form-label">名字</label>

                    <div class="am-u-sm-9">
                        <input type="text" id="username" name="username" placeholder="名字" value="${object.username}">
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
