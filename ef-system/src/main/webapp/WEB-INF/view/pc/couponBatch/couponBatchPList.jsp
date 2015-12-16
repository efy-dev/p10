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
        function removeCouponBatch(couponBatchId){
            jQuery.ajax({
                type:"GET",
                url:'<c:url value="/couponBatch/removeCouponBatch.do"/>',
                data:{id:couponBatchId},
                dataType:"json",
                success:function(data){
                    $("#"+couponBatchId).remove();
                }
            });
        }

        function createCoupon(obj,url,couponBatchId,amount,deliverType){
            if("3" == deliverType){
                alert("通码不能生成优惠券！");
            }else{
                $.ajax({
                    type:"GET",
                    url:url,
                    data:{id:couponBatchId,amount:amount},
                    success:function(data){
                        $(obj).find("span").text("查看优惠券");
                        $(obj).attr("href",'<c:url value="/basic/xm.do"/>?qm=plistCoupon_couponBatch&view=couponBatch&conditions=couponBatch.id:'+data.substring(1,data.length-1));
                        $(obj).attr("onclick","");
                        window.location.reload();
                    }
                });
            }
        }
        function setDefaultFlag(obj,url,couponBatchId){
            var f = $(obj).find("span").text();
            $.ajax({
                type:"GET",
                url:url,
                data:{id:couponBatchId,ftext:f},
                success:function(data){
                    console.log(data);
                    if("1" != data){
                        $(obj).find("span").text("设置新注册送券");
                    }else{
                        $(obj).find("span").text("取消新注册送券");
                    }
                }
            });
        }

        function createURL(couponBatchId){
            window.prompt("链接","www.efeiyi.com/yhq.do?couponBatchId="+couponBatchId);
        }

    </script>
</head>
<body>

<div class="am-btn-toolbar" style="margin-bottom: 10px">
    <div class="am-btn-group am-btn-group-xs">
<security:authorize ifAnyGranted="admin,operational,o_operational">
        <a type="button" class="am-btn am-btn-default" href="<c:url value="/basic/xm.do?qm=formCouponBatch"/>"><span class="am-icon-plus"></span>新建优惠券批次</a>
</security:authorize>
    </div>
</div>
<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>
        <div class="">
            <div class="am-g">
                <div class="am-u-sm-12 am-u-md-6">
                </div>
                <div class="am-u-sm-12">
                    <table class="am-table am-table-striped am-table-hover table-main">
                        <thead>
                        <tr>
                            <th class="table-set">操作</th>
                            <th class="table-title">优惠券批次名</th>
                            <th class="table-title">优惠券金额</th>
                            <th class="table-title">使用限制金额</th>
                            <th class="table-title">数量</th>
                            <th class="table-title">生效日期</th>
                            <th class="table-title">失效日期</th>
                        </tr>
                        </thead>
                        <tbody>

                        <c:forEach items="${requestScope.pageInfo.list}" var="couponBatch">
                            <tr id="${couponBatch.id}">
                                <td>
                                    <div class="am-btn-toolbar">
                                        <security:authorize ifAnyGranted="admin,operational,o_operational">
                                        <div class="am-btn-group am-btn-group-xs">
                                            <button class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" onclick="showConfirm('提示','是否删除',function(){removeCouponBatch('${couponBatch.id}')})"><span
                                                    class="am-icon-trash-o">删除</span>
                                            </button>
                                            <%--<a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"--%>
                                               <%--href="<c:url value="/basic/xm.do?qm=formCouponBatch&id=${couponBatch.id}"/>"><span--%>
                                                    <%--class="am-icon-trash-o">编辑</span>--%>
                                            <%--</a>--%>

                                            <c:if test="${couponBatch.isCreatedCoupon == 1}">
                                                <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                                   href="#" onclick="createCoupon(this,'<c:url value="/couponBatch/createCoupon.do"/>','${couponBatch.id}','${couponBatch.amount}','${couponBatch.deliverType}')"><span
                                                        class="am-icon-trash-o">创建优惠券</span>
                                                </a>
                                            </c:if>
                                            <c:if test="${couponBatch.isCreatedCoupon == 2}">
                                                <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                                   href="<c:url value="/basic/xm.do?qm=plistCoupon_couponBatch&view=${view}&conditions=couponBatch.id:${couponBatch.id}"/>"><span class="am-icon-trash-o">查看优惠券</span>
                                                </a>
                                            </c:if>

                                            <c:choose>
                                                <c:when test="${couponBatch.defaultFlag != 1}">
                                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                                       href="#" onclick="setDefaultFlag(this,'<c:url value="/couponBatch/setDefaultFlag.do"/>','${couponBatch.id}')" id=""><span
                                                            class="am-icon-trash-o">设置新注册送券</span>
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                                       href="#" onclick="setDefaultFlag(this,'<c:url value="/couponBatch/setDefaultFlag.do"/>','${couponBatch.id}')"><span
                                                            class="am-icon-trash-o">取消新注册送券</span>
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                            </security:authorize>
                                            <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" href="<c:url value='/basic/xm.do?qm=plistCoupon_used&conditions=couponBatch.id:${couponBatch.id}'/>"><span
                                                    class="am-icon-trash-o">查看优惠券使用情况</span>
                                            </a>
                                            <c:if test="${couponBatch.deliverType == 2 && couponBatch.isCreatedCoupon == 2}">
                                                <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                                   href="<c:url value="/couponBatch/download.do"><c:param name="id" value="${couponBatch.id}"></c:param></c:url>"><span
                                                        class="am-icon-trash-o">下载</span>
                                                </a>
                                            </c:if>
                                            <c:if test="${couponBatch.deliverType == 1 || couponBatch.deliverType == 2}">
                                                <button class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" onclick="createURL('${couponBatch.id}')"><span
                                                        class="am-icon-trash-o">生成链接</span>
                                                </button>
                                            </c:if>
                                        </div>
                                    </div>
                                </td>
                                <td class="am-hide-sm-only"><a href="<c:url value='/basic/xm.do?qm=viewCouponBatch&view=${view}&id=${couponBatch.id}'/>">${couponBatch.name}</a></td>
                                <td class="am-hide-sm-only"><fmt:formatNumber type="number" value="${couponBatch.price}" maxFractionDigits="2" minFractionDigits="2"/></td>
                                <td class="am-hide-sm-only"><fmt:formatNumber type="number" value="${couponBatch.priceLimit}" maxFractionDigits="2" minFractionDigits="2"/></td>
                                <td class="am-hide-sm-only">${couponBatch.amount}</td>
                                <td class="am-hide-sm-only">
                                <fmt:formatDate value="${couponBatch.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                </td>
                                <td class="am-hide-sm-only">
                                    <fmt:formatDate value="${couponBatch.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
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
                    <ming800:pcPageParam name="view" value="${view}"/>
                    <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
                </ming800:pcPageList>
            </div>
        </div>


</body>
</html>
