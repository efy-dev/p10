<%@ page import="com.efeiyi.ec.website.base.util.AuthorizationUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/5/13
  Time: 9:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>首页</title>
  <link type="text/css" rel="stylesheet" href="<c:url value="/resources/assets/css/amazeui.min.css?v=20160411"/>">
  <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/css/home.css?v=20160411"/>">
</head>
<body>
<div class="home wh">
  <div class="hd">
    <div class="nav-fixed">
      <a class="logo" href=""><img src="<c:url value="/scripts/images/home-logo.png"/>" alt=""></a>
      <ul class="items">
        <li><a href="http://master.efeiyi.com" title=""><i class="icon icon1"></i>非遗大师</a></li>
        <li><a href="http://j.efeiyi.com/ef-wiki/" title=""><i class="icon icon2"></i>非遗百科</a></li>
        <li><a href="http://j.efeiyi.com/ef-gift/" title=""><i class="icon icon3"></i>非遗礼品</a></li>
        <li><a href="http://www.315cheng.com" title=""><i class="icon icon4"></i>诚品宝</a></li>
        <li><a href="http://mall.efeiyi.com" title=""><i class="icon icon5"></i>非遗电商</a></li>
        <li><a href="" title=""><i class="icon icon6"></i>产权交易</a></li>
        <li><a href="" title=""><i class="icon icon7"></i>融艺投</a></li>
      </ul>
    </div>
    <!--//End-左侧悬浮导航-->
    <div class="main">
      <div class="form">
        <form action="http://mall.efeiyi.com/search.do" method="get">
          <input type="text" class="txt" value="<c:if test="${searchParamBean.q != '*'}">${searchParamBean.q}</c:if>" name="q"
                 id="q">
          <input type="submit" class="icon-new btn" value=" ">
          <input type="hidden" id="resultPage" name="resultPage" value="/searchResult"/>
          <input type="hidden" id="facetFields" name="facetFields" value="project_name"/>
          <input type="hidden" id="group" name="group" value="efeiyi"/>
          <input type="hidden" id="priceUD" name="priceUD" value="0"/>
        </form>

        <div class="links">
          <%
            if (AuthorizationUtil.isAuthenticated()) {
          %>
          <a href="http://i.efeiyi.com" title="个人中心"><%=AuthorizationUtil.getCurrentSampleUsername()%>
          </a>
          <a href="<c:url value='/j_spring_cas_security_logout'/>" title="退出">退出</a>
          <%
          } else {
          %>

            <a class="pink" href="<c:url value="/sso.do"/>" title="e飞蚁登录">登录</a>
            <a href="http://passport.efeiyi.com/register?service=http://mall.efeiyi.com/sso.do?registeSuccess=/registerSuccess.do"
            title="e飞蚁注册">快速注册</a>
          <%
            }
          %>
          <a href="" title="">手机e飞蚁</a>
        </div>
      </div>
      <!--//End--搜索部分-->
      <div class="clinks">
        <a class="item" href="" title="">大师官网入驻</a>
        <a class="item second" href="http://mall.efeiyi.com/document/helpCenter?group=ec.rzlc" title="">商户免费入驻</a>
        <a class="item" href="" title="">企业礼品解决方案</a>
        <a class="close" href="" title="关闭"></a>
      </div>
      <!--//End--广告条-->
      <div class="main-left">
        <div class="fwm">
          <div class="m-box">
            <div class="m-animate">
              <ul >
                <li>
                  <a href="http://yaohuifen.efeiyi.com">
                    <img src="<c:url value="/scripts/upload/姚慧芬.jpg"/>" alt="" >
                  </a>
                </li>
                <li>
                  <a href="zhubingren.efeiyi.com">
                    <img
                            src="<c:url value="/scripts/upload/朱炳仁.jpg"/>"
                            alt=""
                            >
                  </a>
                </li>
                <li>
                  <a href="weilizhong.efeiyi.com">
                    <img
                            src="<c:url value="/scripts/upload/魏立中.jpg"/>"
                            alt=""
                            >
                  </a>
                </li>
                <li>
                  <a href="http://j.efeiyi.com/ef-wiki/project/inlcj19o29sjxcah">
                    <img
                            src="<c:url value="/scripts/upload/苏绣.jpg"/>"
                            alt=""
                            >
                  </a>
                </li>
                <li>
                  <a href="http://mall.efeiyi.com/product/productModel/ihy6pqjo1dizwlaa">
                    <img
                            src="<c:url value="/scripts/upload/筷子.JPG"/>"
                            alt=""
                            >
                  </a>
                </li>
                <li>
                  <a href="http://j.efeiyi.com/ef-wiki">
                    <img
                            src="<c:url value="/scripts/upload/铜雕.jpg"/>"
                            alt=""
                            >
                  </a>
                </li>
                <li>
                  <a href="http://mall.efeiyi.com/product/productModel/if3l43hd1h2oyvov">
                    <img
                            src="<c:url value="/scripts/upload/关山香炉.JPG"/>"
                            alt=""
                            >
                  </a>
                </li>
              </ul>
            </div>
          </div>
        </div>
        <div class="fwm">
          <div class="news">
            <div class="newest">
              <div class="consult">
                <h5>新品上架</h5>
                <ul>
                  <li><a href="http://mall.efeiyi.com/product/productModel/ijw78fl93dqtd4xj">猫蝶图天然水晶内画壶:大师之作 传世之物 罕见珍品</a></li>
                  <li><a href="http://mall.efeiyi.com/product/productModel/ijy2r09wbpav1jly">九龙呈瑞盘:高档摆件 金龙祥瑞 极佳寓意 乔迁好礼</a></li>
                  <li><a href="http://mall.efeiyi.com/product/productModel/il7ubj9p34n0qowg">高官厚禄得意长:闻名于世的真正的芦苇画，世界稀有孤品。最具收藏价值！</a></li>
                  <li><a href="http://mall.efeiyi.com/product/productModel/igdcsu0v3sa6nhb5">崖柏盘香:纯天然室内熏香养生安神助眠老料香薰</a></li>
                  <li><a href="http://mall.efeiyi.com/product/productModel/ik4swda61xofep2u">庆赏昇平公交卡:庆赏昇平创意衍伸品 京剧人物图案 国家图书馆出品</a></li>
                </ul>
              </div>
            </div>
            <div class="west-pic">
              <div class="w-pic">
                <a href=""><img src="<c:url value="/scripts/upload/zhutu320151123180151.jpg"/>" alt=""><span>吉祥佛黑檀</span></a>
              </div>
            </div>
          </div>
        </div>
        <div class="items master">
          <div class="title"><strong>大师推荐</strong></div>
          <ul>
            <li>
              <a href="http://zhubingren.efeiyi.com/" title="">
                <p class="img"><img class="imgbg" src="<c:url value="/scripts/upload/home-pic-1-1.jpg"/>" alt=""></p>
                <p class="info">
                  <span class="name">朱炳仁</span>
                </p>
              </a>
            </li>
            <li>
              <a href="http://yaohuifen.efeiyi.com/" title="">
                <p class="img"><img class="imgbg" src="<c:url value="/scripts/upload/home-pic-1-2.jpg"/>" alt=""></p>
                <p class="info">
                  <span class="name">姚慧芬</span>
                </p>
              </a>
            </li>
            <li>
              <a href="http://weilizhong.efeiyi.com/" title="">
                <p class="img"><img class="imgbg" src="<c:url value="/scripts/upload/home-pic-1-3.jpg"/>" alt=""></p>
                <p class="info">
                  <span class="name">魏立中</span>
                </p>
              </a>
            </li>
          </ul>
        </div>
        <!--//End--大师推荐-->
        <div class="items wiki">
          <div class="title"><strong>非遗百科</strong></div>
          <ul>
            <li>
              <a href="http://j.efeiyi.com/ef-wiki/project/inlcj19o29sjxcah" title="">
                <p class="img"><img class="imgbg" src="<c:url value="/scripts/upload/home-pic-2-1.jpg"/>" alt=""></p>
                <p class="info">
                  <span class="name">苏绣</span>
                  <span class="works">苏绣有着数千年悠久历史,苏绣艺术开始走向成熟...</span>
                </p>
              </a>
            </li>
            <li>
              <a href="http://j.efeiyi.com/ef-wiki/project/inl4on7x7tuttm3x" title="">
                <p class="img"><img class="imgbg" src="<c:url value="/scripts/upload/三花马-蓝色20151026115356.jpg"/>" alt=""></p>
                <p class="info">
                  <span class="name">唐三彩</span>
                  <span class="works">唐三彩是汉族古代陶瓷烧制工艺的珍品，全名唐代三彩釉陶器，属于一种盛行于唐代的低温铅釉的彩釉陶器。</span>
                </p>
              </a>
            </li>
            <li>
              <a href="http://j.efeiyi.com/ef-wiki/project/inl4q8a9320k7jmk" title="">
                <p class="img"><img class="imgbg" src="<c:url value="/scripts/upload/home-pic-2-3.jpg"/>" alt=""></p>
                <p class="info">
                  <span class="name">紫砂</span>
                  <span class="works">紫砂是一种炻器，是一种介于陶器与瓷器之间的陶瓷制品...</span>
                </p>
              </a>
            </li>
          </ul>
        </div>
        <!--//End--非遗百科-->
        <div class="items gift">
          <div class="title"><strong>礼品推荐</strong></div>
          <ul>
            <li>
              <a href="http://mall.efeiyi.com/product/productModel/ihokg0wj2tek3fzo" title="">
                <p class="img"><img class="imgbg" src="<c:url value="/scripts/upload/home-pic-3-1.jpg"/>" alt=""></p>
                <p class="info">
                  <span class="name">母亲节礼物  秋韵油画艺术丝巾</span>
                  <span class="works">¥ 520</span>
                </p>
              </a>
            </li>
            <li>
              <a href="http://mall.efeiyi.com/product/productModel/ijwo0vqfzvc1zu0t" title="">
                <p class="img"><img class="imgbg" src="<c:url value="/scripts/upload/home-pic-3-2.jpg"/>" alt=""></p>
                <p class="info">
                  <span class="name">父亲节礼物  贞观紫砂杯</span>
                  <span class="works">¥ 488</span>
                </p>
              </a>
            </li>
            <li>
              <a href="http://mall.efeiyi.com/product/productModel/igvu2io13czbwif1" title="">
                <p class="img"><img class="imgbg" src="<c:url value="/scripts/upload/home-pic-3-3.jpg"/>" alt=""></p>
                <p class="info">
                  <span class="name">送女友  娟人王昭君</span>
                  <span class="works">¥ 138</span>
                </p>
              </a>
            </li>
            <li>
              <a href="http://mall.efeiyi.com/product/productModel/ihykdmfn1k8httnz" title="">
                <p class="img"><img class="imgbg" src="<c:url value="/scripts/upload/home-pic-3-4.jpg"/>" alt=""></p>
                <p class="info">
                  <span class="name">中秋送礼  华韵·中秋大礼包</span>
                  <span class="works">¥ 666</span>
                </p>
              </a>
            </li>
            <li>
              <a href="http://mall.efeiyi.com/product/productModel/ihbo02nj24x1v68o" title="">
                <p class="img"><img class="imgbg" src="<c:url value="/scripts/upload/home-pic-3-5.jpg"/>" alt=""></p>
                <p class="info">
                  <span class="name">乔迁送礼  财宝天王唐卡</span>
                  <span class="works">¥ 2667</span>
                </p>
              </a>
            </li>
            <li>
              <a href="http://mall.efeiyi.com/product/productModel/ief3hjp46b9jk29l" title="">
                <p class="img"><img class="imgbg" src="<c:url value="/scripts/upload/home-pic-3-6.jpg"/>" alt=""></p>
                <p class="info">
                  <span class="name">结婚送礼  鸳鸯荷花剪纸</span>
                  <span class="works">¥ 260</span>
                </p>
              </a>
            </li>
          </ul>
        </div>
        <!--//End--礼品推荐-->
        <div class="items edify">
          <div class="title"><strong>陶冶烧造</strong></div>
          <div class="title2">千姿百态&nbsp;&nbsp;&nbsp;&nbsp;因美而生</div>
          <ul>
            <li>
              <a href="http://mall.efeiyi.com/product/productModel/iefgxes915akvek5" title="">
                <p class="img"><img class="imgbg" src="<c:url value="/scripts/upload/home-pic-4-1.jpg"/>" alt=""></p>
                <p class="info">
                  <span class="name">牡丹花语斗笠碟</span>
                  <span class="works">¥ 150</span>
                </p>
              </a>
            </li>
            <li>
              <a href="http://mall.efeiyi.com/product/productModel/ighrk1id384nfu6r" title="">
                <p class="img"><img class="imgbg" src="<c:url value="/scripts/upload/home-pic-4-2.jpg"/>" alt=""></p>
                <p class="info">
                  <span class="name">金蟾纳福砚</span>
                  <span class="works">¥ 6500</span>
                </p>
              </a>
            </li>
            <li>
              <a href="http://mall.efeiyi.com/product/productModel/igrin2dh3cdj6gi1" title="">
                <p class="img"><img class="imgbg" src="<c:url value="/scripts/upload/home-pic-4-3.jpg"/>" alt=""></p>
                <p class="info">
                  <span class="name">马到成功铜雕</span>
                  <span class="works">¥ 2900</span>
                </p>
              </a>
            </li>
          </ul>
        </div>
        <!--//End--陶冶烧造-->
        <div class="items stone">
          <div class="title"><strong>金石錾锻</strong></div>
          <div class="title2">天地之灵&nbsp;&nbsp;&nbsp;&nbsp;淬火重生</div>
          <ul>
            <li>
              <a href="" title="">
                <p class="img"><img class="imgbg" src="<c:url value="/scripts/upload/home-pic-5-1.jpg"/>" alt=""></p>
                <p class="info">
                  <span class="name">景德镇青白瓷  牡丹花语斗笠碟</span>
                  <span class="works">¥ 521</span>
                </p>
              </a>
            </li>
            <li>
              <a href="http://mall.efeiyi.com/product/productModel/ihd4sf6rgc6hjwnx" title="">
                <p class="img"><img class="imgbg" src="<c:url value="/scripts/upload/home-pic-5-2.jpg"/>" alt=""></p>
                <p class="info">
                  <span class="name">金银丝镶嵌  金小叶紫檀</span>
                  <span class="works">¥ 2680</span>
                </p>
              </a>
            </li>
            <li>
              <a href="http://mall.efeiyi.com/product/productModel/ihmqo94q19dvqlvy" title="">
                <p class="img"><img class="imgbg" src="<c:url value="/scripts/upload/home-pic-5-3.jpg"/>" alt=""></p>
                <p class="info">
                  <span class="name">香道  高山流水</span>
                  <span class="works">¥ 3980</span>
                </p>
              </a>
            </li>
          </ul>
        </div>
        <!--//End--金石錾锻-->
      </div>
      <!--//End--左侧部分-->
      <div class="main-slide">
        <div class="bd mbox1">
          <a href="" class="" title=""><p class="img"><img class="imgbg" src="<c:url value="/scripts/upload/1000000.jpg"/>" alt=""></p></a>
          <a href="" title="">【非遗资讯】陶瓷“老男孩”的工匠情怀</a>
          <a href="" title="">【非遗资讯】古法炒制碧螺春</a>
          <a href="" title="">【非遗资讯】四川“抢救”10位国家级非遗传人 防“人走技失”</a>
          <a href="" title="">【非遗资讯】《传承者》震撼收官 非遗传承有了自己的舞台</a>
        </div>
        <div class="bd mbox2">
          <div class="title">精彩活动</div>
          <ul class="items">
            <li>
              <a href="http://mall.efeiyi.com/product/productModel/im1ks2wy24egdx4q" title="">
                <p class="img"><img class="imgbg" src="<c:url value="/scripts/upload/主图220160321140311.jpg"/>" alt=""></p>
                <p class="name">新品上市</p>
                <p class="info">藏山香盒</p>
              </a>
            </li>
            <li>
              <a href="http://mall.efeiyi.com/product/productModel/in031lv24bmyuc9h" title="">
                <p class="img"><img class="imgbg" src="<c:url value="/scripts/upload/120160414172814.jpg"/>" alt=""></p>
                <p class="name">秒杀活动</p>
                <p class="info">小缠线提梁方壶[88元包邮夏日饮茶秒杀中]</p>
              </a>
            </li>
            <li>
              <a href="http://mall.efeiyi.com/product/productModel/imret0bt539jqhyk" title="">
                <p class="img"><img class="imgbg" src="<c:url value="/scripts/upload/主图320160408154741.jpg"/>" alt=""></p>
                <p class="name">拼团活动</p>
                <p class="info">建盏「鹧鸪斑」禅定杯手机端188元春日团购开启中</p>
              </a>
            </li>
          </ul>
        </div>
        <!--//End--精彩活动-->
      </div>
      <!--//End--右侧部分-->
    </div>
    <!--//End-主体部分-->
  </div>
</div>





<!--[if (gte IE 9)|!(IE)]><!-->
<script src="<c:url value="/scripts/js/jquery.min.js"/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value="/scripts/js/amazeui.ie8polyfill.min.js"/>"></script>
<![endif]-->
<script src="<c:url value="/scripts/js/home.js"/>"></script>
</body>
</html>

