<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">审核</strong>
    </div>
</div>
<hr/>
<c:if test="${review=='2' || review=='3'}">
<div class="am-g">



        <form action="<c:url value="/basic/xm.do"/>" method="post" class="am-form am-form-horizontal"
              enctype="multipart/form-data">

            <div class="am-form-group">
                <label for="content" class="am-u-sm-3 am-form-label">审核意见</label>

                <div class="am-u-sm-9">
                    <textarea id="content" name="content" rows="4" cols="5" placeholder="审核意见,用冒号分开" ></textarea>
                    <%--<input type="text" id="content" name="content" placeholder="企业商家简介" value="${object.content}" required>--%>
                </div>
            </div>

            <div class="am-form-group" style="margin-left: 26.3%">
                <a href="javascript:void (0);" onclick="toSubmitReview('3');" class="am-btn am-btn-primary am-btn-xs">审核失败</a>
                <a href="javascript:void (0);" onclick="toSubmitReview('4');" class="am-btn am-btn-primary am-btn-xs">审核成功</a>
            </div>
        </form>
</div>
</c:if>
<div class="am-g">
    <div class="am-u-md-12">
        <h2>审核记录</h2>
    </div>

    <div class="am-u-md-12">
        <jsp:include flush="true"
                     page="/master/masterReviewList.do">
            <jsp:param name="masterId" value="${masterId}" />
        </jsp:include>
    </div>
</div>
<script>
    function toSubmitReview(review){
        var masterId = '${masterId}';
        var content = $("#content").val();
        if(content==""){
            alert("请填写审核意见!");
        }else {
            $.ajax({
                type: "get",
                url: '<c:url value="/master/toSubmitReview.do"/>',
                cache: false,
                dataType: "json",
                data: {masterId: masterId, content: content, review: review},
                success: function (data) {
                    window.location.href = "<c:url value="/basic/xm.do?qm=formMasterReview&id=" />" + masterId ;

                }
            });
        }
    }

</script>
</body>
</html>
