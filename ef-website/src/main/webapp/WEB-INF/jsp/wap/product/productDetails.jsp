<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/24
  Time: 9:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
    <title>商品详情</title>
</head>
<body>

<article class="custom">
    <div data-am-widget="slider" class="am-slider am-slider-a1" data-am-slider='{&quot;directionNav&quot;:false}'>
        <ul class="am-slides">
            <li><img src="http://pro.efeiyi.com/${productModel.productModel_url}@!wap-product-pic"></li>
            <c:forEach items="${productModel.product.productPictureList}" var="picture">
                <c:if test="${picture.status=='1'}">
                <li><img src="http://pro.efeiyi.com/${picture.pictureUrl}@!wap-product-pic"></li>
                </c:if>
            </c:forEach>
        </ul>
    </div>
    <!--//End--am-slider-->
    <div class="bd details">
        <div class="bd des-title">
            <strong class="bd txt">${productModel.product.name}
                <c:forEach
                    items="${productModel.productPropertyValueList}" var="pv">
                ${pv.projectPropertyValue.value}
            </c:forEach> </strong>
            <a href="#分享" class="share">
                <i class="icon icon-share"></i>
                <p>分享</p>
            </a>
            <a id ="show" onclick="collect('${productModel.id}')" class="addfav">
                <i class="icon icon-addfav"></i>

                <p>收藏</p>
            </a>
            <a id ="hidden" style="display: none;" onclick="deCollect('${productModel.id}')" class="addfav addfav-end">
                <i class="icon icon-addfav"></i>
                <p>已收藏</p>
            </a>
        </div>
        <!-- //End--des-title-->
        <div class="des-master">
         <c:if test="${not empty productModel.product.master.id}">
            <p class="p1"><span>${productModel.product.master.fullName}</span>[${productModel.product.master.getMainProjectName().getProject().getName()}]</p>
            <p class="p2"><ming800:status name="level" dataType="Project.level" checkedValue="${productModel.product.master.getMainProjectName().getProject().getLevel()}" type="normal"/>大师</p>
            <p class="img"><img src="http://tenant.efeiyi.com/${productModel.product.master.favicon}@!tanent-details-view"></p>
        </c:if>
        </div>
        <!-- //End--des-master-->
        <div class="bd des-price">
            <c:if test="productModel.marketPrice!=null">
                <p class="bd t1"><span>市场价：</span>
                    <del>${productModel.marketPrice}</del>
                </p>
            </c:if>
            <p class="bd t2"><span>飞蚁价：</span><dfn>￥</dfn><em>${productModel.price}</em></p>
            <p class="bd t3"><span>  服务：</span>由 <a href="<c:url value="/tenantOfMobile/${productModel.product.tenant.id}"/>" style="color: #000">${product.tenant.name}</a>[${product.tenant.address}] 发货并提供售后服务</p>
        </div>
        <!-- //End--des-price-->
        <div class="bd des-format">
            <a id="btn-num" class="bd btn-num">
                <span class="select">数量</span>
                <span class="add-sub">
                    <em class="sub btn-cart-no" onclick="subtractProduct()" href="#"></em>
                    <input id = "value" class="ipt-txt" type="text" value="1">
                    <em class="add" onclick="addProduct()" href="#"></em>
                </span>
            </a>
        </div>
        <%--<div class="bd des-price">--%>
            <%--<p class="bd p-price"><span>价格：</span><em>￥</em><strong>${productModel.price()}</strong></p>--%>

            <%--<p class="bd express">快递：0（飞蚁包邮）</p>--%>
        <%--</div>--%>
        <!-- //End--des-price-->
        <c:if test="${fn:length(productModelList)>1}">
        <div class="bd des-format">
            <a data-am-modal="{target: '#my-actions'}" style="color: #000" class="bd btn-format" title="选择规格">选择规格<i
                    class="arrow-right"></i></a>
        </div>
        </c:if>
        <!-- //End--des-format-->
        <div class="des-content">
            <div class="bd title">详情</div>
            <div class="bd">
                <c:if test="${!empty product.productDescription}">
                    ${product.productDescription.content}
                </c:if>
                <c:if test="${not empty purchaseOrderProductList}">
                    <div class="discuss">
                        <div class="bd dis-title">【顾客评论】</div>
                        <ul class="ul-list">
                            <c:forEach items="${purchaseOrderProductList}" var="purchaseOrderProduct" varStatus="rec">
                                <li class="item">
                                    <div class="user-info">
                                        <img id="personPhoto${rec.index}" src="/scripts/upload/yonghm.jpg">
                                        <c:set var="user">
                                            ${purchaseOrderProduct.purchaseOrder.user.getUsername()}
                                        </c:set>
                                        <p class="name">${fn:substring(user, 0,3 )}*****${fn:substring(user,7,11)}</p>
                                            <%--<p class="time">2015-10-12   16:16</p>--%>
                                    </div>
                                    <div class="seller">
                                        <p class="ask">
                                            <c:if test="${not empty purchaseOrderProduct.purchaseOrderComment}">
                                                ${purchaseOrderProduct.purchaseOrderComment.content}
                                            </c:if>
                                        </p>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                        </ul>
                    </div>
                    <!-- //End--box-des-->
                </c:if>
            </div>

        </div>

        <!-- //End--des-format-->
    </div>
    <!-- //End---->
    <div class="bd details-total-bar">
      <c:if test="${empty productModel.product.tenant.id}">
          <a class="btn-default" title="进店">进店</a>
      </c:if>
     <c:if test="${not empty productModel.product.tenant.id}">
         <a class="btn-default" href="<c:url value="/tenantOfMobile/${productModel.product.tenant.id}"/>" title="进店">进店</a>
     </c:if>
        <a class="btn-default" target="_blank"  title="咨询">咨询</a>
        <c:if test="${productModel.amount<=0}">
            <a class="btn-cart" title="放入购物车"><i class="icon"></i>放入购物车</a>
            <a class="btn-buy" title="售罄">售罄</a>
        </c:if>
        <c:if test="${productModel.amount>0}">
            <a class="btn-cart"  onclick="addCart('${productModel.id}')"  title="放入购物车"><i class="icon"></i>放入购物车</a>
            <a class="btn-buy"   onclick="immediateBuy('${productModel.id}')" title="立即购买">立即购买</a>
        </c:if>
    </div>
</article>
<div class="am-modal-actions dialog-des-format" id="my-actions" style="display: none;">
    <div class="format-error">请选择商品规格</div>
    <div class="bd ">
        <ul class="bd ul-nav">
            <c:if test="${fn:length(productModelList) >1}">
                <c:forEach items="${productModel.product.productModelList}" var="pm">
                    <li> <a href="<c:url value="/product/productModel/${pm.id}"/> " style="color: #000">
                            ${pm.name}
                            <%--${pm.product.name} <c:forEach--%>
                            <%--items="${pm.productPropertyValueList}" var="pv">--%>
                        <%--${pv.projectPropertyValue.value}--%>
                    <%--</c:forEach>--%>
                    </a></li>
                </c:forEach>
            </c:if>
            <%--<li><a href="#规格2">规格2</a></li>--%>
            <%--<li><a href="#规格1">规格1</a></li>--%>
            <%--<li><a href="#规格2">规格2</a></li>--%>
        </ul>
        <%--<ul class="bd ul-amount">--%>
        <%--<li>购买数量</li>--%>
        <%--<li>--%>
        <%--<a class="sub btn-cart-no" href="#减"></a>--%>
        <%--<input class="ipt-txt" type="text" value="1"/>--%>
        <%--<a class="add" href="#加"></a>--%>
        <%--</li>--%>
        <%--</ul>--%>
        <%--<c:if test="${productModel.amount <= 0}">--%>
            <%--<a  class="bd btn-cart">缺货</a>--%>
        <%--</c:if>--%>
        <%--<c:if test="${productModel.amount > 0}">--%>
            <%--<a class="bd btn-cart" href="<c:url value="/cart/addProduct.do?id=${productModel.id}"/>" >加 入 购 物 车</a>--%>
        <%--</c:if>--%>
    </div>
</div>
<div class="am-dimmer am-active" data-am-dimmer="" style="display: none;"></div>
<script type="text/javascript">
    function collect(o) {
        style = "visibility: none;"
        $.ajax({
            type: 'post',
            async: false,
            url: '<c:url value="/product/addProductFavorite.do?id="/>' + o,
            dataType: 'json',
            success: function (data) {
                if (data == false) {
                    window.location.href = "<c:url value="/sso.do"/>";
                } else {
//                    document.getElementById("show").style.visibility = "hidden";
//                    document.getElementById("hidden").style.visibility = "visible";
                    $("#show").hide();
                    $("#hidden").show();
                }
            },
        });
    }
</script>
<%--<script>--%>
    <%--$(function(){--%>
        <%--$('.btn-cart,.btn-format,.btn-buy').click(function(){--%>
            <%--$('.dialog-des-format').css({'-webkit-transform':'translateY(0)'});--%>
            <%--$('.am-dimmer').show();--%>
            <%--$('.am-active').click(function(){--%>
                <%--$('.dialog-des-format').css({'-webkit-transform':'translateY(110%)'});--%>
                <%--$('.am-dimmer').hide();--%>
            <%--})--%>
            <%--return false;--%>
        <%--})--%>
    <%--})--%>
<%--</script>--%>
<script type="text/javascript">
    $().ready(function(){
        ajaxRequest("<c:url value="/product/favorite/productFavoriteStatus.do"/>",{"id":"${productModel.id}"},function(data){
            if(data){
                $("#show").hide();
                $("#hidden").show();
            }else{
                $("#show").show();
                $("#hidden").hide();
            }
        },function(){},"get")
    })
</script>
<script type="text/javascript">
    function deCollect(o) {
        $.ajax({
            type: 'post',
            async: false,
            url: '<c:url value="/product/removeProductFavorite.do?id="/>' + o,
            dataType: 'json',
            success: function (data) {
                if (data == false) {
                    window.location.href = "<c:url value="/sso.do"/>";
                } else {
//                    document.getElementById("show").style.visibility = "visible";
//                    document.getElementById("hidden").style.visibility = "hidden";
                    $("#show").show();
                    $("#hidden").hide();
                }
            },
        });
    }

    function subtractProduct() {
        var t = $("#value");
        if(t.val()<=1){
            document.getElementById("classid").value = 1;
        }
        t.val(parseInt(t.val())-1)
    }
    function addProduct() {
        var t = $("#value");
        t.val(parseInt(t.val())+1)
    }

    function addCart(o){
        var t = document.getElementById("value").value;
        window.location.href = "<c:url value="/cart/addProduct.do?id="/>"+o +"&amount="+ t+"&redirect=/product/productModel/"+o;
    }
    function immediateBuy(o){
        var t = document.getElementById("value").value;
        window.location.href = "<c:url value=""/>"+"/order/easyBuy/"+o +"?amount="+ t;
    }
</script>
<!--[if (gte IE 9)|!(IE)]><!-->
<script type='text/javascript'>
    (function(m, ei, q, i, a, j, s) {
        m[a] = m[a] || function() {
                    (m[a].a = m[a].a || []).push(arguments)
                };
        j = ei.createElement(q),
                s = ei.getElementsByTagName(q)[0];
        j.async = true;
        j.src = i;
        s.parentNode.insertBefore(j, s)
    })(window, document, 'script', '//eco-api.meiqia.com/dist/meiqia.js', '_MEIQIA');
    _MEIQIA('entId', 486);
    $().ready(function(){
        $("img").each(function(){
            $(this).css("width","100%");
        })
        $("img").each(function(){
            var length = ${fn:length(productModelList)};
            for (var i=0; i<length; i++)
            {
                $('#personPhoto'+i).css("width","auto");
            }

        })

    })
</script>
</body>


</html>
