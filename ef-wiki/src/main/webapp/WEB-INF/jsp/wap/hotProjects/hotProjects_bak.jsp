<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/11
  Time: 15:22
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
  <meta name="viewport"
        content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>Masonry 结合 Panel 使用 | Amaze UI 插件</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="Cache-Control" content="no-siteapp"/>
  <link rel="icon" type="image/png"
        href="/scripts/assets/images/favicon.ico">
  <link rel="stylesheet"
        href="http://cdn.amazeui.org/amazeui/2.1.0/css/amazeui.min.css">
  <link rel="stylesheet" href="http://a.static.amazeui.org/assets/plugin/css/app.min.css">
  <!--[if (gte IE 9)|!(IE)]><!-->
  <script src="http://code.jquery.com/jquery-2.1.3.min.js"></script>
  <script src="http://cdn.amazeui.org/amazeui/2.1.0/js/amazeui.min.js"></script>
  <!--<![endif]-->
  <!--[if lte IE 8 ]>
  <script src="http://libs.baidu.com/jquery/1.11.1/jquery.min.js"></script>
  <![endif]-->
  <link rel="stylesheet" href="../demo.css"/>
</head>
<body class="am-plugin">
<header class="am-topbar am-topbar-inverse">

</header>


<section class="amp-main">
  <div class="am-container">

    <div id="js-container">

    </div>

    <div id="load-more"><button class="am-btn am-btn-primary">载入更多</button></div>

    <script type="text/x-handlebars-template" id="tpl-list">
      {{#each events}}
      <div class="msry-item">
        <section class="am-panel am-panel-default">
          <header class="am-panel-hd">
            <h3 class="am-panel-title">{{title}}</h3>
          </header>
          <div class="am-panel-bd">
            开始：{{begin_time}} <br/>
            结束： {{begin_time}}<br/>
            地点：{{address}} <br/>
            类型： {{category_name}} <br/>
            <a href="{{alt}}" target="_blank">查看详情 &rarrlp;</a>
          </div>
        </section>
      </div>
      {{/each}}
    </script>

    <script src="<c:url value='/scripts/js/masonry.pkgd.min.js'/>"></script>
    <script src="<c:url value='/scripts/js/bundle.js'/>"></script>


  </div>
</section>
<input type="text" id="ms" value="<c:url value='/getHotProjects.do?'/>"  style="display:none;">

</div><div class="amp-toolbar" id="amp-toolbar"><a href="#top" title="回到顶部" class="am-icon-btn am-icon-arrow-up" id="amp-go-top"></a></div>
<script src="http://a.static.amazeui.org/assets/plugin/js/app.min.js"></script>
<script async defer id="github-bjs" src="https://buttons.github.io/buttons.js"></script>

<script>

  (function(w, d, s) {

    function gs(){
      (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){ (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o), m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
      })(w , d, s ,'//www.google-analytics.com/analytics.js','ga');
      ga('create', 'UA-34196034-8', 'amazeui.org');
      ga('send', 'pageview');
    }
    if (w.addEventListener) { w.addEventListener('load', gs, false); }
    else if (w.attachEvent) { w.attachEvent('onload',gs); }
  }(window, document, 'script'));
</script>
</body>
</html>

