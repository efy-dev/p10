<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/20
  Time: 16:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <link href="<c:url value="/scripts/css/myorder.css"/>" type="text/css " rel="stylesheet">
</head>
<body>
<div class="wr wh">
    <!--结算-->
    <div class="my-clearing">
        <h1>填写并核对订单信息</h1>
        <!--地址-->
        <div class="clearing-site">
            <span class="clearing-left">收货人信息</span>
        <span class="clearing-right">
            <a href="#" class="btn-cart-add">新增收货地址</a>
             <div class="active-pop" style="display: none">
                 <div class="pop-up">
                     <div class="pop-h">编辑收货人信息
                         <i class="clase" title="关闭"></i>
                     </div>
                     <div class="m-form">
                         <form id="newAddress">
                             <ul>
                                 <li>
                                     <label>收货人：</label>
                                     <input type="text" name="consignee">
                                 </li>
                                 <li>
                                     <label>所在地区：</label>

                                     <form>
                                         <select class="cars" id="province" name="province.id"
                                                 onchange="provinceChange(this)" required>
                                             <option value="请选择">请选择</option>
                                         </select>
                                         <select class="car1" id="city" name="city.id" required>
                                             <option value="请选择">请选择</option>
                                         </select>
                                     </form>
                                 </li>
                                 <li>
                                     <label>详细地址：</label>
                                     <input type="text" name="details">
                                 </li>
                                 <li>
                                     <label>手机号码：</label>
                                     <input type="text" name="phone">
                                 </li>
                                 <li>
                                     <label></label>
                                     <a  class="dj-btn" onclick="submitNewAddress()" value="保存收货人信息" href="javascript:void(0)">保存收货人信息</a>
                                     <input type="reset" style="display: none" id="reset">
                                     <span id="ts" style="border: 0"></span>
                                 </li>
                             </ul>
                         </form>
                     </div>
                     <div class="sh-bg"></div>
                 </div>
             </div>
        </span>
        </div>
        <div class="page-clearing" id="address">
            <c:forEach items="${addressList}" var="address">

                <div class="page-default">
            <span>
                <c:if test="${address.status=='2'}">
                <div id="${address.id}" class="default-text triangle activeFlag" name="addressItem"
                     onclick="chooseAddress(this,'${address.id}')">
                    </c:if>
                    <c:if test="${address.status=='1'}">
                    <div class="default-text" name="addressItem" onclick="chooseAddress(this,'${address.id}')">
                        </c:if>
                        <strong>${address.consignee} ${address.province.name}</strong>
                            <%--<i class="triangle" style="display: block"></i>--%>
                        </a>
                    </div>
            </span>
                    <span>${address.consignee}</span>
                    <span>${address.province.name}</span>
                    <span>${address.city.name}</span>
                    <span>${address.details}</span>
                    <span>${address.phone}</span>
                </div>
            </c:forEach>
            <%--<div class="dj-p">--%>
            <%--<a href="#">展开地址--%>
            <%--<span class="triangle-bg"></span>--%>
            <%--</a>--%>

            <%--</div>--%>
        </div>
        <!--支付-->
        <div class="clearing-site divtop">
            <span class="clearing-left">支付方式</span>
        </div>
        <div class="page-clearing ">
            <li id="zhifubao" class="alipay triangle " onclick="zhifubao(this)">
                <span>支 付 宝</span>
            </li>
            <li id="weixin" class="alipay " onclick="weixin(this)">
                <span>微   信</span>
            </li>
        </div>
        <!--支付-->
        <!--订货清单-->
        <div class="clearing-site divtop">
            <span class="clearing-left">订货清单</span>
        <span class="clearing-right">
            <a  href="<c:url value="/cart/view"/>" onclick="window.location.href='<c:url value="/cart/view"/>'">返回修改购物车</a>
        </span>
        </div>
        <c:forEach items="${tenantList}" var="tenant">

            <div class="page-inventory">
                <div class="page-store">
                    <a href="#">${tenant.name}</a>
                        <%--<a href="#">收起店铺--%>
                        <%--<span class="triangle-bg"></span>--%>
                        <%--</a>--%>
                </div>
                <div class="page-Commodity">
                    <table>
                        <c:forEach items="${productMap.get(tenant.id)}" var="product">
                            <c:if test="${product.isChoose==1}">

                                <tr>
                                    <td width="542">
                                        <div class="cols1 page-pdl">
                                            <img src="http://pro.efeiyi.com/${product.productModel.productModel_url}@!product-icon" alt=""/>

                                            <div class="info">
                                                <p><a href="#">${product.productModel.product.project.name}</a></p>

                                                <p><a href="#">${product.productModel.name}
                                                    <c:if test="${product.productModel.productPropertyValueList.size()>1}">
                                                        [
                                                    <c:forEach items="${product.productModel.productPropertyValueList}"
                                                               var="ppv">${ppv.projectPropertyValue.value}</c:forEach></a>
                                                        ]
                                                    </c:if>

                                                </p>
                                            </div>
                                        </div>
                                    </td>
                                    <td width="171"><span
                                            class="moneycl">${(product.productModel.price.intValue())*product.amount}</span>
                                    </td>
                                    <td width="137">
                                        <span>x${product.amount}</span>
                                    </td>
                                    <td width="102"><span>有货</span></td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </table>
                </div>
                <div class="page-leaveword">
                    <label>给店家留言</label>
                    <input id="${tenant.id}Message" name="message" type="text" placeholder="限45个字" maxlength="45" onchange="updateCount(this)" style="color: black">
                    <span id="${tenant.id}Count">0/45</span>
                </div>
            </div>
        </c:forEach>
        <!--订货清单-->
        <!--发票-->
        <!--<div class="clearing-site divtop">-->
        <!--<span class="clearing-left">-->
        <!--<input type="checkbox" class="middle-active"  value="全部">-->
        <!--开具发票-->
        <!--</span>-->
        <!--</div>-->
        <!--<div class="page-clearing">-->

        <!--</div>-->
        <!--发票-->
        <!--结算-->
        <div class="System">
            <div class="System-text">
                <span><a  target="_blank" onclick="submitOrder(this,'${purchaseOrder.id}')">提交订单</a> </span>
                <span>应付金额：<strong>${cart.totalPrice-purchaseOrder.coupon.couponBatch.price}</strong> 元</span>
            </div>
        </div>
        <!--结算-->
    </div>
</div>

<script>

    var payment = "1";
    var consumerAddress = "";
    if (typeof $(".activeFlag").attr("id")!="undefined") {
        consumerAddress = $(".activeFlag").attr("id");
    }

    function zhifubao(element) {
        $(element).attr("class", "alipay triangle");
        $("#weixin").attr("class", "alipay");
        payment = "1";
    }

    function updateCount(element){
        var Id = $(element).attr("id");
        var tenantId = Id.substring(0,Id.length-7);
        var str = $(element).val();
        var count = str.length;
        $("#"+tenantId+"Count").html(count+"/45");
    }

    function weixin(element) {
        $(element).attr("class", "alipay triangle");
        $("#zhifubao").attr("class", "alipay");
        payment = "3";
    }
    function submitOrder(element,orderId) {
        var messageObject = new Object();
        $("input[name=message]").each(function () {
            messageObject[$(this).attr("id")] = $(this).val();
        })
        var message = "";
        for (var key in messageObject) {
            message += key + ":" + messageObject[key] + ";"
        }

        if (consumerAddress == "") {
            showAlert("提示", "请选择一个收货地址！");
        } else {
            var url = "<c:url value="/order/confirm/"/>";
            url += orderId + "?payment=" + payment + "&address=" + consumerAddress + "&message=" + message;
            element.onclick = null;
            $(element).attr("href",url);
            $(element).click();
            showChooseConfirm("提示","是否支付成功？",function(){
                window.location.href = "<c:url value="/order/myEfeiyi/view/"/>"+orderId;
            },function(){
                window.location.href = "<c:url value="/order/myEfeiyi/view/"/>"+orderId;
            })
        }
    }


    $(function () {
        $('.clearing-site span a').click(function () {
            $(this).siblings('.active-pop').show();
            $('.clase, .sh-bg').click(function () {
                $(this).parents('.active-pop').hide();
            })
            return false;
        })

        //网页加载的时候把城市的数据取回来
        ajaxRequest("<c:url value="/myEfeiyi/address/listProvince.do"/>", {}, function (data) {
            var out = '<option value="">请选择</option>';
            for (var i = 0; i < data.length; i++) {
                out += '<option value="' + data[i]["id"] + '">' + data[i]["name"] + '</option>';
            }
            $("#province").html(out);
        }, function () {
        }, "post")

    })

    function provinceChange(element) {
        var provinceId = $(element).val();
        ajaxRequest("<c:url value="/myEfeiyi/address/listCity.do"/>", {provinceId: provinceId}, function (data) {
            var out = '<option value="">请选择</option>';
            for (var i = 0; i < data.length; i++) {
                out += '<option value="' + data[i]["id"] + '">' + data[i]["name"] + '</option>';
            }
            $("#city").html(out);
        }, function () {
        }, "post")
    }

    function newAddress(it) {
        var out = ' <div class="page-default"> <span> <div id="' + (it.id) + '" class="default-text" name="addressItem" onclick="chooseAddress(this,\'' + it.id + '\')"> <strong>' + (it.consignee) + ' ' + (it.province.name) + '</strong> </a> </div> </span> <span>' + (it.consignee) + '</span> <span>' + (it.province.name) + '</span> <span>' + (it.city.name) + '</span> <span>' + (it.details) + '</span> <span>' + (it.phone) + '</span> </div>';
        return out;
    }

    function submitNewAddress() {
        var consignee=$(":input[name='consignee']").val();
        var  phone=$(":input[name='phone']").val();
        var details=$(":input[name='details']").val();
        if(consignee == "" || phone == ""|| details == "" ){
           $("#ts").text("请完善您的新增地址");
        }else{
            var param = $("#newAddress").serialize();

            var success = function (data) {
//                window.location.href=window.location.href;
                var html = newAddress(data);
                $("#address").append(html);
                $(".active-pop").hide();
                $("#reset").click();
                $("#"+data.id).click();
            }
            ajaxRequest("<c:url value="/order/addAddress.do"/>", param, success, function () {
            }, "post")
        }

    }

    function chooseAddress(element, addressId) {
        consumerAddress = addressId
        $("div[name=addressItem]").each(function () {
            $(this).attr("class", "default-text");
        })
        $(element).attr("class", "default-text triangle")
    }
</script>
</body>
</html>
