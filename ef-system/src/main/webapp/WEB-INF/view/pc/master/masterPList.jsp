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
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title></title>
    <script type="text/javascript" src="<c:url value='/scripts/recommended.js'/>"></script>

</head>
<body>
<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>
<div class="">
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-6">
            <div class="am-btn-toolbar">
                <div class="am-btn-group am-btn-group-xs">
                    <a type="button" class="am-btn am-btn-default" href="<c:url value="/basic/xm.do?qm=formMaster&form=master&param=master"/>"><span class="am-icon-plus"></span>新建传承人</a>
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
                        <td width="50%">
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs">
                                    <security:authorize ifAnyGranted="admin,operational,c_operational">
                                    <a class="am-btn am-btn-default am-btn-xs am-text-secondary"
                                       href="<c:url value="/basic/xm.do?qm=formMaster&form=master&id=${master.id}&param=master"/>"><span
                                            class="am-icon-pencil-square-o"></span> 编辑
                                    </a>
                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                      onclick="showConfirm('提示','删除大师同时会解除该大师与商家，项目的关联，确认删除?',function(){removeMaster('${master.id}')})" href="#"><span
                                            class="am-icon-trash-o"></span> 删除
                                    </a>
                                    </security:authorize>
                                    <%--<a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"--%>
                                       <%--href="<c:url value="/basic/xm.do?qm=plistMasterMessage_default&conditions=master.id:${master.id}&masterId=${master.id}"/>"><span--%>
                                            <%--class="am-icon-trash-o"></span> 最新动态--%>
                                    <%--</a>--%>
                                    <%--<a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"--%>
                                        <%--href="<c:url value="/basic/xm.do?qm=plistMasterFollowed_default&conditions=master.id:${master.id}&masterId=${master.id}"/>"><span--%>
                                            <%--class="am-icon-trash-o"></span> 查看粉丝--%>
                                    <%--</a>--%>
                                    <%--<a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"--%>
                                       <%--href="<c:url value="/basic/xm.do?qm=plistMasterWork_default&conditions=master.id:${master.id}&masterId=${master.id}"/>"><span--%>
                                            <%--class="am-icon-trash-o"></span> 查看作品--%>
                                    <%--</a>--%>
                                    <security:authorize ifAnyGranted="admin,operational,c_operational">
                                    <c:set value="0" var="isOk"/>
                                    <c:if test="${not empty master.masterRecommendedList}">
                                        <c:forEach var="recommended" items="${master.masterRecommendedList}">
                                            <c:if test="${recommended.master.id == master.id}">
                                                <c:set value="1" var="isOk"/>
                                                <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                                   href="javascript:void(0);"  onclick="recommended(this,1,'<c:url value="/Recommended/deleteObjectRecommended.do" />')" recommendedId = "${master.id}"  id="${recommended.id}" recommend="0">
                                                    <span class="am-icon-heart" >取消推荐 </span>
                                                </a>
                                            </c:if>
                                        </c:forEach>

                                    </c:if>
                                    <c:if test="${isOk == '0'}">
                                        <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                           onclick="recommended(this,1,'<c:url value="/Recommended/deleteObjectRecommended.do" />')"
                                           href="javascript:void(0);" recommend="1" recommendedId = "${master.id}" id="" >
                                            <span class="am-icon-heart"> 推荐</span>
                                        </a>
                                    </c:if>

                                       <span style="display: none;float: left;padding-left: 10px;">
                                            <%--<select id="type" name="type" style="width: 90px;display: inline-block;">--%>
                                                <%--<option value="ec.masterRecommended">请选择</option>--%>
                                                <%--<option value="masterSkillRecommended">传统技艺</option>--%>
                                                <%--<option value="masterArtRecommended">传统美术</option>--%>
                                            <%--</select>--%>
                                                <input type="text" name="sort" style="width: 35px;" value="" />
                                                <a class=" am-btn-primary" href="javascript:void (0);" onclick="saveModel(this)" style="padding: 0px 10px 5px 10px" > 保存</a>

                                       </span>
                                    </security:authorize>
                                </div>
                            </div>
                        </td>
                        <td class="am-hide-sm-only" width="20%">
                            <a href="<c:url value="/basic/xm.do?qm=viewMaster&view=master&id=${master.id}"/>">
                              ${master.fullName}
                            </a>
                            <c:forEach var="recommended" items="${master.masterRecommendedList}">
                                <c:if test="${recommended.master.id == master.id}" >
                                    <span  id="${recommended.id}" style="margin-left: 5px;color: red;"> 推荐(${recommended.sort})</span>
                                </c:if>
                            </c:forEach>
                        </td>

                        <td class="am-hide-sm-only" width="10%">
                            <ming800:status name="sex" dataType="Master.sex" checkedValue="${master.sex}" type="normal"/>

                        </td>
                        <td class="am-hide-sm-only" width="20%">
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



    function saveModel(obj){
        var  typeRecommended = "ec.masterRecommended";
        /*if(typeRecommended == "ec.masterRecommended"){
            alert("请选择推荐类型!");
        }else */if($(obj).prev("input").val()==""){
            alert("请输入序号!");
        }else {
            saveRecommended(obj, typeRecommended, 1, '<c:url value="/Recommended/saveObjectRecommended.do" />');
        }



    }



    function removeMaster(divId){
        $.ajax({
            type: "get",
            url: '<c:url value="/master/removeMaster.do"/>',
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
