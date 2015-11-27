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
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title></title>
    <script>
        <%--function removeProduct(productId){--%>
            <%--jQuery.ajax({--%>
                <%--type:"GET",--%>
                <%--url:'<c:url value="/basic/xmj.do?qm=removeProduct"/>',--%>
                <%--data:{id:productId},--%>
                <%--dataType:"json",--%>
                <%--success:function(data){--%>
                    <%--$("#"+productId).remove();--%>
                <%--}--%>
            <%--});--%>
        <%--}--%>
    </script>
</head>
<body>


<div style="text-align: left" >
<security:authorize ifAnyGranted="admin,operational,c_operational,o_operational">
    <a class="am-btn am-btn-default am-btn-xs am-text-secondary"
       href="<c:url value="/basic/xm.do?qm=formSeckillProduct" />"><span
            class="am-icon-pencil-square-o">新建秒杀商品</span>
    </a>
    </security:authorize>
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
<security:authorize ifAnyGranted="admin,operational,c_operational,o_operational">
                    <th class="table-set" >操作</th>
</security:authorize>
                    <th class="table-title">秒杀商品</th>
                    <th class="table-title">秒杀价格</th>
                    <th class="table-title">限购数量</th>
                    <th class="table-title">库存</th>
                    <th class="table-title">关注数</th>
                    <th class="table-title">秒杀开始时间</th>
                    <th class="table-title">秒杀结束时间</th>
                    <th class="table-title">状态</th>
                </tr>
                </thead>
                <tbody>

                <c:forEach items="${requestScope.pageInfo.list}" var="seckillProduct">
                    <tr id="${seckillProduct.id}">
                        <security:authorize ifAnyGranted="admin,operational,c_operational,o_operational">
                        <td width="15%">
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs">
                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="<c:url value="/basic/xm.do?qm=plistPurchaseOrderProductMiao_default&viewIdentify=orderProductMiao&viewProductModel=orderMiao&productModelId=${seckillProduct.productModel.id}&conditions=productModel.id:${seckillProduct.productModel.id}"/>">
                                        查看订单
                                    </a>
                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="<c:url value="/basic/xm.do?qm=formSeckillProduct&id=${seckillProduct.id}"/>">
                                        编辑
                                    </a>
                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" href="javascript:void (0);" onclick="showConfirm('提示','是否删除',function(){removeSeckillProduct('${seckillProduct.id}')})">
                                        删除
                                    </a>

                                </div>
                            </div>
                        </td>
                        </security:authorize>
                        <td class="am-hide-sm-only" width="10%">
                            ${seckillProduct.productModel.name}
                        </td>
                        <td class="am-hide-sm-only" width="10%">
                                ${seckillProduct.price}
                        </td>
                        <td class="am-hide-sm-only" width="7%">
                                ${seckillProduct.limitAmount}
                        </td>
                        <td class="am-hide-sm-only" width="8%">
                                ${seckillProduct.amount}
                        </td>
                        <td class="am-hide-sm-only" width="10%">${seckillProduct.attentionAmount}</td>

                        <td class="am-hide-sm-only" width="12%">
                           <fmt:formatDate value="${seckillProduct.startDatetime}" pattern="yyyy-MM-dd HH:mm:ss" type="both"/>
                        </td>
                        <td class="am-hide-sm-only" width="12%">
                            <fmt:formatDate value="${seckillProduct.endDatetime}" pattern="yyyy-MM-dd HH:mm:ss" type="both"/>
                        </td>
                        <td class="am-hide-sm-only" width="12%">
                            <ming800:status name="showStatus" dataType="SeckillProduct.showStatus" checkedValue="${seckillProduct.status}" type="normal"/>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div style="clear: both">
        <c:url value="/basic/xm.do" var="url" />
        <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
            <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
            <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
        </ming800:pcPageList>
    </div>
</div>
<script>
    function toSendPacket(url){
        $.ajax({
            type: "get",
            url: url,
            cache: false,
            dataType: "json",
            data:{},
            success: function (data) {
              alert("发送成功！");
            }
        });
    }
    function removeSeckillProduct(divId){
        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeSeckillProduct"/>',
            cache: false,
            dataType: "json",
            data:{id:divId},
            success: function (data) {
                $("#"+divId).remove();
            }
        });
    }


</script>

</body>
</html>
