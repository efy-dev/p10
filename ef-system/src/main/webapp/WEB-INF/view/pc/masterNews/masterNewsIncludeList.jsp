<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/22
  Time: 13:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<table class="am-table am-table-striped am-table-hover table-main">
    <thead>
    <tr>
        <th class="table-set">操作</th>
        <th class="table-title">标题</th>
        <th class="table-title">作者</th>
        <th class="table-title">创建时间</th>

    </tr>
    </thead>
    <tbody>

    <c:forEach items="${objectList}" var="masterNews">
        <tr id="${masterNews.id}">
            <td>
                <div class="am-btn-toolbar">
                    <div class="am-btn-group am-btn-group-xs">
                        <a class="am-btn am-btn-default am-btn-xs am-text-secondary"
                           href="<c:url value="/basic/xm.do?qm=formMasterNews&id=${masterNews.id}&masterId=${masterNews.master.id}"/>"><span
                                class="am-icon-pencil-square-o"></span> 编辑
                        </a>
                        <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                          onclick="removeMasterNews('${masterNews.id}')"><span
                                class="am-icon-trash-o"></span> 删除
                        </a>
                    </div>
                </div>
            </td>
            <td class="am-hide-sm-only"><a
                    href="<c:url value="/basic/xm.do?qm=viewMasterNews&id=${masterNews.id}"/>">${masterNews.title}</a>
            </td>
            <td class="am-hide-sm-only">${!empty masterNews.creator ?masterNews.creator.name:""}</td>
            <td class="am-hide-sm-only"><fmt:formatDate value="${masterNews.createDateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<script>

    function removeMasterNews(divId){
        var f = confirm("确认删除?");
        if(f) {
            $.ajax({
                type: "get",
                url: '<c:url value="/basic/xmj.do?qm=removeMasterNews"/>',
                cache: false,
                dataType: "json",
                data: {id: divId},
                success: function (data) {
                    $("#" + divId).remove();
                }
            });
        }
    }

</script>
