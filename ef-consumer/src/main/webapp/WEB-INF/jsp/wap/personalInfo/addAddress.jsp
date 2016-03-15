<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新增收货地址</title>
</head>
<body>

<!--//End--header-->
<div class="shipping-address" style="margin-bottom: 20px;">
  <form action="<c:url value="/myEfeiyi/addAddressOfMob.do"/>" method="post" id="addAddress">
  <div class="address">
      <ul>
        <li>
          <input name="id" type="hidden" value="">
          <label>收货人</label>
          <input type="text" class="txt" name="consignee" value="" required>
        </li>
        <li>
          <label>手机号</label>
          <input type="text" class="txt" name="phone" value="" size="11" maxlength="11">
        </li>
        <li>
          <label>所在地区</label>
          <select  id="provinceVal" class="cars  am-selected am-dropdown am-selected-btn" name="province.id" onchange="province(this)"
                  required>
            <option value="请选择">请选择</option>
            <c:forEach var="pro" items="${province}">
               <option value="${pro.id}">${pro.name}</option>
            </c:forEach>
          </select>
          <select  id="cityVal" class="car1  am-selected am-dropdown am-selected-btn" name="city.id" onchange="district(this)"  required>
            <option value="请选择">请选择</option>
          </select>
          <select  id="districtVal" class="car1  am-selected am-dropdown am-selected-btn" name="district.id" required>
            <option value="请选择">请选择</option>
          </select>
        </li>
        <span class="active-d span2" id="hao" style="border: 0;color: #000"></span>
        <li>
          <label>具体地址</label>
          <textarea name="details" id="doc-vld-ta-2-1" class="text-act" required></textarea>
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
    <input type="button" class="a" value="保存信息" onclick="sm();" >
  </div>
  </form>
</div>
<script src="<c:url value="/scripts/js/jquery.validate.js"/>"></script>

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

  function district(obj) {
    var cityId = $("#cityVal").val();
    var v = $(obj).val();
    $("#districtVal").empty();
    $.ajax({
      type: 'post',
      async: false,
      url: '<c:url value="/myEfeiyi/address/listDistrict.do"/>',
      dataType: 'json',
      data: {
        cityId: cityId
      },
      success: function (data) {
        var obj = eval(data);
        var rowHtml = "";
        rowHtml += "<option value='请选择'>请选择</option>";
        for (var i = 0; i < obj.length; i++) {
          rowHtml += "<option value='" + obj[i].id + "'>" + obj[i].name + "</option>";
        }
        $("#districtVal").append(rowHtml);
        $("#districtVal option[value='" + v + "']").attr("selected", "selected");

      },
    });
  }

  function province(obj) {
    var v = $(obj).val();
    city(v);
  }

  function sm(){
    var province=$("#provinceVal").val();
    var city=$("#cityVal").val();
    if(province=="请选择"||city=="请选择"){
      $("#hao").html("省市不能为空");
    }else {
      $("#addAddress").submit();
      $("#hao").html("");
    }
  }

  $().ready(function () {
    $("#addAddress").validate({
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
