<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/14
  Time: 10:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/css/amazeui.min.css?v=20150831"/>" />
    <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/css/login.css"/>"/>
</head>
<body>
<div class="topbar wh">
    <div class="hd">
        <ul class="ul-item">
            <li><a href="" title="请登录">请登录</a></li>
            <li><a href="" title="快速注册">快速注册</a></li>
            <li class="btn-top-wechat">
                <a title="手机e飞蚁">手机e飞蚁</a>
                <span class="top-wechat" style="display: none;"></span>
            </li>
            <li class="cart">
                <a href=" " title="购物车"><i class="icon"></i>购物车</a>
                <span class="tips"><em id="cartAmount">0</em></span>
            </li>
        </ul>
    </div>
</div>

<div class="header wh">
    <div class="hd">
        <div class="logo">
            <a class="icon" href="http://www.efeiyi.com" title="e飞蚁-商户后台"></a>
        </div>
        <h2>商户后台</h2>
    </div>
</div>

<div class="login hd">
    <div class="login-form">
        <form action="<c:url value="/j_spring_security_check"/>" method="post">
            <div class="mt wh">
                <h3>商户登录</h3><span class="link"><em>没有账号?</em><a class="reg" href="<c:url value="/sign/toRegister.do"/>">立即入驻</a></span>
            </div>
            <div class="am-form-group">
                <i class="icon name"></i>
                <input id="username" name="username" class="text1 textam" tabindex="1" minlength="3" placeholder="已验证手机" type="text" value="${username}">
            </div>
            <div class="am-form-group">
                <i class="icon pwd"></i>
                <input id="password" name="password" class="text1 textam" tabindex="2" minlength="3" placeholder="密码" type="password" value="">
            </div>
            <div class="am-form-group">
                <%--<label for="">--%>
                    <%--<input type="checkbox" tabindex="4" name="rememberMe" value="true">--%>
                    <%--<span>自动登录</span>--%>
                    <%--<a class="forgetpwd" href="" title="忘记密码">忘记密码？</a>--%>
                <%--</label>--%>
            </div>
            <input class="btn-submit " type="submit" tabindex="5" value="登 录 工 作 台">
        </form>
    </div>
</div>
<!-- //End--login-->


<div class="footernew wh">
    <div class="publ-top hd">
        <dl class="city">
            <dt>正</dt>
            <dd>
                <p>诚&nbsp;品&nbsp;保&nbsp;真</p>
                <p>非&nbsp;遗&nbsp;佳&nbsp;作</p>
            </dd>
        </dl>
        <dl class="city">
            <dt>七</dt>
            <dd>
                <p>无&nbsp;忧&nbsp;售&nbsp;后</p>
                <p>七&nbsp;天&nbsp;退&nbsp;换</p>
            </dd>
        </dl>
        <dl class="city">
            <dt>专</dt>
            <dd>
                <p>文&nbsp;化&nbsp;垂&nbsp;直</p>
                <p>专&nbsp;注&nbsp;非&nbsp;遗</p>
            </dd>
        </dl>
        <dl class="city">
            <dt>省</dt>
            <dd>
                <p>省&nbsp;时&nbsp;省&nbsp;力</p>
                <p>省&nbsp;钱&nbsp;省&nbsp;心</p>
            </dd>
        </dl>
    </div>
    <div class="servicenew wh">
        <div class="hd tct">
            <div class=" foremax">
                <dl class="fore">
                    <dt>帮助中心</dt>
                    <dd><a href="#" target="_blank">购物流程</a></dd>
                    <dd><a href="#" target="_blank">支付方式</a></dd>
                    <dd><a href="#" target="_blank">配送方式</a></dd>
                </dl>
                <dl class="fore">
                    <dt>商家服务</dt>
                    <dd><a href="#" target="_blank">入驻须知</a></dd>
                    <dd><a href="#" target="_blank">入驻流程</a></dd>
                    <dd><a href="#" target="_blank">入驻咨询</a></dd>
                </dl>
                <dl class="fore">
                    <dt>售后流程</dt>
                    <dd><a href="#" target="_blank">退货流程</a></dd>
                    <dd><a href="#" target="_blank">换货流程</a></dd>
                </dl>
                <dl class="fore">
                    <dt>服务保障</dt>
                    <dd><a href="#" target="_blank">正品保障</a></dd>
                    <dd><a href="#" target="_blank">售后政策</a></dd>
                </dl>
                <dl class="fore">
                    <dt>法律声明</dt>
                    <dd><a href="#" target="_blank">法律声明</a></dd>
                    <dd><a href="#" target="_blank">安全及隐私声明</a></dd>
                </dl>
                <div class="wechatnew" title="手机e飞蚁"><i class="inro-icon"></i></div>
            </div>
        </div>
    </div>
    <div class="max-links wh">
        <div class="links wh">
            <a href="" target="_blank" title="关于我们">关于我们</a>
            <a class="line"></a>
            <a href="" target="_blank" title="平台优势">平台优势</a>
            <a class="line"></a>
            <a href="" target="_blank" title="诚聘英才">诚聘英才</a>
            <a class="line"></a>
            <a href="" target="_blank" title="联系我们">联系我们</a>
            <a class="line"></a>
            <a href="" target="_blank" title="意见反馈">意见反馈</a>
            <a class="line"></a>
            <a href="" target="_blank" title="非遗简介">非遗简介</a>
        </div>
        <div class="copyright wh">
            <div class="frlinksimg">
                <strong>战略合作伙伴</strong>
                <a class="icon1" href="http://en.unesco.org/" title="联合国教科文组织" target="_blank"></a><em class="line"></em><a class="icon3" title="中国非物质文化遗产保护协会"></a><em class="line"></em><a class="icon2" title="中国非物质文化遗产保护协会"></a></div>
            <div class="info">Copyright © 2012-2022 永新华韵文化发展有限公司版权所有-京ICP备15032511号-1</div>
        </div>
        <div class="wh authentication">
            <a href="http://www.miitbeian.gov.cn" target="_blank" title=""> <img class="imgfilter" src="<c:url value="/scripts/images/authentication-0.png"/>" alt=""></a>
            <a href="http://www.miitbeian.gov.cn" target="_blank" title="网站域名备案"> <img class="imgfilter" src="<c:url value="/scripts/images/authentication-1.png"/>" alt="网站域名备案"></a>
            <a href="http://www.baic.gov.cn/" target="_blank" title="企业信用信息备案"> <img class="imgfilter" src="<c:url value="/scripts/images/authentication-2.png"/>" alt="企业信用信息备案"></a>
            <a href="/scripts/images/license.jpg" target="_blank" title="企业营业执照"> <img class="imgfilter" src="<c:url value="/scripts/images/authentication-3.png"/>" alt="企业营业执照 "></a>
        </div>
    </div>
</div>



<%--<div class="am-g am-g-fixed" style="max-width: 550px;">--%>
    <%--<div class="am-u-md-12" style="box-shadow: 0px 0px 2px #626262;">--%>
        <%--<div class="am-u-md-12" style="text-align: center ;"><h2 style=" margin-top: 1.6rem;">e飞蚁 商家后台系统登录</h2></div>--%>
        <%--<form class="am-form am-form-horizontal" action="<c:url value="/j_spring_security_check"/>" method="post">--%>
            <%--<div class="am-form-group">--%>
                <%--<label for="username" class="am-u-sm-2 am-form-label">用户名</label>--%>

                <%--<div class="am-u-sm-10">--%>
                    <%--<input type="text" name="username" id="username" value="${username}" placeholder="输入用户名">--%>
                <%--</div>--%>
            <%--</div>--%>

            <%--<div class="am-form-group">--%>
                <%--<label for="password" class="am-u-sm-2 am-form-label">密码</label>--%>

                <%--<div class="am-u-sm-10">--%>
                    <%--<input type="password" name="password" id="password" placeholder="输入密码">--%>
                <%--</div>--%>
            <%--</div>--%>

            <%--<div class="am-form-group">--%>
                <%--<div class="am-u-sm-10 am-u-sm-offset-2">--%>
                    <%--<span>--%>
                        <%--<button type="submit" class="am-btn am-btn-default">登录</button>--%>
                    <%--</span>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</form>--%>
    <%--</div>--%>

          <%--<span style="margin-left: 550px;">--%>
             <%--<a class="am-u-sm-3" href="<c:url value="/sign/toRegister.do"/>"  style="text-decoration: underline;float: right;margin-top: 10px;">商家注册</a>--%>
          <%--</span>--%>

<%--</div>--%>
<script type="text/javascript">
    $(function(){
        $('.btn-top-wechat').hover(function(){
            $(this).find('.top-wechat').stop(true).slideDown('fast');
        },function(){
            $(this).find('.top-wechat').stop(true).slideUp('fast');
        });
    })
</script>
</body>
</html>
