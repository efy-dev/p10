<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/25
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title></title>
    <script>
    </script>

</head>
<body>
<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>
<div class="admin-content">
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-6">
        </div>
        <div class="am-u-sm-12">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>
                    <th class="table-set">操作</th>
                    <th class="table-title">订单编号</th>
                    <th class="table-title">用户名</th>
                    <th class="table-title">总额/实付金额(元)</th>
                    <th class="table-title">商品规格</th>
                    <th class="table-title">星级</th>
                    <th class="table-title">评价内容</th>
                    <th class="table-title">评价时间</th>
                    <th class="table-title">回复内容</th>
                    <th class="table-title">回复时间</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${requestScope.pageInfo.list}" var="purchaseOrderComment">
                    <tr id="${purchaseOrderComment.id}" width="10%">
                        <td width="14%">

                                  <span>
                                      <c:if test="${empty purchaseOrderComment.purchaseOrderBusinessReply}">
                                          <input flag="false" type="checkbox" name="reply" value="${purchaseOrderComment.id}" />
                                      </c:if>
                                      <c:if test="${not empty purchaseOrderComment.purchaseOrderBusinessReply}">
                                          <input flag="true" type="checkbox" name="reply" value="${purchaseOrderComment.id}" disabled="disabled"/>
                                      </c:if>
                                  </span>
                                  <span>
                                       <c:if test="${empty purchaseOrderComment.purchaseOrderBusinessReply}">
                                           <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="javascript:void (0);" onclick="reply(this,'reply');">
                                               回复评论
                                           </a>
                                       </c:if>
                                        <c:if test="${not empty purchaseOrderComment.purchaseOrderBusinessReply}">
                                            <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" disabled="disabled" href="javascript:void (0);" onclick="reply(this,'reply');" >
                                                已回复
                                            </a>
                                        </c:if>
                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="javascript:void (0);" onclick="showConfirm('提示','是否删除',function(){removePurchaseOrderComment('${purchaseOrderComment.id}')})">
                                        删除
                                    </a>
                                  </span>

                        </td>
                        <td class="am-hide-sm-only" width="10%">
                            <a
                                    href="<c:url value='/basic/xm.do?qm=viewPurchaseOrder&viewIdentify=comment&id=${purchaseOrderComment.purchaseOrderProduct.purchaseOrder.id}'/>">${purchaseOrderComment.purchaseOrderProduct.purchaseOrder.serial}
                            </a>
                        </td>

                        <td class="am-hide-sm-only" width="10%">${purchaseOrderComment.purchaseOrderProduct.purchaseOrder.user.username}</td>
                        <td class="am-hide-sm-only" width="10%">
                            <fmt:formatNumber type="number" value="${purchaseOrderComment.purchaseOrderProduct.productModel.price}" maxFractionDigits="2" minFractionDigits="2"/> <br>
                        </td>
                        <td class="am-hide-sm-only" width="10%">
                            <p style="margin-left: 10px;">
                                <a href="<c:url value='/basic/xm.do?qm=viewPurchaseOrderProduct&view=${view}&id=${purchaseOrderComment.purchaseOrderProduct.id}'/>">
                                        ${purchaseOrderComment.purchaseOrderProduct.productModel.name}
                                </a>
                                <img width="20px" src="http://pro.efeiyi.com/${purchaseOrderComment.purchaseOrderProduct.productModel.productModel_url}@!product-model" alt="产品图片">
                            </p>
                        </td>
                        <td class="am-hide-sm-only" width="6%">${purchaseOrderComment.starts}</td>
                        <td class="am-hide-sm-only" width="10%">${purchaseOrderComment.content}</td>
                        <td class="am-hide-sm-only" width="10%">
                            <fmt:formatDate value="${purchaseOrderComment.createDatetime}" type="both" pattern="yyyy-MM-dd HH:mm"/>
                        </td>
                        <td class="am-hide-sm-only" width="10%">${purchaseOrderComment.purchaseOrderBusinessReply.reply}</td>
                        <td class="am-hide-sm-only" width="14%">
                            <fmt:formatDate value="${purchaseOrderComment.purchaseOrderBusinessReply.createDatetime}" type="both" pattern="yyyy-MM-dd HH:mm"/>
                        </td>
                    </tr>

                </c:forEach>
                </tbody>
            </table>
        </div>
        <div style="margin-left: 32px;">
            <input type="checkbox"  name="all"  />&nbsp;全选
            <a style="margin-left: 15px;" onclick="reply(this,'allReply')" href="javascript:void (0)">批量回复</a>
        </div>

    </div>
    <div style="clear: both">
        <c:url value="/basic/xm.do" var="url"/>
        <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
            <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
            <ming800:pcPageParam name="view" value="delivery"/>
            <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
        </ming800:pcPageList>
    </div>
</div>

<!-- 回复-->
<div class="am-modal am-modal-prompt" tabindex="-1" id="my-prompt">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">评论回复</div>
        <div class="am-modal-bd">
            <textarea id="replyText" class="" rows="5" style="width: 470px;"></textarea>
        </div>
        <div class="am-modal-footer">
            <span class="am-modal-btn" data-am-modal-cancel>取消</span>
            <span class="am-modal-btn" data-am-modal-confirm>提交</span>
        </div>
    </div>
</div>
<script>
    $(function(){
        isDisabled();
        $("input[name='all']").click(function() {
            $('input[name="reply"][flag="false"]').prop("checked",this.checked);
        });

        $("input[name='reply'][flag='false']").click(function(){
            var $reply = $("input[name='reply'][flag='false']");
            $("input[name='all']").prop("checked",$reply.length == $("input[name='reply'][flag='false']:checked").length ? true : false);
        });
    });
    var ids = [];
    function reply(obj,flag){
        ids.splice(0,ids.length);
        var f = true;
        if(flag=="allReply"){
            if($('input[name="reply"][flag="false"]:checked').length==0){
                alert("请选择要回复的评论!");
                f= false;
            }else {
                $('input[name="reply"][flag="false"]:checked').each(function () {
                    ids.push($(this).parents("tr").attr("id"));
                });
            }
        }else{
            ids.push($(obj).parents("tr").attr("id"))
        }
        if(f) {
            $('#my-prompt').modal({
                relatedTarget: this,
                onConfirm: function (e) {
                    var reply = $("#replyText").val();
                    var uriec = encodeURI(reply);
                    $.ajax({
                        type: "GET",
                        url: '<c:url value="/PurchaseOrderComment/reply.do"/>',
                        data: {ids: ids, reply: uriec},
                        dataType: "json",
                        success: function (data) {
                            for (var i = 0; i<ids.length; i++) {
                                $("tr[id='" + ids[i] + "'] td:eq(8)").text(reply);
                                $("tr[id='" + ids[i] + "'] td:eq(9)").text(data);
                                var check = $("tr[id='" + ids[i] + "'] input[name='reply']");
                                $(check).attr("flag","true");
                                $(check).prop("checked",false);
                                $(check).attr("disabled","disabled");
                                var a = $("tr[id='" + ids[i] + "'] td:eq(0) a:eq(0)");
                                $(a).text("已回复");
                                $(a).attr("disabled","disabled");


                            }
                            isDisabled();
                        }
                    });
                    document.getElementById("replyText").value = "";
                },
                onCancel: function (e) {
                    document.getElementById("replyText").value = "";
                }
            });
        }

    }
    function isDisabled(){
        if($("input[name='reply'][flag='false']").length==0){
            $("input[name='all']").prop("checked",false);
            $("input[name='all']").prop("disabled","disabled");
        }
    }
</script>
</body>
</html>
