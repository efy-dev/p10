<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head></head>
<body>
<!--内容-->

<!--作品-->
<div id="page-nav">
  <p><a href="#">首页</a><span>作品</span></p>
</div>
<div class="border-nav"></div>
<!--作品内容-->
<div id="center--1">
  <div class="center-buttom">
    <h1>当前标签</h1>
    <div class="buttom-zx">
      <div class="buttom-zx-tr">
        <ul class="buttom-zx-td-1">
          <li class="buttom-zx-td-left"></li>
          <li class="buttom-zx-td-center">
            <div class="buttom-zx-td-border-1"></div>
            <div class="buttom-zx-td-center-1"><a href="#">2015</a></div>
            <div class="buttom-zx-td-border-2"></div>
          </li>
          <li class="buttom-zx-td-right"></li>
        </ul>
        <ul class="buttom-zx-td-2">
          <li class="buttom-zx-td-left"></li>
          <li class="buttom-zx-td-center">
            <div class="buttom-zx-td-border-1"></div>
            <div class="buttom-zx-td-center-1"><a href="#">代表作</a></div>
            <div class="buttom-zx-td-border-2"></div>
          </li>
          <li class="buttom-zx-td-right"></li>
        </ul>
      </div>
      <div class="buttom-zx-tr-2">
        <ul class="buttom-zx-td-3">
          <li class="buttom-zx-td-left"></li>
          <li class="buttom-zx-td-center">
            <div class="buttom-zx-td-border-1"></div>
            <div class="buttom-zx-td-center-1"><a href="#">人物版画</a></div>
            <div class="buttom-zx-td-border-2"></div>
          </li>
          <li class="buttom-zx-td-right"></li>
        </ul>
        <ul class="buttom-zx-td-2">
          <li class="buttom-zx-td-left"></li>
          <li class="buttom-zx-td-center">
            <div class="buttom-zx-td-border-1"></div>
            <div class="buttom-zx-td-center-1"><a href="#">大师画像</a></div>
            <div class="buttom-zx-td-border-2"></div>
          </li>
          <li class="buttom-zx-td-right">

          </li>
        </ul>
      </div>
      <div class="buttom-zx-tr-2">
        <ul class="buttom-zx-td-4">
          <li class="buttom-zx-td-left"></li>
          <li class="buttom-zx-td-center">
            <div class="buttom-zx-td-border-1"></div>
            <div class="buttom-zx-td-center-1"><a href="#">知名获奖作品</a></div>
            <div class="buttom-zx-td-border-2"></div>
          </li>
          <li class="buttom-zx-td-right">

          </li>
        </ul>
      </div>
    </div>
  </div>
  <div class="center-right">
    <c:forEach items="${productList}" var="product" varStatus="vs">
      <c:if test="${productList.size()-1 != vs.index && vs.index%3 == 0}">
        <div class="works-container">
          <a href="<c:url value="/tenantProduct/getProduct.do?productId=${product.id}"/>"><img src="<c:url value="/scripts/assets/images/img10.jpg"/>" class="works-img"></a>
        </c:if>
       <c:if test="${productList.size()-1 != vs.index && vs.index%3==1}">
         <a href="<c:url value="/tenantProduct/getProduct.do?productId=${product.id}"/>"><img src="<c:url value="/scripts/assets/images/img10.jpg"/>" class="works-img"></a>
       </c:if>
      <c:if test="${ vs.index%3==2}">
          <a href="<c:url value="/tenantProduct/getProduct.do?productId=${product.id}"/>"><img src="<c:url value="/scripts/assets/images/img10.jpg"/>" class="works-img-1"></a>
    </div>
      </c:if>
      <c:if test="${productList.size()-1 == vs.index && vs.index%3 == 0}">
      <div class="works-container">
        <a href="<c:url value="/tenantProduct/getProduct.do?productId=${product.id}"/>"><img src="<c:url value="/scripts/assets/images/img10.jpg"/>" class="works-img"></a>
        </div>
      </c:if>
      <c:if test="${productList.size()-1 == vs.index && vs.index%3 == 1}">
      <a href="<c:url value="/tenantProduct/getProduct.do?productId=${product.id}"/>"><img src="<c:url value="/scripts/assets/images/img10.jpg"/>" class="works-img"></a>
        </div>
      </c:if>
      </c:forEach>
    <!--页码-->

  </div>
</div>
<ming800:pcPageList bean="${pageEntity}" url="/tenantProduct/tenantProductList.do">
  <%--<ming800:page-param2 name="qm" value="${requestScope.qm}"/>--%>
  <ming800:pcPageParam name="conditions"
                       value='<%=request.getParameter("conditions")!=null ? request.getParameter("conditions") : ""%>'/>
  <ming800:pcPageParam name="sort"
                       value='<%=request.getParameter("sort")!=null ? request.getParameter("sort") : ""%>'/>
</ming800:pcPageList>
<!--其他内容-->
<div id="footer">
  <ul class="guild">
    <li><a href="#"><img src="<c:url value="/scripts/assets/images/i/fybk.jpg"/>"></a></li>
    <li><a href="#"><img src="<c:url value="/scripts/assets/images/i/efeiyi.jpg"/>"></a></li>
    <li><a href="#"><img src="<c:url value="/scripts/assets/images/i/cpb.jpg"/>"></a></li>
    <li><a href="#"><img src="<c:url value="/scripts/assets/images/i/gl.jpg"/>"></a></li>
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
      <span ></span>
      <div class="floating_left floating_ewm floating_left-1">
        <i><img src="/scripts/assets/images/images/img6_03.jpg"></i>
      </div>
    </dd>
    <dd class="quote">
      <span>分享</span>
      <div class="floating_left">
        <a href="#" class="float-a"><img src="<c:url value="/scripts/assets/images/i/wx.gif"/>"></a>
        <a href="#" class="float-a"><img src="<c:url value="/scripts/assets/images/i/wqq.gif"/>"></a>
        <a href="#" class="float-a"><img src="<c:url value="/scripts/assets/images/i/kj.gif"/>"></a>
        <a href="#" class="float-a"><img src="<c:url value="/scripts/assets/images/i/xl.gif"/>"></a>
        <a href="#" class="float-a"><img src="<c:url value="/scripts/assets/images/i/qq.gif"/>"></a>
      </div>
    </dd>


  </dl>
</div>
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="js/jquery.min.js"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js/"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script src="js/amazeui.min.js"></script>

</body>
</html>