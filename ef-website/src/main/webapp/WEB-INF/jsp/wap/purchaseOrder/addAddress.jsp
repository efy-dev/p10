<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新增收货地址</title>
</head>
<body>

<!--//End--header-->
<div class="shipping-address">
  <form action="<c:url value="/myEfeiyi/addAddressOfMob.do"/>">
  <div class="address">
      <ul>
        <li>
          <input name="id" type="hidden" value="">
          <label>收货人</label>
          <input type="text" class="txt" name="consignee" value="">
        </li>
        <li>
          <label>手机号</label>
          <input type="text" class="txt" name="phone" value="" size="11" maxlength="11">
        </li>
        <li>
          <label>所在地区</label>
          <select id="provinceVal" class="cars" name="province.id"
                  onclick="province(this);">
          </select>
          <select id="cityVal" class="car1" name="city.id" onclick="city(this);">
          </select>
        </li>
        <li>
          <label>具体地址</label>
          <textarea name="details" id="doc-vld-ta-2-1" minlength="10" maxlength="100" class="text-act"></textarea>
        </li>
      </ul>
      <div class="default">
        <p>
          <input type="checkbox" id="checkbox" onclick="putVal(this);" name="checkbox" value="">
          <strong>设为默认地址</strong>
          <span>（注：每次下单时都使用该地址）</span>
        </p>
      </div>
  </div>
  <div class="edit-info">
    <input type="submit" class="a" value="保存信息">
  </div>
  </form>
</div>
<script>

  function putVal(o){
    var ele = document.getElementById("checkbox");
    if(ele.checked){
      $(o).val("1");
    }else{
      $(o).val("0");
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
  function df(id) {
    $.ajax({
      type: 'post',
      async: false,
      url: '<c:url value="/myEfeiyi/defaultAddress.do"/>',
      dataType: 'json',
      data: {
        status: 2,
        id: id

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
        rowHtml += "<option value='请选择'>请选择</option>";
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
        rowHtml += "<option value='请选择'>请选择</option>";
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
  chooseCity($("${address.id}") , "${address.province.id}","${address.city.id}","${address.id}");
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
    $("#updateAddress").validate({
      rules: {
        consignee: "required",
        details: "required",
        name: "required",
        phone: "required",
      },
    });
  });
</script>
</body>
</html>
