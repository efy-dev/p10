<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head></head>
<body style="overflow:-moz-scrollbars-vertical;">
<div class="hd"></div>
<!-- //End--header-->
<!--content-->
  <div class="evaluation">
    <div class="my-order">
        <div class="layout-col">
          <div class="mt wh1">
            <div class="extra-l">
              <strong>我的评价</strong>
            </div>
          </div>
          <!-- //End--mt-->
          <div class="title wh1">
            <div class="evaluation-nav">
              <table>
                <tr>
                  <td width="400">
                    <span class="sp-page">商品信息</span>
                  </td>
                  <td width="180">
                    <span  class="sp-page">购买时间</span>
                  </td>
                  <td width="150">
                    <span  class="sp-page">评价状态</span>
                  </td>
                  <td width="120">
                    <span  class="sp-page">操作</span>
                  </td>
                </tr>
              </table>
            </div>
            <!--状态查看评价-->
            <c:forEach items="${finishList}" var="finish">
              <c:forEach items="${finish.purchaseOrderProductList}" var="op">
            <div class="appraise">
              <div class="table">
                <table>
                  <tr>
                    <td width="400">
                      <div class="list-refer">
                        <dl>
                          <dt><a href="#"><img src="http://pro.efeiyi.com/${op.productModel.productModel_url}@!product-icon" alt=""></a></dt>
                          <dd>${op.productModel.product.name}</dd>
                        </dl>
                      </div>
                    </td>
                    <td width="180">
                      <div class="list-refer-2">
                        <p><fmt:formatDate value="${finish.createDatetime}" pattern="yyyy-MM-dd" /></p>
                        <p><fmt:formatDate value="${finish.createDatetime}" pattern="H:m:s" /></p>
                      </div>
                    </td>
                    <td width="150">
                      <div class="list-refer-3">
                        <c:if test="${op.status==1}">
                        <P><strong>已评价</strong></P>
                        </c:if>
                        <c:if test="${op.status!=1}">
                          <P><strong>未评价</strong></P>
                        </c:if>
                      </div>
                    </td>
                    <td width="120">
                      <div class="list-refer-4">
                        <P><a href="#" class="act-ui">查看评价</a></P>
                      </div>
                    </td>
                  </tr>
                </table>
              </div>
              <!--追加评价状态-->
              <c:if test="${op.status==1}">
              <div class="mutual" style="display: none">
                <div class="parameter">
                  <form>
                    <ul class="data">
                      <%--<li class="data-list">--%>
                        <%--<label>评分：</label>--%>
                        <%--<div class="starbox">--%>
                          <%--<div id="quacorgrading">--%>
                            <%--<input name="1" type="button" />--%>
                            <%--<input name="2" type="button" />--%>
                            <%--<input name="3" type="button" />--%>
                            <%--<input name="4" type="button" />--%>
                            <%--<input name="5" type="button" />--%>
                            <%--<span id="QuacorGradingValue"><b><font size="5" color="#fd7d28">0</font></b>分</span>--%>
                          <%--</div>--%>
                        <%--</div>--%>
                      <%--</li>--%>
                      <li class="data-list">
                        <dl>
                          <dt>
                            <label>心得：</label>
                          </dt>
                          <dd>
                            <span class="am-txt">
                              ${op.purchaseOrderComment.content}
                            </span>
                          </dd>
                        </dl>
                      </li>

                    </ul>
                  </form>
                </div>
              </div>
              </c:if>
              <!--没有评价状态-->
              <c:if test="${op.status!=1}">
              <div class="mutual" style="display: none">
                <div class="parameter">
                  <form action="<c:url value="/comment/saveComment.do"/>" method="post">
                    <ul class="data">
                      <li class="data-list">
                        <dl>
                          <dt>
                            <label>心得：</label>
                          </dt>
                          <dd>
                            <span class="am-txt" style="width: 640px;">
                              <textarea class="rarae" name="content"></textarea>
                            </span>
                          </dd>
                        </dl>
                        <input type="hidden" value="${op.id}" name="productId">
                        <input type="hidden" value="${finish.id}" name="orderId">
                      </li>
                      <li class="data-list">
                        <dl>
                          <dt>
                            <label></label>
                          </dt>
                          <dd>
                            <input type="submit" class="btn" value="评&nbsp&nbsp&nbsp&nbsp价" >
                               <%--<span style="margin-left: 44px;font-size: 12px;">--%>
                                 <%--<input type="checkbox" class="btn" value="评&nbsp&nbsp&nbsp&nbsp价">--%>
                                 <%--匿名评价--%>
                               <%--</span>--%>
                          </dd>
                        </dl>
                      </li>
                    </ul>
                  </form>
                </div>
              </div>
              </c:if>
            </div>
                </c:forEach>
            </c:forEach>
            <!--状态查看评价-->
            <!--状态发表评价-->
            <%--<div class="appraise">--%>
              <%--<div class="table">--%>
                <%--<table>--%>
                  <%--<tr>--%>
                    <%--<td width="400">--%>
                      <%--<div class="list-refer">--%>
                        <%--<dl>--%>
                          <%--<dt><a href="#"> <img src="<c:url value="/scripts/upload/pep-2.jpg"/>"></a></dt>--%>
                          <%--<dd>禅意香薰陶瓷哥窑龙泉青瓷盘香香炉</dd>--%>
                        <%--</dl>--%>
                      <%--</div>--%>
                    <%--</td>--%>
                    <%--<td width="180">--%>
                      <%--<div class="list-refer-2">--%>
                        <%--<p>2015—08—01</p>--%>

                        <%--<p>18:29:30</p>--%>
                      <%--</div>--%>
                    <%--</td>--%>
                    <%--<td width="150">--%>
                      <%--<div class="list-refer-3">--%>
                        <%--<P><strong>未评价</strong></P>--%>
                      <%--</div>--%>
                    <%--</td>--%>
                    <%--<td width="120">--%>
                      <%--<div class="list-refer-4">--%>
                        <%--<P><a href="#" class="act-ui">发表评价</a></P>--%>
                      <%--</div>--%>
                    <%--</td>--%>
                  <%--</tr>--%>
                <%--</table>--%>
              <%--</div>--%>
              <!--状态2内容-->
              <%--<div class="mutual" style="display: none">--%>
                <%--<div class="parameter">--%>
                  <%--<form>--%>
                    <%--<ul class="data">--%>
                      <%--<li class="data-list">--%>
                        <%--<label>评分：</label>--%>
                        <%--<div class="starbox">--%>
                          <%--<div id="quacorgrading">--%>
                            <%--<input name="1" type="button" />--%>
                            <%--<input name="2" type="button" />--%>
                            <%--<input name="3" type="button" />--%>
                            <%--<input name="4" type="button" />--%>
                            <%--<input name="5" type="button" />--%>
                            <%--<span id="QuacorGradingValue"><b><font size="5" color="#fd7d28">0</font></b>分</span>--%>
                          <%--</div>--%>
                        <%--</div>--%>
                      <%--</li>--%>
                      <%--<li class="data-list">--%>
                        <%--<dl>--%>
                          <%--<dt>--%>
                            <%--<label>标签：</label>--%>
                          <%--</dt>--%>
                          <%--<dd>--%>
                            <%--<ul class="tally">--%>
                              <%--<li class="djml">材&nbsp质材&nbsp质材&nbsp质材&nbsp质</li>--%>
                              <%--<li class="djml">材&nbsp质材&nbsp质材&nbsp质材&nbsp质</li>--%>
                              <%--<li class="djml">材&nbsp质材&nbsp质材&nbsp质材&nbsp质</li>--%>
                              <%--<li class="djml">材&nbsp质材&nbsp质材&nbsp质材&nbsp质</li>--%>
                            <%--</ul>--%>
                          <%--</dd>--%>
                        <%--</dl>--%>
                      <%--</li>--%>
                      <%--<li class="data-list">--%>
                        <%--<dl>--%>
                          <%--<dt>--%>
                            <%--<label>心得：</label>--%>
                          <%--</dt>--%>
                          <%--<dd>--%>
                                                   <%--<span class="am-txt" style="width: 640px;">--%>
                                                       <%--<textarea class="rarae" ></textarea>--%>
                                                   <%--</span>--%>
                          <%--</dd>--%>
                        <%--</dl>--%>
                      <%--</li>--%>
                      <%--<li class="data-list">--%>
                        <%--<dl>--%>
                          <%--<dt>--%>
                            <%--<label></label>--%>
                          <%--</dt>--%>
                          <%--<dd>--%>
                            <%--<input type="button" class="btn" value="评&nbsp&nbsp&nbsp&nbsp价">--%>
                                                        <%--<span style="margin-left: 44px;font-size: 12px;">--%>
                                                        <%--<input type="checkbox" class="btn"--%>
                                                               <%--value="评&nbsp&nbsp&nbsp&nbsp价">--%>
                                                            <%--匿名评价--%>
                                                        <%--</span>--%>
                          <%--</dd>--%>
                        <%--</dl>--%>
                      <%--</li>--%>
                    <%--</ul>--%>
                  <%--</form>--%>
                <%--</div>--%>
              <%--</div>--%>
              <!--状态2内容-->
            <%--</div>--%>
            <!--状态发表评价-->
            <!--状态追加评价-->
            <%--<div class="appraise">--%>
              <%--<div class="table">--%>
                <%--<table>--%>
                  <%--<tr>--%>
                    <%--<td width="400">--%>
                      <%--<div class="list-refer">--%>
                        <%--<dl>--%>
                          <%--<dt><a href="#"> <img src="<c:url value="/scripts/upload/pep-2.jpg"/>"></a></dt>--%>
                          <%--<dd>禅意香薰陶瓷哥窑龙泉青瓷盘香香炉</dd>--%>
                        <%--</dl>--%>
                      <%--</div>--%>
                    <%--</td>--%>
                    <%--<td width="180">--%>
                      <%--<div class="list-refer-2">--%>
                        <%--<p>2015—08—01</p>--%>

                        <%--<p>18:29:30</p>--%>
                      <%--</div>--%>
                    <%--</td>--%>
                    <%--<td width="150">--%>
                      <%--<div class="list-refer-3">--%>
                        <%--<P><strong>已评价</strong></P>--%>
                      <%--</div>--%>
                    <%--</td>--%>
                    <%--<td width="120">--%>
                      <%--<div class="list-refer-4">--%>
                        <%--<P><a href="#" class="act-ui">查看评价</a></P>--%>
                      <%--</div>--%>
                    <%--</td>--%>
                  <%--</tr>--%>
                <%--</table>--%>
              <%--</div>--%>
              <%--<!--状态3内容-->--%>
              <%--<div class="mutual" style="display: none">--%>
                <%--<div class="parameter">--%>
                  <%--<form>--%>
                    <%--<ul class="data">--%>
                      <%--<li class="data-list">--%>
                        <%--<label>评分：</label>--%>
                        <%--<div class="starbox">--%>
                          <%--<div id="quacorgrading">--%>
                            <%--<input name="1" type="button" />--%>
                            <%--<input name="2" type="button" />--%>
                            <%--<input name="3" type="button" />--%>
                            <%--<input name="4" type="button" />--%>
                            <%--<input name="5" type="button" />--%>
                            <%--<span id="QuacorGradingValue"><b><font size="5" color="#fd7d28">0</font></b>分</span>--%>
                          <%--</div>--%>
                        <%--</div>--%>
                      <%--</li>--%>
                      <%--<li class="data-list">--%>
                        <%--<dl>--%>
                          <%--<dt>--%>
                            <%--<label>标签：</label>--%>
                          <%--</dt>--%>
                          <%--<dd>--%>
                            <%--<ul class="tally">--%>
                              <%--<li class="djml">材&nbsp质材&nbsp质材&nbsp质材&nbsp质</li>--%>
                              <%--<li class="djml">材&nbsp质材&nbsp质材&nbsp质材&nbsp质</li>--%>
                              <%--<li class="djml">材&nbsp质材&nbsp质材&nbsp质材&nbsp质</li>--%>
                              <%--<li class="djml">材&nbsp质材&nbsp质材&nbsp质材&nbsp质</li>--%>
                            <%--</ul>--%>
                          <%--</dd>--%>
                        <%--</dl>--%>
                      <%--</li>--%>
                      <%--<li class="data-list">--%>
                        <%--<dl>--%>
                          <%--<dt>--%>
                            <%--<label>心得：</label>--%>
                          <%--</dt>--%>
                          <%--<dd>--%>
                            <%--<span class="am-txt"> 宝贝是否满意，宝贝是否满意，是否满意宝贝是否满意，宝贝是否满意，是否满意--%>
                              <%--宝贝是否满意，宝贝是否满意，是否满意宝贝是否满意，宝贝是否满意，是否满意--%>
                            <%--</span>--%>
                          <%--</dd>--%>
                        <%--</dl>--%>
                      <%--</li>--%>
                      <%--<li class="data-list">--%>
                        <%--<dl>--%>
                          <%--<dt>--%>
                            <%--<label>晒单：</label>--%>
                          <%--</dt>--%>
                          <%--<dd>--%>
                            <%--<ul class="tally-1">--%>
                              <%--<li class="img-act"><img src="<c:url value="/scripts/upload/pep-2.jpg"/>"></li>--%>
                              <%--<li class="img-act"><img src="<c:url value="/scripts/upload/pep-2.jpg"/>"></li>--%>
                            <%--</ul>--%>
                          <%--</dd>--%>
                        <%--</dl>--%>
                      <%--</li>--%>
                      <%--<li class="data-list" >--%>
                        <%--<div class="con-vessel">--%>
                          <%--<ul class="dialogue">--%>
                            <%--<!--卖家回复状态-->--%>
                            <%--<li class="list-crossover">--%>
                              <%--<dl class="content">--%>
                                <%--<dt class="dt">卖家回复：</dt>--%>
                                <%--<dd>h宝贝是否满意，宝贝是否满意，是否满意宝贝是否满意，宝贝是否满意，是否满意 宝贝是否满意，宝贝是否满意，是否满意宝贝是否满意，宝贝是否满意，是否满意 宝贝是否满意，宝贝是否满意，是否满意宝贝是否满意，宝贝是否满意，是否满意 宝贝是否满意，宝贝是否满意，是否满意宝贝是否满意，宝贝是否满意，是否满意 宝贝是否满意，宝贝是否满意，是否满意宝贝是否满意，宝贝是否满意，是否满意 宝贝是否满意，宝贝是否满意，是否满意宝贝是否满意，宝贝是否满意，是否满意 宝贝是否满意，宝贝是否满意，是否满意宝贝是否满意，宝贝是否满意，是否满意 宝贝是否满意，宝贝是否满意，是否满意宝贝是否满意，宝贝是否满意，是否满意</dd>--%>
                              <%--</dl>--%>
                            <%--</li>--%>
                            <%--<!--卖家回复状态-->--%>
                            <%--<!--买家回复的状态-->--%>
                            <%--<!--文字标题部分-->--%>
                            <%--<li class="list-crossover">--%>
                              <%--<dl class="content">--%>
                                <%--<dt class="dt1">收货2个月后追加的评价：</dt>--%>
                                <%--<dd class="dd">h宝贝是否满意，宝贝是否满意，是否满意宝贝是否满意，宝贝是否满意，是否满意 宝贝是否满意，宝贝是否满意，是否满意宝贝是否满意，宝贝是否满意，是否满意 宝贝是否满意，宝贝是否满意，是否满意宝贝是否满意，宝贝是否满意，是否满意 宝贝是否满意，宝贝是否满意，是否满意宝贝是否满意，宝贝是否满意，是否满意 宝贝是否满意，宝贝是否满意，是否满意宝贝是否满意，宝贝是否满意，是否满意 宝贝是否满意，宝贝是否满意，是否满意宝贝是否满意，宝贝是否满意，是否满意 宝贝是否满意，宝贝是否满意，是否满意宝贝是否满意，宝贝是否满意，是否满意 宝贝是否满意，宝贝是否满意，是否满意宝贝是否满意，宝贝是否满意，是否满意</dd>--%>
                              <%--</dl>--%>
                            <%--</li>--%>
                            <%--<!--img-->--%>
                            <%--<li class="list-crossover">--%>
                              <%--<dl class="content">--%>
                                <%--<dt class="dt">--%>
                                  <%--<label></label>--%>
                                <%--</dt>--%>
                                <%--<dd>--%>
                                  <%--<ul class="add-images">--%>
                                    <%--<li><img src="<c:url value="/scripts/upload/pep-2.jpg"/>"></li>--%>
                                    <%--<li><img src="<c:url value="/scripts/upload/pep-2.jpg"/>"></li>--%>
                                  <%--</ul>--%>
                                <%--</dd>--%>
                              <%--</dl>--%>
                            <%--</li>--%>
                            <%--<!--买家回复的状态-->--%>
                          <%--</ul>--%>
                        <%--</div>--%>
                      <%--</li>--%>
                    <%--</ul>--%>
                  <%--</form>--%>
                <%--</div>--%>
              <%--</div>--%>
              <%--<!--状态3内容-->--%>
            <%--</div>--%>
          </div>
          <!-- //End--title-->
        </div>
      </div>
    </div>
  </div>
</div>
<script>
  function a1(obj){
    $(obj).hide();
    $('#zt',$(obj).parents("ul")).slideToggle();
  }
  $(function(){
    $('.act-ui').click(function(){
      $(this).parents('.table').siblings('.mutual').slideToggle();
      return false;
    })
  })
</script>
<!--content-->
<!-- //End--footer-->

<!--[if (gte IE 9)|!(IE)]><!-->
<script src="<c:url value="/scripts/js/jquery.min.js"/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value="/scripts/js/amazeui.ie8polyfill.min.js"/>"></script>
<![endif]-->
<script src="<c:url value="/scripts/js/amazeui.min.js"/>"></script>
<!--<script src="../shop2015/js/system.js"></script>-->
<script src="<c:url value="/scripts/js/myorder.js"/>"></script>
</body>
</html>