<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>个人中心</title>
  <script src="/META-INF/resources/resources/jquery/jquery-1.11.1.min.js"></script>
  <script type="text/javascript"></script>
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
                <form action="/addAddress.do" method="post" >
                  <ul>
                    <li>
                      <label>收货人：</label>
                      <input type="text" name="consignee">
                      <span>请您填写收货人姓名</span>
                    </li>
                    <li>
                      <label>所在地区：</label>
                      <form>
                        <select id="provinceVal" class="cars" onclick="province(this);">
                        </select>
                        <select id="cityVal" class="car1" onclick="city(this);">
                        </select>
                        <span>请您填写所在地区</span>
                      </form>


                    </li>
                    <li>
                      <label>详细地址：</label>
                      <input type="text" name="details">
                      <span>请您填写详细地址</span>
                    </li>
                    <li>
                      <label>手机号码：</label>
                      <input type="text" name="phone">
                    </li>
                    <li>
                      <label></label>
                      <strong>用来接收订单提醒邮件，便于您及时了解订单情况</strong>
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
            <td   width="76"  style="text-align: right;"><span>收货人：</span></td>
            <td   width="600">
              <span>${address.consignee}</span>
            </td>
            <td width="188"  class="ae-rg1">
              <div class="ae-rg">

              </div>
            </td>
          </tr>
          <tr>
            <td   width="76"  style="text-align: right;"><span>所在地区：</span></td>
            <td   width="600">
                <span>您对“苏绣《安格尔—公爵夫人像》”的商品评价已成功发布。</span>

            </td>
            <td width="188"  class="ae-rg1">
              <div class="ae-rg">

              </div>
            </td>
          </tr>
          <tr>
            <td   width="76"  style="text-align: right;"><span>详细地址：</span></td>
            <td   width="600">
              <span>${address.details}</span>
            </td>
            <td width="188"  class="ae-rg1">
              <div class="ae-rg">

              </div>
            </td>
          </tr>
          <tr>
            <td   width="76"  style="text-align: right;"><span>手机号码：</span></td>
            <td   width="600">
              <span>${address.phone}</span>
            </td>
            <td width="188"  class="ae-rg1">
              <div class="ae-rg">

              </div>
            </td>
          </tr>

          <tr>
            <td  width="76"  style="text-align: right;"></td>
            <td  width="600">
            </td>
            <td width="188"  class="ae-rg1">
              <div class="ae-rg">
                <c:if test="${address.status == 2}">
                  <span><span class="text-a"><a href="#" onclick="df('${address.id}')">默认地址</a></span></span>

                </c:if>
                <c:if test="${address.status != 2}">
                  <span><span class="text-a"><a href="#" onclick="df('${address.id}')">设为默认</a></span></span>

                </c:if>
                <span><span class="text-a"><a class="hideDiv" href="">编辑</a>
                      <div class="active-pop" style="display: none">
                        <div class="pop-up">
                          <div class="pop-h">编辑收货人信息
                            <i class="clase" title="关闭"></i>
                          </div>
                          <div class="m-form">
                            <form action="/addAddress.do" method="post">
                              <ul>
                                <li>
                                  <label>收货人：</label>
                                  <input type="text" name="consignee" value="${address.consignee}">
                                  <span>请您填写收货人姓名</span>
                                </li>
                                <input type="hidden" name="id" value="${address.id}" >
                                <li>
                                  <label>所在地区：</label>
                                  <form>
                                    <select id="provinces" class="cars" onclick="province(this);">
                                    </select>
                                    <select id="citys" class="car1" onclick="city(this);">

                                    </select>
                                    <span>请您填写所在地区</span>
                                  </form>


                                </li>
                                <li>
                                  <label>详细地址：</label>
                                  <input type="text" name="details" value="${address.details}" >
                                  <span>请您填写详细地址</span>
                                </li>
                                <li>
                                  <label>手机号码：</label>
                                  <input type="text" name="phone" value="${address.phone}">
                                </li>
                                <li>
                                  <label></label>
                                  <strong>用来接收订单提醒邮件，便于您及时了解订单情况</strong>
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
<script src="/scripts/assets/js/jquery.min.js"></script>

<script src="/scripts/assets/js/amazeui.min.js"></script>
<script src="/scripts/assets/js/system.js"></script>

<script>
  $(function(){
    $("#add").click(function(){
      $(this).siblings('.active-pop').show();
      $('.my-order .clase, .my-order .sh-bg').click(function(){
        $(this).parents('.active-pop').hide();
      })
      return false;
    })
  });
  $(function(){
    $(".hideDiv").click(function(){
      $(this).siblings('.active-pop').show();
      $('.my-order .clase, .my-order .sh-bg').click(function(){
        $(this).parents('.active-pop').hide();
      })
      return false;
    })
  });
  function df(id) {
    $.ajax({
      type: 'post',
      async: false,
      url: '<c:url value="/myEfeiyi/defaultAddress.do"/>',
      dataType: 'json',
      data: {
        status:2,
        id:id

      },
      success: function (data) {
         if(data == true){
           window.location.reload();
         }
      },

    });
  }

  function s(){
    alert("dd");
  }

  function city(obj){
    var pid = $("#provinceVal").val();
    var v = $(obj).val();
     $("#cityVal").empty();
    $.ajax({
      type: 'post',
      async: false,
      url: '<c:url value="/myEfeiyi/address/listCity.do"/>',
      dataType: 'json',
      data:{
        provinceId:pid
      },
      success: function (data) {
        var obj = eval(data);
        var rowHtml = "";
        rowHtml += "<option value='请选择'>请选择</option>";
        for(var i = 0;i<obj.length;i++){
          rowHtml += "<option value='"+obj[i].id+"'>"+obj[i].name+"</option>";
        }
        $("#cityVal").append(rowHtml);
        $("#cityVal option[value='"+v+"']").attr("selected","selected");

      },
    });
  }
  function province(obj){
    var v = $(obj).val();
//    $("#provinceVal").empty();
    alert(11111);
    $.ajax({
      type: 'post',
      async: false,
      url: '<c:url value="/myEfeiyi/addAddress.do"/>',
      dataType: 'json',
      success: function (data) {
          var obj = eval(data);
        var rowHtml = "";
        rowHtml += "<option value='请选择'>请选择</option>";
        for(var i = 0;i<obj.length;i++){

            rowHtml += "<option value='"+obj[i].id+"'>"+obj[i].name+"</option>";


        }
        $("#provinceVal").append(rowHtml);
        $("#provinceVal option[value='"+v+"']").attr("selected","selected");
      },

    });
  }


</script>


</body>
</html>
