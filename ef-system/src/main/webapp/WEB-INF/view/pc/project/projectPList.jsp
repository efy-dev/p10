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
</head>
<body>
<div style="text-align: left;margin-left: 10px;">
    <input onclick="window.location.href='<c:url
            value="/basic/xm.do?qm=formProject&param=formProject&fatherId=${fatherId}"/>'" type="button"
           class="am-btn am-btn-default am-btn-xs"
           style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;" value="新建项目"/>
</div>
<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>
<table class="am-table am-table-bordered am-table-radius am-table-striped">
    <tr style="text-align: left">
        <td width="15%">操作</td>
        <td width="15%">项目名称</td>
        <td width="15%">项目编号</td>
        <td width="15%">省</td>
        <td width="15%">市</td>
        <td width="15%">项目图片</td>

    </tr>


    <c:forEach items="${requestScope.pageInfo.list}" var="project">
        <tr style="text-align: left" id="${project.id}">
            <td width="15%">
                <div class="am-btn-toolbar">
                    <div class="am-btn-group am-btn-group-xs" style="width: 100%;">
                        <button onclick="window.location.href='<c:url
                                value="/basic/xm.do?qm=formProject&param=formProject&id=${project.id}"/>'"
                                class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span
                                class="am-icon-edit"></span> 编辑
                        </button>
                        <button onclick="showConfirm('提示','删除项目同时也会解除该项目与大师，商家的关联，确定删除吗',function(){removeProject('${project.id}')})"
                                class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                                class="am-icon-trash-o"></span> 删除
                        </button>

                        <c:if test="${project.status == '1'}">
                            <button onclick="changeStatus(this,'${project.id}')" status="2"
                                    class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                                    class="am-icon-trash-o">隐藏</span>

                            </button>
                        </c:if>
                        <c:if test="${project.status == '2'}">
                            <button onclick="changeStatus(this,'${project.id}')" status="1"
                                    class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                                    class="am-icon-trash-o">显示</span>

                            </button>
                        </c:if>

                    </div>
                </div>
            </td>
            <td width="15%">
                <c:if test="${project.level == 1}">
                    <a href="<c:url value="/basic/xm.do?qm=viewProject&param=project&id=${project.id}"/>">
                            ${project.name}
                    </a>
                </c:if>
            </td>
            <td width="15%">
                    ${project.serial}
            </td>
            <td width="15%">
                    ${project.addressDistrict.addressCity.addressProvince.name}
            </td>
            <td width="15%">
                    ${project.addressDistrict.addressCity.name}
            </td>
            <td width="15%">
                <img width="35px;" src="<c:url value="http://pro.efeiyi.com/${project.picture_url}@!product-model"/>"
                     alt=""/>
            </td>
        </tr>

    </c:forEach>
</table>
<div style="clear: both">
    <c:url value="/basic/xm.do" var="url"/>
    <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
        <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
        <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
    </ming800:pcPageList>
</div>
<script>
    function removeProject(id){
        $.ajax({
            type: "get",
            url: '<c:url value="/product/project/removeProject.do"/>',
            cache: false,
            dataType: "json",
            data:{id:id},
            success: function (data) {
                $("#"+id).remove();
            }
        });
    }
    function changeStatus(obj,id){
        var status = $(obj).attr("status");
        $.ajax({
            type: "get",
            url: '<c:url value="/product/project/updateStatus.do"/>',
            cache: false,
            dataType: "json",
            data:{id:id,status:status},
            success: function (data) {
                $(obj).attr("status",data);
                if(status=="1"){
                    $(obj).find("span").text("隐藏");
                    $(obj).attr("status","2");
                }
                if(status=="2"){
                    $(obj).find("span").text("显示");
                    $(obj).attr("status","1");
                }
            }
        });
    }
</script>
</body>
</html>
