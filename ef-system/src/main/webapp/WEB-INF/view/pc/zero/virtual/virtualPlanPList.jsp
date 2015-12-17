<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/11/25
  Time: 17:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title>虚拟数据批次</title>
</head>
<body style="height: auto">
<div style="text-align: left;margin-left: 10px;">
    <input onclick="window.location.href='<c:url value="/basic/xm.do?qm=formVirtualPlan&virtual=virtual"/>'"
           type="button" class="am-btn am-btn-default am-btn-xs"
           style="margin-top: 4px;margin-bottom: 6px;margin-left:2px;height: 35px;"
           value="新建虚拟数据批次"/>
</div>
<div>
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr style="text-align:left">
            <td>操作</td>
            <td>虚拟数据批次</td>
            <td>虚拟数据对象</td>
            <td>关联数量</td>
            <td>已完成数量</td>
            <td>起始日期</td>
            <td>终止日期</td>
            <td>起始时间</td>
            <td>终止时间</td>
            <td>任务状态</td>
            <td>创建时间</td>
        </tr>
        <c:forEach items="${VPEList}" var="vpe">
            <tr>
                <td>
                    <div class="am-btn-toolbar">
                        <div class="am-btn-group am-btn-group-xs" style="width: 100%;">
                            <button onclick="window.location.href='<c:url
                                    value="/basic/xm.do?qm=formVirtualPlan&virtual=virtual&id=${vpe.virtualPlan.id}"/>'"
                                    class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span
                                    class="am-icon-edit"></span> 编辑
                            </button>
                            <button onclick="window.location.href='<c:url
                                    value="/basic/xm.do?qm=removeVirtualPlan&id=${vpe.virtualPlan.id}"/>'"
                                    class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                                    class="am-icon-trash-o"></span> 删除
                            </button>
                            <button onclick="window.location.href='<c:url
                                    value="/virtualPlan/pausePlan.do?id=${vpe.virtualPlan.id}&resultPage=/basic/xm.do?qm=plistVirtualPlan_default"/>'"
                                    class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span
                                    class="am-icon-edit"></span> 暂停任务
                            </button>
                            <button onclick="window.location.href='<c:url
                                    value="/virtualPlan/startPlan.do?id=${vpe.virtualPlan.id}&resultPage=/basic/xm.do?qm=plistVirtualPlan_default"/>'"
                                    class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span
                                    class="am-icon-trash-o"></span> 开始任务
                            </button>
                        </div>
                    </div>
                </td>
                <td>
                    <a href="<c:url value="/virtualPlan/getTypeObjectView.do?virtual=virtual&id=${vpe.virtualPlan.id}&type=${vpe.type}"/>">${vpe.virtualPlan.serial}</a>
                </td>
                <td>
                    <ming800:status name="status" dataType="PCVirtualPlan.planType" checkedValue="${vpe.virtualPlan.planType}"
                                    type="normal"/>
                </td>
                <td><%--关联数量--%>${vpe.relation}</td>
                <td><%--已完成数量--%><%--${vpe.complete}--%>
                    <a href="<c:url value="/virtualPlan/getTypeObjectList.do?virtual=virtual&id=${vpe.virtualPlan.id}&type=${vpe.type}"/>">${vpe.complete}</a>
                </td>
                <td><%--起始日期--%>${vpe.virtualPlan.startDate}
                    <%--<fmt:formatDate value="${plan.startDate}" pattern="yyyy-MM-dd"/>--%>
                </td>
                <td><%--终止日期--%>${vpe.virtualPlan.endDate}
                    <%--<fmt:formatDate value="${plan.endDate}" pattern="yyyy-MM-dd"/>--%>
                </td>
                <td><%--起始时间--%>${vpe.virtualPlan.startTime}
                    <%--<fmt:formatDate value="${plan.startTime}" pattern="HH:mm:ss"/>--%>
                </td>
                <td><%--终止时间--%>${vpe.virtualPlan.endTime}
                    <%--<fmt:formatDate value="${plan.endTime}" pattern="HH:mm:ss"/>--%>
                </td>
                <td>
                    <ming800:status name="status" dataType="PCVirtualPlan.status" checkedValue="${vpe.virtualPlan.status}"
                                    type="normal"/>
                </td>
                <td>
                    <fmt:formatDate value="${vpe.virtualPlan.createDatetime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
<div style="clear: both">
    <c:url value="/basic/xm.do" var="url"/>
    <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
        <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
        <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
    </ming800:pcPageList>
</div>
</body>
</html>
