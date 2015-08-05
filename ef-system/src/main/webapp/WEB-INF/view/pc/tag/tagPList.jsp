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
        <input onclick="window.location.href='<c:url value="/basic/xm.do?qm=formTag"/>'" type="button" class="am-btn am-btn-default am-btn-xs" style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;" value="新建字典" />
     </div>
        <table class="am-table am-table-bordered am-table-radius am-table-striped">
            <tr style="text-align: center">
                <td>操作</td>
                <td>字典组</td>
                <td>字典名称</td>
            </tr>

          <c:forEach items="${requestScope.pageInfo.list}" var="tag">
                <tr style="text-align: center" id="${tag.id}">
                    <td width="20%">
                        <div class="am-btn-toolbar">
                            <div class="am-btn-group am-btn-group-xs" style="width: 100%" >
                                <button style="margin-left: 35%;" onclick="window.location.href='<c:url value="/basic/xm.do?qm=formTag&id=${tag.id}"/>'" class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span class="am-icon-edit"></span> 编辑</button>
                                <button onclick="removeTag('${tag.id}')" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 删除</button>
                            </div>
                        </div>
                    </td>
                    <td width="20%">${tag.groupName}</td>
                    <td width="20%">${tag.value}</td>
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
<script>

    function removeTag(divId){
        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeTag"/>',
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
