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


<div style="text-align: left" >
    <input onclick="window.location.href='<c:url value="/basic/xm.do?qm=viewEcProjectCategory&id=${projectCategoryId}"/>'" type="button" class="am-btn am-btn-default am-btn-xs" style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;" value="返回" />
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
                    <th class="table-set" width="33%">操作</th>
                    <th class="table-title" width="33%">产品名称</th>
                    <th class="table-title" width="33%">产品编号</th>
                    <%--<th class="table-title">产品价格</th>--%>


                </tr>
                </thead>
                <tbody>



                <c:forEach items="${requestScope.pageInfo.list}" var="productModel">
                    <tr id="${productModel.id}">
                        <td width="33%">
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs">
                                    <a id="${productModel.id}" projectCategoryProductModelId="0" status="1" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="javascript:void(0);" onclick="removeSubjectProduct1(this,'${projectCategoryId}','${productModel.id}')">
                                        推荐
                                    </a>
                                </div>
                            </div>
                        </td>
                        <td class="am-hide-sm-only" width="33%">${productModel.name}</td>
                        <td class="am-hide-sm-only" width="33%">${productModel.serial}</td>
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
            <ming800:pcPageParam name="projectCategoryId" value="${projectCategoryId}"/>

        </ming800:pcPageList>
    </div>
</div>
<script>

    $(function(){

        <c:forEach var="projectCategoryProductModel" items="${projectCategoryProductModelList}">
        var productModelId = '${projectCategoryProductModel.productModel.id}';
           <c:if test="${projectCategoryProductModel.status=='0'}">
                     $("a[id='"+productModelId+"']").attr("status","1");
                     $("a[id='"+productModelId+"']").text("推荐");
                     $("a[id='"+productModelId+"']").attr("projectCategoryProductModelId",'${projectCategoryProductModel.id}')
        </c:if>
        <c:if test="${projectCategoryProductModel.status=='1'}">
                    $("a[id='"+productModelId+"']").attr("status","0");
                    $("a[id='"+productModelId+"']").text("取消推荐");
                    $("a[id='"+productModelId+"']").attr("projectCategoryProductModelId",'${projectCategoryProductModel.id}')
        </c:if>




        </c:forEach>

    });

    function removeSubjectProduct1(obj,projectCategoryId,productModelId){

        var  status = $(obj).attr("status");
        var  projectCategoryProductModelId = $(obj).attr("projectCategoryProductModelId");

        $.ajax({
            type: "get",
            url: '<c:url value="/product/linkProjectCategory.do"/>',
            cache: false,
            dataType: "json",
            data:{projectCategoryId:projectCategoryId,productModelId:productModelId,projectCategoryProductModelId:projectCategoryProductModelId,status:status},
            success: function (data) {
                if(status=="0"){
                    $(obj).attr("status","1");
                    $(obj).text("推荐");
                    $(obj).attr("projectCategoryProductModelId",data)
                }else{
                    $(obj).attr("status","0");
                    $(obj).text("取消推荐");
                    $(obj).attr("projectCategoryProductModelId",data)
                }
            }
        });
    }
</script>

</body>
</html>
