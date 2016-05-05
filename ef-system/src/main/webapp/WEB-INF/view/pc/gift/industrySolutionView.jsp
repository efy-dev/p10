<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/5/5 0005
  Time: 10:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>


<div class="am-g">

    <div class="am-u-md-12">

        <h2>${object.solutionName}</h2>

        <div class="am-u-md-12"><h3>礼品关联列表</h3></div>

        <div class="am-u-md-12">
            <div class="am-btn-toolbar">
                <div class="am-btn-group am-btn-group-xs">
                    <a type="button" class="am-btn am-btn-default"
                       href="<c:url value="/basic/xm.do?qm=plistProductGift_industry&industrySolutionId=${object.id}"/>"><span
                            class="am-icon-plus"></span>新建礼品关联</a>

                </div>
            </div>
        </div>

        <div class="am-u-md-12">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>
                    <th class="table-set">操作</th>
                    <th class="table-title">礼品名称</th>
                    <th class="table-title">礼品图片</th>

                </tr>
                </thead>
                <tbody>

                <c:forEach items="${giftList}" var="productGift">
                    <tr id="${productGift.id}">
                        <td width="10%">
                            <div class="am-btn-toolbar">
                                <div class="am-btn-gro up am-btn-group-xs">
                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                       onclick="showConfirm('提示','是否取消关联',function(){removeIndustrySolutionProductGift('${productGift.id}')})"
                                       href="#"><span
                                            class="am-icon-trash-o"></span> 取消关联
                                    </a>
                                </div>
                            </div>
                        </td>
                        <td class="am-hide-sm-only" width="10%">
                            <a href="#">
                                    ${productGift.productGift.name}
                            </a>
                        </td>
                        <td class="am-hide-sm-only" width="10%">
                            <img src="http://pro.efeiyi.com/${productGift.productGift.productModel.productModel_url}@!product-model">

                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

</div>
<script>

    function removeIndustrySolutionProductGift(divId) {
        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeProductGiftIndustrySolution"/>',
            cache: false,
            dataType: "json",
            data: {id: divId},
            success: function (data) {
                $("#" + divId).remove();
            }
        });
    }

</script>
</body>
</html>
