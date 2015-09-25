<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/24
  Time: 11:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/layouts/public.jsp" %>
<!doctype html>
<html class="no-js">
<head>
  <title>非遗协会首页</title>
</head>
<body>
<div class="wh home">
  <div class="hd">
    <div class="slide-left">
      <div class="focus">
        <div data-am-widget="slider" class="am-slider am-slider-default" data-am-slider='{"animation":"slide","slideshow":false}' >
          <ul class="am-slides">
            <c:forEach items="${bannerList}" var="banner">
              <li>
                <a href="${banner.directUrl}" target="_blank"><img src="<%=imgBasePath %>${banner.imageUrl}"></a>
                <div class="am-slider-desc">
                  <h3>${banner.title}</h3>
                  <p>这是标题标题标题标题标题标题标题这是标题标题标题标题标题标题标题</p>
                </div>
              </li>
            </c:forEach>
          </ul>
        </div>
      </div>
      <!--//End--am-slider-->
      <div class="wh list-box">
        <div class="list-news">
          <div class="title">非遗要闻</div>
          <ul class="ul-items">
            <c:forEach items="${IndustryList}" var="industry">
              <li>
                <c:if test="${empty industry.documentAttachmentList}">
                  <a href="#" target="_blank" title=""><img src="../shop2015/upload/exp1.jpg" alt=""/></a>
                </c:if>
                <c:if test="${not empty industry.documentAttachmentList}">
                  <c:forEach items="${industry.documentAttachmentList}" var="att" end="0">
                    <a href="#" target="_blank" title=""><img src="${att.path}" alt=""/></a>
                  </c:forEach>
                </c:if>
                <p class="name">${industry.title}</p>
                <p class="info">${industry.sampleContent}</p>
                <a href="#阅读更多" class="btn-more" title="阅读更多">阅读更多</a>
              </li>
            </c:forEach>
          </ul>
        </div>
        <!-- //End---->
        <div class="list-news list-news2">
          <div class="title">重要通知</div>
          <ul class="ul-items">
            <c:forEach items="${NoteList}" var="note">
              <li>
                <c:if test="${empty note.documentAttachmentList}">
                  <a href="#" target="_blank" title=""><img src="../shop2015/upload/exp1.jpg" alt=""/></a>
                </c:if>
                <c:if test="${not empty note.documentAttachmentList}">
                  <c:forEach items="${note.documentAttachmentList}" var="att" end="0">
                    <a href="#" target="_blank" title=""><img src="${att.path}" alt=""/></a>
                  </c:forEach>
                </c:if>
                <p class="name">${note.title}</p>
                <p class="info">${note.sampleContent}</p>
                <a href="#阅读更多" class="btn-more" title="阅读更多">阅读更多</a>
              </li>
            </c:forEach>
          </ul>
        </div>
        <!-- //End---->
      </div>
      <!-- //End---->
      <div class="wh directory">
        <div class="title">非遗名录<a class="btn-more" href="#更多" title="更多">更多</a></div>
        <ul class="list-img-txt">
          <li>
            <a href="" target="_blank" title=""><img src="../shop2015/upload/exp4.jpg" alt=""/></a>
            <p>蓝印花布手工艺</p>
          </li>
          <li>
            <a href="" target="_blank" title=""><img src="../shop2015/upload/exp4.jpg" alt=""/></a>
            <p>蓝印花布手工艺</p>
          </li>
          <li>
            <a href="" target="_blank" title=""><img src="../shop2015/upload/exp4.jpg" alt=""/></a>
            <p>蓝印花布手工艺</p>
          </li>
          <li>
            <a href="" target="_blank" title=""><img src="../shop2015/upload/exp4.jpg" alt=""/></a>
            <p>蓝印花布手工艺</p>
          </li>
        </ul>
        <a href="#上一页" class="btn btn-prev" title="上一页"></a>
        <a href="#下一页" class="btn btn-next" title="下一页"></a>
      </div>
      <!-- //End---->
      <div class="wh data-down">
        <div class="title">资料下载<a class="btn-more" href="#更多" title="更多">更多</a></div>
        <ul class="list-table">
          <li>
            <a href="#" target="_blank" title="国家级非物质文化遗产项目代表性传承人认定与管理暂行办法(2008)">
              <table>
                <tr>
                  <td>国家级非物质文化遗产项目代表性传承人认定与管理暂行办法(2008)</td>
                </tr>
              </table>
            </a>
          </li>
          <li>
            <a href="#" target="_blank" title="中华人民共和国非物质文化遗产法（2011）">
              <table>
                <tr>
                  <td>中华人民共和国非物质文化遗产法（2011）(2008)</td>
                </tr>
              </table>
            </a>
          </li>
          <li>
            <a href="#" target="_blank" title="中华人民共和国非物质文化遗产法（2011）">
              <table>
                <tr>
                  <td>中华人民共和国非物质文化遗产法（2011）</td>
                </tr>
              </table>
            </a>
          </li>
          <li>
            <a href="#" target="_blank" title="中华人民共和国非物质文化遗产法（2011）">
              <table>
                <tr>
                  <td>中华人民共和国非物质文化遗产法（2011）</td>
                </tr>
              </table>
            </a>
          </li>
        </ul>
      </div>
      <!-- //End---->
    </div>
    <!-- //End--slide-right-->
    <div class="slider-right">
      <div class="part">
        <div class="title">非物质文化</div>
        <ul class="ul-list">
          <li>
            <a href="" target="_blank" title=""><img src="../shop2015/upload/exp5.jpg" alt=""/></a>
            <p>建立非遗协会这样国家级的非物质文化遗产构。</p>
            <a class="btn-more" href="#更多" target="_blank" title="更多">更多</a>
          </li>
          <li>
            <a href="" target="_blank" title=""><img src="../shop2015/upload/exp5.jpg" alt=""/></a>
            <p>建立非遗协会这样国家级的非物质文化遗产构。</p>
            <a class="btn-more" href="#更多" target="_blank" title="更多">更多</a>
          </li>
        </ul>
      </div>
      <!-- //End--part1-->
      <div class="part">
        <div class="title">在线服务</div>
        <ul class="ul-list-btn">
          <li><a href="#在线申报" target="_blank" title="在线申报"><i class="icon icon-1"></i>在线申报</a></li>
          <li><a href="#非遗名录" target="_blank" title="非遗名录"><i class="icon icon-2"></i>非遗名录</a></li>
          <li><a href="#法规政策" target="_blank" title="法规政策"><i class="icon icon-3"></i>法规政策</a></li>
          <li><a href="#下属机构" target="_blank" title="下属机构"><i class="icon icon-4"></i>下属机构</a></li>
        </ul>
      </div>
      <!-- //End--part-->
      <div class="part">
        <div class="title">非物质文化</div>
        <ul class="ul-list">
          <li>
            <a href="" target="_blank" title=""><img src="../shop2015/upload/exp6.jpg" alt=""></a>
            <p>姚惠芬-苏绣</p>
          </li>
          <li>
            <a href="" target="_blank" title=""><img src="../shop2015/upload/exp6.jpg" alt=""></a>
            <p>姚惠芬-苏绣</p>
          </li>
        </ul>
      </div>
    </div>
    <!-- //End--slide-right-->
  </div>
</div>
</body>
</html>
