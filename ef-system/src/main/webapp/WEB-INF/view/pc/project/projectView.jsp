<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <div class="am-u-sm-12">
        <table class="am-table am-table-bordered">
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">项目名称</td>
                <td class="am-u-md-3">${object.name}</td>
                <td class="am-primary am-u-md-3">项目编号</td>
                <td class="am-u-md-3">${object.serial}</td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">父类别</td>
                <td class="am-u-md-3">
                    <c:if test="${not empty object.projectCategory.id}">
                       ${object.projectCategory.name}
                    </c:if>
                </td>
                <td class="am-primary am-u-md-3">父项目</td>
                <td class="am-u-md-3">
                    <c:if test="${not empty object.fatherProject.id}">
                       ${object.fatherProject.name}
                    </c:if>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
<div style="text-align: left;margin-left: 10px;" >
    <input onclick="window.location.href='<c:url value="/basic/xm.do?qm=formProject&fatherId=${object.id}"/>'" type="button" class="am-btn am-btn-default am-btn-xs" style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;" value="新建子项目" />
</div>
<div class="am-u-md-6" style="width:100%; " >
    <div class="am-panel am-panel-default">
        <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-1'}">子项目<span class="am-icon-chevron-down am-fr" ></span></div>
        <div id="collapse-panel-1" class="am-in">
            <table class="am-table am-table-bd am-table-bdrs am-table-striped am-table-hover">
                <tbody>
                <tr>
                    <th>操作</th>
                    <th>项目名称</th>
                    <th>项目编号</th>
                </tr>
            <c:forEach var="subProject" items="${object.subProjectList}" >
                <tr>

                    <td width="20%">
                        <div class="am-btn-toolbar">
                            <div class="am-btn-group am-btn-group-xs" style="width: 100%;" >
                                <button   onclick="window.location.href='<c:url value="/basic/xm.do?qm=formProject&id=${subProject.id}&fatherId=${object.id}"/>'" class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span class="am-icon-edit"></span> 编辑</button>
                                <button onclick="window.location.href='<c:url value="/basic/xm.do?qm=removeProject&id=${subProject.id}"/>'" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 删除</button>
                            </div>
                        </div>
                    </td>
                    <td>
                        <a href="<c:url value="/basic/xm.do?qm=viewProject&id=${subProject.id}"/>">${subProject.name}</a>
                    </td>
                    <td>${subProject.serial}</td>
                </tr>
            </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div style="text-align: left;" >
        <input onclick="window.location.href='<c:url value="/basic/xm.do?qm=formProjectTag&projectId=${object.id}"/>'" type="button" class="am-btn am-btn-default am-btn-xs" style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;" value="新建标签" />
    </div>
    <div class="am-panel am-panel-default">
        <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-2'}">项目标签<span class="am-icon-chevron-down am-fr" ></span></div>
        <div id="collapse-panel-2" class="am-in" >
                <c:forEach var="projectTag" items="${object.projectTagList}" varStatus="status">
                     <span class="am-badge am-badge-secondary" style="margin-left: 10px;width:85px;height: 28px;line-height: 2;margin-top: 10px;margin-bottom: 10px;background-color:rgb(102,102,102);">${projectTag.value}
                     </span>
                    <span style="margin-right: 2px;">
                     <a href="#" onclick="window.location.href='<c:url value="/basic/xm.do?qm=formProjectTag&id=${projectTag.id}&projectId=${object.id}"/>'" >编辑</a>
                     <a href="#"  onclick="window.location.href='<c:url value="/basic/xm.do?qm=removeProjectTag&id=${projectTag.id}"/>'" >删除</a>
                    </span>
                </c:forEach>

        </div>
    </div>

    <div style="text-align: left;margin-left: 10px;" >
        <input onclick="window.location.href='<c:url value="/basic/xm.do?qm=formProjectProperty&projectId=${object.id}"/>'" type="button" class="am-btn am-btn-default am-btn-xs" style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;" value="新建项目属性" />
    </div>
    <div class="am-u-md-6" style="width:100%; " >
        <div class="am-panel am-panel-default">
            <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-3'}">项目属性<span class="am-icon-chevron-down am-fr" ></span></div>
            <div id="collapse-panel-3" class="am-in">
                <table class="am-table am-table-bd am-table-bdrs am-table-striped am-table-hover">
                    <tbody>
                    <tr>
                        <th>操作</th>
                        <th>项目属性名称</th>
                        <th>项目属性值</th>
                    </tr>
                    <c:forEach var="projectProperty" items="${object.projectPropertyList}" >
                        <tr>
                            <td width="20%">
                                <div class="am-btn-toolbar">
                                    <div class="am-btn-group am-btn-group-xs" style="width: 100%;" >
                                        <button   onclick="window.location.href='<c:url value="/basic/xm.do?qm=formProjectProperty&id=${projectProperty.id}&projectId=${object.id}"/>'" class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span class="am-icon-edit"></span> 编辑</button>
                                        <button onclick="window.location.href='<c:url value="/basic/xm.do?qm=removeProjectProperty&id=${projectProperty.id}"/>'" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 删除</button>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <a href="#">${projectProperty.name}</a>
                            </td>
                            <td>
                                <span class="am-badge am-badge-secondary" style="margin-left: 10px;width:85px;height: 28px;line-height: 2;margin-top: 10px;margin-bottom: 10px;background-color:rgb(102,102,102);">+
                                 </span>
                                <c:forEach var="projectPropertyValue" items="${projectProperty.projectPropertyValueList}" varStatus="status">
                                      <span class="am-badge am-badge-secondary" style="margin-left: 10px;width:85px;height: 28px;line-height: 2;margin-top: 10px;margin-bottom: 10px;background-color:rgb(102,102,102);">${projectPropertyValue.value}
                                      </span>
                                    <span style="margin-left: 2px;">
                                 <!--      <a href="#" onclick="window.location.href='<c:url value="/basic/xm.do?qm=formProjectPropertyValue&id=${projectPropertyValue.id}&projectPropertyId=${projectProperty.id}"/>'" >编辑</a>
                                        <a href="#"  onclick="window.location.href='<c:url value="/basic/xm.do?qm=removeProjectPropertyValue?id=${projectPropertyValue.id}"/>'" >删除</a> -->
                                    </span>
                                </c:forEach>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
   </div>



</div>


</body>
</html>
