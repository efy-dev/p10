
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/25
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>


<div class="am-g">
    <div class="am-u-sm-12">
<table class="am-table am-table-striped am-table-hover table-main">
       <thead>
               <tr>
<security:authorize ifAnyGranted="admin,operational,c_operational">
                   <th class="table-set">操作</th>
</security:authorize>
                   <th class="table-title">名称</th>
                   <th class="table-title">作者</th>
                   <th class="table-title">封面</th>
               </tr>
      </thead>
      <tbody>

                    <c:forEach items="${objectList}" var="masterWorkRecommended">
                        <tr id="${masterWorkRecommended.id}" name="${masterWorkRecommended.project.id}">
                            <security:authorize ifAnyGranted="admin,operational,c_operational">
                            <td>
                                <div class="am-btn-toolbar">
                                    <div class="am-btn-group am-btn-group-xs">
                                        <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                           onclick="removeMasterWorkRecommended11('${masterWorkRecommended.id}')" href="#"><span
                                                class="am-icon-heart" style="color: red;" ></span> 取消推荐
                                        </a>
                                        <a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="<c:url value="/basic/xm.do?qm=formMasterWorkRecommended&id=${masterWorkRecommended.masterWork.id}&masterId=${masterWorkRecommended.masterWork.master.id}&projectId=${masterWorkRecommended.masterWork.project.id}"/>"><span
                                                class="am-icon-pencil-square-o"></span> 编辑
                                        </a>
                                    </div>
                                </div>
                            </td>
                            </security:authorize>
                            <td class="am-hide-sm-only">
                                 <a href="<c:url value="/basic/xm.do?qm=viewMasterWork&id=${masterWorkRecommended.masterWork.id}&masterId=${masterWorkRecommended.masterWork.id}"/>">
                                    ${masterWorkRecommended.masterWork.name}
                                 </a>
                            </td>
                            <td class="am-hide-sm-only">
                               ${masterWorkRecommended.master.fullName}
                            </td>
                            <td class="am-hide-sm-only">
                                <a href="/Img/imgUrl.do?imgUrl=http://tenant.efeiyi.com/${masterWorkRecommended.masterWork.pictureUrl}">
                                  <img  width="10%"  src="http://tenant.efeiyi.com/${masterWorkRecommended.masterWork.pictureUrl}@!tenant-manage-banner" >
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
       </tbody>
</table>
    </div>
</div>

<script type="text/javascript">

    function removeMasterWorkRecommended11(divId){

        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeMasterWorkRecommended"/>',
            cache: false,
            dataType: "json",
            data:{id:divId},
            success: function (data) {
                $("#"+divId).remove();
            }
        });
    }

    function removeMasterWork(divId){
        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeMasterWork"/>',
            cache: false,
            dataType: "json",
            data:{id:divId},
            success: function (data) {
                $("#"+divId).remove();
            }
        });
    }

</script>

