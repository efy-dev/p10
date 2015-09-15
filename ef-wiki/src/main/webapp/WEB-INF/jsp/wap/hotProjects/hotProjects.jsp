<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/14
  Time: 9:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <title></title>



  <link rel="stylesheet" type="text/css" href="/scripts/assets/css/pubu.css">
  <style type="text/css">
    body {
      padding:0;
      margin:0;
      background:url(/scripts/assets/images/bg.jpg);
    }
    img {
      border:none;
    }
    a {
      text-decoration: none;
    }
  </style>

  <script src="/scripts/js/jquery-2.1.3.min.js" type="text/javascript"></script>
  <script type="text/javascript" src="/scripts/js/pubu.js"></script>

</head>
<body>
<script>
  $(window).load(function(){
    getData("<c:url value='/basic/xmj.do?qm=plistProjectRecommended_default&conditions=&pageEntity.size=10&pageEntity.index='/>");
    PBL("#pubu",".box",2);
    var ajaxkey = true;//设置ajax请求的开关,如需动态加载、需要打开这个开关
    var winH = $(window).height(); //页面可视区域高度
    $(window).scroll(function(){
      var pageH = $(document.body).height();
      var scrollT = $(window).scrollTop(); //滚动条top
      var aa = (pageH - winH - scrollT) / winH;
      if(aa < 0.02){
        if (getDataCheck() && ajaxkey) {
          //var pubu = $("#pubu");
          //for(i in data){
          //var box = $("<div class='box'><div class='pic'><img src="+data[i].src+"></div></div>");
          //pubu.append(box);
          //}
          //PBL("#pubu",".box",2);
          getData("/basic/xmj.do?qm=plistProjectRecommended_default&conditions=&pageEntity.size=10&pageEntity.index=");//jquery的Ajax异步加载数据、需要从数据库加载的、需要调用该函数
        };

      }


    });

  })
</script>


<div id="pubu">


  <div class="box">
    <div class="pic">
      <img src="/scripts/assets/images/3.jpg">
    </div>
  </div>


</div>
</body>
</html>

