<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html class="no-js">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>个人中心</title>
</head>
<body>
<!-- //End--header-->
<!--content-->
<div class="layout-col">
    <div class="mt wh1">
        <div class="extra-l">
            <strong>个人信息</strong>
        </div>
    </div>
    <!-- //End--information-->
    <div class="efeiyi-userinfo">
        <div class="userinfo-portrait">
            <dl>
                <dt>
                <div class="userinfo-figure">
                    <img src="/scripts/assets/images/yonghm.jpg">
                </div>
                <div class="editor">
                    <a href="#">编辑头像</a>
                </div>
                </dt>
                <dd>
                    <p>当前头像</p>

                    <p><span>用户名：</span><span>${user.username}</span></p>

                    <p><span>用户类型：</span><span>个人用户</span></p>
                </dd>
            </dl>
        </div>
        <div class="userinfo-datum">
            <form action="/updatePersonalInfo.do" method="post">
                <ul>
                    <li>
                        <label>昵称：</label>
                        <input type="text" class="userinfo-tex" name="name2" value="${user.name2}">
                    </li>
                    <li>
                        <label>真实姓名：</label>
                        <input type="text" class="userinfo-tex" name="name" value="${user.name}">
                    </li>
                    <li>
                        <label>性别：</label>
                        <c:if test="${user.sex==1}">
                        <input type="radio" class="userinfo-box" value="1" name="性别" checked>男
                        </c:if>
                        <c:if test="${user.sex !=1}">
                            <input type="radio" class="userinfo-box" value="1" name="性别" >男
                        </c:if>
                      <c:if test="${user.sex == 2}">
                        <input type="radio" class="userinfo-box" value="2" name="性别" checked>女
                      </c:if>
                        <c:if test="${user.sex != 2}">
                            <input type="radio" class="userinfo-box" value="2" name="性别" >女
                        </c:if>
                    </li>
                    <li>
                        <label class="act1">生日：</label>
                        <!--amazeui-->
                        <div class="am-input-group am-datepicker-date" data-am-datepicker="{format: 'dd-mm-yyyy'}">
                            <input type="text" class="am-form-field" placeholder="年月日" readonly name="birthDate" value="${user.birthDate}">
      <span class="am-input-group-btn am-datepicker-add-on">
        <button class="am-btn am-btn-default actt" type="button"><span class="am-icon-calendar-1 "></span></button>
      </span>
                        </div>
                        <!--amazeui-->
                    </li>
                    <input type="hidden" name="id" value="${user.id}" >
                    <li>
                        <label></label>
                        <input type="submit" class="dj-btn" value="保存个人信息">
                    </li>
                </ul>
            </form>
        </div>
    </div>
    <!-- //End--title-->
</div>
</div>
</div>
<!--content-->
<!-- //End--footer-->
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="/scripts/assets/js/jquery.min.js"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script src="/scripts/assets/js/amazeui.min.js"></script>
<script src="/scripts/assets/js/system.js"></script>


<script>
    function info() {
        $.ajax({
            type: 'get',
            async: false,
            url: '<c:url value="/defaultAddress.do"/>',
            dataType: 'json',
            data: {},
            success: function (data) {
            },

        });
    }
</script>
</body>
</html>
