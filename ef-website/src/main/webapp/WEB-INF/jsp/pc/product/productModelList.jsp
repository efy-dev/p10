<%@ page import="com.efeiyi.ec.product.model.ProductModel" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/17
  Time: 9:34
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>【${proName}】-e飞蚁</title>
    <meta name="keywords" content="${proName}" />
    <meta name="description" content="${project.description}" />
</head>
<body>
<!-- //End--header-->
<div class="hd category  product-intro">
    <div class="wh">
  <div class="breadcrumb wh">
    <ol class="am-breadcrumb">
      <li><a href="/">首页</a></li>
      <li class="am-active">${proName}</li>
    </ol>
  </div>
 </div>
  <!-- //End--breadcrumb-->
    <div class="explain" height="22px">
        <div class="title">
            <img src="http://pro.efeiyi.com/${project.picture_url}@!project-pc-view" alt=""/>
        </div>
        <div class="info">
            <%--<c:if test="${fn:length(project.description)>186}">${fn:substring(project.description,0 ,186 )}......</c:if><c:if test="${fn:length(project.description)<=186}">${project.description}</c:if>--%>
                ${project.description}
        </div>
    </div>
  <!-- //End--explain-->
  <div class="shop-sort wh">
      <ul class="link1">

          <li class="active">
              <c:if test="${str==null}">
              <a href="<c:url value="/product/list/${project.id}?sort=desc:price&pageEntity.index=1"/>" title="价  格">价  格</a>
              </c:if>
              <c:if test="${str=='desc'}">
              <a href="<c:url value="/product/list/${project.id}?sort=asc:price&pageEntity.index=1"/>" title="价  格">价  格<i class="icon arrow-down"></i></a>
              </c:if>
              <c:if test="${str=='asc'}">
              <a href="<c:url value="/product/list/${project.id}?sort=desc:price&pageEntity.index=1"/>" title="价  格">价  格<i class="icon arrow-up"></i></a>
               </c:if>
                  </li>
      </ul>
  </div>
  <!-- //End--shop-sort-->

  <c:if test="${productModelList.size()>0}">
      <div class="list-pro">
        <ul class="ul-item">
            <%--<%! int i=0 ;%>--%>
          <c:forEach items="${productModelList}" var="productModel" varStatus="rec">
          <li>
                       <a href="<c:url value="/product/productModel/${productModel.id}"/>" target="_blank" title="">
                       <img class="imgfilter"
                            src="http://pro.efeiyi.com/${productModel.productModel_url}@!product-hot" alt=""/>
                       </a>
                       <%--<%}%>--%>
                <p class="wh name">
                        ${map.get(productModel)}
                </p>
              <p class="wh price">￥${productModel.price}</p>
            </a>
          </li>
          </c:forEach>
        </ul>
        <!-- //End-->
      </div>
  </c:if>

 <div class="page wh">
      <ming800:pcPageList bean="${pageEntity}" url="/product/list/${project.id}">
      <ming800:pcPageParam name="sort"
                           value='<%=request.getParameter("sort")!=null ? request.getParameter("sort") : ""%>'/>
      </ming800:pcPageList>
  </div>

  <!-- //End--footer-->
</div>
<!--[if (gte IE 9)|!(IE)]><!-->
<script href="<c:url value='/scripts/js/jquery.min.js'/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script href="<c:url value='http://libs.baidu.com/jquery/1.11.3/jquery.min.js'/>"></script>
<script href="<c:url value='http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js'/>"></script>
<script href="<c:url value='/scripts/js/amazeui.ie8polyfill.min.js'/>"></script>
<![endif]-->

<script href="<c:url value='/scripts/js/amazeui.min.js'/>"></script>
<script href="<c:url value='/scripts/js/system.js'/>"></script>
</body>
</html>
