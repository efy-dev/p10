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
        function removeProduct(productId){
            jQuery.ajax({
                type:"GET",
                url:'<c:url value="/basic/xmj.do?qm=removeProduct"/>',
                data:{id:productId},
                dataType:"json",
                success:function(data){
                    $("#"+productId).remove();
                }
            });
        }
    </script>
</head>
<body>


<div style="text-align: left" >
    <input onclick="window.location.href='<c:url value="/basic/xm.do?qm=formProduct&view=${view}&tenantId=${tenantId}"/>'" type="button" class="am-btn am-btn-default am-btn-xs" style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;" value="新建商品" />
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
                    <th class="table-set" width="35%">操作</th>
                    <th class="table-title" width="35%">产品名称</th>
                    <th class="table-title" width="15%">产品编号</th>
                    <th class="table-title" width="15%">状态</th>
                    <%--<th class="table-title">产品价格</th>--%>


                </tr>
                </thead>
                <tbody>



                <c:forEach items="${requestScope.pageInfo.list}" var="product">
                    <tr id="${product.id}">
                        <td>
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs">

                                    <c:if test="${not empty product.master}">
                                        <c:set var="masterId" value="${product.master.id}"/>
                                    </c:if>
                                    <c:if test="${empty product.master}">
                                        <c:set var="masterId" value="0"/>
                                    </c:if>
                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="<c:url value="/basic/xm.do?qm=formProduct&view=${view}&id=${product.id}&tenantId=${tenantId}&masterId=${masterId}"/>">
                                        修改基本信息
                                    </a>
                                        <%--<a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="<c:url value="/basic/xm.do?qm=formProduct_Description&view=${view}&id=${product.id}"/>">--%>
                                        <%--修改描述--%>
                                        <%--</a>--%>
                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="<c:url value="/basic/xm.do?qm=formProduct_ProductModel&view=${view}&tenantId=${tenantId}&id=${product.id}"/>">
                                        修改规格
                                    </a>
                                    <%--<c:if test="${product.status == '2'}">--%>
                                        <%--<a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="javascript:void(0);" onclick="setStatus(this,'1','${product.id}')">--%>
                                            <%--上架--%>
                                        <%--</a>--%>
                                    <%--</c:if>--%>
                                    <%--<c:if test="${product.status == '1'}">--%>
                                        <%--<a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="javascript:void(0);" onclick="setStatus(this,'2','${product.id}')">--%>
                                            <%--下架--%>
                                        <%--</a>--%>
                                    <%--</c:if>--%>
                                        <%--<c:if test="${view == 'newProduct'}">--%>
                                        <%--<a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="<c:url value="/basic/xm.do?qm=plistTenantProduct_default&productId=${product.id}&view=${view}"/>">--%>
                                        <%--关联商家--%>
                                        <%--</a>--%>
                                        <%--</c:if>--%>

                                        <%--<a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="<c:url value="/basic/xm.do?qm=formProduct_Picture&id=${product.id}"/>">--%>
                                        <%--修改图片--%>
                                        <%--</a>--%>
                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="#" onclick="showConfirm('提示','是否删除',function(){removeProduct('${product.id}')})">
                                        删除
                                    </a>
                                    <c:if test="${empty product.project}">
                                        <small style="color: red;margin-left: 2px;">
                                            (未关联项目)
                                        </small>
                                    </c:if>
                                        <%--<button class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" onclick="showConfirm('提示','是否删除',function(){removeProduct('${product.id}')})"><span--%>
                                        <%--class="am-icon-trash-o">删除</span>--%>
                                        <%--</button>--%>
                                        <%--<a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"--%>
                                        <%--href="<c:url value="/product/recommendedProduct.do?id=${product.id}&categoryId=${product.category.id}"/>"><span--%>
                                        <%--class="am-icon-trash-o">推荐</span>--%>
                                        <%--</a>--%>
                                </div>
                            </div>
                        </td>
                        <td class="am-hide-sm-only"><a href="<c:url value='/basic/xm.do?qm=viewProduct&view=${view}&id=${product.id}'/>">${product.name}</a></td>
                        <td class="am-hide-sm-only">${product.serial}</td>
                        <td class="am-hide-sm-only">
                            <c:if test="${product.status == '2'}">
                                   <span>
                                      下架
                                   </span>
                            </c:if>
                            <c:if test="${product.status == '1'}">
                                <span style="color: red">
                                    上架
                                </span>
                            </c:if>
                        </td>
                            <%--<td class="am-hide-sm-only">${product.price}</td>--%>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div style="clear: both">
        <c:url value="/basic/xm.do" var="url" />
        <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
            <ming800:pcPageParam name="view" value="${view}"/>
            <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
            <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
        </ming800:pcPageList>
    </div>
</div>
<script>
    function setStatus(obj,status,id){
        $.ajax({
            type: "get",
            url: '<c:url value="/product/setProductStatus.do"/>',
            cache: false,
            dataType: "json",
            data:{id:id,status:status},
            success: function (data) {
                if(status=="1"){
                    $(obj).text("下架");
                    $(obj).attr("onclick","setStatus(this,'2','"+data+"')");
                    var span =  '<span style="color: red">上架 </span>';
                    $("#"+data+" td:eq(3)").html(span);
                }
                if(status=="2"){
                    $(obj).text("上架");
                    $(obj).attr("onclick","setStatus(this,'1','"+data+"')");
                    var span =  '<span>下架 </span>';
                    $("#"+data+" td:eq(3)").html(span);
                }
            }
        });
    }
    function removeProduct(divId){
        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeProduct"/>',
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
