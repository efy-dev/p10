<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head></head>
<body>
<!--//End--header-->
<div class="my-evaluate ae">
  <c:forEach items="${finishOrder.purchaseOrderProductList}" var="orderProduct" varStatus="op">
    <c:if test="${orderProduct.status!='1'}">
  <div class="merchandise pg ae" sd="${op.index}">
    <div class="mer-pic"><a href="#"><img src="<c:url value="http://pro.efeiyi.com/${orderProduct.productModel.productModel_url}"/>"></a></div>
    <div class="mer-text ae">
      <p>${orderProduct.productModel.name}</p>
      <p>￥${orderProduct.productModel.price}</p>
    </div>
  </div>
  <div class="score ae">
    <form id="stars" action="<c:url value="/comment/saveComment.do"/>">
      <input name="productId" value="${orderProduct.id}" type="hidden"/>
      <input name="orderId" value="${finishOrder.id}" type="hidden"/>
      <input id="starCount" type="hidden" name="starts" value=""/>
      <div class="score-star pg ae">
        <div class="ae mb">
          <label>评分：</label>
          <div class="star" id="star">
            <i class="a-star"></i>
            <i class="a-star"></i>
            <i class="a-star"></i>
            <i class="a-star"></i>
            <i class="a-star"></i>
          </div>
        </div>
      </div>
      <div class="score-estimate ae">
        <label class="ae">评价：</label>
        <textarea class="ae sc-text" name="content"></textarea>
      </div>
      <div class="bask ae">
        <label class="ae">晒单：</label>
        <div class="file-pic" id="sd${op.index}">
          <a class="fileimg fi-icon"><input id="uploadInput${op.index}"  style="display:block;height:68px;width:68px;opacity:0;"></a>
        </div>

      </div>
      <input type="button" class="butt" value="提&nbsp;&nbsp;&nbsp;&nbsp;交" onclick="tj(this);">
    </form>
  </div>
    </c:if>
  </c:forEach>
</div>
<script src="<c:url value="/scripts/js/jquery.uploadify.min.js"/>"></script>

<script>
  $(function(){
    //简洁用户评分代码
    $(".my-evaluate .score .score-star .star .a-star").click(function(){
      $(this).addClass("ye-star");
      $(this).prevAll().addClass("ye-star");
      $(this).nextAll().removeClass("ye-star");
    });

  })
  function tj(obj){
    var count= $(".ye-star",$(obj).parents("form")).length;
    $("#starCount").attr("value",count);
    $(obj).parents("form").submit();
  }

  function addPhotoDynamic(photoUrl,sd){
    var sdtp=$("#sd"+sd);
    var sub= "<div class=\"li-img\"><img src=\"http://pro.efeiyi.com/"+photoUrl+"@!info-user-pic\"><input type='hidden' value='"+photoUrl+"' name='url' /></div>"
    sdtp.prepend(sub);
  }

  $(function () {
    $(".merchandise").each(function(){
     var sd=$(this).attr("sd");
      $("#uploadInput"+sd).uploadify({
        width: 106,
        height: 30,
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
    })

  });



</script>
</body>
</html>