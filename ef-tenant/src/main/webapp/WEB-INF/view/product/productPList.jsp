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
    <script type="text/javascript" src="<c:url value='/scripts/jquery-1.11.1.min.js'/>"></script>
</head>
<body>

     <div style="text-align: left" >
        <input onclick="window.location.href='/basic/xm.do?qm=formProduct'" type="button" class="am-btn am-btn-default am-btn-xs" style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;" value="添加商品" />
     </div>
        <table class="am-table am-table-bordered am-table-radius am-table-striped">
            <tr style="text-align: center">
                <td>操作</td>
                <td>产品id</td>
                <td>产品名称</td>
                <td>图片地址</td>
                <td>价格</td>
                <td>系列</td>
            </tr>

          <c:forEach items="${requestScope.pageInfo.list}" var="product">
                <tr style="text-align: center">
                    <td>
                        <div class="am-dropdown" data-am-dropdown>
                            <button class="am-btn am-btn-default am-btn-xs am-dropdown-toggle" data-am-dropdown-toggle><span class="am-icon-cog"></span> <span class="am-icon-caret-down"></span></button>
                            <ul class="am-dropdown-content">
                                <li><a href="#">1. 详情</a></li>
                                <li><a href="#">2. 删除</a></li>
                            </ul>
                        </div>
                    </td>
                    <td>${product.id}</td>
                    <td>${product.name}</td>
                    <td>${product.picture_url}</td>
                    <td>${product.price}</td>
                    <td>${product.serial}</td>
                </tr>
            </c:forEach>
        </table>
        <div style="clear: both">
            <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="/basic/xm.do">
                <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
                <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
                <ming800:pcPageParam name="menuId" value="${requestScope.menuId}"/>
            </ming800:pcPageList>
        </div>
</body>
</html>
