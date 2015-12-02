<%@ page import="com.ming800.core.p.PConst" %>
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
<div class="layout-col evaluation">
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

    <c:forEach items="${finishList}" var="finish" varStatus="status">
      <c:forEach items="${finish.purchaseOrderProductList}" var="op" varStatus="vs">

        <c:if test="${op.status==null or op.status==''}">
          <div class="appraise" status="0" sd="${status.index}${vs.index}">
            <div class="table">
              <table>
                <tr>
                  <td width="400">
                    <div class="list-refer">
                      <dl>
                        <dt><a href="<%=PConst.HOSTNAME%>/product/productModel/${op.productModel.id}"><img src="http://pro.efeiyi.com/${op.productModel.productModel_url}@!product-icon" alt=""></a></dt>
                        <dd><a href="<%=PConst.HOSTNAME%>/product/productModel/${op.productModel.id}">${op.productModel.product.name}</a></dd>
                      </dl>
                    </div>
                  </td>
                  <td width="180">
                    <div class="list-refer-2">
                      <p><fmt:formatDate value="${finish.createDatetime}" pattern="yyyy-MM-dd" /></p>
                      <p><fmt:formatDate value="${finish.createDatetime}" pattern="HH:mm:ss" /></p>
                    </div>
                  </td>
                  <td width="150">
                    <div class="list-refer-3">
                      <P><strong>未评价</strong></P>
                    </div>
                  </td>
                  <td width="120">
                    <div class="list-refer-4">
                      <P><a href="#" class="act-ui">发表评价</a></P>
                    </div>
                  </td>
                </tr>
              </table>
            </div>
            <!--状态1未评价-->
            <div class="mutual" style="display: none">
              <div class="parameter">
                <form action="<c:url value="/comment/saveComment.do"/>" method="post" id="stars">
                    <%--<input name="url" id="url" value="" type="hidden"/>--%>
                  <input name="productId" value="${op.id}" type="hidden"/>
                  <input name="orderId" value="${finish.id}" type="hidden"/>
                  <input id="starCount" type="hidden" name="starts" value=""/>

                  <ul class="data">
                    <li class="data-list">
                      <label>评分：</label>
                      <div class="starbox">
                        <div  class="quacorgrading">
                          <input name="1" onmouseover="star(this)" type="button"  flage="0"/>
                          <input name="2"  onmouseover="star(this)" type="button" flage="0"/>
                          <input name="3" onmouseover="star(this)" type="button"  flage="0"/>
                          <input name="4"  onmouseover="star(this)" type="button" flage="0"/>
                          <input name="5"  onmouseover="star(this)" type="button" flage="0"/>
                        </div>
                      </div>
                    </li>
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
                    </li>
                    <li class="data-list">
                      <dl>
                        <dt>
                          <label>晒单：</label>
                        </dt>
                        <dd>
                          <ul class="add-images" id="sd${status.index}${vs.index}">

                            <li><div class="add-file"><a id="file${status.index}${vs.index}" href="#"></a></div></li>
                          </ul>
                        </dd>
                      </dl>
                    </li>
                    <li class="data-list">
                    <li class="data-list">
                      <dl>
                        <dt>
                          <label></label>
                        </dt>
                        <dd>
                          <input type="button" class="btn" value="评&nbsp&nbsp&nbsp&nbsp价" onclick="comment(this)">
                                 <span style="margin-left: 44px;font-size: 12px;">
                                 <input type="checkbox" class="btn" value="评&nbsp&nbsp&nbsp&nbsp价">匿名评价</span>
                        </dd>
                      </dl>
                    </li>
                  </ul>
                </form>
              </div>
            </div>
          </div>
        </c:if>
        <!--状态2已评价但没有追加评价-->
        <c:if test="${op.status==1}">
          <c:if test="${op.purchaseOrderComment.subPurchaseOrderComment==null}">
            <div class="appraise">
              <div class="table">
                <table>
                  <tr>
                    <td width="400">
                      <div class="list-refer">
                        <dl>
                          <dt><a href="<%=PConst.HOSTNAME%>/product/productModel/${op.productModel.id}"><img src="http://pro.efeiyi.com/${op.productModel.productModel_url}@!product-icon" alt=""></a></dt>
                          <dd><a href="<%=PConst.HOSTNAME%>/product/productModel/${op.productModel.id}">${op.productModel.product.name}</a></dd>
                        </dl>
                      </div>
                    </td>
                    <td width="180">
                      <div class="list-refer-2">
                        <p><fmt:formatDate value="${finish.createDatetime}" pattern="yyyy-MM-dd" /></p>
                        <p><fmt:formatDate value="${finish.createDatetime}" pattern="HH:mm:ss" /></p>
                      </div>
                    </td>
                    <td width="150">
                      <div class="list-refer-3">
                        <P><strong>已评价</strong></P>
                      </div>
                    </td>
                    <td width="120">
                      <div class="list-refer-4">
                        <P><a href="#" class="act-ui">追加评价</a></P>
                      </div>
                    </td>
                  </tr>
                </table>
              </div>
              <div class="mutual" style="display: none">
                <div class="parameter">
                  <form action="<c:url value="/comment/addTOComment.do"/>" method="post">
                    <ul class="data">
                      <li class="data-list">
                        <label>评分：</label>
                        <div class="starbox">
                          <div class="quacorgrading">
                            <c:choose>
                              <c:when test="${op.purchaseOrderComment.starts=='1'}">
                                <span class="x1 xq1"></span>
                              </c:when>
                              <c:when test="${op.purchaseOrderComment.starts=='2'}">
                                <span class="x1 xq2"></span>
                              </c:when>
                              <c:when test="${op.purchaseOrderComment.starts=='3'}">
                                <span class="x1 xq3"></span>
                              </c:when>
                              <c:when test="${op.purchaseOrderComment.starts=='4'}">
                                <span class="x1 xq4"></span>
                              </c:when>
                              <c:when test="${op.purchaseOrderComment.starts=='5'}">
                                <span class="x1 xq5"></span>
                              </c:when>
                              <c:otherwise>
                                <span class="x1 xq5"></span>
                              </c:otherwise>
                            </c:choose>
                          </div>
                        </div>
                      </li>
                        <%--<li class="data-list">--%>
                        <%--<dl>--%>
                        <%--<dt>--%>
                        <%--<label class="lab">标签：</label>--%>
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
                      <li class="data-list">
                        <dl>
                          <dt>
                            <label>心得：</label>
                          </dt>
                          <dd>
                            <span class="am-txt"> ${op.purchaseOrderComment.content}</span>
                          </dd>
                        </dl>
                      </li>
                      <c:if test="${!empty op.purchaseOrderComment.purchaseOrderCommentPictureList}">
                        <li class="data-list">
                          <dl>
                            <dt>
                              <label>晒单：</label>
                            </dt>
                            <dd>
                              <ul class="tally-1">
                                <c:forEach items="${op.purchaseOrderComment.purchaseOrderCommentPictureList}" var="cplist">
                                  <li class="img-act"><img src="http://pro.efeiyi.com/${cplist.pictureUrl}@!info-user-pic"></li>
                                </c:forEach>
                              </ul>
                            </dd>
                          </dl>
                        </li>
                      </c:if>
                      <li class="data-list">
                        <dl>
                          <dt>
                            <label></label>
                          </dt>
                          <dd>
                            <input type="button" class="btn addbtn" value="追&nbsp加&nbsp评&nbsp价&nbsp">
                          </dd>
                        </dl>
                      </li>
                      <div class="con-vessel addcon" style="display: none">
                        <ul class="dialogue">
                          <li class="list-crossover">

                          </li>
                          <!--文字标题部分-->
                          <li class="list-crossover">
                            <dl class="content">
                              <dt class="dt">追加评价：</dt>
                              <dd>
                                <textarea class="rarae" name="content"></textarea>
                                <input type="hidden" name="parentComment" value="${op.purchaseOrderComment.id}"/>
                              </dd>
                            </dl>
                          </li>
                          <!--买家回复的状态-->
                          <li class="list-crossover">
                            <dl class="content">
                              <dt class="dt"><label></label></dt>
                              <dd>
                                <input type="submit" value="确认追加" class="btn">
                              </dd>
                            </dl>
                          </li>
                        </ul>
                      </div>
                    </ul>
                  </form>
                </div>
              </div>
            </div>
          </c:if>
        </c:if>
        <!--状态3已评价已追加内容-->
        <c:if test="${ op.status==1}">
          <c:if test="${op.purchaseOrderComment.subPurchaseOrderComment!=null}">
            <div class="appraise">
              <div class="table">
                <table>
                  <tr>
                    <td width="400">
                      <div class="list-refer">
                        <dl>
                          <dt><a href="<%=PConst.HOSTNAME%>/product/productModel/${op.productModel.id}"><img src="http://pro.efeiyi.com/${op.productModel.productModel_url}@!product-icon" alt=""></a></dt>
                          <dd><a href="<%=PConst.HOSTNAME%>/product/productModel/${op.productModel.id}">${op.productModel.product.name}</a></dd>
                        </dl>
                      </div>
                    </td>
                    <td width="180">
                      <div class="list-refer-2">
                        <p><fmt:formatDate value="${finish.createDatetime}" pattern="yyyy-MM-dd" /></p>
                        <p><fmt:formatDate value="${finish.createDatetime}" pattern="HH:mm:ss" /></p>
                      </div>
                    </td>
                    <td width="150">
                      <div class="list-refer-3">
                        <P><strong>已评价</strong></P>
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
              <!--状态3内容-->
              <div class="mutual" style="display: none">
                <div class="parameter">
                  <form>
                    <ul class="data">
                      <li class="data-list">
                        <label>评分：</label>
                        <div class="starbox">
                          <div class="quacorgrading">
                            <c:choose>
                              <c:when test="${op.purchaseOrderComment.starts=='1'}">
                                <span class="x1 xq1"></span>
                              </c:when>
                              <c:when test="${op.purchaseOrderComment.starts=='2'}">
                                <span class="x1 xq2"></span>
                              </c:when>
                              <c:when test="${op.purchaseOrderComment.starts=='3'}">
                                <span class="x1 xq3"></span>
                              </c:when>
                              <c:when test="${op.purchaseOrderComment.starts=='4'}">
                                <span class="x1 xq4"></span>
                              </c:when>
                              <c:when test="${op.purchaseOrderComment.starts=='5'}">
                                <span class="x1 xq5"></span>
                              </c:when>
                              <c:otherwise>
                                <span class="x1 xq5"></span>
                              </c:otherwise>
                            </c:choose>
                          </div>
                        </div>
                      </li>
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
                      <li class="data-list">
                        <dl>
                          <dt>
                            <label>心得：</label>
                          </dt>
                          <dd>
                            <span class="am-txt">${op.purchaseOrderComment.content}</span>
                          </dd>
                        </dl>
                      </li>
                      <li class="data-list">
                        <dl>
                          <dt>
                            <label>晒单：</label>
                          </dt>
                          <dd>
                            <ul class="tally-1">
                              <c:forEach items="${op.purchaseOrderComment.purchaseOrderCommentPictureList}" var="cplist">
                                <li class="img-act"><img src="http://pro.efeiyi.com/${cplist.pictureUrl}@!info-user-pic"></li>
                              </c:forEach>
                            </ul>
                          </dd>
                        </dl>
                      </li>
                      <li class="data-list" >
                        <div class="con-vessel">
                          <ul class="dialogue">
                            <!--卖家回复状态-->
                              <%--<li class="list-crossover">--%>
                              <%--<dl class="content">--%>
                              <%--<dt class="dt">卖家回复：</dt>--%>
                              <%--<dd></dd>--%>
                              <%--</dl>--%>
                              <%--</li>--%>
                            <li class="list-crossover">
                              <dl class="content">
                                <dt class="dt1">追加的评价：</dt>
                                <dd class="dd">${op.purchaseOrderComment.subPurchaseOrderComment.content}</dd>
                              </dl>
                            </li>
                          </ul>
                        </div>
                      </li>
                    </ul>
                  </form>
                </div>
              </div>
              <!--状态3内容-->
            </div>
          </c:if>
        </c:if>

      </c:forEach>
    </c:forEach>

  </div>
</div>
<script src="<c:url value="/scripts/js/jquery.uploadify.min.js"/>"></script>

<script>

  function comment(obj){
    var count=$("input[flag='1']",$(obj).parents("form")).length
    $("#starCount").attr("value",count);
//    $("#stars").submit();
  alert(count);
  }



  function addPhotoDynamic(photoUrl,sd){
    var sdtp=$("#sd"+sd);
    var sub= "<li><img src=\"http://pro.efeiyi.com/"+photoUrl+"@!info-user-pic\"><i class=\"add-no\"><input type='hidden' value='"+photoUrl+"' name='url' /></inp></li>"

    sdtp.prepend(sub);
  }

  $(function () {
    $("div[status='0']").each(function(){
      var sd = $(this).attr("sd");
      $("#file"+sd).uploadify({
        width: 80,
        height: 80,
        left:0,
        top:0,
        dataType: 'json',
        swf: '<c:url value="/scripts/js/uploadify.swf"/>',
        uploader: '<c:url value="/comment/uploadSd.do"/>',
        'onUploadSuccess':function(file, data, response){
          $('#' + file.id).find('.data').html(' 上传完毕');
          var jsonResult = eval(data);
          addPhotoDynamic(jsonResult,sd);
        },

      });
    });

  });
  function star(obj) {

    $(obj).prevAll("input").each(function () {
      $(this).css({"backgroundPosition": "-5px -21px"});
      $(this).attr("flag", "1");
    });
    $(obj).css({"backgroundPosition": "-5px -21px"});
    $(obj).attr("flag", "1");
    $(obj).nextAll("input").each(function () {
      $(this).css({"backgroundPosition": "-36px -21px"});
      $(this).attr("flag", "0");
    });

  }
</script>
</body>
</html>