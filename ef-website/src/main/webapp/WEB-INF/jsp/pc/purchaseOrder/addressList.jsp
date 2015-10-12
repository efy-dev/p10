<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!doctype html>
<html class="no-js">
<head>
</head>
<body>

<!-- //End--header-->
<!--content-->

<div class="layout-col">
    <div class="mt wh1">
        <div class="extra-l">
            <strong>收货地址</strong>
        </div>
        <div class="extra-r">
            <a id="add" href="">新增收货地址</a>

            <div class="active-pop" style="display: none">
                <div class="pop-up">
                    <div class="pop-h">编辑收货人信息
                        <i class="clase" title="关闭"></i>
                    </div>
                    <div class="m-form">
                        <form id="addAddress" action="<c:url value="/myEfeiyi/addAddress.do"/>" method="post" accept-charset="utf-8">
                            <ul>
                                <li>
                                    <label>收货人：</label>
                                    <input type="text" name="consignee">
                                </li>
                                <li>
                                    <label>所在地区：</label>

                                    <form>
                                        <select id="provinceVal" class="cars" name="province.id"
                                                onclick="province(this);" required>
                                        </select>
                                        <select id="cityVal" class="car1" name="city.id" onclick="city(this);" required>
                                        </select>
                                        <span class="active-d span2" id="hao" style="border: 0;color: #000"></span>
                                    </form>

                                </li>
                                <li>
                                    <label>详细地址：</label>
                                    <input style="width: 255px;" type="text" name="details">
                                </li>
                                <li>
                                    <label>手机号码：</label>
                                    <input type="text" name="phone">
                                </li>
                                <li>
                                    <label></label>
                                    <input type="button" onclick="sm()" class="dj-btn" value="保存收货人信息">
                                </li>
                            </ul>
                        </form>
                    </div>
                    <div class="sh-bg"></div>
                </div>
            </div>
        </div>
    </div>
    <!-- //End--mt-->
    <c:forEach items="${addressList}" var="address" varStatus="as">
        <div class="title wh1">
            <table class="address">
                <tr class="yes-border">
                    <td colspan="6">
                        <span class="ae-black">地址${as.index+1}</span>
                    </td>
                </tr>
                <tr>
                    <td width="76" style="text-align: right;"><span>收货人：</span></td>
                    <td width="600">
                        <span>${address.consignee}</span>
                    </td>
                    <td width="188" class="ae-rg1">
                        <div class="ae-rg">

                        </div>
                    </td>
                </tr>
                <tr>
                    <td width="76" style="text-align: right;"><span>所在地区：</span></td>
                    <td width="600">
                        <span>${address.province.name} ${address.city.name}</span>

                    </td>
                    <td width="188" class="ae-rg1">
                        <div class="ae-rg">

                        </div>
                    </td>
                </tr>
                <tr>
                    <td width="76" style="text-align: right;"><span>详细地址：</span></td>
                    <td width="600">
                        <span>${address.details}</span>
                    </td>
                    <td width="188" class="ae-rg1">
                        <div class="ae-rg">

                        </div>
                    </td>
                </tr>
                <tr>
                    <td width="76" style="text-align: right;"><span>手机号码：</span></td>
                    <td width="600">
                        <span>${address.phone}</span>
                    </td>
                    <td width="188" class="ae-rg1">
                        <div class="ae-rg">

                        </div>
                    </td>
                </tr>

                <tr>
                    <td width="76" style="text-align: right;"></td>
                    <td width="500">
                    </td>
                    <td width="300" class="ae-rg1">
                        <div class="ae-rg">
                            <c:if test="${address.status == 2}">
                                <span><span class="text-a"><a href="#"
                                                              onclick="df('${address.id}','${address.consumer.id}')">默认地址</a></span></span>

                            </c:if>
                            <c:if test="${address.status != 2}">
                                <span><span class="text-a"><a href="#"
                                                              onclick="df('${address.id}','${address.consumer.id}')">设为默认</a></span></span>

                            </c:if>
                <span><span class="text-a"><a class="hideDiv" href="">编辑</a>
                <span><span class="text-a"><a
                        href="#" onclick="showConfirm('提示','是否删除',function(){
                     window.location.href='<c:url value="/myEfeiyi/removeAddress.do?addressId=${address.id}"/>';
                        })">删除</a></span></span>

                      <div class="active-pop" style="display: none">
                          <div class="pop-up  ae-lf">
                              <div class="pop-h">编辑收货人信息
                                  <i class="clase" title="关闭"></i>
                              </div>
                              <div class="m-form">
                                  <form class="aaa" id="updateAddress" action="<c:url value="/myEfeiyi/addAddress.do"/>"
                                        method="post">
                                      <ul>
                                          <li>
                                              <label>收货人：</label>
                                              <input type="text" name="consignee" value="${address.consignee}">
                                          </li>
                                          <input type="hidden" name="id" value="${address.id}">
                                          <li>
                                              <label>所在地区：</label>

                                              <form>
                                                  <select id="${address.id}" name="province.id" class="cars"
                                                          onchange="provinceChange(this , '${address.id}')" required>
                                                      <c:forEach var="pro" items="${province}">
                                                          <option value="${pro.id}">${pro.name}</option>
                                                      </c:forEach>
                                                  </select>
                                                  <select id="citys${address.id}" name="city.id" class="car1" required>
                                                  </select>
                                              </form>
                                          </li>
                                          <li>
                                              <label>详细地址：</label>
                                              <input style="width: 255px;" type="text" name="details" value="${address.details}">
                                          </li>
                                          <li>
                                              <label>手机号码：</label>
                                              <input type="text" name="phone" value="${address.phone}">
                                          </li>
                                          <li>
                                              <label></label>
                                              <input type="submit" class="dj-btn" value="保存收货人信息">
                                          </li>
                                      </ul>
                                  </form>
                              </div>
                              <div class="sh-bg"></div>
                          </div>
                      </div>
                </span></span>
                        </div>
                    </td>
                </tr>
            </table>
            <!-- //End--title-->

        </div>
    </c:forEach>
</div>
</div>
</div>
<script src="<c:url value="/scripts/js/jquery.min.js"/>"></script>

<script src="<c:url value="/scripts/js/amazeui.min.js"/>"></script>
<script src="<c:url value="/scripts/js/system.js"/>"></script>
<script src="<c:url value="/scripts/js/jquery.validate.js"/>"></script>

<script>

    function sm(){
        var province=$("#provinceVal").val();
        var city=$("#cityVal").val();
        if(province == "请选择" || city == "请选择"){
            $("#hao").html("省市不能为空");
        }else {
            $("#addAddress").submit();
            $("#hao").html("");
        }
    }
    $(function () {
        $("#add").click(function () {
            $(this).siblings('.active-pop').show();
            province();
            $('.my-order .clase, .my-order .sh-bg').click(function () {
                $(this).parents('.active-pop').hide();
            })
            return false;
        })
    });
    $(function () {
        $(".hideDiv").click(function () {
            $(this).siblings('.active-pop').show();
            $('.my-order .clase, .my-order .sh-bg').click(function () {
                $(this).parents('.active-pop').hide();
            })
            return false;
        });
    });
    function df(addressId,consumerId) {
        $.ajax({
            type: 'post',
            async: false,
            url: '<c:url value="/myEfeiyi/defaultAddress.do"/>',
            dataType: 'json',
            data: {
                status: 2,
                id: addressId,
                consumerId:consumerId,

            },
            success: function (data) {
                if (data == true) {
                    window.location.reload();
                }
            },

        });
    }
    function city(obj) {
        var pid = $("#provinceVal").val();
        var v = $(obj).val();
        $("#cityVal").empty();
        $.ajax({
            type: 'post',
            async: false,
            url: '<c:url value="/myEfeiyi/address/listCity.do"/>',
            dataType: 'json',
            data: {
                provinceId: pid
            },
            success: function (data) {
                var obj = eval(data);
                var rowHtml = "";
                rowHtml += "<option value='请选择'>请选择所在区县</option>";
                for (var i = 0; i < obj.length; i++) {
                    rowHtml += "<option value='" + obj[i].id + "'>" + obj[i].name + "</option>";
                }
                $("#cityVal").append(rowHtml);
                $("#cityVal option[value='" + v + "']").attr("selected", "selected");

            },
        });
    }

    function province(obj) {
        var v = $(obj).val();
        $("#provinceVal").empty();
        $.ajax({
            type: 'post',
            async: false,
            url: '<c:url value="/myEfeiyi/address/listProvince.do"/>',
            dataType: 'json',
            success: function (data) {
                var obj = eval(data);
                var rowHtml = "";
                rowHtml += "<option value='请选择'>请选择所在省市</option>";
                for (var i = 0; i < obj.length; i++) {
                    rowHtml += "<option value='" + obj[i].id + "'>" + obj[i].name + "</option>";

                }
                $("#provinceVal").append(rowHtml);
                $("#provinceVal option[value='" + v + "']").attr("selected", "selected");
                city(v);
            },

        });
    }

    function provinceChange(element, o, callback) {
        $("#citys" + o).empty();
        var provinceId = $(element).val();
        ajaxRequest("<c:url value="/myEfeiyi/address/listCity.do"/>",
                {provinceId: provinceId},
                function (data) {
                    var out = '<option value="">请选择</option>';
                    for (var i = 0; i < data.length; i++) {
                        out += '<option value="' + data[i]["id"] + '">' + data[i]["name"] + '</option>';
                    }
                    $("#citys" + o).append(out);
                    if(typeof callback!= "undefined"){
                        callback();
                    }
                }
        )
    }

    function chooseCity(element,provinceId,cityId,o){
        $(element).val(provinceId);
        var callback = function(){
            $("#citys" + o).val(cityId);
        }
        provinceChange(element, o,callback);
    }

    <c:forEach items="${addressList}" var="address">
        chooseCity($("#${address.id}") , "${address.province.id}","${address.city.id}","${address.id}");
    </c:forEach>

    $().ready(function () {
        $("#addAddress").validate({
            rules: {
                consignee: "required",
                details: "required",
                name: "required",
                phone: "required",
            },
        });

        $(".aaa").each( function(){
            $(this).validate({
                rules: {
                    consignee: "required",
                    details: "required",
                    name: "required",
                    phone: "required",
                },
            });

        });
    });
</script>


</body>
</html>
