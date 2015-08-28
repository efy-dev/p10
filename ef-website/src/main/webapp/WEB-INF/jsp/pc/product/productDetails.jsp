<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/24
  Time: 9:14
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
  <title>商品详情页</title>
  <!-- Set render engine for 360 browser -->
  <meta name="renderer" content="webkit">
  <!-- No Baidu Siteapp-->
  <meta http-equiv="Cache-Control" content="no-siteapp"/>
  <link rel="icon" type="image/png" href="assets/i/favicon.png">
  <!-- Add to homescreen for Chrome on Android -->
  <meta name="mobile-web-app-capable" content="yes">
  <link rel="icon" sizes="192x192" href="assets/i/app-icon72x72@2x.png">
  <!-- Add to homescreen for Safari on iOS -->
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
  <link rel="apple-touch-icon-precomposed" href="assets/i/app-icon72x72@2x.png">
  <!-- Tile icon for Win8 (144x144 + tile color) -->
  <meta name="msapplication-TileImage" content="assets/i/app-icon72x72@2x.png">
  <meta name="msapplication-TileColor" content="#0e90d2">
  <link type="text/css" rel="stylesheet" href="/scripts/assets/css/amazeui.min.css?v=20150831">
  <link type="text/css" rel="stylesheet" href="/scripts/css/app.css?v=20150831">
</head>
<body>
<!-- //End--topbar-->
<!-- //End--header-->
<div class="hd product-intro">
  <div class="wh">
    <ol class="am-breadcrumb">
      <li><a href="#">首页</a></li>
      <li><a href="#">分类</a></li>
      <li class="am-active">内容</li>
    </ol>
  </div>
  <!-- //End--面包屑-->
  <div class="wh itemInfo">
    <div class="preview">
      <div class="collect"><i class="icon"></i><span class="hover">收藏</span><span class="active">已收藏</span></div>
      <div class="slider-img">
        <ul>
          <li class="active"><img src="/scripts/assets/upload/pep-1.jpg" width="60" height="60" alt=""/></li>
          <li><img src="/scripts/assets/upload/pep-2.jpg" width="60" height="60" alt=""/></li>
          <li><img src="/scripts/assets/upload/pep-3.jpg" width="60" height="60" alt=""/></li>
          <li><img src  ="/scripts/assets/upload/pep-4.jpg" width="60" height="60" alt=""/></li>
          <li><img src="/scripts/assets/upload/pep-5.jpg" width="60" height="60" alt=""/></li>
        </ul>
      </div>
      <!-- //End--sliderimg-->
      <div class="slider-main">
        <ul>
          <li><img src="/scripts/assets/upload/pep-1.jpg" width="900" height="800" alt=""/></li>
          <li><img src="/scripts/assets/upload/pep-2.jpg" width="900" height="800" alt=""/></li>
          <li><img src="/scripts/assets/upload/pep-3.jpg" width="900" height="800" alt=""/></li>
          <li><img src="/scripts/assets/upload/pep-4.jpg" width="900" height="800" alt=""/></li>
          <li><img src="/scripts/assets/upload/pep-5.jpg" width="900" height="800" alt=""/></li>
        </ul>
      </div>
      <!-- //End--slider-main-->
    </div>
    <!-- //End--des-focus-->
    <div class="itme-ext">
      <div class="name">
        <p>${productModel.product.master.fullName}</p>
        <p><strong>${productModel.product.name}</strong></p>
      </div>
      <!-- //End-->
      <div class="des">
        <ul>
          <li><strong>品&nbsp;&nbsp;&nbsp;&nbsp;名：</strong><span>${productModel.name}</span></li>
          <%--<li><strong>尺&nbsp;&nbsp;&nbsp;&nbsp;寸：</strong><span></span></li>--%>
          <%--<li><strong>材&nbsp;&nbsp;&nbsp;&nbsp;质：</strong><span></span></li>--%>
          <li><strong>制作方式：</strong><span>手工</span></li>
          <li><strong>所属项目：</strong><span>平遥推光漆器</span></li>
          <li><strong>项目级别：</strong><span>国家级非物质文化遗产</span></li>
          <li><strong>传&nbsp;承&nbsp;人：</strong><span>${productModel.product.master.fullName}（${productModel.product.master.title}）</span></li>
          <li><strong>适&nbsp;&nbsp;&nbsp;&nbsp;用：</strong><span>个人收藏</span><span>家居装饰</span><span>商务礼品</span><span>祝寿礼品</span><span>家居装饰</span></li>
        </ul>
      </div>
      <!-- //End-->
      <div class="price">
        <div class="p-text">飞蚁价：</div>
        <div class="p-price"><em>￥</em><span>${productModel.price}</span></div>
        <div class="m-price">市场价：￥${productModel.price}</div>
      </div>
      <!-- //End-->
      <div class="choose-btns">
        <a class="btn btn-append" href="" title="放入购物车">放入购物车</a>
        <a class="btn btn-buy" href="" title="立即购买">立即购买</a>
        <!-- JiaThis Button BEGIN -->
        <div class="jiathis_style">
          <span class="jiathis_txt">分享到</span>
          <a class="jiathis_button_weixin"></a>
          <a class="jiathis_button_tqq"></a>
          <a class="jiathis_button_tsina"></a>
          <a class="jiathis_button_cqq"></a>
        </div>
        <!-- JiaThis Button END -->
      </div>
      <!-- //End-->
    </div>
    <!-- //End--itme-ext-->
  </div>
  <!-- //End--itemInfo-->
  <div class="wh">
    <div class="tab-wrap">
      <!-- JiaThis Button BEGIN -->
      <div class="jiathis_style">
        <span class="jiathis_txt">分享到</span>
        <a class="jiathis_button_weixin"></a>
        <a class="jiathis_button_tqq"></a>
        <a class="jiathis_button_tsina"></a>
        <a class="jiathis_button_cqq"></a>
      </div>
      <!-- JiaThis Button END -->
      <div class="tab-items">
        <ul>
          <li><a href="#detail" title="商品详情">商 品 详 情<i class="icon"></i></a></li>
          <li><a href="#feeling" title="大师感悟">大 师 感 悟<i class="icon"></i></a></li>
          <li><a href="#" title="商品评价">商 品 评 价<i class="icon"></i></a></li>
          <li><a href="#" title="服务保障">服 务 保 障<i class="icon"></i></a></li>
          <li><a href="#" title="同店精品">同 店 精 品</a></li>
        </ul>
      </div>
      <!-- //End-->
      <div class="btns">
        <a class="buy" href="" title="立即购买">立 即 购 买</a>
        <a class="append" href="" title="放入购物车"><i class="icon"></i>放 入 购 物 车</a>
      </div>
    </div>
  </div>
  <!-- //End-->
  <div class="wh detail" id="detail">
    <div class="wh title"><h3>商品详情</h3></div>
    <div class="wh part">
      <div class="wh spe1">
        <h4>非遗风貌</h4>
        <ul>
          <li><strong>品&nbsp;&nbsp;&nbsp;&nbsp;名：</strong><span>开柜</span></li>
          <li><strong>尺&nbsp;&nbsp;&nbsp;&nbsp;寸：</strong><span>1200×350×7000</span></li>
          <li><strong>材&nbsp;&nbsp;&nbsp;&nbsp;质：</strong><span></span></li>
          <li><strong>制作方式：</strong><span>手工</span></li>
          <li><strong>所属项目：</strong><span>平遥推光漆器</span></li>
          <li><strong>项目级别：</strong><span>国家级非物质文化遗产</span></li>
          <li><strong>传&nbsp;承&nbsp;人：</strong><span>${productModel.product.master.fullName}（${productModel.product.master.title}）</span></li>
          <li><strong>适&nbsp;&nbsp;&nbsp;&nbsp;用：</strong><span>个人收藏</span><span>家居装饰</span><span>商务礼品</span><span>祝寿礼品</span><span>家居装饰</span></li>
        </ul>
      </div>
      <!-- //End--spe1-->
      <div class="wh spe2">
        <h4>非遗承袭</h4>
        <ul>
          <li>${productModel.product.productDescription.content}</li>
          <%--<li><p>在晋中，有一俗语可谓家喻户晓："平遥古城三件宝，漆器牛肉长山药"。在古城三件宝中，漆器列为首。平遥古城地处黄土高原。公元前2000年前，新石器时代，这里覆盖有大量树木。有一种叫漆树的树种分布甚广。先民们便用漆树的浆汁涂抹食器，以图光亮、好看、耐用。另外，由于漆器具有自动变黑的特征，它也被用来作为文字记号。3700年前，禹造祭器，髹以漆液，墨染其外，先染其内，证明当时已使用矿物质颜料调制朱色漆饰。</p></li>--%>
        </ul>
      </div>
      <!-- //End--spe2-->
      <div class="wh spe3">
        <h4>非遗雅韵</h4>
        <ul>
          <li>
            <span><img src="/scripts/assets/upload/details-1.jpg" alt=""/></span>
            <p>平遥推光漆器外观古朴雅致、闪光发亮，绘饰金碧辉煌，手感细腻滑润，耐热防潮，经久耐用，诚为漆器中之精品。</p>
          </li>
          <li>
            <span><img src="/scripts/assets/upload/details-1.jpg" alt=""/></span>
            <p>平遥推光漆器外观古朴雅致、闪光发亮，绘饰金碧辉煌，手感细腻滑润，耐热防潮，经久耐用，诚为漆器中之精品。</p>
          </li>
          <li>
            <span><img src="/scripts/assets/upload/details-1.jpg" alt=""/></span>
            <p>平遥推光漆器外观古朴雅致、闪光发亮，绘饰金碧辉煌，手感细腻滑润，耐热防潮，经久耐用，诚为漆器中之精品。</p>
          </li>
        </ul>
      </div>
      <!-- //End--spe3-->
    </div>
    <!-- //End--spe-->
    <div class="wh part">
      <div class="feeling" id="feeling">
        <div class="title"><h3>大师感悟</h3></div>
        <div class="info">
          <div class="tbar">
            <p><i class="icon"></i>省级非物质文化遗产传承人<span class="red">[如胶似漆]</span></p>
          </div>
          <div class="img"><img src="../shop2015/upload/details-2.jpg" alt=""/></div>
          <div class="txt">
           ${productModel.product.master.name}
          </div>
        </div>
      </div>
    </div>
    <!-- //End-->
    <div class="wh part">
      <div class="wh spe4">
        <h4>非遗珍材</h4>
        <ul>
          <li><p>平遥推光漆器的魅力不仅仅在于精雕细琢，用料也颇有讲究。平遥推光漆器使用的是在黄土高原广泛分布着的漆树刮掉树皮后流出来的一种天然漆料－－大漆。</p></li>
        </ul>
      </div>
      <div class="wh spe4">
        <h4>制非遗</h4>
        <ul>
          <li><p>木胎—灰胎—漆工—画工—镶嵌
            漆工车间的工序是非常细致和复杂的。每一件漆艺品"髹漆"是最关键的工序，在灰胎上每刷一道漆，都要先用水砂纸蘸水擦拭，擦拭毕，再用手反复推擦，直到手感光滑，再进行刷漆，每件产品一般上五道到八道漆，每上完一道漆干后需打磨--再上漆--再打磨，最后出光。
            出好光是每件产品质量优劣的关键。推光漆工艺，从底漆到面漆，每髹饰一道大漆都有不同的工艺要求。
            平遥推光漆最后一道面漆工序是用手掌推磨抛光的，通常的做法是先用细砂纸把漆面打磨光滑，接下来要用优质椴木烧制的木炭块细细蘸水打磨增加漆面的黑度，再用头发蘸油打磨，最后用手掌蘸上特制的细砖灰（用水将砖灰反复过滤）和麻油推光。
            漆面要达到光亮如镜的效果，推磨次数愈多出的光愈亮，以后会越擦越亮，适于长期摆放。</p></li>
        </ul>
      </div>
      <div class="wh spe4">
        <h4>制非遗</h4>
        <ul>
          <li><p>防晒防熏
            收藏漆器应注意避免阳光曝晒、烟熏。
            防干防湿
            避免忽干忽湿、温度忽高忽低，最好把漆器放在温度和湿度比较恒定的房间中。空气过于干燥，漆器容易发生断裂；湿度过大，则易出现变形和脱漆。
            防霉
            收藏时特别注意不要把漆器放得离地太近，也不要放在铺设海绵的地上。因为地上湿气大，海绵的吸水力又比较强，离地太近或久置于海绵上，易使漆器发霉脱漆。
            防擦撞
            移动漆器时要轻拿轻放，不要与坚硬、锐利的物体碰撞或摩擦，避免剧烈震动。漆器年代越久远，胎质越易变得疏松，稍不注意就会损坏。要远离盐、碱等对漆器有一定损害的东西。
            防尘
            漆器上有灰尘积淀，可用鸡毛掸和柔软的毛刷轻轻清理，或用棉纱布擦拭。如果漆器表面沾上污垢，可用洗涤剂清洗或用棉纱布蘸上少许食用油轻轻擦拭。</p></li>
        </ul>
      </div>
    </div>
    <!-- //End-->
    <div class="online-ask">
      <a href="" class="btn"><i class="icon"></i>在线咨询</a>
    </div>
  </div>

</div>
<!-- //End--footer-->


<!--[if (gte IE 9)|!(IE)]><!-->
<script src="../shop2015/js/jquery.min.js"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script src="../shop2015/js/amazeui.min.js"></script>
<script src="../shop2015/js/system.js"></script>
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js?uid=" charset="utf-8"></script>
</body>
</html>
