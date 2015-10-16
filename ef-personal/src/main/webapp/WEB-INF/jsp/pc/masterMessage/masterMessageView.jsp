<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>大师动态-单图</title>
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
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/pc/css/leader.css?v=20150831'/>">
  <script src="<c:url value='/scripts/assets/pc/js/jquery.min.js'/> "></script>
</head>
<body style="float: left">
<div class="topbar wh" data-am-sticky>
  <div class="hd">
    <ul class="ul-item">
      <li><strong>李先生8899</strong><a href="" title="退出">退出</a></li>
      <!--<li><a href="" title="请登录">请登录</a></li>-->
      <li><a href="" title="快速注册">快速注册</a></li>
      <li class="btn-top-wechat">
        <a title="手机e飞蚁">手机e飞蚁</a>
        <span class="top-wechat"></span>
      </li>
      <li><a href="" title="个人中心">个人中心</a></li>
    </ul>
  </div>
</div>
<!-- //End--topbar-->
<div class="header wh">
  <div class="hd">
    <div class="logo"><a class="icon" href="" target="_blank" title="e飞蚁-爱非遗"></a></div>
    <div class="nav">
      <ul>
        <li><a href="" title="首页">e飞蚁首页</a></li>
        <li><a href="" title="传承人">大师</a></li>
        <li><a href="" title="展览">工艺</a></li>
      </ul>
    </div>
  </div>
</div>
<!-- //End--header-->
<div class="list-find">
  <div class="list-f-title">
    <p><a>大师</a><i class="fu-icon"></i><a>动态</a><i class="fu-icon"></i><span>动态详情</span></p>
  </div>
  <div class="ae">
    <div class="details ae">
      <div class="detaile-left">
        <P>${msg.content}</P>
        <c:if test="${!empty msg.messageAttachmentLists}">
          <c:forEach items="${msg.messageAttachmentLists}" var="att">
            <div class="detaile-img"><a href="#"><img src="${att.pictureUrl}"></a></div>
          </c:forEach>
        </c:if>
          <div class="detaile-share ae" style="height: auto">
          <!-- JiaThis Button BEGIN -->
          <div class="jiathis_style" style="background: #fff;border: 0;float: left;padding: 30px 0;">
            <a class="jiathis_button_weixin"></a>
            <a class="jiathis_button_tqq"></a>
            <a class="jiathis_button_tsina"></a>
            <a class="jiathis_button_cqq"></a>
          </div>
          <!-- JiaThis Button END -->
          <div class="thumb-up">
            <div class="thump-collect">
              <a href="#"><i class="s-icon"></i> </a>
              <a href="#"><em>收藏</em></a>
            </div>
            <div class="thump-assist">
              <a href="#"><i class="z-icon"></i> </a>
              <a onclick="praiseMessage(this,'${msg.id}');"><em>赞${msg.praiseNum}</em></a>
            </div>
          </div>
        </div>
        <!--评论-->
        <div class="detaile-comment ae">
          <form>
            <h4>评论</h4>
            <ul class="comment ae">
              <c:if test="${!empty commentList}">
                <c:forEach items="${commentList}" var="comm">
                  <c:if test="${comm.fatherComment.id == '0'}">
                    <li class="ae">
                      <div class="img"><a href="#"><img class="am-circle" src="../shop2015/upload/yonghm.jpg"></a></div>
                      <div class="text"><span><a href="#">${comm.user.name2} ：</a></span><span>${comm.content}</span></div>
                      <div class="status ae">
                        <div class="status-left"><span>10分钟前</span></div>
                        <div class="status-right">
                          <div class="hf"><a href="#">回复</a></div>
                          <div class="zan">
                            <a href="#"><i class="icon"></i></a>
                            <em>${comm.amount}</em>
                          </div>
                        </div>
                        <ul class="add-obtain">
                          <c:if test="${!empty comm.subComment}">
                            <c:forEach items="${comm.subComment}" var="sub">
                              <li style="margin: 0;border-bottom: 0;" class="obtain">
                                <div class="ae">
                                  <div class="img"><a href="#"><img class="am-circle" src="../shop2015/upload/yonghm.jpg"></a></div>
                                  <div class="text"><span><a href="#">${sub.user.name2} 回复 ${sub.fatherComment.user.name2}：</a></span><span>${sub.content}</span></div>
                                  <div class="status ae">
                                    <div class="status-left"><span>10分钟前</span></div>
                                    <div class="status-right">
                                      <div class="ef"><a href="#">回复</a></div>
                                      <div class="zan">
                                        <a href="#"><i class="icon"></i> <em>${sub.amount}</em></a>

                                      </div>
                                    </div>
                                  </div>
                                  <div class="review-sr ae" style="display: none;">
                                    <textarea></textarea>
                                    <div class="btn1 ae">
                                      <input type="button" class="btn" value="评论">
                                      <!--<a href="#">取消</a>-->
                                    </div>
                                  </div>
                                </div>
                              </li>
                            </c:forEach>
                          </c:if>
                        </ul>
                        <div class="review ae" style="display: none;">
                          <textarea></textarea>
                          <div class="btn1 ae">
                            <input type="submit" class="btn" value="评论">
                          </div>
                        </div>
                      </div>
                    </li>
                  </c:if>
                </c:forEach>
              </c:if>
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
                  <h4>${msg.master.fullName}</h4>
                  <p>${msg.master.projectName}</p>
                  <p><span>国家级传承人</span></p>
                  <a class="btn-guan" href="#"><i class="gz-icon"></i><em>关注</em></a>
                </div>
                <div class="img"><img src="../shop2015/upload/pep-2.jpg"></div>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- //End--list-find-->
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
  function praiseMessage(o,msgId){
    $.ajax({
      type: "get",//设置get请求方式
      url: "<c:url value='/masterMessage/praiseMessage.do'/>",//设置请求的脚本地址
      data: "msgId="+msgId,//设置请求的数据
      async: true,
      dataType: "json",//设置请求返回的数据格式
      success: function (data) {
        if(data =="noRole"){
          alert("您还没有登录,请登录后操作!");
        }else if(data == "add"){
          alert("成功!");
        }else if(data == "del"){
          alert("已取消点赞");
        }
      }
    })
  }
</script>
<!-- //End--footer-->

<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value='/scripts/assets/pc/js/amazeui.ie8polyfill.min.js'/>"></script>
<![endif]-->
<script src="<c:url value='/scripts/assets/pc/js/system.js'/>"></script>
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
<script src="<c:url value='/scripts/assets/pc/js/cyclopedia.js'/>"></script>
</body>
</html>

