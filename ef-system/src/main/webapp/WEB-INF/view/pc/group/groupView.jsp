<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<html>
<head>
    <title></title>
</head>
<body>

<div class="am-g">
    <div class="am-u-md-12">
        <h2>详细信息</h2>
        <table class="am-table am-table-bordered">
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">团长</td>
                <td class="am-u-md-3">${object.manUser.name}</td>
                <td class="am-primary am-u-md-3">团购商品</td>
                <td class="am-u-md-3">
                    ${object.groupProduct.productModel.name}
                </td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">状态</td>
                <td class="am-u-md-3">
                    <ming800:status name="showStatus" dataType="Group.showStatus" checkedValue="${object.status}" type="normal"/>
                </td>
                <td class="am-primary am-u-md-3">创建时间</td>
                <td class="am-u-md-3" >
                    ${object.createDateTime}
                    <%--<fmt:formatDate value="" pattern="yyyy-MM-dd HH:mm:ss" type="both"/>--%>
                </td>
            </tr>
            </tbody>
        </table>

    </div>
</div>
<div class="am-g">
    <div class="am-u-md-12">
        <h2>成员</h2>
    </div>

    <div class="am-u-md-12">
        <div class="am-panel-bd am-collapse am-in" id="collapse-panel-3" style="height: auto;overflow: hidden">

            <table class="am-table am-table-bd am-table-bdrs am-table-striped am-table-hover"
                   id="productModel">
                <tbody>
                <tr>
                    <th width="14%">成员</th>

                </tr>
                <c:forEach var="member" items="${object.groupMemberList}">
                    <tr>
                        <td>
                          ${member.user.username}
                        </td>


                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<div class="am-g">
    <div class="am-u-md-12">
        <h2>订单</h2>
    </div>

    <div class="am-u-md-12">
        <div class="am-panel-bd am-collapse am-in" id="collapse-panel-1" style="height: auto;overflow: hidden">

            <table class="am-table am-table-bd am-table-bdrs am-table-striped am-table-hover">
                <tbody>
                <tr>
                    <th width="14%">订单号</th>
                    <th width="14%">成员</th>
                </tr>
                <c:forEach var="po" items="${object.purchaseOrderGroupList}">
                    <tr>
                        <td>
                                ${po.serial}
                        </td>
                        <td>
                            ${po.groupMember.user.username}
                       </td>


                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script>
    function openUrl(id){
      var   url = "http://www2.efeiyi.com/subject/"+id;
        window.open(url);
    }
</script>

</body>
</html>
