<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/29
  Time: 11:01
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
</head>
<body>
<!-- //End--header-->
<div class="hd product-intro">
  <div class="wh">
    <ol class="am-breadcrumb">
      <li><a href="/">首页</a></li>
      <li><a href="#">分类</a></li>
      <li class="am-active">内容</li>
    </ol>
  </div>
  <!-- //End--面包屑-->
  <div class="wh itemInfo">
    <div class="preview">
      <div class="collect" onclick="getStatus('${productModel.id}')">  <i class="icon" > </i> <span class="hover" id="collection" >收藏</span><span class="active">已收藏</span>  </div>
      <%--<div class="collect" > <a <a onclick="getStatus('${productModel.id}')"> method="post"/> <i class="icon"></i></a><span class="hover">收藏</span></div>--%>
      <div class="slider-img">
        <ul>
          <%--<c:if test="${productPicture.status=='2'}">--%>
          <li class="active"><img src="http://pro.efeiyi.com/${productModel.productModel_url}@!product-detail-pc-view"
                                  alt=""/></li>
          <%--</c:if>--%>
          <c:forEach items="${productPictures}" var="productPicture" varStatus="rec">
            <c:if test="${productPicture.status=='1'}">
              <li class="active"><img src="http://pro.efeiyi.com/${productPicture.pictureUrl}@!product-detail-pc-view"
                                      alt=""/></li>
            </c:if>
          </c:forEach>
        </ul>
      </div>
      <!-- //End--sliderimg-->
      <div class="slider-main">
        <ul>
         <%--<c:if test="${productPicture.status=='2'}">--%>
          <li>
            <a href="<c:url value="http://${product.master.name}.efeiyi.com"/>" target="_blank" title="">
            <img src="http://pro.efeiyi.com/${productModel.productModel_url}@!product-details-picture"  alt=""/>
            </a>
          </li>
         <%--</c:if>--%>
          <c:forEach items="${productPictures}" var="productPicture" varStatus="rec">
            <c:if test="${productPicture.status=='1'}">
            <li>
              <a href="<c:url value="http://${product.master.name}.efeiyi.com"/>" target="_blank" title="">
              <img src="http://pro.efeiyi.com/${productPicture.pictureUrl}@!product-details-picture"  alt=""/>
              </a>
            </li>
            </c:if>
          </c:forEach>
        </ul>
      </div>
      <!-- //End--slider-main-->
    </div>
    <!-- //End--des-focus-->
    <div class="itme-ext">
      <div class="name">
        <p>${product.master.fullName}</p>
        <p><strong>${product.name}</strong></p>
      </div>
      <!-- //End-->
      <div class="des">
        <ul class="ul-list">
          <c:forEach items="${productModelList}" var="productModelTmp" varStatus="rec">
            <%--<c:if test="${productModel.id == productModelTmp.id}">--%>
              <%--<li class="active" >--%>
                <%--<a href="/product/productModel/${productModelTmp.id}">--%>
                  <%--<c:forEach items="${productModelTmp.productPropertyValueList}" var="productPropertyValue" varStatus="rec">--%>
                    <%--${productPropertyValue.projectPropertyValue.value}--%>
                  <%--</c:forEach>--%>
                    <%--${product.name}</a>--%>
              <%--</li>--%>
            <%--</c:if>--%>
            <c:if test="${productModel.id != productModelTmp.id}">
              <li class="">
                <a href="/product/productModel/${productModelTmp.id}">
                  <c:forEach items="${productModelTmp.productPropertyValueList}" var="productPropertyValue" varStatus="rec">
                    ${productPropertyValue.projectPropertyValue.value}
                  </c:forEach>
                    ${product.name}</a>
              </li>
            </c:if>


          </c:forEach>
        </ul>
      </div>
      <!-- //End-->
      <%--<div class="amount">--%>
        <%--<div class="ipt">--%>
          <%--<input class="txt" type="text" value=${productModel.amount}/><em class="ge">个</em>--%>
        <%--</div>--%>
        <%--<div class="btns">--%>
          <%--<a href="#btn-add" class="btn-add" title="加">+</a>--%>
          <%--<a href="#btn-sub" class="btn-sub" title="减">-</a>--%>
        <%--</div>--%>
      <%--</div>--%>
      <!-- //End-->
      <div class="price">
        <div class="p-text">飞蚁价：</div>
        <div class="p-price"><em>￥</em><span>${productModel.price}</span></div>
        <div class="m-price">市场价：￥${productModel.marketPrice}</div>
      </div>
      <!-- //End-->

      <div class="choose-btns">
         <c:if test="${productModel.amount == 0}">
         <a id ="modelId" class="btn btn-append"  title="缺货">缺货</a>
         </c:if>
        <c:if test="${productModel.amount != 0}">
          <a id ="modelId" class="btn btn-append"  href="<c:url value="/cart/addProduct.do?id=${productModel.id}"/>" title="放入购物车" dis>放入购物车</a>
          <a class="btn btn-buy" href="<c:url value="/order/easyBuy/${productModel.id}"/>" title="立即购买" disabled="disabled" >立即购买</a>
        </c:if>
        <!-- JiaThis Button BEGIN -->
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
          <%--<li><a href="#feeling" title="大师感悟">大 师 感 悟<i class="icon"></i></a></li>--%>
          <%--<li><a href="#" title="商品评价">商 品 评 价<i class="icon"></i></a></li>--%>
          <%--<li><a href="#" title="服务保障">服 务 保 障<i class="icon"></i></a></li>--%>
          <li><a href="<c:url value="/tenant/${product.tenant.id}"/>" title="同店精品">进 入 店 铺</a></li>
        </ul>
      </div>
      <!-- //End-->
      <div class="btns">
     <c:if test="${productModel.amount != 0}">
        <a class="buy" href="/order/easyBuy/${productModel.id}" title="立即购买">立 即 购 买</a>
        <a class="append" href="<c:url value="/cart/addProduct.do?id=${productModel.id}"/>" title="放入购物车"><i class="icon"></i>放 入 购 物 车</a>
     </c:if>
      </div>
    </div>
  </div>
  <div class="wh detail" id="detail">
    <div class="wh title"><h3>商品详情</h3></div>
      <div class="wh part">
      ${product.productDescription.content}
    </div>
    <div class="online-ask">
      <a href="" class="btn"><i class="icon"></i>在线咨询</a>
    </div>
  </div>
</div>
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="/scripts/js/jquery.min.js"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="/scripts/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script src="/scripts/js/amazeui.min.js"></script>
<script src="/scripts/js/system.js"></script>
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js?uid=" charset="utf-8"></script>
<script type="text/javascript">
  function getStatus(o) {
    $.ajax({
      type: 'post',
      async: false,
      url: '<c:url value="/product/addProductFavorite.do?id="/>' + o,
      dataType: 'json',
      success: function (data) {
        if(data==true){
        }
      },
    });
  }
</script>
</body>
</html>









