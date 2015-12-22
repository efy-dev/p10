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

    </script>
</head>
<body>


<div style="text-align: left" >
<security:authorize ifAnyGranted="admin,operational,c_operational">
    <input onclick="window.location.href='<c:url value="/basic/xm.do?qm=formProduct&view=${view}&tenantId=${tenantId}"/>'" type="button" class="am-btn am-btn-default am-btn-xs" style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;" value="新建商品" />
    <input onclick="outExcel();" type="button" class="am-btn am-btn-default am-btn-xs" style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;" value="生成excel" />
    <%--<a onclick="initSort(this)"  class="am-btn am-btn-default am-btn-xs" style="margin-top: 4px;margin-bottom: 6px;width: 135px;margin-left:2px;height: 35px;"  >初始化商品图片排序</a>--%>
    </security:authorize>
</div>
<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions};tenant.id:${tenantId}&tenantId=${tenantId}"/>
<div class="">
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-6">
        </div>
        <div class="am-u-sm-12">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>
                    <security:authorize ifAnyGranted="admin,operational,c_operational">
                    <th class="table-set" width="30%">操作</th>
                    </security:authorize>
                    <th class="table-title" width="20%">产品名称</th>
                    <th class="table-title" width="15%">产品编号</th>
                    <th class="table-title" width="10%">项目</th>
                    <th class="table-title" width="10%">状态</th>

                    <%--<th class="table-title">产品价格</th>--%>
                    <th class="table-title" width="15%">上架时间</th>

                </tr>
                </thead>
                <tbody>



                <c:forEach items="${requestScope.pageInfo.list}" var="product">
                    <tr id="${product.id}">
                        <security:authorize ifAnyGranted="admin,operational,c_operational">
                        <td>
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs">
                                    <c:if test="${not empty product.tenant}">
                                        <c:set var="tenantId" value="${product.tenant.id}"/>
                                    </c:if>
                                    <c:if test="${empty product.tenant}">
                                        <c:set var="tenantId" value="0"/>
                                    </c:if>
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
                                    <c:if test="${product.status == '2'}">
                                        <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="javascript:void(0);" onclick="setStatus(this,'1','${product.id}')">
                                            上架
                                        </a>
                                    </c:if>
                                    <c:if test="${product.status == '1'}">
                                        <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="javascript:void(0);" onclick="setStatus(this,'2','${product.id}')">
                                            下架
                                        </a>
                                    </c:if>

                                        <%--<c:if test="${view == 'newProduct'}">--%>
                                        <%--<a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="<c:url value="/basic/xm.do?qm=plistTenantProduct_default&productId=${product.id}&view=${view}"/>">--%>
                                        <%--关联商家--%>
                                        <%--</a>--%>
                                        <%--</c:if>--%>

                                        <%--<a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="<c:url value="/basic/xm.do?qm=formProduct_Picture&id=${product.id}"/>">--%>
                                        <%--修改图片--%>
                                        <%--</a>--%>


                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="#" onclick="showConfirm('提示','是否删除',function(){removeProduct1('${product.id}')})">
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
                        </security:authorize>
                        <td class="am-hide-sm-only"><a href="<c:url value='/basic/xm.do?qm=viewProduct&view=${view}&id=${product.id}'/>">${product.name}</a></td>
                        <td class="am-hide-sm-only">${product.serial}</td>
                        <td class="am-hide-sm-only">
                            <c:if test="${not empty product.project}">
                                ${product.project.name}
                            </c:if>
                       </td>
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
                        <td class="am-hide-sm-only">
                            <c:if test="${not empty product.showDateTime}">
                                <fmt:formatDate value="${product.showDateTime}" type="both" pattern="YYYY-MM-dd HH:mm:ss"/>
                            </c:if>

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
            <ming800:pcPageParam name="view" value="${view}"/>
            <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
            <ming800:pcPageParam name="tenant.id" value="${tenantId}"/>
            <ming800:pcPageParam name="tenantId" value="${tenantId}"/>
        </ming800:pcPageList>
    </div>
</div>
<script>
    function initSort(obj){
        var a=confirm("确定初始化吗，商品图片顺序将重置？");
        if(a) {
            $(obj).attr("disabled", "disabled");
            $(obj).text("正在初始化....");
            $.ajax({
                type: "get",
                url: '<c:url value="/product/initProductViewSort.do"/>',
                cache: false,
                dataType: "json",
                success: function (data) {
                    if (data == "1") {
                        alert("初始化成功!");
                        $(obj).removeAttr("disabled");
                        $(obj).text("初始化商品图片排序");
                    }
                    if (data == "0") {
                        alert("初始化失败,请重新初始化!");
                        $(obj).removeAttr("disabled");
                        $(obj).text("初始化商品图片排序");
                    }
                }
            });
        }
    }
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
                    $(obj).attr("onclick","setStatus(this,'2','"+id+"')");
                    var span =  '<span style="color: red">上架 </span>';
                    $("#"+id+" td:eq(4)").html(span);
                    $("#"+id+" td:eq(5)").html(data);
                }
               if(status=="2"){
                   $(obj).text("上架");
                   $(obj).attr("onclick","setStatus(this,'1','"+id+"')");
                   var span =  '<span>下架 </span>';
                   $("#"+id+" td:eq(4)").html(span);

               }
            }
        });
    }
    function removeProduct1(divId){

        $.ajax({
            type: "get",
            url: '<c:url value="/product/removeProduct.do"/>',
            cache: false,
            dataType: "json",
            data:{id:divId},
            success: function (data) {
                $("#"+divId).remove();
            }
        });
    }
    function outExcel(){
        var  home = "商品编号,商品名称,商品规格编号,商品规格名称,价格,市场价格,库存,链接,状态,项目,店铺,类别,商品创建时间";
        var  on = "上架";
        var  down = "下架";
        window.location.href = "<c:url value="/product/outExcel.do"/>"+"?home="+home+"&on="+on+"&down="+down;
        <%--$.ajax({--%>
            <%--type: "get",--%>
            <%--url: '<c:url value="/product/outExcel.do"/>',--%>
            <%--cache: false,--%>
            <%--dataType: "json",--%>
            <%--data:{"home":"商品编号,商品名称,商品规格编号,商品规格名称,价格,市场价格,库存,状态,项目,店铺,类别","on":"上架","down":"下架"},--%>
            <%--success: function (data) {--%>

            <%--}--%>
        <%--});--%>
    }
</script>

</body>
</html>
