<!DocType html>
<%@ page import="com.efeiyi.ec.personal.AuthorizationUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
</head>
<body>

<style>
    .wh {width:100%;min-width:1200px;float:left;position: relative;overflow: hidden;}
    .master-pro img {position: absolute;top:0;left:50%;margin-left: -960px;z-index: 1;}
    .master-pro .linkb {width:1200px;position: absolute;top:0;left:50%;margin-left: -600px;z-index: 2;}
    .master-pro .linkb .link1{width: 314px;height: 70px;position: absolute;top: 419px;left: 180px;}
    .master-pro .linkb .link2{    width: 158px;
        height: 158px;
        position: absolute;
        top: 327px;
        left: 522px;}
</style>
<!-- 新头部 -->
<div class="top2016">
    <div class="hd" style="width:1200px;">
        <div class="tips fl"><a class="logo"></a></div>
        <ul class="fr">
            <li><a href="http://www.efeiyi.com" title="e飞蚁首页">e飞蚁首页</a></li>
            <li><a href="http://mall.efeiyi.com" title="非遗电商">非遗电商</a></li>
            <li><a href="http://master.efeiyi.com" title="非遗大师">非遗大师</a></li>
            <li><a href="http://minglu.efeiyi.com" title="非遗百科">非遗百科</a></li>
            <li><a href="http://gift.efeiyi.com" title="非遗礼品">非遗礼品</a></li>
            <li><a href="http://www.315cheng.com" title="诚品宝">诚品宝</a></li>
            <%
                if (AuthorizationUtil.getMyUser().getId() != null) {
            %>
            <li><a href="http://i.efeiyi.com" title="个人中心">个人中心</a></li>
            <li><a href="<c:url value='/j_spring_cas_security_logout'/>" title="退出">退出</a></li>
            <%
                }
            %>

            <%
                if (AuthorizationUtil.getMyUser().getId() == null) {
            %>
            <li><a href="<c:url value="/sign/sso.do"/>" title="请登录">请登录</a></li>
            <li><a href="http://passport.efeiyi.com/register?service=http://j.efeiyi.com/ef-gift/sso.do?registeSuccess=/pc/saveEnrollUser.do" title="快速注册">快速注册</a></li>
            <%
                }
            %>
            <li><a href="http://mall.efeiyi.com/document/helpCenter?group=ec.rzlc" title="e飞蚁入驻">商家入驻</a></li>
        </ul>
    </div>
</div>
<div class="topv2" style="padding-top: 0;height:86px;">
    <div class="hd" style="width:1200px;">
        <div class="tips fl"><a class="logo" href=""><img src="<c:url value="/scripts/images/ef-logo-gf.png" />" alt=""></a></div>
        <div class="fr">
            <form action="http://www.efeiyi.com/search.do" method="get">
                <input type="text" value="" name="q" id="q" placeholder="搜索" class="txt">
                <input type="submit" value="" class="icon-new btn">
                <input type="hidden" id="resultPage" name="resultPage" value="/searchResult">
                <input type="hidden" id="facetFields" name="facetFields" value="project_name">
                <input type="hidden" id="group" name="group" value="efeiyi">
                <input type="hidden" id="priceUD" name="priceUD" value="0">
            </form>
        </div>
    </div>
</div>
<div class="nav2016 bgc">
    <div class="hd bgf" style="width:1200px;">
        <div class="navitems">
            <ul>
                <li><a href="<c:url value='/index'/>" title="">首页</a></li>
                <li><a href="<c:url value='/allMaster'/>" target="_blank" title="">全部大师</a></li>
                <li><a href="<c:url value='/subject'/>" target="_blank" title="">大师入驻</a></li>
            </ul>
        </div>
        <!--//End--导航-->
    </div>
</div>


<div class="master-pro wh">
    <div class="wh" style="height:667px;">
        <div class="linkb"><a class="link1" href="http://j.efeiyi.com/ef-person/" target="_blank" title="马上入住"></a></div>
        <img src="http://pro.efeiyi.com/subject/m-banner.jpg" alt="">
    </div>
    <div class="wh" style="height:620px;">
        <div class="linkb" style="top:320px;">
            <div class="wh text" style="text-align: center;line-height:34px;">
                <p style="font-size: 19px;">手工艺从业者与非遗大师的社交平台，融入资讯、社交、电商等多元化因素，</p>
                <p style="font-size: 19px;">为手工艺人、非遗大师提供生态晋升体系，</p>
                <p style="font-size: 19px;">为手工爱好者、收藏者提供了直观学习、欣赏、购买原创手工作品的平台。</p>
            </div>
        </div>
        <img src="http://pro.efeiyi.com/subject/m-img1.jpg" alt="">
    </div>
    <div class="wh" style="height:666px;"><img src="http://pro.efeiyi.com/subject/m-img2.jpg" alt=""></div>
    <div class="wh" style="height:1388px;">
        <div class="linkb" style="top:1325px">
            <div class="wh text">
                <p style="font-size:14px;color:#3e3a39;margin-left:20px;">非遗大师个人主页(首页包含大师姓名、形象照、简介、推荐作品展示等)。</p>
            </div>
        </div>
        <img src="http://pro.efeiyi.com/subject/m-img3.jpg" alt="">
    </div>
    <div class="wh" style="height:766px;">
        <div class="linkb" style="top:581px">
            <div class="wh text">
                <p style="font-size:14px;color:#3e3a39;margin-left:20px;width:590px;">简介：全面的展示非遗传承人、大师的个人信息，关联您的出版著作、荣誉证书、艺术年表，<em style="width:42px;height:20px;display: inline-block;">&nbsp;</em>让潜在藏家更加了解您。</p>
                <p style="font-size:14px;color:#3e3a39;margin-left:20px;width:528px;float: right;margin-top:51px;">作品：上传您的作品，为您和藏家提供一个随时欣赏您作品的空间。</p>
            </div>
        </div>
        <img src="http://pro.efeiyi.com/subject/m-img4.jpg" alt="">
    </div>
    <div class="wh" style="height:927px;">
        <div class="linkb" style="top:687px">
            <div class="wh text">
                <p style="font-size:14px;color:#3e3a39;margin-left:20px;width:500px;">资讯：您的个人观点，他人对您的作品、个人等方面的评论，参加的展览活动及
                    <em style="width:42px;height:20px;display: inline-block;">&nbsp;</em>各媒体对您的报道。</p>
                <p style="font-size:14px;color:#3e3a39;margin-left:20px;width:528px;position: absolute;top:0;right:83px">工作坊：工作室的视频或图文介绍，外景、内景的全面展示。</p>
            </div>
        </div>
        <img src="http://pro.efeiyi.com/subject/m-img5.jpg" alt="">
    </div>
    <div class="wh" style="height:663px;">
        <div class="linkb" style="position: absolute;color: #fff;z-index:-1;">
            <span><p>【注册】</p><p>点击我要入驻</p>同意入驻协议<p></p></span>
            <span><p>【填写/提交信息及资料】</p><p>个人信息，提交资质</p><p>主页设置</p></span>
            <span><p>【等待e飞蚁审核】</p><p>e飞蚁2个工作日内反馈审核结果</p></span>
            <span><p>【个人主页开通】</p><p>主页开通</p><p>大师登陆后台</p></span>
        </div>
        <img src="http://pro.efeiyi.com/subject/m-img6.jpg" alt="">
    </div>
    <div class="wh" style="height:680px;">
        <div class="linkb"><a class="link2" href="http://j.efeiyi.com/ef-person/" target="_blank" title="马上入住"></a></div>
        <img src="http://pro.efeiyi.com/subject/m-img7.jpg" alt="">
    </div>
</div>
<%--<div class="page-border-solid"></div>--%>
<%--</div>--%>
<div class="footernew wh">
    <div class="servicenew wh">
        <div class="hd tct">
            <div class=" foremax">
                <dl class="fore">
                    <dt>帮助中心</dt>
                    <dd><a href="http://www.efeiyi.com/document/helpCenter?group=ec.gwlc" target="_blank">购物流程</a></dd>
                    <dd><a href="http://www.efeiyi.com/document/helpCenter?group=ec.zffs" target="_blank">支付方式</a></dd>
                    <dd><a href="http://www.efeiyi.com/document/helpCenter?group=ec.psfs" target="_blank">配送方式</a></dd>
                </dl>
                <dl class="fore">
                    <dt>商家服务</dt>
                    <dd><a href="http://www.efeiyi.com/document/helpCenter?group=ec.rzxz" target="_blank">入驻须知</a></dd>
                    <dd><a href="http://www.efeiyi.com/document/helpCenter?group=ec.rzlc" target="_blank">入驻流程</a></dd>
                    <dd><a href="http://www.efeiyi.com/document/helpCenter?group=ec.rzzx" target="_blank">入驻咨询</a></dd>
                </dl>
                <dl class="fore">
                    <dt>售后流程</dt>
                    <dd><a href="http://www.efeiyi.com/document/helpCenter?group=ec.thlc" target="_blank">退货流程</a></dd>
                    <dd><a href="http://www.efeiyi.com/document/helpCenter?group=ec.hhlc" target="_blank">换货流程</a></dd>
                </dl>
                <dl class="fore">
                    <dt>服务保障</dt>
                    <dd><a href="http://www.efeiyi.com/document/helpCenter?group=ec.zpbz" target="_blank">正品保障</a></dd>
                    <dd><a href="http://www.efeiyi.com/document/helpCenter?group=ec.shzc" target="_blank">售后政策</a></dd>
                </dl>
                <dl class="fore">
                    <dt>法律声明</dt>
                    <dd><a href="http://www.efeiyi.com/document/helpCenter?group=ec.flsm" target="_blank">法律声明</a></dd>
                    <dd><a href="http://www.efeiyi.com/document/helpCenter?group=ec.aqjyssm" target="_blank">安全及隐私声明</a></dd>
                </dl>
                <div class="wechatnew" title="手机e飞蚁">
                    <i class="inro-icon0"></i>
                    <i class="inro-icon"></i>
                </div>
            </div>
        </div>
    </div>
    <div class="max-links wh">
        <div class="links wh">
            <a href="http://mall.efeiyi.com/document/aboutUs?group=ec.gywm" target="_blank" title="关于我们"><i class="icon"></i>关于我们</a>
            <a href="http://mall.efeiyi.com/document/aboutUs?group=ec.ptys" target="_blank" title="平台优势"><i class="icon"></i>平台优势</a>
            <a href="http://mall.efeiyi.com/document/aboutUs?group=ec.cpyc" target="_blank" title="诚聘英才"><i class="icon"></i>诚聘英才</a>
            <a href="http://mall.efeiyi.com/document/aboutUs?group=ec.lxwm" target="_blank" title="联系我们"><i class="icon"></i>联系我们</a>
            <a href="http://mall.efeiyi.com/document/aboutUs?group=ec.yjfk" target="_blank" title="意见反馈"><i class="icon"></i>意见反馈</a>
            <a href="http://mall.efeiyi.com/document/aboutUs?group=ec.fyjj" target="_blank" title="非遗简介"><i class="icon"></i>非遗简介</a>
        </div>
        <div class="copyright wh">
            <div class="frlinksimg">
                <div class="simgbox">
                    <strong>战略合作伙伴</strong>
                    <a class="icon1" href="http://en.unesco.org/" title="联合国教科文组织" target="_blank"></a><em class="line"></em><a class="icon3" title="中国非物质文化遗产保护协会"></a><em class="line"></em><a class="icon2" title="中国非物质文化遗产保护协会"></a>
                </div>
            </div>
        </div>
        <div class="wh authentication">
            <div class="info">Copyright © 2012-2022 永新华韵文化发展有限公司版权所有-京ICP备15032511号-1</div>
            <a href="http://www.miitbeian.gov.cn" target="_blank" title=""> <img class="imgfilter" src="<c:url value="/scripts/assets/images/authentication-0.png"/>" alt=""></a>
            <a href="http://www.miitbeian.gov.cn" target="_blank" title="网站域名备案"> <img class="imgfilter" src="<c:url value="/scripts/assets/images/authentication-1.png"/>" alt="网站域名备案"></a>
            <a href="http://www.baic.gov.cn/" target="_blank" title="企业信用信息备案"> <img class="imgfilter" src="<c:url value="/scripts/assets/images/authentication-2.png"/>" alt="企业信用信息备案"></a>
            <a href="/scripts/images/license.jpg" target="_blank" title="企业营业执照"> <img class="imgfilter" src="<c:url value="/scripts/assets/images/authentication-3.png"/>" alt="企业营业执照 "></a>
        </div>
    </div>
</div>
<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1255887869'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "w.cnzz.com/q_stat.php%3Fid%3D1255887869' type='text/javascript'%3E%3C/script%3E"));</script>
</body>
</html>
