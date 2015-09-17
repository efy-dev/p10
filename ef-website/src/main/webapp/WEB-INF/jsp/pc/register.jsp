<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>

    <title>注册-e飞蚁</title>


    <style type="text/css">
        .title {
            /*color:#D4D4D4;*/
            font-size: 16px;
            font-weight: bold;
            border-bottom: 2px solid #247ba0;
        }

        .am-nav-tabs > li.am-active > a, .am-nav-tabs > li.am-active > a:hover, .am-nav-tabs > li.am-active > a:focus {
            color: #555;
            background-color: #fff;
            border: 1px solid #ddd;
            border-bottom-color: transparent;
            cursor: default;
            background-color: #8cc5fb;
            color: white;
        }

        .am-active {
            background-color: #8cc5fb;
        }
    </style>
    <script type="text/javascript">

        var flag = false;


        function validForm() {
            if (flag == bool == true) {
                return true;
            }
            return false;
        }


    </script>

    <script type="application/javascript" src="<c:url value="/resources/plugins/parsley/parsley.min.js"/>"/>
    <script type="application/javascript" src="<c:url value="/resources/plugins/parsley/parsley.remote.min.js"/>"/>

    <script>
        $(document).ready(function () {
            $('#btnPanel').on('click', function (event) {
                if ($(event.target).attr('id') == 'consumerEnrollBtn') {
                    /*$('#photographerAttention').fadeOut('fast');
                     $('#consumerAttention').fadeIn('slow');*/
                    $('#photographerAttention').fadeOut('fast', function () {
                        $('#consumerAttention').fadeIn('slow');
                    });

                }
                else if ($(event.target).attr('id') == 'photographerEnrollBtn') {
                    $('#consumerAttention').fadeOut('fast', function () {
                        $('#photographerAttention').fadeIn('slow');
                    });

                }
            });
        });
    </script>
</head>
<body>
<%--<div class="am-g am-g-fixed">--%>
<%--<hr>--%>
<%--<div class="am-g" style="margin-top: 100px">--%>
<%--<div class="am-u-md-8">--%>
<%--&lt;%&ndash;<img id="consumerAttention" src="/scripts/yuepaila/images/common/signInStep.png">--%>
<%--<img id="photographerAttention" src="/scripts/yuepaila/images/common/login4.png" style="display: none">&ndash;%&gt;--%>
<%--</div>--%>

<%--<div class="am-u-md-4" style="margin-top: 35px">--%>
<%--<div data-am-widget="tabs" class="am-tabs am-tabs-default">--%>
<%--<ul id="btnPanel" class="am-tabs-nav am-cf">--%>
<%--<li class="am-active"><a href="#consumerPanel" id="consumerEnrollBtn">用户注册</a></li>--%>
<%--</ul>--%>

<%--<div class="am-tabs-bd" style="border: 0px;">--%>
<%--<div class="am-tab-panel am-active" id="consumerPanel">--%>


<%--<form data-parsley-validate id="bigUser" name="bigUser"--%>
<%--action="<c:url value="/pc/saveEnrollUser.do"/>" method="post"--%>
<%--onkeypress="if(event.keyCode==13||event.which==13){return false;}" class="am-form">--%>
<%--<div class="am-form-group">--%>
<%--<div class="controls">--%>
<%--<label for="username">手机号</label>--%>
<%--<input type="text" id="username" name="username"--%>
<%--data-parsley-pattern="^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$"--%>
<%--data-parsley-error-message="请输入正确的手机号"--%>
<%--data-parsley-trigger="change"--%>
<%--data-parsley-required-message="请输入您的手机号"--%>
<%--placeholder="请输入您的手机号"--%>
<%--required/>--%>

<%--<p id="usernameMessage" style="color: red"></p>--%>

<%--</div>--%>
<%--</div>--%>
<%--&lt;%&ndash;<div class="col-md-12">&ndash;%&gt;--%>
<%--&lt;%&ndash;<div class="col-md-6">&ndash;%&gt;--%>
<%--<div class="am-form-group">--%>
<%--<div class="controls">--%>
<%--<label for="verification">手机验证</label>--%>

<%--<div class="am-u-md-12" style="padding: 0px;">--%>
<%--<div class="am-u-md-6" style="padding: 0px;">--%>
<%--<input type="text" id="verification" placeholder="短信验证码"--%>
<%--required/>--%>
<%--</div>--%>
<%--<div class="am-u-md-6" style="padding-right: 0px;padding-left: 5px;">--%>
<%--<a class="am-btn form-btn" id="verificationButton" style="margin-top: 0px">点击获取验证码</a>--%>
<%--</div>--%>
<%--</div>--%>
<%--<div class="help-block">--%>
<%--<h5 id="consumerVerificationCodeCheck" style="color: red;display: none">--%>
<%--手机验证码输入错误</h5>--%>
<%--</div>--%>
<%--</div>--%>
<%--</div>--%>
<%--<div class="am-form-group" style="margin-top: 40px;">--%>
<%--<div class="controls">--%>
<%--<label for="password">密码</label>--%>
<%--<input type="password" id="password" name="password"--%>
<%--placeholder="密码由6-16位字母或数字组成"--%>
<%--data-parsley-trigger="change"--%>
<%--required/>--%>
<%--</div>--%>
<%--</div>--%>
<%--<div class="am-form-group">--%>
<%--<div class="controls">--%>
<%--<label for="passwordAgain">确认密码</label>--%>
<%--<input type="password" id="passwordAgain" class="form-control" name="passwordAgain"--%>
<%--data-parsley-equalto="#password" data-parsley-equalto-message="两次输入不一致"--%>
<%--data-parsley-required="true"--%>
<%--data-parsley-trigger="change"--%>
<%--placeholder="请与上面输入的值一致"--%>
<%--required/>--%>
<%--</div>--%>
<%--</div>--%>


<%--&lt;%&ndash;<div class="am-form-group" style="display: none">--%>
<%--<div class="controls">--%>
<%--<label for="name">姓名</label>--%>
<%--<input type="text" id="name" class="form-control" name="name"/>--%>
<%--</div>--%>
<%--</div>&ndash;%&gt;--%>
<%--<div class="am-form-group" style="display: none">--%>
<%--<div class="controls">--%>
<%--<label>邮箱</label>--%>
<%--<input type="email" id="email" class="form-control" name="email"/>--%>
<%--</div>--%>
<%--</div>--%>
<%--<div class="am-form-group" style="display: none">--%>
<%--<div class="controls">--%>
<%--<label>电话</label>--%>
<%--<input type="input" id="phone" class="form-control" name="phone"/>--%>
<%--</div>--%>
<%--</div>--%>

<%--&lt;%&ndash;<div class="am-form-group">&ndash;%&gt;--%>
<%--&lt;%&ndash;<label for="userRole">选择用户类型</label>&ndash;%&gt;--%>
<%--&lt;%&ndash;<select id="userRole">&ndash;%&gt;--%>
<%--&lt;%&ndash;<option value="consumer">消费者</option>&ndash;%&gt;--%>
<%--&lt;%&ndash;<option value="photographer">摄影师</option>&ndash;%&gt;--%>
<%--&lt;%&ndash;</select>&ndash;%&gt;--%>
<%--&lt;%&ndash;<span class="am-form-caret"></span>&ndash;%&gt;--%>
<%--&lt;%&ndash;</div>&ndash;%&gt;--%>

<%--<div class="am-form-group" style="margin-top: 25px;margin-top: 17px;">--%>
<%--<div class="controls">--%>
<%--<input id="consumerSubmit" type="submit" class="btn btn-primary btn-block"--%>
<%--value="注册"--%>
<%--style="border-color: #db0c5b;background-color: #db0c5b; display: none"/>--%>
<%--<a id="consumerSignin" class="am-btn form-btn">注册</a>--%>
<%--</div>--%>
<%--</div>--%>
<%--</form>--%>
<%--</div>--%>
<%--</div>--%>
<%--</div>--%>
<%--</div>--%>
<%--</div>--%>
<%--</div>--%>


<div class="hd login">
    <div class="login-wrap">
        <div class="banner"><img src="<c:url value="/scripts/images/login-1.jpg"/>" alt=""/></div>
        <div class="login-form reg-form">
            <form class="am-form" data-parsley-validate id="bigUser" name="bigUser"
                  action="<c:url value="/pc/saveEnrollUser.do"/>" method="post"
                  onkeypress="if(event.keyCode==13||event.which==13){return false;}">
                <fieldset>
                    <div class="mt wh">
                        <h1>注册会员</h1>
                        <span class="link">
                            <p>已是会员，</p>
                            <a class="reg" href="<c:url value="/login"/> ">登录</a>
                        </span>
                    </div>
                    <div class="am-form-group">
                        <input type="text" id="username" name="username"
                               data-parsley-pattern="^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$"
                               data-parsley-error-message="请输入正确的手机号"
                               data-parsley-trigger="change"
                               data-parsley-required-message="请输入您的手机号"
                               placeholder="请输入您的手机号"
                               required>
                        <label class="msg-tips" id="usernameMessage" style="display: none">
                            <span class="msg">！该手机号已存在,如果您是该用户，请 <a href="<c:url value="/login"/> ">立刻登录</a></span>
                        </label>
                    </div>
                    <div class="am-form-group">
                        <input class="txt-yzm" type="text" id="verification" minlength="3" placeholder="验证码" required>
                        <button  class="btn-p1" id="verificationButton">获取验证码</button>

                        <div class=<h5 id="consumerVerificationCodeCheck" style="color: red;display: none">
                                手机验证码输入错误</h5>
                        </div>
                    </div>

                    <div class="am-form-group">
                        <input type="password" id="password" name="password" data-parsley-pattern="^[a-zA-Z0-9]{6,16}$"
                               data-parsley-error-message="密码由6-16位字母或数字组成" placeholder="密码由6-16位字母或数字组成"
                               data-parsley-trigger="change" required="" data-parsley-id="6670">
                    </div>
                    <div class="am-form-group">
                        <input type="password" id="passwordAgain" class="form-control" name="passwordAgain"
                               data-parsley-equalto="#password" data-parsley-equalto-message="两次输入不一致"
                               data-parsley-required="true"
                               data-parsley-required-message="请确认密码"
                               data-parsley-trigger="change"
                               placeholder="请与上面输入的值一致">
                        <%--<label class="msg-tips" for="">--%>
                        <%--<span class="msg">！两次密码输入不一致，请重新输入</span>--%>
                        <%--</label>--%>
                    </div>
                    <div class="am-form-group">
                        <label><input class="checkbox" id="agreemen" type="checkbox" checked />我已认真阅读并同意<a id="protocol"
                                                                                                     class="agree"
                                                                                                     href="#"
                                                                                                     title="e飞蚁用户注册协议">《e飞蚁用户注册协议》</a></label>
                    </div>
                    <input id="consumerSubmit" type="submit" class="btn btn-primary btn-block"
                           value="注册"
                           style="border-color: #db0c5b;background-color: #db0c5b; display: none"/>
                    <a class="am-btn am-btn-secondary" id="consumerSignin">注 册</a>
                </fieldset>
            </form>
        </div>
    </div>
</div>

<div class="thickframe">
    <div class="thickdiv"></div>
    <div class="thickbox">
        <div class="thicktitle">
            <span>e飞蚁电子商务平台规则总则</span><a href="#" id="closeBox" class="icon thickclose">×</a>
        </div>
        <div class="thickcon">
            <div id="protocol-con">
                <h3>第一章 概 述</h3>

                <p>1.1 规则适用范围：本规则适用于e飞蚁电子商务平台用户，卖家可以根据业务需求选择经营模式以通过e飞蚁电子商务平台向买家销售商品或提供服务。本规则不适用于永新华韵自营商品及信息。</p>

                <p>1.2 为保证e飞蚁电子商务平台用户合法权益，维护e飞蚁电子商务平台正常经营秩序，根据《e飞蚁电子商务平台用户注册协议》、《e飞蚁电子商务平台服务协议》等服务协议，特制定本规则。</p>

                <p>1.3 “e飞蚁电子商务平台规则”，是规范e飞蚁电子商务平台用户基本权利和义务的条款。</p>

                <p>1.4 对规则行为的认定与处理，由永新华韵从普通人角度结合卖家和买家提供的凭证认，依据相关规则予以认定。e飞蚁电子商务平台用户在适用规则上一律平等。</p>

                <p>1.5
                    用户应遵守国家法律、行政法规、部门规章等规范性文件。对任何涉嫌违反国家法律、行政法规、部门规章等规范性文件的行为，本规则已有规定的，适用本规则；本规则尚无规定的，永新华韵有权依据相关规则酌情处理，但永新华韵对用户的处理不免除用户因违法、违约等行为应承担的法律责任。</p>

                <p>1.6 用户在e飞蚁电子商务平台的任何行为，应同时遵守与永新华韵签署的各项协议。</p>

                <p>
                    1.7永新华韵有权随时变更本规则并在卖家管理系统予以公告。若用户不同意相关变更，应立即停止使用e飞蚁电子商务平台提供的相关服务，并及时通知永新华韵。永新华韵有权对用户行为及应适用的规则/协议约定进行单方认定，并据此处理。</p>

                <h3>第二章 定 义</h3>

                <p>2.1 “永新华韵”：指永新华韵文化发展有限公司，其为e飞蚁电子商务平台的投资建设方、管理方以及平台规则制订方。</p>

                <p>2.2
                    “e飞蚁电子商务平台”：指运行于“e飞蚁.COM”网站的“e飞蚁.COM”开放平台，是“e飞蚁.COM”网站上为用户提供信息发布、交流，第三方经营者开设店铺经营，以及其它技术服务的电子商务交易服务平台。</p>

                <p>2.3 “用户”：指所有在“e飞蚁.COM”网站上注册，成为“e飞蚁.COM”注册会员的法人、自然人及其他组织，本规则中统称为“用户”，除非另有说明，否则“用户”均指其含义。</p>

                <p>2.4 “买家”指在e飞蚁电子商务平台上浏览或购买商品/接受服务的用户。</p>

                <p>2.5 “卖家”：指符合e飞蚁电子商务平台要求，成功入驻e飞蚁电子商务平台，使用e飞蚁电子商务平台出售商品或提供服务的用户，包括提供服务的服务商。</p>

                <p>2.6 “账号”：指用户注册时设置的账户名，账号具有唯一性。</p>

                <p>2.7 “订单”：指买家向卖家同一时间买下单款或多款商品/服务的合约，订单中针对任一款商品/服务的内容构成独立的交易。</p>

                <p>2.8 “店铺”：指卖家完成注册及入驻流程后，为进行合法经营，依据协议约定和e飞蚁电子商务平台规则，由卖家申请永新华韵审核通过的具有独立且唯一性ID
                    (“身份识别号码”)、特定名称（可依据相关平台规则进行调整）的网络化虚拟店铺。</p>

                <p>2.9 “交易达成”：指在线付款的订单卖家成功付款；货到付款的订单买家成功提交订单。</p>

                <p>2.10 “自提”：买家订单选择到永新华韵指定自提点提取所购商品。商品到达自提点后， 永新华韵为买家保留三日，超过三日买家没有提货，则视为默认取消订单。</p>

                <p>2.11 “自营商品”：指在商品详情页右侧无店铺展示区，且服务显示为“由永新华韵发货并提供售后服务”的商品，除此以外的商品或服务为e飞蚁电子商务平台卖家的商品/服务。</p>

                <p>2.12 “结算”：指永新华韵为提升卖家协议约定，核对、结算收付款项的行为。</p>

                <p>2.13 “自主售后 ”：指卖家通过永新华韵自主售后系统，根据售后原则处理买家签收商品后产生的售后问题，从而提高买家购物满意度的行为；</p>

                <p>2.14 “服务单”：客户申请返修/退换货等售后服务的单据凭证。</p>

                <p>2.15 “市场管理措施”：指为了营造良好的购物环境，永新华韵对违反e飞蚁电子商务平台规则的用户财务的管理手段，包括但不限于警告、扣除积分等。</p>

                <p>2.16 “积分”：是对卖家店铺的积分，具体指用户符合e飞蚁电子商务平台要求成为卖家开设店铺后，依据《e飞蚁电子商务平台卖家积分管理细则》对卖家店铺的奖励积分。</p>

                <h3>第三章 交 易</h3>
                <h4>第一节注 册</h4>

                <p>
                    3.1.1用户应当严格遵守e飞蚁电子商务平台系统设置的注册流程完成注册，并应遵守《e飞蚁电子商务平台服务协议》以及《e飞蚁电子商务平台用户注册协议》，用户在选择用户名时应遵守国家法律法规，不得包含违法或涉嫌侵犯他人权利等相关信息。</p>

                <p>3.1.2 用户必须满足以下条件，才有权申请加入 e飞蚁电子商务平台，成为卖家：</p>

                <p>（a）卖家遵守e飞蚁电子商务平台的招商标准；</p>

                <p>（b）卖家及其销售的商品或提供的服务须具备相应资质；</p>

                <p>（c）卖家有效签署《e飞蚁电子商务平台服务协议》等服务/合作协议，并达到协议约定的开通服务条件；</p>

                <p>3.1.3
                    卖家申请店铺名、子域名等信息时，应遵守国家法律法规及e飞蚁电子商务平台相关规则，不得包含违法或涉嫌侵犯他人权利等相关信息。详细信息请参见《e飞蚁电子商务平台卖家店铺命名规则》、《e飞蚁电子商务平台子域名管理规则》。</p>

                <p>3.1.4 在考核年度内，若卖家出现严重违规累计扣分达100分等情形，永新华韵有权清退该卖家并关店。 </p>
                <h4>第二节经 营</h4>

                <p>3.2.1 卖家应当按照e飞蚁电子商务平台系统设置的流程和 《e飞蚁电子商务平台商品信息发布规范》要求发布商品/服务。</p>

                <p>
                    3.2.2“商品如实描述”及对其所售商品/服务质量承担保证责任是卖家的基本义务。“商品如实描述”是指卖家在商品描述页面、店铺页面、活动页面等所有e飞蚁电子商务平台提供的渠道中，应当对商品的基本属性、成色、瑕疵等必须说明的信息进行真实、完整的描述。卖家在e飞蚁电子商务平台发布的商品或信息应当严格遵守《e飞蚁电子商务平台商品信息发布规范》。</p>

                <p>
                    3.2.3卖家应保证其出售的商品在合理期限内可以正常使用，提供的服务符合承诺标准，包括商品不存在危及人身财产安全的不合理危险、具备商品应当具备的使用性能、符合商品或其包装上注明采用的标准、符合提供服务时承诺的标准，且承诺标准不低于国家/行业标准等。</p>

                <p>3.2.4卖家店铺名的命名应当严格遵守《e飞蚁电子商务平台卖家店铺命名规则》。</p>
                <h4>第三节 超时规定</h4>

                <p>3.3.1 用户须按照e飞蚁电子商务平台系统设置的交易流程进行交易。</p>

                <p>3.3.2 除货到付款及上门自提订单外，买家下单后24小时未付款的订单，系统会自动取消订单并关闭交易；订单状态为已完成或已取消的，买家可以删除订单。</p>

                <p>3.3.3买家自付款成功之时起可申请退款。买家申请退款后，卖家未在7日内完成审核的，该审核自动通过，永新华韵将先行退款给买家，并扣除卖家相应货款。买家申请退款/退货后，按照以下情况分别处理：</p>

                <p>（a）订单完成前，卖家退款审核通过后，退款给买家；订单完成后，退货依照永新华韵售后政策或/规则处理；</p>

                <p>（b）卖家拒绝退款/退货的，买家可要永新华韵直接介入，永新华韵根据卖家回馈的拒绝退款原因/售后服务条款以普通人身份给予判定；</p>

                <p>（c）买家提出退货并在系统中上传快递单号后，15日内如卖家未回馈处理意见，永新华韵视卖家同意永新华韵先行退款给买家，在结算时永新华韵扣除卖家相应货款。</p>

                <p>
                    3.4.4自商品售出之日（以实际收货日期为准）起7日内买家可以申请退换货，15日内买家可以申请换货。买家可依据永新华韵售后政策规则在线提交返修/退换申请办理退换货事宜，如永新华韵售后政策及卖家明确公示不适用此规则的除外。</p>

                <p>3.4.5另行约定发货时间的商品或服务除外，双方交易达成后如买家投诉卖家延迟发货成立，卖家须向买家支付该商品实际成交金额的30%作为违约金（最高不超过500元），该违约金将以积分形式支付给买家。</p>

                <p>3.4.6 特定事件或特定时期的发货时效要求及处理以e飞蚁电子商务平台公告或通知为准，包括但不限于国家法定节假日、不可抗力等情形。</p>
                <h4>第四节 售后服务</h4>

                <p>3.5.1售后服务包括：商品的安装、调试、维修、技术培训等服务内容；买家提出的商品退、换货申请的处理；其他与售后相关的投诉问题的处理等。买家可以在账号后台“我的投诉”处对订单提交投诉。</p>

                <p>3.5.2卖家自主售后服务内容包括但不限于以下内容：</p>

                <p>
                    （a）如永新华韵在处理售后服务时需联系卖家的，永新华韵根据商品类型以及售后服务问题严重程度以电话、邮件（卖家系统记载的邮件地址）或者投诉工单形式与卖家联系，卖家应注意查收并按时效要求回复意见，以便为买家提供售后服务（时效要求详见超时规定）；</p>

                <p>（b）卖家应当配备专门的客服团队（或人员）使用永新华韵在线自主售后系统处理来自买家的问题，包括但不限于商品的退货、换货、维修等售后服务内容；</p>

                <p>
                    （c）卖家以及卖家所配备的客服团队（或人员）应按照商品的保修承诺及e飞蚁电子商务平台售后服务政策为买家提供相应的售后服务；如卖家自己的售后服务政策更有利于买家，则应按更有利于买家的政策提供售后服务；</p>

                <p>
                    （d）卖家应对发生在自主售后服务系统中的所有行为负完全责任，应妥善保管系统的账号、个人信息及相关密码。对于因未经授权的人员使用卖家的自主售后服务系统而可能造成的任何损失，均由卖家自行承担，如永新华韵为此先行承担了相关责任，卖家须赔偿永新华韵因此产生的所有费用及损失；</p>
                <h4>第五节 评 价</h4>

                <p>3.5.1买家有权基于真实的交易在订单交易成功后进行评价，商品评价资格有效期为订单完成后180日内，满意度评价资格有效期为订单完成后3个月内。</p>

                <p>3.5.2删除评价规则：</p>

                <p>（a）涉及反政府、反社会、反宗教、反人类等内容；</p>

                <p>（b）涉及淫秽色情、赌博、毒品等内容；</p>

                <p>（c）涉及辱骂、污蔑、人身攻击等内容；</p>

                <p>（d）涉及外网链接、广告贴等内容；</p>

                <p>（e）因用户发布违规评价，该评价将被删除，且用户将被禁言三日。</p>

                <p>3.5.3评价内容部分屏蔽规则：</p>

                <p>（a）涉及非e飞蚁电子商务平台内部店铺等信息；</p>

                <p>（b）涉及产品价格信息。</p>

                <p>3.5.4评价积分删除规则：</p>

                <p>（a）用户退货后该商品评价积分将被e飞蚁电子商务平台扣除；</p>

                <p>（b）用户换货不会对所获评价积分产生任何影响。</p>

                <p>3.5.5评价回复规则：</p>

                <p>（a）单个用户24小时内，最多发布20条评价回复；相同内容不应重复评价，否则重复内容视为违规内容；</p>

                <p>（b）单个用户24小时内，如相同内容回复大于等于3条，将被删除24小时内全部违规内容；</p>

                <p>（c）单个用户24小时内，对同一评价回复大于等于5条，将被删除24小时内全部违规内容。</p>

                <p>
                    3.5.6店铺综合评分由买家对卖家给出，服务评分包括商品描述相符、卖家送货速度、卖家商品质量、售后服务水平等。评分采样周期为最近180日，计算规则为算术平均值。采样周期内，相同买家与卖家之间的订单满意度评价仅提取前10次评价，售后满意度仅提取前5次评价。</p>

                <h3>第四章 市场管理</h3>
                <h4>第一节 市场管理措施</h4>

                <p>4.1.1为了提升买家的购物体验，维持市场正常运营秩序，e飞蚁电子商务平台按照本规则规定的情形对用户或卖家经营行为采取以下临时性措施：</p>

                <p>（a）警告：指永新华韵通过口头或书面的形式对用户的不当行为进行提醒和告诫；</p>

                <p>（b）下架：指将卖家在售商品/服务转移至线上待售商品；</p>

                <p>（c）限制参加营销活动：指限制卖家参加永新华韵官方发起的营销活动；</p>

                <p>（d）单个商品搜索降权：指调整商品在搜索结果里的排序；</p>

                <p>（e）全店商品搜索降权：指调整卖家店铺内所有商品在搜索结果里的排序；[技术上是否能实现？]</p>

                <p>（f）单个商品搜索屏蔽：指商品在搜索结果里不展现；</p>

                <p>（g）单个商品单一维度搜索默认不展示：指商品信息在按价格、销量等单一维度的搜索结果中默认不展示；</p>

                <p>（h）全店商品单一维度搜索默认不展示：指卖家店铺内所有商品在按价格、销量等单一维度的搜索结果里默认不展示；[技术上是否能实现？]</p>

                <p>（i）店铺屏蔽：指在搜索、导航、营销等各项服务中对卖家店铺及商品等信息进行屏蔽；</p>

                <p>（j）支付违约金：指根据协议约定或本规则规定由卖家向买家和/或永新华韵支付一定金额的违约金；</p>

                <p>（k）关闭店铺：指删除卖家的店铺，下架店铺内所有出售中的商品，禁止发布商品，并禁止创建店铺；</p>
                <h4>第二节 市场管理情形</h4>

                <p>4.2.1卖家应积极提升自身经营水平，为买家提供优质的商品及服务。对于综合表现优秀的卖家，e飞蚁电子商务平台会适当给予扶持。</p>

                <p>
                    4.2.2用户如发生危及交易安全或扰乱e飞蚁电子商务平台运营秩序等行为，永新华韵将依照其行为的危险程度采取账户强制措施、关店、店铺屏蔽、限制发布商品或信息、限制网站登录等保障交易安全的临时性管理措施；情形严重的，永新华韵有权依照平台规则采取违规处理要求卖家承担违约责任。</p>

                <p>4.2.3新闻媒体曝光或国家质监部门通报的质量不合格的品牌、品类或批次的商品及信息，永新华韵将对卖家在售的相关商品及信息进行临时性下架或删除处理。</p>

                <p>4.2.4卖家参与e飞蚁电子商务平台活动及活动展示时，应符合相关活动规则。</p>

                <p>
                    4.2.5卖家应根据协议约定或规则规定缴纳或补足保证金。若保证金余额不足或被永新华韵通知需要增加保证金时，且经永新华韵催缴后卖家未按协议约定期限缴纳或补足的，永新华韵有权视违约情况采取临时性管理措施，直至卖家足额缴纳为止。</p>

                <p>4.2.6如果卖家店铺被关闭，永新华韵将按照合同约定及规则办理店铺关闭手续，如卖家向永新华韵支付过保证金的，永新华韵按约定情形办理保证金退还事宜。</p>

                <h3>第五章 违规行为及违规处理执行</h3>
                <h4>第一节 违规行为</h4>

                <p>
                    5.1.1严重违规行为，是指严重破坏e飞蚁电子商务平台网站经营秩序并涉嫌违反国家法律法规的行为。卖家严重违规行为说明请详见《e飞蚁电子商务平台平台卖家积分管理规则》[技术上是否能实现？如能实现，请技术中心起草卖家积分管理规则。]中有关严重违规行为的说明。</p>

                <p>5.1.2一般违规行为，是指除严重违规行为外的违规行为，卖家一般违规行为说明请详见《e飞蚁电子商务平台平台卖家积分管理规则》中有关一般违规行为的说明。</p>
                <h4>第二节 违规处理措施</h4>

                <p>5.2.1为保障用户或永新华韵的正当权益，维持市场正常运营秩序，在用户违规处理期间永新华韵按照本规则规定的情形对用户采取违规处理措施：</p>

                <p>5.2.2对于违规卖家，永新华韵采取以下处理措施：</p>

                <p>（a）限制参加营销活动：指限制卖家参加永新华韵官方发起的营销活动；</p>

                <p>（b）限制发布商品：指限制卖家发布新商品；</p>

                <p>（c）限制开新店：指限制卖家在e飞蚁电子商务平台开设新的店铺；</p>

                <p>（d）限制社区功能：指禁止卖家使用e飞蚁社区、卖家论坛板块等社区类服务；</p>

                <p>（e）店铺屏蔽：指在搜索、导航、营销等各项服务中对卖家店铺及商品等信息进行屏蔽； </p>

                <p>（f）关闭店铺：指删除卖家的店铺，下架店铺内所有出售中的商品，禁止发布商品，并禁止创建店铺；</p>

                <p>（g）公示警告：指在e飞蚁电子商务平台卖家的卖家管理系统、卖家论坛等位置对其正在被执行的处理进行公示；</p>

                <p>（h）限制登录：指禁止卖家登录e飞蚁电子商务平台网站；</p>

                <p>（i）限制发货：指限制卖家操作商品出库的行为；</p>

                <p>（j）查封账户：指永久禁止用户使用违规账户登录e飞蚁电子商务平台网站、登录卖家管理系统。</p>

                <p>5.2.2对于违规买家，永新华韵采取以下处理措施：</p>

                <p>（a）限制买家行为：指禁止买家购买商品；</p>

                <p>（b）限制登录：指禁止买家登录e飞蚁电子商务平台网站；</p>

                <h3>第三节 违规处理</h3>

                <p>5.3.1卖家发生违规行为的，其违规行为应当及时纠正，永新华韵将对该卖家扣以一定积分且在卖家管理系统或卖家论坛等位置公布。自然年度违规扣分在次年的一月一日零时清零。</p>

                <p>5.3.2违规行为根据严重程度分为严重违规行为及一般违规行为，两者分别扣分、分别累计、分别执行，但针对一事仅作一次处理，不涉及重复处理。</p>

                <p>5.3.3卖家违规行为的纠正，是指：</p>

                <p>（a）出售假冒商品的，永新华韵对卖家所发布的假冒商品及信息进行删除；</p>

                <p>（b）盗用他人账户的，永新华韵收回被盗账户，原所有人可以通过永新华韵申诉重新取回账户；</p>

                <p>（c）假冒材质成分的，永新华韵对卖家所发布的假冒材质成分的商品及信息进行删除； </p>

                <p>（d）虚假宣传的，永新华韵对商业活动中卖家利用广告或其他方法对商品或者服务做出与实际内容不相符的虚假信息相关商品及/或信息进行删除；</p>

                <p>（e）发布违禁信息的，永新华韵对卖家所发布的违禁商品及信息及因此产生的交易评价进行删除；</p>

                <p>（f）发布非约定商品的，永新华韵对卖家所发布的非约定商品及信息进行删除；</p>

                <p>（g）泄露他人信息的，永新华韵对卖家所泄露的他人隐私资料的信息进行删除；</p>

                <p>（h）骗取他人财物的，永新华韵对用以骗取他人财物的商品或/及信息及因此产生的交易评价进行删除；</p>

                <p>（i）滥发信息的，永新华韵删除卖家所滥发的商品或/及信息；同时永新华韵对有滥发信息行为的商品或/及信息进行搜索降权处理；</p>

                <p>
                    （j）虚假交易中通过不正当方式提高店铺评分，永新华韵删除卖家因虚假交易产生的店铺评分并下架店铺内商品；虚假交易中通过不正当方式提高商品销量的，永新华韵删除该商品及虚假交易产生的店铺评分；同时永新华韵对有虚假交易的店铺或商品进行搜索降权处理；[技术上是否能实现？]</p>

                <p>
                    （k）描述不符的，卖家对商品材质、成分、品质等信息的描述与买家收到的商品不符，或导致买家无法正常使用的，永新华韵下架该描述不符的商品；卖家未对商品瑕疵等信息进行披露或对商品的描述与买家收到的商品不相符，且影响买家正常使用的，永新华韵下架该描述不符的商品；</p>

                <p>（l）违背承诺的，卖家须履行如实描述义务或消费者保障服务规定的赔付、退货、换货、维修服务；或卖家须按实际交易价款向买家/或永新华韵提供发票；[如卖家为个人？]</p>

                <p>（m）延迟发货的，如买家投诉卖家未按约定时间发货，卖家须向买家支付一定金额违约金；</p>

                <p>（n）不当注册的，永新华韵对用户使用软件、程序方式大批量注册的账户进行查处；并对滥用权利提交的订单予以取消；</p>

                <p>（o）不当使用他人权利的，永新华韵对卖家所发布的不当使用他人权利的商品及信息进行删除；</p>

                <p>5.3.4就卖家的首次或者非故意实施的违规行为,永新华韵将视情形给予纠正和教育,并要求卖家进行自查。</p>
                <h4>第四节 违规处理执行</h4>

                <p>5.4.1 用户的违规行为，通过其他用户、权利人的投诉或永新华韵排查发现。</p>

                <p>5.4.2卖家自行作出的承诺或说明与本规则相悖的，除证据有误或判断错误的情形外，对违规行为的处理不中止、不撤销。</p>

                <p>5.4.3永新华韵对卖家的严重违规行为将按《e飞蚁电子商务平台卖家积分管理规则》执行，详见《e飞蚁电子商务平台卖家积分管理规则》之违规处理。</p>

                <p>第五节 违规申诉</p>

                <p>
                    针对违规行为，卖家可在被违规处理之时起总计十四日内（永新华韵审核时间除外）通过e飞蚁电子商务平台商家后台提交违规申诉申请，卖家提交申诉资料后将由e飞蚁电子商务平台客服中心核实处理，申诉处理时效为接收到卖家申诉资料后3-5个工作日。</p>

                <p>第六章 奖励机制及执行</p>

                <p>6.1为提升e飞蚁电子商务平台影响力，e飞蚁电子商务平台对综合表现优秀的卖家会给予奖励，奖励包括积分奖励及返利两部分内容。具体内容详见《e飞蚁电子商务平台卖家积分管理规则》之卖家奖励管理规定。</p>

                <p>6.2 卖家违规积分和奖励积分二者互不抵消，分别计算，具体内容详见《e飞蚁电子商务平台卖家积分管理规则》之奖励说明及执行。</p>

                <p>第七章 附 则</p>

                <p>7.1 本规则中的日如无特殊说明均指连续的自然日，如7日是连续七日。</p>

                <p>7.2 永新华韵可根据平台运营情况随时调整本管理规则并以“e飞蚁电子商务平台”公告的形式向卖家公示，调整后的规则一经发布即生效。</p>
            </div>
            <div class="btnt"><input type="button" class="btn-img" value="同意并继续"></div>
        </div>
    </div>
</div>

<script>

    var isConsumerCodeRight = false;
    var isVerification = false;

    //验证用户名
    function usernameConfirm() {
        var reg = /^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/;
        var username
        username = $("#username").val();

        if (reg.test(username)) {
            $("#usernameConfirmWarning").hide();
            return true;
        } else {
            $("#usernameConfirmWarning").show();
            return false;
        }
    }


    var bool = false;


    function checkUserName(usertype) {

        var username = "";
        if (usertype == "user") {
            username = $("#username").val();
//                $("#name").val($("#username").val());
            $("#phone").val($("#username").val());
        } else {
            username = $("#photographerUsername").val();
            $("#pgphone").val($("#photographerUsername").val());
        }


        if ((username != null && username != "")) {
            jQuery.ajax({
                type: 'post',
                async: false,
                url: '<c:url value="/pc/checkUserName.do"/>',
                dataType: 'json',
                data: {
                    username: username
                },
                success: function (data) {
//                console.log("检查用户名");
                    if (usertype == "user") {
//                    console.log("user type is user");
                        if (data) {
//                        console.log("用户名已经存在");
                            $("#usernameMessage").show()
                            bool = false;
                        } else {
//                        console.log("用户名不存在");
                            $("#usernameMessage").hide();
                            bool = true;
                        }
                    } else {
//                        console.log("user type is photographer");
                        if (data) {
//                        console.log("用户名已经存在");
                            $("#pgUsernameMessage").text("用户名已存在!");
                            bool = false;
                        } else {
//                        console.log("用户名不存在");
                            $("#pgUsernameMessage").text("");
                            bool = true;
                        }
                    }
                }
            });
        }
//    console.log("检查用户名");
//    console.log(bool)
        return bool;
    }


    var wait = 60;//时间
    function time(o, p) {//o为按钮的对象，p为可选，这里是60秒过后，提示文字的改变
        if (wait == 0) {
            o.removeAttr("disabled");
            o.html("获取验证码");//改变按钮中value的值
//        p.html("如果您在1分钟内没有收到验证码，请检查您填写的手机号码是否正确或重新发送");
            wait = 60;
        } else {
            o.attr("disabled", true);//倒计时过程中禁止点击按钮
            o.html(wait + "秒后重试");//改变按钮中value的值
            wait--;
            setTimeout(function () {
                        time(o, p);//循环调用
                    },
                    1000)
        }
    }

    function sendVerificationCode(phone) {
        $.ajax({
            type: 'get',
            async: false,
            url: '<c:url value="/pc/verification/send.do"/>',
            dataType: 'json',
            data: {
                phone: phone
            },
            success: function (data) {
                if (data) {
                    console.log("发送验证吗成功");
                } else {
                    console.log("发送验证码失败");
                }
            },
            error: function () {
                console.log("数据获取失败");
            }
        });
    }

    function checkVerificationCode(phone, code, userType) {
        isVerification = false;
        isPhotographerVerification = false;
        jQuery.ajax({
            type: 'get',
            async: false,
            url: '<c:url value="/pc/verification/verify.do"/>',
            dataType: 'json',
            data: {
                verificationCode: code,
                phone: phone
            },
            success: function (data) {
                if (data) {
                    if (userType == "user") {
                        isVerification = true;
                        $("#consumerVerificationCodeCheck").css("display", "none");
                    } else {
                        isPhotographerVerification = true;
                        $("#photographerVerificationCodeCheck").css("display", "none");
                    }
//                console.log("验证成功");
                } else {
                    if (userType == "user") {
                        isVerification = false;
                    } else {
                        isPhotographerVerification = false;
                    }
                    console.log("验证失败");
                }
            },
            error: function () {
                console.log("数据获取失败");
            }
        });
    }

    $().ready(function () {

        $("#verificationButton").click(function () {
            if ($("#username").val() != "") {
                if (true) {
                    sendVerificationCode($("#username").val())
                    time($("#verificationButton"));
                }
            }
        });

        $("#verification").blur(function () {
            checkVerificationCode($("#username").val(), $("#verification").val(), "user");
        });


        $("#consumerSignin").click(function () {
            console.log($("#agreemen").attr("checked"));
            if (isVerification && bool&&$("#agreemen").is(':checked')) {
//                if ($("#userRole").val() == "consumer") {
                $("#consumerSubmit").click();
//                } else if ($("#userRole").val() == "photographer") {
//                    $("#bigUser").attr("action", "/pc/saveEnrollPhotographer.do");
//                    $("#consumerSubmit").click();
//                }
            } else if (!isVerification) {
                $("#consumerVerificationCodeCheck").css("display", "block");
            } else if(!$("#agreemen").is(':checked')){
                showAlert("提示","请勾选同意注册协议");
            }
        });


        $("#username").blur(function () {


            if ($("#verification").val() != "") {
                checkVerificationCode($("#username").val(), $("#verification").val(), "user");
            }
            checkUserName("user");
        });
    });
</script>
</body>
</html>
