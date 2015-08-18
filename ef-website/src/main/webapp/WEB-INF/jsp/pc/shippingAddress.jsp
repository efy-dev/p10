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
                <form id="address" name="address" action="" method="post">
                  <ul>
                    <li>
                      <label>收货人：</label>
                      <input type="text">
                      <span>请您填写收货人姓名</span>
                    </li>
                    <li>
                      <label>所在地区：</label>
                      <form>
                        <select name="cars" class="cars">
                          <option value="请选择">请选择</option>
                          <option value="saab">Saab</option>
                          <option value="fiat">Fiat</option>
                          <option value="audi">Audi</option>
                        </select>
                        <select name="cars" class="car1">
                          <option value="请选择">请选择</option>
                          <option value="saab">Saab</option>
                          <option value="fiat">Fiat</option>
                          <option value="audi">Audi</option>
                        </select>
                        <span>请您填写所在地区</span>
                      </form>


                    </li>
                    <li>
                      <label>详细地址：</label>
                      <input type="text">
                      <span>请您填写详细地址</span>
                    </li>
                    <li>
                      <label>手机号码：</label>
                      <input type="text">
                    </li>
                    <li>
                      <label>邮箱：</label>
                      <input type="text">
                      <span>请您填写邮箱</span>
                    </li>
                    <li>
                      <label></label>
                      <strong>用来接收订单提醒邮件，便于您及时了解订单情况</strong>
                    </li>
                    <li>
                      <label></label>
                      <input type="button" onclick="addAddress();" class="dj-btn" value="保存收货人信息">
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
      <c:forEach items="addressList" var="address" varStatus="as">
      <div class="title wh1">
        <table class="address">
          <tr class="yes-border">
            <td colspan="6">
              <%--<span class="ae-black">地址${as.index+1}</span>--%>
                <span>您对“苏绣《安格尔—公爵夫人像》”的商品评价已成功发布。</span>

            </td>
          </tr>
          <tr>
            <td   width="76"  style="text-align: right;"><span>收货人：</span></td>
            <td   width="600">
              <%--<span>${address.consumer.name}</span>--%>
                <span>您对“苏绣《安格尔—公爵夫人像》”的商品评价已成功发布。</span>

            </td>
            <td width="188"  class="ae-rg1">
              <div class="ae-rg">

              </div>
            </td>
          </tr>
          <tr>
            <td   width="76"  style="text-align: right;"><span>所在地区：</span></td>
            <td   width="600">
              <%--<span>${address.province.name}${address.city.name}</span>--%>
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
              <%--<span>${address.details}</span>--%>
              <span>您对“苏绣《安格尔—公爵夫人像》”的商品评价已成功发布。</span>

            </td>
            <td width="188"  class="ae-rg1">
              <div class="ae-rg">

              </div>
            </td>
          </tr>
          <tr>
            <td   width="76"  style="text-align: right;"><span>手机号码：</span></td>
            <td   width="600">
              <span>您对“苏绣《安格尔—公爵夫人像》”的商品评价已成功发布。</span>
            </td>
            <td width="188"  class="ae-rg1">
              <div class="ae-rg">

              </div>
            </td>
          </tr>
          <tr>
            <td   width="76"  style="text-align: right;"></td>
            <td   width="600">
            </td>
            <td width="188"  class="ae-rg1">
              <div class="ae-rg">
                <span><span class="text-a"><a href="#">设为默认</a></span></span>
                <span><span class="text-a"><a id="hideDiv" href="">编辑</a>
                      <div class="active-pop" style="display: none">
                        <div class="pop-up">
                          <div class="pop-h">编辑收货人信息
                            <i class="clase" title="关闭"></i>
                          </div>
                          <div class="m-form">
                            <form>
                              <ul>
                                <li>
                                  <label>收货人：</label>
                                  <input type="text">
                                  <span>请您填写收货人姓名</span>
                                </li>
                                <li>
                                  <label>所在地区：</label>
                                  <form>
                                    <select name="cars" class="cars">
                                      <option value="请选择">请选择</option>
                                      <option value="saab">Saab</option>
                                      <option value="fiat">Fiat</option>
                                      <option value="audi">Audi</option>
                                    </select>
                                    <select name="cars" class="car1">
                                      <option value="请选择">请选择</option>
                                      <option value="saab">Saab</option>
                                      <option value="fiat">Fiat</option>
                                      <option value="audi">Audi</option>
                                    </select>
                                    <span>请您填写所在地区</span>
                                  </form>


                                </li>
                                <li>
                                  <label>详细地址：</label>
                                  <input type="text">
                                  <span>请您填写详细地址</span>
                                </li>
                                <li>
                                  <label>手机号码：</label>
                                  <input type="text">
                                </li>
                                <li>
                                  <label>邮箱：</label>
                                  <input type="text">
                                  <span>请您填写邮箱</span>
                                </li>
                                <li>
                                  <label></label>
                                  <strong>用来接收订单提醒邮件，便于您及时了解订单情况</strong>
                                </li>
                                <li>
                                  <label></label>
                                  <input type="button" class="dj-btn" value="保存收货人信息">
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
<!--content-->
<!-- //End--footer-->
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="/scripts/assets/js/jquery.min.js"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script src="/scripts/assets/js/amazeui.min.js"></script>
<script src="/scripts/assets/js/system.js"></script>
<!--<script type="text/javascript">
$(window).scroll(function(){
	if($(this).scrollTop()>100){
		$('.slider-menu ul').css({'position':'fixed'})
	}
})
</script>-->
<script>
  $(function(){
    $("#add").click(function(){
      $(this).siblings('.active-pop').show();
      $('.my-order .clase, .my-order .sh-bg').click(function(){
        $(this).parents('.active-pop').hide();
      })
      return false;
    })
  })
  $(function(){
    $("#hideDiv").click(function(){
      $(this).siblings('.active-pop').show();
      $('.my-order .clase, .my-order .sh-bg').click(function(){
        $(this).parents('.active-pop').hide();
      })
      return false;
    })
  })

  $.post("address/addAddress",{},function(data){

  })
</script>


</body>
</html>
