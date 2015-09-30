<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head></head>
<body>
<!--//End--header-->
<div class="commodity">
  <div class="discount">
    <div class="on-list">
      <!--一个收藏商品-->
   <c:forEach items="${collectList}" var="collectList">
      <div class="act-wid">
        <dl>
          <dt><a href="<c:url value="/product/productModel/${collectList.productModel.id}"/>"><img width="150"height="150" src="http://pro.efeiyi.com/${collectList.productModel.productModel_url}@!product-icon"></a></dt>
          <dd>
            <p class="commodity-bt"><a href="<c:url value="/product/productModel/${collectList.productModel.id}"/>" style="color: #666;font-size: 12px;">${collectList.productModel.product.name}</a></p>
            <p><a href="#" onclick="showConfirm('提示','是否取消',function(){
                    window.location.href='<c:url value="/purchaseCollect/unfollow.do?id=${collectList.id}"/>';
                    })"  class="edit-dete">取消收藏</a><strong>￥${collectList.productModel.price}</strong></p>
          </dd>
        </dl>
      </div>
    </c:forEach>
    </div>
  </div>
</div>
<!--Strat--删除弹出框-->
<%--<div class="alert-delete" style="display:none">--%>
  <%--<div class="content">--%>
    <%--<div class="bd title">提示</div>--%>
    <%--<div class="bd info">您确定要取消收藏？</div>--%>
    <%--<div class="bd btns">--%>
      <%--<a class="btn-true" href="<c:url value="/purchaseCollect/unfollow.do?id=${collectList.id}"/>" title="确定">确定</a>--%>
      <%--<a class="btn-false" href="#取消" title="取消">取消</a>--%>
    <%--</div>--%>
  <%--</div>--%>
  <%--<div class="overbg"></div>--%>
<%--</div>--%>
</body>
</html>
