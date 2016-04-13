<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/4/13
  Time: 17:38
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
  <title>工艺首页</title>
</head>
<body>
<div class="nav2016 bgc">
  <div class="hd bgf">
    <div id="cate" class="cate">
      <div class="dt"><span href="" title="">全部商品<i class="icon2016 icon-arrow"></i></span></div>
      <div class="dd" style="display:none">
        <div class="layer">
          <ul>
            <li class="title"><strong>陶冶烧造：</strong></li>
            <li><a href="">唐三彩</a></li>
            <li><a href="">紫砂</a></li>
            <li><a href="">越窑青瓷</a></li>
            <li><a href="">景泰蓝</a></li>
            <li><a href="">龙泉青瓷</a></li>
            <li><a href="">景德镇陶瓷</a></li>
            <li><a href="">铂玉瓷</a></li>
            <li><a href="">南宋官窑瓷</a></li>
          </ul>
        </div>
        <div class="layer">
          <ul>
            <li class="title"><strong>传统美术：</strong></li>
            <li><a href="">唐卡</a></li>
            <li><a href="">剪纸</a></li>
            <li><a href="">绢人</a></li>
            <li><a href="">内画</a></li>
          </ul>
        </div>
        <div class="layer">
          <ul>
            <li class="title"><strong>金石錾锻：</strong></li>
            <li><a href="">藏书澄泥石刻</a></li>
            <li><a href="">花丝镶嵌</a></li>
            <li><a href="">铜雕</a></li>
            <li><a href="">金银丝镶嵌</a></li>
          </ul>
        </div>
        <div class="layer">
          <ul>
            <li class="title"><strong>如胶似漆：</strong></li>
            <li><a href="">平遥推光漆器</a></li>
            <li><a href="">厦门漆线雕</a></li>
            <li><a href="">漆器</a></li>
          </ul>
        </div>
        <div class="layer">
          <ul>
            <li class="title"><strong>织染印秀：</strong></li>
            <li><a href="">苏绣</a></li>
            <li><a href="">蜀绣</a></li>
            <li><a href="">蓝印花布</a></li>
            <li><a href="">丝雕</a></li>
            <li><a href="">庆阳香包绣</a></li>
          </ul>
        </div>
        <div class="layer">
          <ul>
            <li class="title"><strong>琢玉成器：</strong></li>
            <li><a href="">北京玉雕</a></li>
          </ul>
        </div>
        <div class="layer">
          <ul>
            <li class="title"><strong>木作编扎：</strong></li>
            <li><a href="">竹编</a></li>
            <li><a href="">南阳藤编</a></li>
            <li><a href="">东阳木雕</a></li>
          </ul>
        </div>
        <div class="layer">
          <ul>
            <li class="title"><strong>文房四宝：</strong></li>
            <li><a href="">粉蜡扎</a></li>
            <li><a href="">端砚</a></li>
            <li><a href="">连四纸</a></li>
          </ul>
        </div>

        <div class="layer">
          <ul>
            <li class="title"><strong>创意生活：</strong></li>
            <li><a href="">传统家具</a></li>
            <li><a href="">香道</a></li>
            <li><a href="">传统手工皂</a></li>
            <li><a href="">办公用品</a></li>
            <li><a href="">尼布藏香</a></li>
            <li><a href="">茶道用品</a></li>
            <li><a href="">摆件</a></li>
            <li><a href="">荷香</a></li>
            <li><a href="">芦苇画</a></li>
            <li><a href="">皮包皮具</a></li>
          </ul>
        </div>
      </div>
    </div>
    <!--//End--分类-->
    <div class="navitems">
      <ul>
        <li><a href="" title="">首页</a></li>
        <li><a href="" title="">大师精品</a></li>
        <li><a href="" title="">青年新锐</a></li>
        <li><a href="" title="">飞蚁工坊</a></li>
        <li><a href="" title="">礼品专区</a></li>
      </ul>
    </div>
    <!--//End--导航-->
    <div class="search">
      <form action="">
        <input type="text" value="" placeholder="搜索" class="ipt">
        <input type="submit" value="" class="icon2016 btn">
      </form>
    </div>
    <!--//End--搜索-->
  </div>
</div>
<!--//End--nav2016-->
<div id="slide2016" class="slide2016">
  <div class="img">
    <ul>
      <c:forEach items="pcbannerList" var="banner">
      <li><a href="" title=""><img src="/shop2016/upload/slide2016-3.jpg" alt=""></a></li>
      </c:forEach>
    </ul>
  </div>
  <div class="num">
    <ul>
      <li class="active"></li>
      <li></li>
      <li></li>
    </ul>
  </div>
</div>
<!--//End--slide2016-->
<div class="craft-list2016">
  <div class="craft-list">
    <div class="topic">
      <div class="bd-list"></div>
      <div class="topic-txt"><span>传统技艺</span></div>
      <div class="bd-list"></div>
    </div>
    <ul class="list">
      <li>
        <a href="">
          <img src="shop2016/upload/carf2016.jpg" alt="">
          <div class="list-content">
            <p class="name">生日好礼生日好礼生日好礼生日好礼</p>
            <p class="title">国家级非遗项目</p>
          </div>
        </a>
      </li>
      <li>
        <a href="">
          <img src="shop2016/upload/carf2016.jpg" alt="">
          <div class="list-content">
            <p class="name">生日好礼</p>
            <p class="title">国家级非遗项目</p>
          </div>
        </a>
      </li>
      <li>
        <a href="">
          <img src="shop2016/upload/carf2016.jpg" alt="">
          <div class="list-content">
            <p class="name">生日好礼</p>
            <p class="title">国家级非遗项目</p>
          </div>
        </a>
      </li>
      <li>
        <a href="">
          <img src="shop2016/upload/carf2016.jpg" alt="">
          <div class="list-content">
            <p class="name">生日好礼</p>
            <p class="title">国家级非遗项目</p>
          </div>
        </a>
      </li>
    </ul>
  </div>
</div>
<!--//End--craft2016-->

<!--[if (gte IE 9)|!(IE)]><!-->
<script src="shop2016/js/jquery.min.js"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->



<script src="shop2016/js/system.js"></script>
</body>
</html>

