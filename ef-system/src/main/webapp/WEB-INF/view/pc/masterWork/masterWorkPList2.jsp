<%@ page import="java.util.HashMap" %>
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


<div class="admin-content">
    <div class="am-u-md-12">
        <div class="am-btn-toolbar">
            <div class="am-btn-group am-btn-group-xs">
                <a type="button" class="am-btn am-btn-default"
                   href="<c:url value="/basic/xm.do?qm=formWork2&view=master"/>"><span
                        class="am-icon-plus"></span>新建作品</a>
                <a type="button" class="am-btn am-btn-default" id="dddd"
                   href="javascript:void (0);" onclick="getPinyin()"><span class="am-icon-plus"></span>初始化作者</a>
            </div>
        </div>
    </div>

    <jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>
    <div class="am-g">
        <div class="am-u-sm-12">
                <table class="am-table am-table-striped am-table-hover table-main">
                    <thead>
                    <tr>
                        <th class="table-set">操作</th>
                        <th class="table-title">作品名称</th>
                        <th class="table-title">项目</th>
                        <th class="table-title">作者</th>
                        <th class="table-title">作品封面</th>
                        <%--<th class="table-title">简介</th>--%>
                        <th class="table-title">规格尺寸</th>
                        <th class="table-title">材质</th>
                        <th class="table-title">管藏地</th>
                    </tr>
                    </thead>
                    <tbody>

                    <c:forEach items="${requestScope.pageInfo.list}" var="masterWork">
                        <tr id="${masterWork.id}">
                            <td width="25%">
                                <div class="am-btn-toolbar">
                                    <div class="am-btn-group am-btn-group-xs">
                                        <a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="<c:url value="/basic/xm.do?qm=formWork2&view=master&id=${masterWork.id}"/>"><span
                                                class="am-icon-pencil-square-o"></span> 编辑
                                        </a>
                                        <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" onclick="showConfirm('提示','是否删除',function(){removeMasterWork('${masterWork.id}')})" href="#"><span
                                                class="am-icon-trash-o"></span> 删除
                                        </a>
                                        <a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="<c:url value="/basic/xm.do?qm=formMasterWork2&id=${masterWork.id}"/>"><span
                                                class="am-icon-pencil-square-o"></span> 链接
                                        </a>
                                        <a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="javascript:void (0)" onclick="GetCode('${masterWork.serial}')"><span
                                                class="am-icon-pencil-square-o"></span> 生成二维码
                                        </a>
                                    </div>
                                </div>
                            </td>
                            <td class="am-hide-sm-only" width="10%">
                                 <a href="<c:url value="/basic/xm.do?qm=viewWork&view=masterWork&id=${masterWork.id}"/>">
                                    ${masterWork.name}
                                 </a>
                            </td>
                            <td class="am-hide-sm-only" width="10%">
                                        ${masterWork.project.name}
                            </td>
                            <td class="am-hide-sm-only" width="10%">
                               ${masterWork.master.fullName}
                            </td>
                            <td class="am-hide-sm-only" width="10%">
                                <a href="/Img/imgUrl.do?imgUrl=http://tenant.efeiyi.com/${masterWork.pictureUrl}">
                                  <img  width="10%"  src="http://tenant.efeiyi.com/${masterWork.pictureUrl}@!tenant-manage-banner" >
                                </a>
                            </td>
                            <%--<td class="am-hide-sm-only">--%>
                                   <%--${masterWork.brief}--%>
                            <%--</td>--%>
                            <td class="am-hide-sm-only" width="12%">
                                    ${masterWork.size}
                            </td>
                            <td class="am-hide-sm-only" width="12%">
                                    ${masterWork.material}
                            </td>
                            <td class="am-hide-sm-only" width="13%">
                                    ${masterWork.site}
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
            <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
        </ming800:pcPageList>
    </div>
</div>
<script type="text/javascript">

    function  getPinyin(){
        $("#dddd").text("正在初始化...");
        $("#dddd").attr("disabled",true);
        $.ajax({
            type: "get",
            url: '<c:url value="/masterWork/getPinyin.do" />',
            cache: false,
            dataType: "json",
            data: {},
            success: function (data) {
                if(data){
                    alert("初始化成功!");
                }else{
                    alert("初始化失败!!");
                }
                $("#dddd").text("初始化作者");
                $("#dddd").removeAttr("disabled");
            }
        });
    }

    function GetCode(serial){

        $.ajax({
            type: "post",
            url: "<c:url value="/masterWork/gg.do" />",
            cache: false,
            dataType: "json",
            data:{"serial":serial},
            success: function (data) {
                alert(data);
            }

        });
    }

    function removeMasterWork(divId){
        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeMasterWork2"/>',
            cache: false,
            dataType: "json",
            data:{id:divId,masterWorkId:divId},
            success: function (data) {
                $("#"+divId).remove();
            }
        });
    }

</script>
</body>
</html>
