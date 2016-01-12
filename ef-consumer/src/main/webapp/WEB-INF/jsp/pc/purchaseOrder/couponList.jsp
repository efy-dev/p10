<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="now" class="java.util.Date" />
<!doctype html>
<html class="no-js">
<head></head>
<body>
<!-- //End--header-->
<!--content-->
<div class="layout-col">
    <!--套用amazeui的选项卡插件-->
    <div class="my-kj">
        <div class="am-tabs-nav">
            <ul class="ul-list">
                <li class="items1 "><a href="<c:url value="/coupon/list?cf=1"/>">可&nbsp使&nbsp用</a></li>
                <li class="items1"><a href="<c:url value="/coupon/list?cf=2"/>">不&nbsp可&nbsp用</a></li>
                <li class="items1"><a href="<c:url value="/coupon/list?cf=3"/>">已&nbsp使&nbsp用</a></li>
                <li class="items2"><a id="coupon-dialog">优惠券兑换</a>
                    <div style="display: none" class="ytacu" id="tk">
                        <div class="dh">
                            <form>
                                <div class="exchange">
                                    <label>请输入您的兑换码</label>
                                    <input type="text" name="cdkey" id="cdkey"/>
                                </div>
                                <p id="tx"></p>
                                <i class="no"></i>
                                <input class="btn" type="button" onclick="exchangeCoupon()" value="马上领取">
                            </form>
                        </div>
                        <div class="bg"></div>
                    </div>
                    <div style="display: none" class="ytacu" id="ytacu2">

                    </div>
                </li>
            </ul>

            <div class="am-tabs-bd">
                <div class="am-tab-panel am-active">

                    <c:set var="td" >
                        <fmt:formatDate value="${now}" type="both" dateStyle="long" pattern="yyyy-MM-dd" />
                    </c:set>

                    <c:forEach items="${couponList}" var="coupon">
                        <c:set var="ed">
                            <fmt:formatDate value="${coupon.couponBatch.endDate}" pattern='yyyy-MM-dd' />
                        </c:set>
                        <c:set var="sd">
                            <fmt:formatDate value="${coupon.couponBatch.startDate}" pattern='yyyy-MM-dd'/>
                        </c:set>
                        <c:if test="${td<sd || td>ed && employ=='unUse'}">
                       <div class="serial-list-page">
                        <div class="list-hd">
                            <span>券编号:${coupon.serial}</span>
                        </div>
                        <div class="list-zq">
                            <ul class="serial-list">
                                <li class="list1"><em class="bg1"></em><strong>
                                    <c:set var="price" value="${coupon.couponBatch.price}"/>
                                        ${fn:substringBefore(price, ".")}
                                </strong><span>
                                <c:choose>
                                    <c:when test="${coupon.couponBatch.type==1}">
                                     满减券
                                    </c:when>
                                    <c:when test="${coupon.couponBatch.type==2}">
                                        现金券
                                    </c:when>
                                </c:choose>
                                </span></li>
                                <li class="list2">
                                    <c:choose>
                                        <c:when test="${coupon.couponBatch.range ==1}">
                                            <p>全场通用</p>
                                        </c:when>
                                        <c:when test="${coupon.couponBatch.range ==2}">
                                            <p>限购 [${coupon.couponBatch.project.name}] 类商品</p>

                                        </c:when>
                                        <c:when test="${coupon.couponBatch.range ==3}">
                                            <p>限购 [${coupon.couponBatch.tenant.name}] 店铺商品</p>
                                        </c:when>
                                        <c:when test="${coupon.couponBatch.range ==4}">
                                            <p>限购 [${coupon.couponBatch.tenant.name}] 店铺商品</p>
                                        </c:when>
                                            </c:choose>
                                    <c:if test="${coupon.couponBatch.type==1}">
                                        <p>一次性消费满${coupon.couponBatch.priceLimit}元即可使用</p>
                                    </c:if>
                                    <p>期限：
                                        <fmt:formatDate value="${coupon.couponBatch.startDate}" pattern='yyyy.MM.dd'/>
                                    -<fmt:formatDate value="${coupon.couponBatch.endDate}" pattern='yyyy.MM.dd' /></p>
                                </li>
                                <li class="list3">
                                    <p>  <a href="#" onclick="showConfirm('提示','是否确定删除',function(){
                                            window.location.href='<c:url value="/remove/coupon.do?couponId=${coupon.id}&cf=2"/>';
                                            })">删除</a></p>
                                </li>
                            </ul>
                        </div>
                    </div>
                        </c:if>
                        <c:if test="${sd<=td && td<=ed && employ=='use'}">
                            <div class="serial-list-page">
                                <div class="list-hd">
                                    <span>券编号:${coupon.serial}</span>
                                </div>
                                <div class="list-zq">
                                    <ul class="serial-list">
                                        <li class="list1"><em class="bg1"></em><strong>
                                            <c:set var="price" value="${coupon.couponBatch.price}"/>
                                                ${fn:substringBefore(price, ".")}
                                        </strong><span>
                                <c:choose>
                                    <c:when test="${coupon.couponBatch.type==1}">
                                        满减券
                                    </c:when>
                                    <c:when test="${coupon.couponBatch.type==2}">
                                        现金券
                                    </c:when>
                                </c:choose>
                                </span></li>
                                        <li class="list2">
                                            <c:choose>
                                                <c:when test="${coupon.couponBatch.range ==1}">
                                                    <p>全场通用</p>
                                                </c:when>
                                                <c:when test="${coupon.couponBatch.range ==2}">
                                                    <p>限购 [${coupon.couponBatch.project.name}] 类商品</p>

                                                </c:when>
                                                <c:when test="${coupon.couponBatch.range ==3}">
                                                    <p>限购 [${coupon.couponBatch.tenant.name}] 店铺商品</p>

                                                </c:when>
                                                <c:when test="${coupon.couponBatch.range ==4}">
                                                    <p>限购 [${coupon.couponBatch.product.name}] 商品</p>

                                                </c:when>
                                            </c:choose>
                                            <c:if test="${coupon.couponBatch.type==1}">
                                                <p>一次性消费满${coupon.couponBatch.priceLimit}元即可使用</p>
                                            </c:if>
                                            <p>期限：
                                                <fmt:formatDate value="${coupon.couponBatch.startDate}" pattern='yyyy.MM.dd'/>
                                                -<fmt:formatDate value="${coupon.couponBatch.endDate}" pattern='yyyy.MM.dd' /></p>
                                        </li>
                                        <li class="list3">
                                            <p>  <a href="#" onclick="showConfirm('提示','是否确定删除',function(){
                                                    window.location.href='<c:url value="/remove/coupon.do?couponId=${coupon.id}&cf=1"/>';
                                                    })">删除</a></p>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </c:if>

                        <c:if test="${employ=='ue'}">
                        <div class="serial-list-page">
                            <div class="list-hd">
                                <span>券编号:${coupon.serial}</span>
                            </div>
                            <div class="list-zq">
                                <ul class="serial-list">
                                    <li class="list1"><em class="bg1"></em><strong>
                                        <c:set var="price" value="${coupon.couponBatch.price}"/>
                                            ${fn:substringBefore(price, ".")}
                                    </strong><span>
                                <c:choose>
                                    <c:when test="${coupon.couponBatch.type==1}">
                                        满减券
                                    </c:when>
                                    <c:when test="${coupon.couponBatch.type==2}">
                                        现金券
                                    </c:when>
                                </c:choose>
                                </span></li>
                                    <li class="list2">
                                        <c:choose>
                                            <c:when test="${coupon.couponBatch.range ==1}">
                                                <p>全场通用</p>
                                            </c:when>
                                            <c:when test="${coupon.couponBatch.range ==2}">
                                                <p>限购 [${coupon.couponBatch.project.name}] 类商品</p>

                                            </c:when>
                                            <c:when test="${coupon.couponBatch.range ==3}">
                                                <p>限购 [${coupon.couponBatch.tenant.name}] 店铺商品</p>

                                            </c:when>
                                            <c:when test="${coupon.couponBatch.range ==4}">
                                                <p>限购 [${coupon.couponBatch.tenant.name}] 店铺商品</p>

                                            </c:when>
                                        </c:choose>
                                        <c:if test="${coupon.couponBatch.type==1}">
                                            <p>一次性消费满${coupon.couponBatch.priceLimit}元即可使用</p>
                                        </c:if>
                                        <p>期限：
                                            <fmt:formatDate value="${coupon.couponBatch.startDate}" pattern='yyyy.MM.dd'/>
                                            -<fmt:formatDate value="${coupon.couponBatch.endDate}" pattern='yyyy.MM.dd' /></p>
                                    </li>
                                    <li class="list3">
                                        <p>  <a href="#" onclick="showConfirm('提示','是否确定删除',function(){
                                                window.location.href='<c:url value="/remove/coupon.do?couponId=${coupon.id}&cf=3"/>';
                                                })">删除</a></p>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        </c:if>
                    </c:forEach>

                </div>
            </div>
        </div>

    </div>
    <!--套用amazeui的选项卡插件-->
</div>
<script type="text/javascript">
$('.order-nav').addClass('my-ds');

function exchangeCoupon() {
    var cdkey=$("#cdkey").val()
    $.ajax({
        type: 'post',
        async: false,
        url: '<c:url value="/coupon/exchangeCoupon.do"/>',
        dataType: 'json',
        data:{
            cdkey:cdkey
        },
        success: function(data){
            if(data =="null"){
             $("#tx").html("兑换码输入错误，请核对后再输入！")
            }else{

               var box = $("#ytacu2");
                var sub = "<div class=\"cg\">"+
                "<p>领&nbsp;取&nbsp;成&nbsp;功!</p>"+
                "<div class=\"yhqys\">"+
                        "<div class=\"left\">"+
                        "<strong>"+data.couponBatch.price+"</strong>"+
                        "<span>";
                         if(data.couponBatch.type==1){
                             sub +="满减券"
                         }else{
                             sub +="现金券"
                         }
                sub +="</span>"+
                        "</div>"+
                        "<div class=\"right\">"+
                        "<p>";
                   if(data.couponBatch.type==1){
                       sub +="满"+data.couponBatch.priceLimit +"立减"+data.couponBatch.price
                   }else{
                       sub +="立减"+data.couponBatch.price
                   }
                sub +="</p>"+
                        "<p>使用条件:";
                if(data.couponBatch.range==1){
                   sub += "全场通用";
                }else if(data.couponBatch.range==2){
                    sub += data.couponBatch.project.name+"类商品使用";
                }else if(data.couponBatch.range==3){
                    sub += data.couponBatch.tenant.name+"店铺使用";
                }else{
                    sub +=  data.couponBatch.product.name+"商品使用";
                }
                sub +="</p>"+
                "<p>有效时间:"+formatDate(data.couponBatch.startDate)+"至"+formatDate(data.couponBatch.endDate) +"</p>"+
                "</div>"+
                "</div>"+
                "<a class=\"btn\" onclick='gbs()'>关闭</a>"+
                       "</div>" +
                        "<div class=\"bg\"></div>";
                box.html(sub);
                $("#tx").html("")
                $("#tk").hide()
                $("#ytacu2").show()
            }

        },

    });

}

$('#coupon-dialog').click(function(){
    $('.topbar,.header,.footer').css('z-index','-1');
    $('#tk').show();
    $('#tk').find('.no').click(function(){
        $('#tk').hide();
        $('.topbar,.header,.footer').css('z-index','');
    })
})
function gbs(){
    $("#ytacu2").hide()
}
function formatDate(now) {
    return new Date(parseInt(now)).toLocaleString().replace(/:\d{1,2}$/, ' ').substr(0,10);
}
$('.my-kj .am-tabs-nav .ul-list li.items1').mouseenter(function(){
    $(this).addClass('active').siblings().removeClass('active')
})
</script>
</body>
</html>