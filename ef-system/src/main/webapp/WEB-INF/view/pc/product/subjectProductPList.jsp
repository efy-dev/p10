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
    <input onclick="window.location.href='<c:url value="/basic/xm.do?qm=viewSubject&id=${subjectId}"/>'" type="button" class="am-btn am-btn-default am-btn-xs" style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;" value="返回" />
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



                <c:forEach items="${requestScope.pageInfo.list}" var="product">
                    <tr id="${product.id}">
                        <td width="33%">
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs">
                                    <a id="${product.id}" subjectProductId="0" status="1" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="javascript:void(0);" onclick="removeSubjectProduct1(this,'${subjectId}','${product.id}')">
                                        关联产品
                                    </a>
                                </div>
                            </div>
                        </td>
                        <td class="am-hide-sm-only" width="33%">${product.name}</td>
                        <td class="am-hide-sm-only" width="33%">${product.serial}</td>
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

    $(function(){

        <c:forEach var="subjectProduct" items="${subjectProductList}">
        var productId = '${subjectProduct.product.id}';

            $("a[id='"+productId+"']").attr("status","0");
            $("a[id='"+productId+"']").text("解除产品");


              $("a[id='"+productId+"']").attr("subjectProductId",'${subjectProduct.id}');

        </c:forEach>

    });

    function removeSubjectProduct1(obj,subjectId,productId){

        var  status = $(obj).attr("status");
        var  subjectProductId = $(obj).attr("subjectProductId");

        $.ajax({
            type: "get",
            url: '<c:url value="/product/linkSubject.do"/>',
            cache: false,
            dataType: "json",
            data:{subjectId:subjectId,productId:productId,subjectProductId:subjectProductId,status:status},
            success: function (data) {
                if(status=="0"){
                    $(obj).attr("status","1");
                    $(obj).text("关联产品");
                    $(obj).attr("subjectProductId",data)
                }else{

                    $(obj).attr("status","0");
                    $(obj).text("解除产品");
                    $(obj).attr("subjectProductId",data)
                }
            }
        });
    }
</script>

</body>
</html>
