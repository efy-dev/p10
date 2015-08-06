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
                                           onclick="recommended(this,1)"
                                           href="#" recommend="1" recommendedId = "${master.id}" id="" >
                                            <span class="am-icon-heart"> 推荐</span>
                                        </a>


                                    </c:if>
                                    <c:if test="${not empty master.masterRecommendedList}">
                                        <c:forEach var="recommended" items="${master.masterRecommendedList}">
                                            <c:if test="${recommended.master.id == master.id}">
                                                <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                                   href="#"  onclick="recommended(this,1)" recommendedId = "${master.id}"  id="${recommended.id}" recommend="0">
                                                    <span class="am-icon-heart" >取消推荐 </span>
                                                </a>
                                            </c:if>
                                        </c:forEach>

                                    </c:if>
                                       <span style="display: none;float: left;padding-left: 10px;">
                                                <input type="text" name="sort" style="width: 35px;" value="" />
                                                <a class=" am-btn-primary" onclick="saveRecommended(this,'masterRecommended',1)" style="padding: 0px 10px 5px 10px" > 保存</a>
                                       </span>
                                </div>
                            </div>
                        </td>
                        <td class="am-hide-sm-only">
                            <a href="<c:url value="/basic/xm.do?qm=viewMaster&id=${master.id}"/>">
                              ${master.fullName}
                            </a>
                            <c:forEach var="recommended" items="${master.masterRecommendedList}">
                                <c:if test="${recommended.master.id == master.id}" >
                                    <span  id="${recommended.id}" style="margin-left: 5px;color: red;"> 推荐</span>
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

    /**
     * 推荐 取消推荐 切换
     * @param obj
     * @param td 推荐标示位于哪一列
     */
    function recommended(obj,td){
        //推荐  recommend 为1时 推荐  显示出排序文本框
        if($(obj).attr("recommend")=="1"){
            $(obj).next("span").css({"display":"block"});
        }
        if($(obj).attr("recommend")=="0"){
            var id = $(obj).attr("id"); //推荐对象id
            deleteRecommended(obj,id,td);
        }
    }

    /**
     *  删除推荐对象  切换用的删除方法不直接调用
     * @param obj
     * @param id
     */
    function deleteRecommended(obj,id,td){
        var  recommendedId = $(obj).attr("recommendedId");
        $.ajax({
            type:"get",
            url:'<c:url value="/Recommended/deleteObjectRecommended.do" />',
            data:{id:id},
            success:function(data){
                $(obj).attr("recommend","1");
                $(obj).attr("id","");
                $(obj).find("span").text("推荐");
                $("table tr[id='"+recommendedId+"'] td:eq("+td+") span ").remove();
            }
        });
    }


    /**
     *保存推荐对象
     * @param obj
     * @param groupName 组名
     * @param td 推荐标示所在列
     */
    function saveRecommended(obj,groupName,td){
        var recommendId = $(obj).parent().prev("a").attr("recommendedId");
        var sort = $(obj).prev().val();
        $.ajax({
            type:"get",
            url:'<c:url value="/Recommended/saveObjectRecommended.do" />',
            dataType:"json",
            data:{groupName:groupName,recommendId:recommendId,status:"1",sort:sort},
            success:function(data){
                $(obj).parent("span").css({"display":"none"});
                $(obj).parent("span").find("input").val("");
                $(obj).parent().prev("a").attr("recommend","0");
                $(obj).parent().prev("a").attr("id",data);
                $(obj).parent().prev("a").find("span").text("取消推荐");
                $("table tr[id='"+recommendId+"'] td:eq("+td+")").append("<span  id="+data+" style=\"margin-left: 5px;color: red;\" >推荐"+"</span>");
            }
        });
    }



    function removeMaster(divId){
        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeMaster"/>',
            cache: false,
            dataType: "json",
            data:{id:divId,recommendId:divId},
            success: function (data) {
                $("#"+divId).remove();
            }
        });
    }

</script>
</body>
</html>
