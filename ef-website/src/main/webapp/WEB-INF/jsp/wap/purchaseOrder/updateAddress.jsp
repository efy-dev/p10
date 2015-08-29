<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<header class="am-header custom-header">
  <div class="am-header-left am-header-nav">
    <a href="#chevron-left" class="chevron-left"></a>
  </div>
  <!-- //End--chevron-left-->
  <h1 class="am-header-title">编辑收货地址</h1>
  <!-- //End--title-->
  <div class="am-header-right am-header-nav">
    <a href="#chevron-right" class="chevron-right" id="menu">
      <i class="line"></i>
    </a>
  </div>
  <!-- //End--chevron-left-->
  <div class="menu-list">
    <ul class="bd">
      <li><a href="" title="首页">首页</a></li>
      <li><a href="" title="分类">分&nbsp;类</a></li>
      <li class="active"><a href="" title="购物车">购&nbsp;物&nbsp;车</a></li>
      <li><a href="" title="传承人">传承人</a></li>
      <li><a href="" title="个人中心">个&nbsp;人&nbsp;中&nbsp;心</a></li>
    </ul>
  </div>
</header>
<!--//End--header-->
<div class="shipping-address">
  <div class="address">
    <form action="<c:url value="/myEfeiyi/addAddress.do"/>">
      <ul>
        <li>
          <label>收货人</label>
          <input type="text" class="txt" name="consignee" value="${address.consignee}">
        </li>
        <li>
          <label>手机号</label>
          <input type="text" class="txt" value="${address.phone}" size="11" maxlength="11">
        </li>
        <li>
          <label>所在地区</label>
          <select id="${address.id}" name="province.id" class="cars"
                  onchange="provinceChange(this , '${address.id}')">
            <c:forEach var="pro" items="${province}">
              <option value="${pro.id}">${pro.name}</option>
            </c:forEach>
          </select>
          <select id="citys${address.id}" name="city.id" class="car1">
          </select>
        </li>
        <li>
          <label>具体地址</label>
          <textarea id="doc-vld-ta-2" minlength="10" maxlength="100" class="text-act">${address.details}</textarea>
        </li>
      </ul>
      <div class="default">
          <p>
            <input type="checkbox">
            <strong>设为默认地址</strong>
            <span>（注：每次下单时都使用该地址）</span>
          </p>
      </div>
      <div class="edit-info">
        <input type="submit" class="dj-btn" value="保存信息"></input>
      </div>
    </form>
  </div>

</div>
<script>

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
