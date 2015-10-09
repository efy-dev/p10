
<%@ page import="com.efeiyi.ec.wiki.organization.util.AuthorizationUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/10/9
  Time: 10:18
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
  <title>e飞蚁工艺秀</title>
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
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/pc/css/amazeui.min.css?v=20150831'/>">
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/pc/css/app.css?v=20150831'/>">
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/pc/css/cyclopedia.css?v=20150831'/>">
  <script src="/scripts/assets/js/jquery-2.1.3.min.js" type="text/javascript"></script>
</head>
<body>
<div class="topbar wh" data-am-sticky>
  <div class="hd">
    <ul class="ul-item">
      <li><strong>李先生8899</strong><a href="" title="退出">退出</a></li>
      <li><a href="" title="请登录">请登录</a></li>
      <li><a href="" title="快速注册">快速注册</a></li>
      <li><a href="" title="商家入驻">商家入驻</a></li>
      <li class="btn-top-wechat">
        <a title="手机e飞蚁">手机e飞蚁</a>
        <span class="top-wechat"></span>
      </li>
      <li class="cart">
        <a href="" title="购物车"><i class="icon"></i>购物车</a>
        <span class="tips"><em>0</em></span>
      </li>
    </ul>
  </div>
</div>
<!-- //End--topbar-->
<div class="header wh">
  <div class="hd">
    <div class="logo"><a class="icon" href="" target="_blank" title="e飞蚁-爱非遗"></a></div>
    <div class="nav">
      <ul>
        <li><a href="" title="首页">首页</a></li>
        <li class="" >
          <a title="商品分类">商品分类</a>
          <span class="bgbor"></span>
          <div class="nav-links">
            <ul>
              <li class="title">陶 冶 烧 造</li>
              <li><a href="" target="_blank" title="">紫砂</a></li>
              <li><a href="" target="_blank" title="">景泰蓝</a></li>
              <li><a href="" target="_blank" title="">景德镇</a></li>
              <li><a href="" target="_blank" title="">钧瓷</a></li>
              <li><a href="" target="_blank" title="">龙泉青瓷</a></li>
            </ul>
            <ul>
              <li class="title">传 统 美 术</li>
              <li><a href="" target="_blank" title="">唐卡</a></li>
              <li><a href="" target="_blank" title="">剪纸</a></li>
              <li><a href="" target="_blank" title="">书法篆刻</a></li>
              <li><a href="" target="_blank" title="">陶瓷微书</a></li>
              <li><a href="" target="_blank" title="">脸谱</a></li>
              <li><a href="" target="_blank" title="">掐丝珐琅画</a></li>
            </ul>
            <ul>
              <li class="title">金 石 錾 锻</li>
              <li><a href="" target="_blank" title="">铜雕</a></li>
              <li><a href="" target="_blank" title="">花丝镶嵌</a></li>
            </ul>
            <ul>
              <li class="title">如胶似膝</li>
              <li><a href="" target="_blank" title="">平遥漆器</a></li>
              <li><a href="" target="_blank" title="">北京雕漆</a></li>
            </ul>
            <ul>
              <li class="title">织 染 印.绣</li>
              <li><a href="" target="_blank" title="">潮绣</a></li>
              <li><a href="" target="_blank" title="">苏绣</a></li>
              <li><a href="" target="_blank" title="">顾绣</a></li>
              <li><a href="" target="_blank" title="">沈绣</a></li>
              <li><a href="" target="_blank" title="">瑶族绣</a></li>
              <li><a href="" target="_blank" title="">京绣</a></li>
              <li><a href="" target="_blank" title="">云锦</a></li>
              <li><a href="" target="_blank" title="">蜀锦</a></li>
              <li><a href="" target="_blank" title="">漳缎</a></li>
              <li><a href="" target="_blank" title="">缂丝</a></li>
              <li><a href="" target="_blank" title="">蓝印花布</a></li>
              <li><a href="" target="_blank" title="">蜡染</a></li>
            </ul>
          </div>
        </li>
        <li><a href="" title="传承人">大师</a></li>
        <li><a href="" title="展览">工艺</a></li>

      </ul>
    </div>
  </div>
</div>
<!-- //End--header-->
<div class="craft-details ">
  <div class="nav-bars ae">
    <ul class="bars">
      <li class="active"><a href="#">动&nbsp;态</a></li>
      <%if(AuthorizationUtil.getMyUser().getId()==null || "no".equalsIgnoreCase(request.getAttribute("isShow").toString()) ){%>
      <li><a href="<c:url value='/pc/beforeAttention.do'/>">关注</a></li>
      <%}%>
      <%
        if(AuthorizationUtil.getMyUser().getId()!=null && "ok".equalsIgnoreCase(request.getAttribute("isShow").toString()) ){
      %>
      <li><a href="#">已关注</a></li>
      <%}%>

      <li><a href="#">发&nbsp;现</a></li>
    </ul>
  </div>
</div>
<!--nav-bars-->
<div class="home-craft">
  <div class="craft-details">
    <div class="focus wh">
      <!--轮播图-->
      <ul class="slider-main">
        <c:if test="${! empty bannerList}">
          <c:forEach var="banner" items="${bannerList}" varStatus="status">
            <c:if test="${status.index==0}">
              <li style="display: block;"><a href="#"><img src="${banner.imageUrl}" ></a></li>
            </c:if>
            <c:if test="${status.index!=0}">
              <li><a href="#"><img src="${banner.imageUrl}" ></a></li>
            </c:if>
          </c:forEach>

        </c:if>
      </ul>
      <ul class="slider-nav">
        <li class="active"></li>
        <li></li>
        <li></li>
      </ul>
    </div>
    <!-- //End--nav-->
    <div class="cart-tabe">

      <div class="craft-gz ae" style="display: block">
        <div class="craft-wz ae"><span>共关注<c:if test=" ${!empty fsAmount}">${fsAmount}</c:if>
          个工艺</span></div>
        <div class="craft-ts ae"><span>您还没有关注任何工艺，下面是我们为您推荐的几位工艺项目</span></div>
        <div class="craft-list ae">
          <ul class="craft-l-page ae" id="beforeAttention">
            <li>
              <div class="eimg"><a href="#"><img src="../shop2015/upload/110206jpg-02.png"></a></div>
              <div class="etext">
                <p class="dz">北京</p>
                <h5>景泰蓝</h5>
                <p>又称“铜胎掐丝珐琅”</p>
                <p>国家级非物质文化遗产</p>
                <p><strong>1000 件作品</strong><strong>50 位大师</strong></p>
                <a class="btn-guan" href="#">
                  <div class="gz-q">
                    <i class="gz-icon"></i>
                    <em>关注</em>
                  </div>
                </a>
              </div>
            </li>
            <li>
              <div class="eimg"><a href="#"><img src="../shop2015/upload/110206jpg-02.png"></a></div>
              <div class="etext">
                <p class="dz">北京</p>
                <h5>景泰蓝</h5>
                <p>又称“铜胎掐丝珐琅”</p>
                <p>国家级非物质文化遗产</p>
                <p><strong>1000 件作品</strong><strong>50 位大师</strong></p>
                <a class="btn-guan" href="#">
                  <div class="gz-q">
                    <i class="gz-icon"></i>
                    <em>关注</em>
                  </div>
                </a>
              </div>
            </li>
            <li>
              <div class="eimg"><a href="#"><img src="../shop2015/upload/110206jpg-02.png"></a></div>
              <div class="etext">
                <p class="dz">北京</p>
                <h5>景泰蓝</h5>
                <p>又称“铜胎掐丝珐琅”</p>
                <p>国家级非物质文化遗产</p>
                <p><strong>1000 件作品</strong><strong>50 位大师</strong></p>
                <a class="btn-guan" href="#">
                  <div class="gz-q">
                    <i class="gz-icon"></i>
                    <em>关注</em>
                  </div>
                </a>
              </div>
            </li>
            <li>
              <div class="eimg"><a href="#"><img src="../shop2015/upload/110206jpg-02.png"></a></div>
              <div class="etext">
                <p class="dz">北京</p>
                <h5>景泰蓝</h5>
                <p>又称“铜胎掐丝珐琅”</p>
                <p>国家级非物质文化遗产</p>
                <p><strong>1000 件作品</strong><strong>50 位大师</strong></p>
                <a class="btn-guan" href="#">
                  <div class="gz-q">
                    <i class="gz-icon"></i>
                    <em>关注</em>
                  </div>
                </a>
              </div>
            </li>
            <li>
              <div class="eimg"><a href="#"><img src="../shop2015/upload/110206jpg-02.png"></a></div>
              <div class="etext">
                <p class="dz">北京</p>
                <h5>景泰蓝</h5>
                <p>又称“铜胎掐丝珐琅”</p>
                <p>国家级非物质文化遗产</p>
                <p><strong>1000 件作品</strong><strong>50 位大师</strong></p>
                <a class="btn-guan" href="#">
                  <div class="gz-q">
                    <i class="gz-icon"></i>
                    <em>关注</em>
                  </div>
                </a>
              </div>
            </li>
            <li>
              <div class="eimg"><a href="#"><img src="../shop2015/upload/110206jpg-02.png"></a></div>
              <div class="etext">
                <p class="dz">北京</p>
                <h5>景泰蓝</h5>
                <p>又称“铜胎掐丝珐琅”</p>
                <p>国家级非物质文化遗产</p>
                <p><strong>1000 件作品</strong><strong>50 位大师</strong></p>
                <a class="btn-guan" href="#">
                  <div class="gz-q">
                    <i class="gz-icon"></i>
                    <em>关注</em>
                  </div>
                </a>
              </div>
            </li>
            <li>
              <div class="eimg"><a href="#"><img src="../shop2015/upload/110206jpg-02.png"></a></div>
              <div class="etext">
                <p class="dz">北京</p>
                <h5>景泰蓝</h5>
                <p>又称“铜胎掐丝珐琅”</p>
                <p>国家级非物质文化遗产</p>
                <p><strong>1000 件作品</strong><strong>50 位大师</strong></p>
                <a class="btn-guan" href="#">
                  <div class="gz-q">
                    <i class="gz-icon"></i>
                    <em>关注</em>
                  </div>
                </a>
              </div>
            </li>
            <li>
              <div class="eimg"><a href="#"><img src="../shop2015/upload/110206jpg-02.png"></a></div>
              <div class="etext">
                <p class="dz">北京</p>
                <h5>景泰蓝</h5>
                <p>又称“铜胎掐丝珐琅”</p>
                <p>国家级非物质文化遗产</p>
                <p><strong>1000 件作品</strong><strong>50 位大师</strong></p>
                <a class="btn-guan" href="#">
                  <div class="gz-q">
                    <i class="gz-icon"></i>
                    <em>关注</em>
                  </div>
                </a>
              </div>
            </li>
            <li>
              <div class="eimg"><a href="#"><img src="../shop2015/upload/110206jpg-02.png"></a></div>
              <div class="etext">
                <p class="dz">北京</p>
                <h5>景泰蓝</h5>
                <p>又称“铜胎掐丝珐琅”</p>
                <p>国家级非物质文化遗产</p>
                <p><strong>1000 件作品</strong><strong>50 位大师</strong></p>
                <a class="btn-guan" href="#">
                  <div class="gz-q">
                    <i class="gz-icon"></i>
                    <em>关注</em>
                  </div>
                </a>
              </div>
            </li>
            <li>
              <div class="eimg"><a href="#"><img src="../shop2015/upload/110206jpg-02.png"></a></div>
              <div class="etext">
                <p class="dz">北京</p>
                <h5>景泰蓝</h5>
                <p>又称“铜胎掐丝珐琅”</p>
                <p>国家级非物质文化遗产</p>
                <p><strong>1000 件作品</strong><strong>50 位大师</strong></p>
                <a class="btn-guan" href="#">
                  <div class="gz-q">
                    <i class="gz-icon"></i>
                    <em>关注</em>
                  </div>
                </a>
              </div>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="footer wh">
  <div class="service wh">
    <div class="icon phone"></div>
    <div class="line"></div>
    <div class="icon platform"><a href="" target="_blank" title="平台优势">平台优势</a></div>
    <div class="line"></div>
    <div class="icon chengbao"><a href="" target="_blank" title="诚品宝">诚品宝</a></div>
    <div class="line"></div>
    <div class="icon wechat"></div>
  </div>
  <div class="links wh">
    <a href="" target="_blank" title="关于我们">关于我们</a>
    <a class="line"></a>
    <a href="" target="_blank" title="联系我们">联系我们</a>
    <a class="line"></a>
    <a href="" target="_blank" title="诚聘英才">诚聘英才</a>
    <a class="line"></a>
    <a href="" target="_blank" title="意见反馈">意见反馈</a>
    <a class="line"></a>
    <a href="" target="_blank" title="帮助中心">帮助中心</a>
    <a class="line"></a>
    <a href="" target="_blank" title="诚信保障">诚信保障</a>
    <a class="line"></a>
    <a href="" target="_blank" title="新闻资讯">新闻资讯</a>
  </div>
  <div class="copyright wh">
    <div class="phone">
      <strong>商家入住热线</strong>
      <em>400-876-8766</em>
    </div>
    <div class="frlinks">
      <span>友情链接：</span>
      <a rel="nofollow" href="http://www.unesco.org.cn/" target="_blank" title="联合国教科文组织">联合国教科文组织</a>
      <a rel="nofollow" href="http://www.mcprc.gov.cn/" target="_blank" title="中国文化部">中国文化部</a>
      <a rel="nofollow" href="" target="_blank" title="中国文化部非物质文化遗产保护司">中国文化部非物质文化遗产保护司</a>
      <a rel="nofollow" href="" target="_blank" title="中国非物质文化遗产保护中心">中国非物质文化遗产保护中心</a>
    </div>
    <div class="info">Copyright © 2012-2022 永新华韵文化发展有限公司版权所有-京ICP备15032511号-1</div>
  </div>
</div>

<script>

  $(document).ready(function(){
    getData("<c:url value='/basic/xmj.do?qm=plistProjectRecommended_default&conditions=&pageEntity.size=10&pageEntity.index='/>");
  });

  function getData(url){
    var flag = false;
    $.ajax({
      type:"get",//设置get请求方式
      url:url+StartNum2,//设置请求的脚本地址
      data:"",//设置请求的数据
      dataType:"json",//设置请求返回的数据格式
      success:function(data){
        var pubu = $("#beforeAttention");

        if(data && data.length>=1){
          for(i in data){
            for(var key in data[i]){
              var box = $("<li> <div class='eimg'><a href='#'><img src='../shop2015/upload/110206jpg-02.png'></a></div> " +
                      "<div class='etext'> <p class='dz'>北京</p> " +
                      "<h5>景泰蓝</h5> <p>又称“铜胎掐丝珐琅”</p> " +
                      "<p>国家级非物质文化遗产</p> " +
                      "<p><strong>1000 件作品</strong>" +
                      "<strong>50 位大师</strong></p> " +
                      "<a class='btn-guan' href='#'> " +
                      "<div class='gz-q'> <i class='gz-icon'></i> <em>关注</em> </div> " +
                      "</a> </div> </li>");

            }

            pubu.append(box);

          }

        }else{
          flag = true;
        }
        PBL("#beforeAttention","#before",2);
        StartNum2=StartNum2+1;
      },
      error:function(){

        showAlert("effor","出错了，请联系管理员！！！");
        return false;
      },
      complete:function(){
        if(flag==true) {
          ajaxkey2 = false;
        }
      }
    })
  }

  $(window).load(function(){

    PBL("#pubu","#box",2);
    var winH = $(window).height(); //页面可视区域高度
    $(window).scroll(function(){
      var pageH = $(document.body).height();
      var scrollT = $(window).scrollTop(); //滚动条top
      var aa = (pageH - winH - scrollT) / winH;
      if(aa < 0.02){


      }


    });




  });

  function saveProjectFllow(projectId){

    $.ajax({
      type:"get",
      url:"/base/attention.do?projectId="+projectId,//设置请求的脚本地址
      data:"",
      dataType:"json",
      success:function(data){
        if(data==false){
          alert("您还未登陆，请登录后再操作");
          return false;
        }
        if(data==true){
          $("#"+projectId).html("已关注");
          return true;
        }

      },
      error:function(){

        alert("出错了，请联系管理员！！！");
        return false;
      },
      complete:function(){

      }
    });
  }

  function PBL(outer,boxs,style){//outer父级元素、boxs子级元素，style加载样式（ 1或者2 ）
    var pubu = $(outer);
    var box = $(boxs);
    var num = Math.floor($(document.body).width()/box.outerWidth());//根据浏览器宽度获得显示的列的数量
    pubu.width(num*(box.outerWidth()));//给pubu的宽度赋值
    var allHeight = [];//定义一个数组存储所有列的高度
    for(var i=0;i<box.length;i++){
      if (i<num) {
        allHeight[i]=box.eq(i).outerHeight();
      }else{
        var minHeight = Math.min.apply({},allHeight);//获得所有的列中高度最小的列的高度
        var sy = getSy(minHeight,allHeight);//获取高度最小的列的索引
        getStyle(box.eq(i),minHeight,sy*box.eq(i).outerWidth(),i,style);
        allHeight[sy] += box.eq(i).outerHeight();
      }
    }
  }
  //获取高度最小的列的索引
  function getSy(minH,allH){
    for(sy in allH){
      if(allH[sy]==minH) return sy;
    }
  }

  function checkIsAttention(projectId){
    isAttention = false;
    $.ajax({
      type:"get",
      url:"/base/Isattention.do?projectId="+projectId,
      data:"",
      async:false,
      dataType:"json",
      success:function(data){
        if(data==false){
          isAttention = false;
          return false;
        }
        if(data==true){
          isAttention=true;
          return true;
        }
      },
      error:function(){

        alert("出错了，请联系管理员！！！");
        return false;
      },
      complete:function(){

      }
    })

  }




  //判断请求数据的开关
  function getDataCheck(){
    var pubu = $("#pubu");
    var box = $("#box");
    var lastboxHeight = $(box[box.length-1]).offset().top+Math.floor($(box[box.length-1]).outerHeight()/2);
    var documentHeight = $(window).height();
    var scrollTop = $(document).scrollTop();
    return lastboxHeight<documentHeight+scrollTop?true:false;
  }
  //存储开始请求数据条数的位置
  var getStartNum = 0;
  var StartNum2 = 1;
  var ajaxkey = true;//设置ajax请求的开关,如需动态加载、需要打开这个开关
  var ajaxkey2 = true;
  var  isAttention = false;
  //设置请求数据加载的样式
  function getStyle(boxs,top,left,index,style){
    if (getStartNum>=index) {
      return;
    }
    boxs.css("position","absolute");
    switch(style){
      case 1:
        boxs.css({
          "top":top+$(window).height(),
          "left":left
        });
        boxs.stop().animate({
          "top":top,
          "left":left
        },999);
        break;
      case 2:
        boxs.css({
          "top":top,
          "left":left,
          "opacity":"0"
        });
        boxs.stop().animate({
          "opacity":"1"
        },999);
    }
    getStartNum = index;//更新请求数据的条数位置

  }

</script>
<!-- //End--footer-->
<!--[if (gte IE 9)|!(IE)]><!-->
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<!--自定义js--Start-->
<script src="<c:url value='/scripts/assets/pc/js/system.js?v=20150831'/>"></script>
<script src="<c:url value='/scripts/assets/pc/js/cyclopedia.js?v=20150831'/>"></script>
</body>
</html>


