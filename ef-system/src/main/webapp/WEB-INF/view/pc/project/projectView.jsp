<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title></title>
</head>

<div class="am-g">
    <div style="text-align: left;margin-left: 18px;" >
        <input onclick="window.location.href='<c:url value="/basic/xm.do?qm=plistProject_default"/>'" type="button" class="am-btn am-btn-default am-btn-xs" style="margin-top: 4px;margin-bottom: 6px;width: 100px;height: 35px;" value="返回列表" />
<security:authorize ifAnyGranted="admin,operational,c_operational">
        <input onclick="window.location.href='<c:url value="/basic/xm.do?qm=formProject&param=formProject"/>'" type="button" class="am-btn am-btn-default am-btn-xs" style="margin-top: 4px;margin-bottom: 6px;width: 100px;height: 35px;" value="新建项目" />
        <input onclick="window.location.href='<c:url value="/basic/xm.do?qm=formProject&param=formProject&id=${object.id}"/>'" type="button" class="am-btn am-btn-default am-btn-xs" style="margin-top: 4px;margin-bottom: 6px;width: 100px;height: 35px;" value="编辑项目" />
    </security:authorize>
    </div>
    <div class="am-u-sm-12">
        <table class="am-table am-table-bordered">
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">项目名称</td>
                <td class="am-u-md-3">${object.name}</td>
                <td class="am-primary am-u-md-3">项目编号</td>
                <td class="am-u-md-3">${object.serial}</td>
            </tr>
            <%--<tr>--%>
                <%--<td class="am-primary am-u-md-3">父类别</td>--%>
                <%--<td class="am-u-md-3">--%>
                    <%--<c:if test="${not empty object.projectCategory.id}">--%>
                       <%--${object.projectCategory.name}--%>
                    <%--</c:if>--%>
                <%--</td>--%>
                <%--<td class="am-primary am-u-md-3">父项目</td>--%>
                <%--<td class="am-u-md-3">--%>
                    <%--<c:if test="${not empty object.fatherProject.id}">--%>
                       <%--${object.fatherProject.name}--%>
                    <%--</c:if>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <tr>
                <td class="am-primary am-u-md-3">项目图片(PC)</td>
                <td class="am-u-md-3">
                    <img width="35px;" src="<c:url value="http://pro.efeiyi.com/${object.picture_url}@!product-model"/>" alt=""/>
                </td>
                <td class="am-primary am-u-md-3">项目图片(WAP)</td>
                <td class="am-u-md-3">
                    <img width="35px;" src="<c:url value="http://pro.efeiyi.com/${object.picture_wap_url}@!product-model"/>" alt=""/>
                </td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">省</td>
                <td class="am-u-md-3">
                    ${object.addressDistrict.addressCity.addressProvince.name}
                </td>
                <td class="am-primary am-u-md-3">市</td>
                <td class="am-u-md-3">
                    ${object.addressDistrict.addressCity.name}
                </td>
            <tr>
                <td class="am-primary am-u-md-3">区</td>
                <td class="am-u-md-3">
                    ${object.addressDistrict.name}
                </td>
                <td class="am-primary am-u-md-3"></td>
                <td class="am-u-md-3">

                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

    <%--<div style="text-align: left;" >--%>
        <%--<input onclick="window.location.href='<c:url value="/basic/xm.do?qm=formProjectTag&param=project&projectId=${object.id}"/>'" type="button" class="am-btn am-btn-default am-btn-xs" style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;" value="新建标签" />--%>
    <%--</div>--%>
    <%--<div class="am-panel am-panel-default">--%>
        <%--<div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-2'}">项目标签<span class="am-icon-chevron-down am-fr" ></span></div>--%>
        <%--<div id="collapse-panel-2" class="am-in" >--%>
                <%--<c:forEach var="projectTag" items="${object.projectTagList}" varStatus="status">--%>
                     <%--<span class="am-badge am-badge-secondary" style="margin-left: 10px;width:85px;height: 28px;line-height: 2;margin-top: 10px;margin-bottom: 10px;background-color:rgb(102,102,102);">${projectTag.value}--%>
                     <%--</span>--%>
                    <%--<span style="margin-right: 2px;">--%>
                     <%--<a href="#" onclick="window.location.href='<c:url value="/basic/xm.do?qm=formProjectTag&id=${projectTag.id}&projectId=${object.id}"/>'" >编辑</a>--%>
                     <%--<a href="#"  onclick="window.location.href='<c:url value="/basic/xm.do?qm=removeProjectTag&id=${projectTag.id}"/>'" >删除</a>--%>
                    <%--</span>--%>
                <%--</c:forEach>--%>

        <%--</div>--%>
    <%--</div>--%>

    <div style="text-align: left;margin-left: 15px;" >
<security:authorize ifAnyGranted="admin,operational,c_operational">
        <input onclick="window.location.href='<c:url value="/basic/xm.do?qm=formProjectProperty&param=project&projectId=${object.id}"/>'" type="button" class="am-btn am-btn-default am-btn-xs" style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;" value="新建项目属性" />
    </security:authorize>
    </div>

        <div class="am-panel am-panel-default" style="margin-left: 15px;">
            <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-3'}">项目属性<span class="am-icon-chevron-down am-fr" ></span></div>
            <div id="collapse-panel-3" class="am-in">
                <table class="am-table am-table-bd am-table-bdrs am-table-striped am-table-hover">
                    <tbody>
                    <tr>
<security:authorize ifAnyGranted="admin,operational,c_operational">
                        <th>操作</th>
</security:authorize>
                        <th>属性名称</th>
                        <th>属性值</th>
                    </tr>
                    <c:forEach var="projectProperty" items="${object.projectPropertyList}" >
                        <tr id="${projectProperty.id}">
                            <security:authorize ifAnyGranted="admin,operational,c_operational">
                            <td width="20%">
                                <div class="am-btn-toolbar">
                                    <div class="am-btn-group am-btn-group-xs" style="width: 100%;" >
                                        <button   onclick="window.location.href='<c:url value="/basic/xm.do?qm=formProjectProperty&param=project&id=${projectProperty.id}&projectId=${object.id}"/>'" class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span class="am-icon-edit"></span> 编辑</button>
                                        <button onclick="removeProjectProperty('${projectProperty.id}')" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 删除</button>
                                    </div>
                                </div>
                            </td>
                            </security:authorize>
                            <td width="20%">
                                <a href="#">${projectProperty.name}</a>
                            </td>
                            <td width="60%">
                                <security:authorize ifAnyGranted="admin,operational,c_operational">
                                <a class="am-badge am-badge-secondary" href="<c:url value="/basic/xm.do?qm=formProjectPropertyValue&projectPropertyId=${projectProperty.id}&projectId=${object.id}"/>"  style="margin-left: 10px;width:85px;height: 28px;line-height: 2;margin-top: 10px;margin-bottom: 10px;background-color:rgb(102,102,102);">+
                                 </a>
                                </security:authorize>
                                <c:forEach var="projectPropertyValue" items="${projectProperty.projectPropertyValueList}" varStatus="status">
                                          <span>
                                            <a class="am-badge am-badge-secondary" style="margin-left: 10px;width:85px;height: 28px;line-height: 2;margin-top: 10px;margin-bottom: 10px;background-color:rgb(102,102,102);">${projectPropertyValue.value}
                                            </a>
                                          </span>
                                    <samll style="margin-left: 2px;">
                                        <security:authorize ifAnyGranted="admin,operational,c_operational">
                                        <a href="#" onclick= "window.location.href='<c:url value="/basic/xm.do?qm=formProjectPropertyValue&id=${projectPropertyValue.id}&projectPropertyId=${projectProperty.id}&projectId=${object.id}"/>'" >编辑</a>
                                        <a href="#"  onclick="removePropertyValue(this,'${projectPropertyValue.id}')" >删除</a>
                                        </security:authorize>
                                    </samll>
                                </c:forEach>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>




</div>
<script>

    function removePropertyValue(obj,divId){
        $.ajax({
            type: "get",
            url: '<c:url value="/product/delProjectPropertyValue.do"/>',
            cache: false,
            dataType: "json",
            data:{id:divId},
            success: function (data) {
                $(obj).parent().prev().remove();
                $(obj).parent().remove();
            }
        });
    }

    function removeProjectProperty(divId){
        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeProjectProperty"/>',
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
