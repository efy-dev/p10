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
<!-- //End--topbar-->
<div class="header wh">
    <div class="hd">
        <div class="logo">
            <a class="icon" href="http://www.efeiyi.com" title="e飞蚁-商户后台"></a>
        </div>
        <h2>商户后台</h2>
    </div>
</div>

<div class="login hd">
    <div class="reg-box">
        <div class="title">
            <p><strong>选择类型</strong></p>
            <p>类型一旦选择不可修改，请谨慎操作</p>
        </div>
        <form action="<c:url value="/sign/Register.do"/>" method="post" id="form">
        <div class="radio">
            <span class="t1"><input name="tenantType" value="11" type="radio">企业</span>
            <span class="t2"><input name="tenantType" value="12" type="radio">个体</span>
            <span class="t3"><input name="tenantType" value="13" type="radio">个人</span>
        </div>
            <div class="items">
                <p>用户名</p>
                <input class="ipt" type="text" name="username" id="username" onblur="checkUserName()" placeholder=""  />

                <small name="message" style="color: red;line-height: 22px;"></small>
            </div>
            <div class="items">
                <p>密码</p>
                <input class="ipt" type="password" name="password" id="password" placeholder="" required />
            </div>
            <div class="items">
                <p>重复密码</p>
                <input class="ipt" type="password" name="rePassword" onkeydown="checkPassword()" onkeyup="checkPassword()" id="RePassword" placeholder=""  />
                <small name="message" style="color: red;line-height: 22px;"></small>
            </div>
            <div class="items items-agree">
                <label>
                    <input class="checkbox" id="" name="agree" onchange="checkAgree()" type="checkbox">
                    <a id="protocol" class="agree" title="同意《“e飞蚁”开放平台在线服务协议》">同意《“e飞蚁”开放平台在线服务协议》</a>
                </label>
            </div>
            <div class="items">
                <a class="btn-reg" href="javascript:void (0);"  onclick="checkRegister()" id="register">注   册</a>
            </div>
            <div class="items items-go">
                <span class="go-reg">已经有账号？<a href="<c:url value="/login.do"/>" title="去登陆">去登陆</a></span>
            </div>
        </form>
    </div>
</div>
<!--//End--login-->
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
<!--//End--footernew-->


<div class="thickframe" style="display:none;">
    <div class="thickdiv"></div>
    <div class="thickbox">
        <div class="thicktitle">
            <span>e飞蚁电子商务平台用户注册协议</span><a href="#" id="closeBox" class="icon thickclose">×</a>
        </div>
        <div class="thickcon">
            <div id="protocol-con">
                <h3>特别提示：</h3>
                <p>永新华韵文化发展有限公司（以下简称“永新华韵”）在此特别提醒您，在您（“用户”）注册成为本网站用户前，请您认真阅读本《e飞蚁电子商务平台用户注册协议》（以下简称“协议”），确保您充分理解本协议的所有条款。请您审慎阅读选择接受或不接受本协议。除非您接受本协议的全部条款，否则您无权注册、登录或使用本《用户注册协议》所涉的各类服务。您的注册、登录、使用等行为将视为对本协议的接受，并同意接受本协议各条款的约束。</p>
                <h3>第一条 本站服务条款的确认和接纳</h3>
                <p>1.1本站的各项电子服务的所有权和运作权归永新华韵所有。您同意所有注册协议条款并完成注册程序，才能成为本站的正式用户。用户确认：本协议条款是处理双方之间权利义务的法律文件，自生效起即始终具有法律效力。</p>
                <p>1.2 用户必须是年龄在18周岁以上的具有完全民事行为能力的自然人或依法设立的企业、事业单位、社会团体，如果用户为年龄18周岁以下的自然人，应在父母或监护人的监护参与下才能使用本站。</p>
                <p>1.3  永新华韵保留在法律允许的范围内独自决定拒绝服务、关闭用户账户、清除或编辑内容或取消订单的权利。</p>
                <h3>第2条 本站服务</h3>
                <p>您使用本站提供的服务，必须自行准备如下设备和承担如下开支：（1）上网设备，包括并不限于电脑或者其他上网终端、调制解调器及其他必备的上网装置；（2）上网开支，包括并不限于网络接入费、上网设备租用费、手机流量费等。</p>
                <h3>第3条 用户信息</h3>
                <p>3.1用户应自行向本站提供真实的注册资料，并保证提供的注册资料真实、准确、完整、合法有效，如用户的注册资料发生变动，应及时对注册资料进行更新。如果用户提供的注册资料存在不合法、不真实、不准确、不详尽的情形，应承担由此引起的一切法律后果。</p>
                <p>3.2永新华韵对用户的真实姓名/名称、通信地址、联系电话、电子邮箱等信息负有保密义务，除非得到用户的事先授权，或者国家法律另有规定，永新华韵不得向外界披露用户的任何隐私信息。</p>
                <p>3.3 用户注册成功后，将产生用户名和密码等账户信息，用户应合理、妥善的保存、使用自己的用户名和密码。若用户发现存在任何非法使用用户账号或存在安全漏洞的情况，应立即通知本站并向公安机关报案。</p>
                <p>3.4用户同意，永新华韵拥有通过邮件、短信电话等形式，向在本站注册、购物用户、收货人发送订单信息、促销活动等告知信息的权利。</p>
                <p>3.5用户应妥善保管在本站注册获得的账户，如用户将账户借给他人使用，应自行承担由此产生的全部责任，并与实际使用人承担连带责任。</p>
                <p>3.6用户同意，永新华韵有权使用用户的注册信息、用户名、密码等信息，登陆进入用户的注册账户，进行证据保全，包括但不限于公证、见证等。</p>
                <h3>第4条 用户义务</h3>
                <p>本协议依据国家相关法律法规规章制定，用户同意严格遵守以下义务：</p>
                <p>（1）不得传输或发表：煽动抗拒、破坏宪法和法律、行政法规实施的言论，煽动颠覆国家政权，推翻社会主义制度的言论，煽动分裂国家、破坏国家统一的言论，煽动民族仇恨、民族歧视、破坏民族团结的言论；</p>
                <p>（2）从中国大陆向境外传输资料信息时必须符合中国有关法规；</p>
                <p>（3）不得利用本站从事洗钱、窃取商业秘密、窃取个人信息等违法犯罪活动；</p>
                <p>（4）不得干扰本站的正常运转，不得侵入本站及国家计算机信息系统；</p>
                <p>（5）不得传输或发表任何违法犯罪的、骚扰性的、中伤他人的、辱骂性的、恐吓性的、伤害性的、庸俗的，淫秽的、不文明的等信息资料；</p>
                <p>（6）不得传输或发表损害国家社会公共利益和涉及国家安全的信息资料或言论；</p>
                <p>（7）不得教唆他人从事本条所禁止的行为；</p>
                <p>（8）不得利用在本站注册的账户进行牟利性经营活动；</p>
                <p>（9）不得发布任何侵犯他人著作权、商标权等知识产权或合法权利的内容；</p>
                <p>用户应不时关注并遵守本站不时公布或修改的各类合法规则规定。</p>
                <p style="font-weight:bold">对于用户在本站内发布的各类不符合国家法律、法规、规章制度和政策的信息，永新华韵有权自行删除而无须通知用户的权利。若用户未遵守本条各款规定的，永新华韵有权暂停或关闭用户帐号。</p>
                <p>用户应不时关注并遵守本站不时公布或修改的各类合法规则规定，并对自己在网上的言论和行为承担法律责任。</p>
                <h3>第5条 商品信息</h3>
                <p>本站上陈列、展示的商品价格、数量、材质以及是否有货等商品信息随时都可以发生变动，请用户密切关注并及时根据变动后的商品信息做出是否购买的决定，本站对商品信息的变动不作特别的通知。由于互联网技术以及其它一些众所周知的原因，本站网页上陈列、展示的商品信息不可避免的会存在一定的滞后性或差错，对此请用户予以理解，本站会采取合理措施确保商品信息的真实性、准确性和及时性。</p>
                <p>为表述便利，商品和服务简称为“商品”或“货物”。</p>
                <h3>第6条 订单</h3>
                <p>6.1用户下订单时，应仔细确认所购商品的名称、价格、数量、型号、规格、尺寸、联系地址、电话、收货人等信息。如收货人与用户本人不一致的，收货人的行为和意思表示视为用户的行为和意思表示，用户应对收货人的行为及意思表示的法律后果承担连带责任。</p>
                <p>6.2由于市场变化等原因，本站无法保证用户提交的订单信息中希望购买的商品都会有货；如用户拟购买的商品发生缺货，用户应予以理解，并可选择取消订单。</p>
                <h3>第7条 配送</h3>
                <p>7.1销售方将会把商品（货物）送到您所指定的收货地址，所有在本站上列出的送货时间为参考时间，参考时间的计算是根据库存状况、正常的处理过程和送货时间、送货地点的基础上估计得出的。</p>
                <p>7.2因如下情况造成订单延迟或无法配送等，销售方不承担延迟配送的责任：</p>
                <p>（1）用户提供的信息错误、地址不详细等原因导致的；</p>
                <p>（2）货物送达后无人签收，导致无法配送或延迟配送的；</p>
                <p>（3）不可抗力因素导致的，例如：自然灾害、交通戒严、突发战争等。</p>
                <p>第8条 所有权及知识产权条款</p>
                <p>本站定义的网络服务内容包括：文字、软件、声音、图片、录像、图表、广告中的全部内容；电子邮件的全部内容；本站为用户提供的其他信息。所有这些内容受版权、商标、标签和其它财产所有权法律的保护。所以，用户只能在本站授权下才能使用这些内容，而不能擅自复制、再造这些内容、或创造与内容有关的派生产品。本站所有的文章版权归原文作者和本站共同所有，任何人需要转载本站的文章，必须征得原文作者或本站授权。</p>
                <p>第9条 责任限制及不承诺担保</p>
                <p>9.1如因不可抗力或其它本站无法控制的原因使本站销售系统崩溃或无法正常使用导致网上交易无法完成或丢失有关的信息、记录等，永新华韵会合理地尽力协助处理善后事宜。</p>
                <p>9.2用户个人对网络服务的使用承担风险。本站对此不作任何类型的担保，不论担保形式是明确的或隐含的。本站不担保服务一定能满足用户的要求，也不担保服务不会受中断，对服务的及时性，安全性，出错发生都不作担保。本站对在本站上得到的任何商品购物服务或交易进程，不作担保。</p>
                <h3>第10条 协议更新及用户关注义务</h3>
                <p>根据国家法律法规变化及网站运营需要，永新华韵有权对本协议条款不时地进行修改，修改后的协议一旦被张贴在本站上即生效，并代替原来的协议。用户可随时登陆查阅最新协议；<strong>用户有义务不时关注并阅读最新版的协议及网站公告。如用户不同意更新后的协议，应立即停止接受e飞蚁平台网站依据本协议提供的服务；如用户继续使用本网站提供的服务的，即视为同意更新后的协议。永新华韵建议用户在使用本站之前阅读本协议及本站的公告。</strong>如果本协议中任何一条被视为废止、无效或因任何理由不可执行，并不影响任何其余条款的有效性和可执行性。 </p>
                <h3>第11条 法律管辖和适用</h3>
                <p>本协议的签订、履行、解释及争议解决，均适用中华人民共和国大陆地区的法律。在本协议履行的过程中如发生争议，用户可与永新华韵协商解决，如协商解决不成的，任何一方可将争议提交永新华韵住所地有管辖权的人民法院诉讼解决。</p>
                <h3>第12条 其他</h3>
                <p>12.1 “e飞蚁平台”网站所有者是指在政府部门依法许可或备案的<span style="text-decoration: underline;"> www.efeiyi.com </span>网站经营主体。</p>
                <p><strong>12.2 用户知晓，如其向自然人商户采购本站陈述或展示的商品，有无法取得合法、正规发票的风险，用户承诺除可直接归责于甲方的原因外，因通过本站交易而引起的发票问题均由其自行解决，与永新华韵无关，用户不得因发票事宜而针对永新华韵提出任何法律要求或主张，亦不得采取法律诉讼、仲裁等行为。</strong></p>
                <p>12.3本协议内容中以黑体、加粗、下划线、斜体等方式显著标识的条款，请用户着重阅读。</p>
                <p>12.3 您点击本协议下方的“同意并继续”按钮即视为您完全接受本协议，在点击之前请您再次确认已知悉并完全理解本协议的全部内容。</p>
                <p></p>
            </div>
            <div class="btnt"><input type="button" class="btn-img" value="同意并继续"></div>
        </div>
    </div>
</div>




<%--<div class="am-g am-g-fixed" style="max-width: 636px;">--%>
    <%--<div class="am-u-md-12" style="box-shadow: 0px 0px 2px #626262;">--%>
        <%--<div class="am-u-md-12" style="text-align: center ;"><h2 style=" margin-top: 1.6rem;">e飞蚁 商家注册</h2></div>--%>
        <%--<form class="am-form am-form-horizontal" action="<c:url value="/sign/Register.do"/>" method="post" id="form" >--%>
            <%--<div class="am-form-group">--%>
                <%--<div class="am-u-sm-10" style="margin-left: 87px;">--%>
                    <%--<span style="padding: 10px;">--%>
                      <%--<input type="radio" name="tenantType" value="13" checked="checked" />--%>
                        <%--企业--%>
                    <%--</span>--%>
                    <%--<span style="padding: 10px;">--%>
                      <%--<input type="radio" name="tenantType" value="12" />--%>
                        <%--个体--%>
                    <%--</span>--%>
                    <%--<span style="padding: 10px;">--%>
                      <%--<input type="radio" name="tenantType" value="11" />--%>
                        <%--个人--%>
                    <%--</span>--%>
                <%--</div>--%>
            <%--</div>--%>

            <%--<div class="am-form-group">--%>
                <%--<label for="username" class="am-u-sm-2 am-form-label">用户名</label>--%>

                <%--<div class="am-u-sm-10">--%>
                    <%--<input type="text" name="username" id="username" onblur="checkUserName()" placeholder="输入用户名">--%>
                    <%--<small name="message" style="color: red"></small>--%>
                <%--</div>--%>
            <%--</div>--%>

            <%--<div class="am-form-group">--%>
                <%--<label for="password" class="am-u-sm-2 am-form-label">密码</label>--%>

                <%--<div class="am-u-sm-10">--%>
                    <%--<input type="password" name="password" id="password" placeholder="输入密码">--%>
                <%--</div>--%>
            <%--</div>--%>

            <%--<div class="am-form-group">--%>
                <%--<label for="RePassword" class="am-u-sm-2 am-form-label">重复密码</label>--%>

                <%--<div class="am-u-sm-10">--%>
                    <%--<input type="password" name="rePassword" onkeydown="checkPassword()" onkeyup="checkPassword()" id="RePassword" placeholder="输入密码">--%>
                    <%--<small name="message" style="color: red"></small>--%>
                <%--</div>--%>
            <%--</div>--%>

            <%--<div class="am-form-group">--%>
                <%--<div class="am-u-sm-10" style="margin-left: 16%;">--%>
                    <%--<small>--%>
                      <%--<input type="checkbox" name="agree" onchange="checkAgree()" />--%>
                      <%--<a href="#">同意《“e飞蚁”开发平台在线服务协议》</a>--%>
                    <%--</small>--%>
                <%--</div>--%>
            <%--</div>--%>


            <%--<div class="am-form-group">--%>
                <%--<div class="am-u-sm-10 am-u-sm-offset-2">--%>
                    <%--<span>--%>
                        <%--<button type="button" id="register" onclick="checkRegister()"  class="am-btn am-btn-default" disabled="disabled">完成注册,马上登录</button>--%>
                    <%--</span>--%>
                    <%--<small>--%>
                        <%--已有账号?去<a href="<c:url value="/login.do"/>">登录</a>--%>
                    <%--</small>--%>
                    <%--&lt;%&ndash;<span>&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<button type="submit" class="am-btn am-btn-default">登录</button>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;</span>&ndash;%&gt;--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</form>--%>
    <%--</div>--%>
 <%--</div>--%>
<script type="text/javascript">

    $(function(){
        $('.btn-top-wechat').hover(function(){
            $(this).find('.top-wechat').stop(true).slideDown('fast');
        },function(){
            $(this).find('.top-wechat').stop(true).slideUp('fast');
        });
        //注册--用户协议
        $('#protocol').click(function(){
            $('.thickframe').show();
            return false;
        })
        $('#closeBox').click(function(){
            $('.thickframe').hide();
            $("input[type='checkbox']").attr("checked",false);
            return false;
        })
        $('.btnt .btn-img').click(function(){
            $('.thickframe').hide();
            $("input[type='checkbox']").attr("checked",true);
            return false;
        })
    });
    /**验证用户唯一*/
    function checkUserName(){
        var  username = $("#username").val();
        if(username==""){
            $("#username").next("small").text("用户名不能为空!");
        }else{
            $.ajax({
                type:"post",
                url: '<c:url value="/sign/checkUsername.do"/>',
                cache: false,
                data:{username:username},
                dataType: "json",
                success:function(data){
                    if(data){
                        $("#username").next("small").text("用户名已存在!");
                    }else{
                        $("#username").next("small").text("");
                    }
                }
            });
        }

    }

    //检验两次密码是否一致
    function checkPassword(){
        if($("#password").val()!=$("#RePassword").val()){
            $("#RePassword").next("small").text("两次密码不一致!");
        }else{
            $("#RePassword").next("small").text("");
        }
    }


    //注册验证
    function checkRegister(){
        var  flag = true;
        $("small[name='message']").each(function(){
             if($(this).text()!=""){
                 alert
                 flag = false;
                 return false;
             }
        });
        if($("#username").val()==""){
            $("#username").next("small").text("用户名不能为空!");
        }
        if($("#password").val()==""){
            $("#RePassword").next("small").text("密码不能为空!");
        }else {
            if ($("#RePassword").val() == "") {
                $("#RePassword").next("small").text("重复密码不能为空!");
            }
        }
        if(!$("input[type='radio']").is(":checked")){
            flag = false;
            alert("请选择类型!");
        }else  if(!$("input[type='checkbox']").is(":checked")){
            flag = false;
            alert("请同意协议后注册!");
        }else{
            if (flag) {
                $("#form").submit();
            } else {
                alert("所填信息有误,无法注册!");
            }
        }
    }

    //同意条约
    function checkAgree(){
        if($("input[type='checkbox']").is(":checked")){
            $("#register").removeAttr("disabled");
        }else{
            $("#register").attr("disabled","disabled");
        }
    }

</script>
</body>
</html>
