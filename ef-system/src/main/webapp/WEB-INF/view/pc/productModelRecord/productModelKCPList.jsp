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
        function toUpdateAmount(obj,updateUrl) {
            $('#my-prompt').modal({
                relatedTarget: this,
                onConfirm: function(e) {
                    var amount = $("#amount").val();
                    var creator = $("#creator").val();
                    var id = $(obj).attr("id");
                    $.ajax({
                        type: "get",
                        url: updateUrl,
                        cache: false,
                        dataType: "json",
                        data:{id:id,amount:amount,creator:creator},
                        success: function (data) {

                            $(obj).text(data);
                            $("#creator").val("");
                            $("#amount").val("");
                        }
                    });
                },
                onCancel: function(e) {
                    // alert('不想说!');
                }
            });


        }


    </script>
</head>
<body>
<%--点击立即发货的时候弹出的模态对话框--%>
<div class="am-modal am-modal-prompt" tabindex="-1" id="my-prompt">
    <div class="am-modal-dialog">
        <%--<div class="am-modal-hd">Amaze UI</div>--%>
        <div class="am-modal-bd">
            <div>入库者</div>
            <div>
                <input type="text" id="creator" name="creator" class="am-modal-prompt-input">

            </div>
            <div>入库数(若减库 则加"-"号 ，如-5 )</div>
            <div>
                <input type="text" id="amount" name="amount" class="am-modal-prompt-input">

            </div>
        </div>
        <div class="am-modal-footer">
            <span class="am-modal-btn" data-am-modal-cancel>取消</span>
            <span class="am-modal-btn" data-am-modal-confirm>提交</span>
        </div>
    </div>
</div>
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
                    <th class="table-title">产品名称</th>
                    <th class="table-title">产品编号</th>
                    <th class="table-title">产品价格</th>
                    <th class="table-title">库存</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${requestScope.pageInfo.list}" var="productModel">
                    <tr id="${productModel.id}">
                        <td>
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs">

                                    <a  class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                       href=""><span
                                            class="am-icon-trash-o">查看记录</span>
                                    </a>
                                </div>
                            </div>
                        </td>
                        <td class="am-hide-sm-only">
                            ${productModel.name}
                        </td>
                        <td class="am-hide-sm-only">${productModel.serial}</td>
                        <td class="am-hide-sm-only">${productModel.price}</td>
                        <td class="am-hide-sm-only">
                            <a href="javascript:void (0);" amount="${productModel.amount}" id="${productModel.id}" onclick="toUpdateAmount(this,'<c:url value="/product/updateAmount.do"/>')">${productModel.amount}</a>
                         </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div style="clear: both">
        <c:url value="/basic/xm.do" var="url"/>
        <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
            <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
            <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
        </ming800:pcPageList>
    </div>
</div>
</body>
</html>
