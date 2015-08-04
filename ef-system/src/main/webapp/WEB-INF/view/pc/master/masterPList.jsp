<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/25
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
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
<div class="admin-content">
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-6">
            <div class="am-btn-toolbar">
                <div class="am-btn-group am-btn-group-xs">
                    <a type="button" class="am-btn am-btn-default" href="<c:url value="/basic/xm.do?qm=formMaster"/>"><span class="am-icon-plus"></span>新建传承人</a>
                </div>
            </div>
        </div>
        <div class="am-u-sm-12">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>
                    <th class="table-set">操作</th>
                    <th class="table-title">中文姓名</th>
                    <th class="table-title">性别</th>
                    <th class="table-title">等级</th>
                </tr>
                </thead>
                <tbody>

                <c:forEach items="${requestScope.pageInfo.list}" var="master">
                    <tr id="${master.id}">
                        <td>
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs">
                                    <a class="am-btn am-btn-default am-btn-xs am-text-secondary"
                                       href="<c:url value="/basic/xm.do?qm=formMaster&id=${master.id}"/>"><span
                                            class="am-icon-pencil-square-o"></span> 编辑
                                    </a>
                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                      onclick="removeMaster('${master.id}')" href="#"><span
                                            class="am-icon-trash-o"></span> 删除
                                    </a>
                                    <c:if test="${empty master.masterRecommendedList}">
                                        <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                           onclick="masterRecommended(this,'${master.id}')"
                                           href="#" recommend="1" recommendedId = "" >
                                            <span class="am-icon-heart"> 推荐</span>
                                        </a>
                                    </c:if>
                                    <c:if test="${not empty master.masterRecommendedList}">
                                        <c:forEach var="recommended" items="${master.masterRecommendedList}">
                                            <c:if test="${recommended.master.id == master.id}">
                                                <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                                   href="#"  onclick="masterRecommended(this,'${master.id}')" recommendedId="${recommended.id}" recommend="0">
                                                    <span class="am-icon-heart" >取消推荐 </span>
                                                </a>
                                            </c:if>
                                        </c:forEach>

                                    </c:if>
                                </div>
                            </div>
                        </td>
                        <td class="am-hide-sm-only">
                            <a href="<c:url value="/basic/xm.do?qm=viewMaster&id=${master.id}"/>">
                              ${master.fullName}
                            </a>
                              <c:forEach var="recommended" items="${master.masterRecommendedList}">
                                <c:if test="${recommended.master.id == master.id}" >
                                    <a href="#" recommendedSort="${recommended.sort}" recommendedId="${recommended.id}" onclick="updateSort(this)" >
                                      <span  id="${recommended.id}" style="margin-left: 5px;color: red;"> 推荐</span>
                                    </a>
                                </c:if>
                              </c:forEach>
                        </td>

                        <td class="am-hide-sm-only">
                            <ming800:status name="sex" dataType="Master.sex" checkedValue="${master.sex}" type="normal"/>
                        </td>
                        <td class="am-hide-sm-only">
                            <ming800:status name="level" dataType="Master.level" checkedValue="${master.level}" type="normal" />

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

<script>

    function masterRecommended(obj,masterId){

        //推荐  recommend 为1时 推荐
        if($(obj).attr("recommend")=="1"){
            var sort=prompt("输入排序号","1");
            if(sort)
            {
               saveMasterRecommended(obj,masterId,sort);
            }
        }
        //0 时 取消推荐
        if($(obj).attr("recommend")=="0"){
            removeMasterRecommended(obj,masterId);
        }
    }

    function saveMasterRecommended(obj,masterId,sort){
        $.ajax({
            type:"get",
            url:'<c:url value="/Recommended/saveObjectRecommended.do" />',
            data:{groupName:"masterRecommended",recommendId:masterId,status:"1",sort:sort},
            success:function(data){
                $(obj).attr("recommend","0");
                $(obj).attr("reId",data);
                $(obj).find("span").text("取消推荐");
                $("table tr[id='"+masterId+"'] td:eq(1) a").append("<a onclick=\"updateSort(this)\" recommendedSort="+sort+" recommendedId="+data+" >" +
                        "<span  id="+data+" style=\"margin-left: 5px;color: red;\" >推荐"+"</span>" +
                        "</a>");
            }
        });
    }


    function removeMasterRecommended(obj,masterId){
        var recommendedId = $(obj).attr("recommendedId");
        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeMasterRecommended"/>',
            cache: false,
            dataType: "json",
            data:{id:recommendedId},
            success: function (data) {
                $(obj).attr("recommend","1");
                $(obj).attr("reId","");
                $(obj).find("span").text("推荐");
                $("table tr[id='"+masterId+"'] td:eq(1) a:eq(1) ").remove();
            }
        });
    }

    function updateSort(obj){
        var recommendedSort = $(obj).attr("recommendedSort");
        var recommendedId = $(obj).attr("recommendedId");
        var sort=prompt("输入排序号",recommendedSort);
        if(sort)
        {
            $.ajax({
                type: "get",
                url: '<c:url value="/Recommended/updateSort.do"/>',
                cache: false,
                dataType: "json",
                data:{id:recommendedId,sort:sort},
                success: function (data) {
                    $(obj).attr("recommendedSort",sort);
                  alert("修改成功!");
                }
            });
        }
    }

    function removeMaster(divId){
        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeMaster"/>',
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
