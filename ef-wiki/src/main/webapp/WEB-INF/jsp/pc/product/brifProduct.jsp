
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
        <li><a href="<c:url value='/pc/index.do'/>" title="展览">工艺</a></li>

      </ul>
    </div>
  </div>
</div>
<!-- //End--header-->
<div class="list-find">
  <!--头部-->
  <div class="list-f-title">
    <p><a>工艺</a><i class="fu-icon"></i><a>景泰蓝</a><i class="fu-icon"></i><a>作品</a><i class="fu-icon"></i><span>作品详情</span></p>
  </div>
  <div class="ae">
    <div class="details ae">
      <div class="detaile-left">
        <div class="detaile-img"><a href="#"><img src="${product.picture_url}"></a></div>
        <div class="detaile-share ae" style="height: auto;z-index: 200;">
          <!-- JiaThis Button BEGIN -->
          <div class="jiathis_style" style="background: #fff;border: 0;float: left;padding: 30px 0;">
            <a class="jiathis_button_weixin"></a>
            <a class="jiathis_button_tqq"></a>
            <a class="jiathis_button_tsina"></a>
            <a class="jiathis_button_cqq"></a>
          </div>
          <!-- JiaThis Button END -->
          <div class="thumb-up">
            <div class="thump-assist">
              <a href="#"><i class="z-icon"></i> </a>
              <a href="#"><em>赞(${product.amount})</em></a>
            </div>
            <div class="thump-collect">
              <a href="#"><i class="s-icon"></i> </a>
              <a href="#"><em>收藏</em></a>
            </div>
            <div class="thump-enquiry">
              <a href="#" id="btn-xj">询价</a>
            </div>
          </div>
        </div>
        <!--弹出框-->
        <div class="word" style="display: none;" id="word">
          <div class="leave">
            <div class="close ae">
              <div class="pic1"><img src="../shop2015/upload/110209-1img1.png"></div>
              <dl class="name">
                <dt><img src="../shop2015/upload/pep-2.jpg"></dt>
                <dd><h4>张同禄</h4><p>最美景泰蓝</p></dd>
              </dl>
              <div class="word-note">
                <form>
                  <div class="content-pg">
                    <label>留言：</label>
                    <textarea class="worde-r" placeholder="给大师的留言"></textarea>
                  </div>
                  <div class="content-pg">
                    <label></label>
                    <input type="submit" class="btn" value="确&nbsp;&nbsp;&nbsp;定">
                  </div>
                </form>
              </div>
              <div class="shut" id="shut-btn"></div>
            </div>
          </div>
          <div class="leave-bg"></div>
        </div>
        <div class="detaile-intro ae">
          <ul class="intro-matter ae">
            <li class="active">简介</li>
            <li>规格</li>
          </ul>
          <div class="detaile-content">
            <div class="master-tab intro">
              <p>
              ${product.productDescription.content}
              </p>
            </div>
            <div class="master-tab norms" style="display: none">
              <p>作品名称：${product.name}</p>
              <p>意&nbsp;&nbsp; &nbsp; &nbsp;        境：${product.subName}</p>
              <p>创作时间：${product.createDateTime}</p>
              <p>类&nbsp;&nbsp; &nbsp; &nbsp;        别：${product.project.projectCategory.name}</p>
            </div>
          </div>
        </div>
        <!--评论-->
        <div class="detaile-comment ae">
          <form>
            <h4>评论</h4>
            <ul class="comment ae">
              <li class="ae">
                <div class="img"><a href="#"><img class="am-circle" src="../shop2015/upload/yonghm.jpg"></a></div>
                <div class="text"><span><a href="#">Andy ：</a></span><span>作品很震撼人！之前没有这么认真的去了解过景泰蓝的工艺，更没有关注过中国的非物质文化遗产，总认为这些东西距离我们的生活是那么的远，然而却离我们这麽近，我们应该学会去珍惜它们。</span></div>
                <div class="status ae">
                  <div class="status-left"><span>10分钟前</span></div>
                  <div class="status-right">
                    <div class="hf"><a href="#">回复</a></div>
                    <div class="zan">
                      <a href="#"><i class="icon"></i></a>
                      <em>99999</em>
                    </div>
                  </div>
                </div>
                <div class="review ae" style="display: none;">
                  <textarea></textarea>
                  <div class="btn1 ae">
                    <input type="submit" class="btn" value="评论">
                    <!--<a href="#">取消</a>-->
                  </div>
                </div>
              </li>
              <li class="ae">
                <div class="img"><a href="#"><img class="am-circle" src="../shop2015/upload/yonghm.jpg"></a></div>
                <div class="text"><span><a href="#">Andy ：</a></span><span>作品很震撼人！之前没有这么认真的去了解过景泰蓝的工艺，更没有关注过中国的非物质文化遗产，总认为这些东西距离我们的生活是那么的远，然而却离我们这麽近，我们应该学会去珍惜它们。</span></div>
                <div class="status ae">
                  <div class="status-left"><span>10分钟前</span></div>
                  <div class="status-right">
                    <div class="hf"><a href="#">回复</a></div>
                    <div class="zan">
                      <a href="#"><i class="icon"></i></a>
                      <em>99999</em>
                    </div>
                  </div>
                </div>
                <div class="review ae" style="display: none;">
                  <textarea></textarea>
                  <div class="btn1 ae">
                    <input type="submit" class="btn" value="评论">
                    <!--<a href="#">取消</a>-->
                  </div>
                </div>
              </li>
              <li class="ae">
                <div class="img"><a href="#"><img class="am-circle" src="../shop2015/upload/yonghm.jpg"></a></div>
                <div class="text"><span><a href="#">Andy ：</a></span><span>作品很震撼人！之前没有这么认真的去了解过景泰蓝的工艺，更没有关注过中国的非物质文化遗产，总认为这些东西距离我们的生活是那么的远，然而却离我们这麽近，我们应该学会去珍惜它们。</span></div>
                <div class="status ae">
                  <div class="status-left"><span>10分钟前</span></div>
                  <div class="status-right">
                    <div class="hf"><a href="#">回复</a></div>
                    <div class="zan">
                      <a href="#"><i class="icon"></i></a>
                      <em>13</em>
                    </div>
                  </div>
                </div>
                <div class="review ae" style="display: none;">
                  <textarea></textarea>
                  <div class="btn1 ae">
                    <input type="submit" class="btn" value="评论">
                    <!--<a href="#">取消</a>-->
                  </div>
                </div>
              </li>
              <li class="ae">
                <div class="img"><a href="#"><img class="am-circle" src="../shop2015/upload/yonghm.jpg"></a></div>
                <div class="text"><span><a href="#">Andy ：</a></span><span>作品很震撼人！之前没有这么认真的去了解过景泰蓝的工艺，更没有关注过中国的非物质文化遗产，总认为这些东西距离我们的生活是那么的远，然而却离我们这麽近，我们应该学会去珍惜它们。</span></div>
                <div class="status ae">
                  <div class="status-left"><span>10分钟前</span></div>
                  <div class="status-right">
                    <div class="hf"><a href="#">回复</a></div>
                    <div class="zan">
                      <a href="#"><i class="icon"></i></a>
                      <em>99999</em>
                    </div>
                  </div>
                </div>
                <div class="review ae" style="display: none;">
                  <textarea></textarea>
                  <div class="btn1 ae">
                    <input type="submit" class="btn" value="评论">
                    <!--<a href="#">取消</a>-->
                  </div>
                </div>
              </li>
            </ul>
            <div class="review ae">
              <textarea></textarea>
              <div class="btn1 ae">
                <input type="submit" class="btn" value="评论">
                <!--<a href="#">取消</a>-->
              </div>
            </div>
          </form>
        </div>
      </div>
      <div class="detaile-right">
        <div class="f-right-gy ae">
          <div class="h4"><span>传承人</span></div>
          <div class="craft-master2">
            <ul class="rf">
              <li>
                <div class="text">
                  <h4>${product.master.fullName}</h4>
                  <p>${product.name}</p>
                  <c:choose>
                    <c:when test="${product.master.level =='1'}">
                      <p><span>国家级传承人</span></p>
                    </c:when>
                    <c:when test="${product.master.level =='2'}">
                      <p><span>省级级传承人</span></p>
                    </c:when>
                    <c:when test="${product.master.level =='3'}">
                      <p><span>市级传承人</span></p>
                    </c:when>
                    <c:otherwise>
                      <p><span>县级传承人</span></p>
                    </c:otherwise>
                  </c:choose>
                  <a class="btn-guan" href="#" onclick="saveMasterFllow('${product.master.id}')">

                    <c:if test="${flag == true}">
                      <input id="saveMasterFllow" type="hidden" value="0">
                      <em>已关注</em>
                    </c:if>
                    <c:if test="${flag == false}">
                      <input id="saveMasterFllow" type="hidden" value="1">
                      <i class="gz-icon"></i><em>关注</em>
                    </c:if>
                  </a>
                </div>
                <div class="img"><img src="${product.master.favicon}"></div>
              </li>
            </ul>
          </div>
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
<!-- //End--footer-->


<script>
  function saveMasterFllow(masterId){
    var val = $("#saveMasterFllow").val();
    var oper;
    if(val=='0'){
      oper="del";
    }else if(val=='1'){
      oper="add";
    }

    $.ajax({
      type:"get",
      url:"/base/attentionMaster.do?masterId="+masterId+"&oper="+oper,//设置请求的脚本地址
      data:"",
      dataType:"json",
      success:function(data){
        if(data=="false"){
          alert("您还未登陆，请登录后再操作");
          return false;
        }
        if(data=="true"){
          $("#"+masterId).html("取消关注");
          return true;
        }
        if(data=="del"){
          $("#"+masterId).html("关注");
          return true;
        }
        if(data=="error"){
          showAlert("提示","未知错误，请联系管理员！！！");
          return false;
        }
      },
      error:function(){

        alert("出错了，请联系管理员！！！");
        return false;
      },
      complete:function(){
        if(oper=="0"){
          var val = $("#saveMasterFllow").val("1");
        }
        if(oper=="1"){
          var val = $("#saveMasterFllow").val("0");
        }
      }
    });
  }


</script>
<!-- //End--footer-->
<!--[if (gte IE 9)|!(IE)]><!-->
<!--<![endif]-->
<!--[if lte IE 8 ]>
<![endif]-->
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>

<!--自定义js--Start-->
<script src="<c:url value='/scripts/assets/pc/js/system.js?v=20150831'/>"></script>
<script src="<c:url value='/scripts/assets/pc/js/cyclopedia.js?v=20150831'/>"></script>
</body>
</html>


