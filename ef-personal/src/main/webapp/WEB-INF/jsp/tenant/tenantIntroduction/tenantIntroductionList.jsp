<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>

</head>
<body>
<!--内容-->

<!--简介-->
<div id="page-nav">
    <p><a href="#">首页</a><span>简介</span></p>
</div>
<div class="border-nav"></div>
<!--简介内容-->
<div id="page-column">
    <div class="column-left " style=" position:relative">
        <div class="page-img"><img src="<c:url value="/scripts/assets/images/img5.jpg"/>"></div>
        <div class="buttom-text floating_cl">
            <p><a href="#ji-ben-xin-xi">基本信息</a></p>
            <p><a href="#da-shi-rong-yu">大师荣誉</a></p>
            <p><a href="#chu-ban-zhu-zuo">出版著作</a></p>
            <p><a href="#yi-shu-nian-biao">艺术年表</a></p>
        </div>
    </div>
    <div class="column-right">
        <div id="ji-ben-xin-xi">
            <h1>基本信息</h1>
            <table class="table-bg">
                <tbody>
                <tr class="tr1" style="height:3px;">
                    <td height="3" colspan="4" style="height:3px"></td>
                </tr>
                <tr class="tr2">
                    <td colspan="4">
                        <input type="text" class="column-tex1" maxlength="6">
                    </td>
                </tr>
                <tr class="tr3">
                    <td height="47" width="80"  class="td-1 td-s">性别</td>
                    <td height="47" width="173" style="border-right:1px solid #000"><input type="text" class="column-tex1 tr-q" maxlength="6"></td>
                    <td height="47" width="80" class="td-1 td-s">出生年月</td>
                    <td height="47" width="173" style="border-right:1px solid #000"><input type="text" class="column-tex1 tr-q" maxlength="10"></td>
                </tr>
                <tr class="tr4">
                    <td height="47" width="80"  class="td-1 td-s">籍贯</td>
                    <td height="47" width="173" style="border-right:1px solid #000"><input type="text" class="column-tex1 tr-q" maxlength="6"></td>
                    <td height="47" width="80" class="td-1 td-s">现居地</td>
                    <td height="47" width="173" style="border-right:1px solid #000"><input type="text" class="column-tex1 tr-q" maxlength="10"></td>
                </tr>
                <tr class="tr5">
                    <td height="47" width="80"  class="td-1 td-s">代表作品</td>
                    <td height="47" width="173" style="border-right:1px solid #000"><textarea class="td-r" rows="4"></textarea></td>
                    <td height="47" width="80" class="td-1 td-s">级别</td>
                    <td height="47" width="173" style="border-right:1px solid #000"><textarea class="td-r" rows="4" ></textarea></td>
                </tr>
                <tr class="tr6">
                    <td colspan="4"></td>
                </tr>
                </tbody>
            </table>
            <div class="column-text-p">
                张同禄，1942年生人，中国工艺美术大师、北京市特级工艺美术大师，是享受国务院政府津贴的有突出贡献的专家，曾三次荣获“北京市劳动模范”称号,是至今唯一当选											                                       过中国共产党党代会代表的国家级大师，现任中国工艺美术大师联谊会副会长、中国工艺美术金属艺术专业委员会副会长、北京市工艺美术评审委员会委员、北京市工                                       艺美术协会副会长、文化部艺术品评估委员会委员.
            </div>
        </div>
        <div id="da-shi-rong-yu">
            <h1>大师荣誉</h1>
            <div class="img-pictures-show">
                <c:forEach var="is" items="${tenantHonorList}" varStatus="ln">
                    <c:if test="${tenantHonorList.size()  - 1 != ln.index && ln.index%2 ==0}">
                    <div class="one-img-pictures">
                        <dl class="one-img-dl-l">
                            <dt><a href="#"><img src="<c:url value="/scripts/assets/images/img6.jpg"/>"></a></dt>
                            <dd>1988中国工艺美术大师</dd>
                        </dl>
                    </c:if>
                    <c:if test="${ln.index%2 ==1}">
                            <dl class="one-img-dl-r">
                                <dt><a href="#"><img src="<c:url value="/scripts/assets/images/img6.jpg"/>"></a></dt>
                                <dd>1988中国工艺美术大师</dd>
                            </dl>
                        </div>
                    </c:if>
                    <c:if test="${ln.index == tenantHonorList.size() - 1 && ln.index%2 ==0}">
                        <div class="one-img-pictures">
                            <dl class="one-img-dl-l">
                                <dt><a href="#"><img src="<c:url value="/scripts/assets/images/img6.jpg"/>"></a></dt>
                                <dd>1988中国工艺美术大师</dd>
                            </dl>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>
        <div id="chu-ban-zhu-zuo">
            <h1>出版著作</h1>
            <ul>
                <c:forEach items="${tenantWorkList}" var="work">
                    <li><a href="#"><img src="<c:url value="/scripts/assets/images/img7.jpg"/>"></a></li>
                </c:forEach>
            </ul>
        </div>
        <div id="yi-shu-nian-biao">
            <h1>艺术年表</h1>
            <div class="year-container">
                <dt class="text-size-color">2009</dt>
                <dd  class="text-size-color">
                    <p>1月被评为2008年中国收藏界十大人物.</p>
                    <p>3月被誉名“张氏景泰蓝”。</p>
                </dd>
            </div>
            <div class="year-container">
                <dt class="text-size-color text-padding">2008</dt>
                <dd  class="text-size-color">
                    <p class="text-padding">2月12日，北京市工艺美术行业协会组织16名中国工艺美术大师考察团，在大选之前，赴台促进两岸文化交流。张同禄大师应邀赴访问台北故宫及台湾高校讲学，盛况空前。</p>
                    <p class="text-padding">4月14日，张同禄大师创作的十二章纹、白头偕老、太平有象和今生富贵等四件景泰蓝珍品，作为目前内地唯一的当代工艺美术珍品入藏台北故宫，台北故宫林曼丽院长称赞为“设计雅致、制作精良、实当代难得之工艺品”，体现中国景泰蓝艺术的最高水准。</p>
                    <p class="text-padding">2008北京奥运倒计时60天，中国非物质文化遗产日纪念大会上，国务委员陈至立亲切接见张同禄大师，鉴赏大师珍品《吉祥宝灯》，并动手体验景泰蓝点蓝工艺。</p>
                    <p class="text-padding">在景泰蓝不断创新的进程中，张同禄大师研创出银胎景泰蓝《万象更新》，这是有史以来的第一件大型银胎景泰蓝，高达85公分。</p>
                </dd>
            </div>
            <div class="year-container">
                <dt class="text-size-color text-padding">2007</dt>
                <dd  class="text-size-color ">
                    <p class="text-padding">6月 张同禄大师被中华人民共和国文化部命名为“国家级非物质文化遗产项目景泰蓝制作技艺的代表性传承人”。</p>
                    <p class="text-padding">全国人大副委员长李铁映参观大师工作室，为大师的作品题词并合影留念。</p>
                    <p class="text-padding">张同禄大师推出代表力作《景泰蓝圆满系列计时仪》，这是他景泰蓝艺术生涯上唯一创作的象征事业、健康、财富、爱情最大圆满的顶级工艺品。</p>
                    <p class="text-padding">张同禄大师创作的又一力作《八吉祥珐琅聚宝招财葫芦》，结合八吉祥、八仙、八葫芦，完美演绎八仙传奇，掐丝珐琅极为罕见，点蓝部分的八仙人物更是奇珍，并因第41届国际旅游品和工艺品交易会金凤凰创新产品设计大奖。</p>
                </dd>
            </div>
        </div>
    </div>
</div>
<!--其他内容-->
<div id="footer">
    <ul class="guild">
        <li><a href="#"><img src="/scripts/assets/images/i/fybk.jpg"></a></li>
        <li><a href="#"><img src="/scripts/assets/images/i/efeiyi.jpg"></a></li>
        <li><a href="#"><img src="/scripts/assets/images/i/cpb.jpg"></a></li>
        <li><a href="#"><img src="/scripts/assets/images/i/gl.jpg"></a></li>
    </ul>
    <div class="efeiyi-url">Copyright © <a href="#">www.efeiyi.com</a>2015</div>
</div>
<!--分析-->
<div class="floating_ck">
    <dl>
        <dt></dt>
        <dd class="return">
            <span onClick="gotoTop();return false;"></span>
        </dd>
        <dd class="qrcord">
            <span></span>
            <div class="floating_left floating_ewm">
                <i></i>
            </div>
        </dd>
        <dd class="quote">
            <span>分享</span>
            <div class="floating_left"><a href="#">分享</a></div>
        </dd>
    </dl>
</div>
<%--<!--[if (gte IE 9)|!(IE)]><!-->
<script src="/scripts/assets/js/jquery.min.js"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script src="/scripts/assets/js/amazeui.min.js"></script>--%>
</body>
</html>