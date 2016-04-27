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
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title></title>


    <style type="text/css">
        .line {
            margin-bottom: 20px;
        }

        /* 复制提示 */
        .copy-tips {
            position: fixed;
            z-index: 999;
            bottom: 50%;
            left: 50%;
            margin: 0 0 -20px -80px;
            background-color: rgba(0, 0, 0, 0.2);
            filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr=#30000000, endColorstr=#30000000);
            padding: 6px;
        }

        .copy-tips-wrap {
            padding: 10px 20px;
            text-align: center;
            border: 1px solid #F4D9A6;
            background-color: #FFFDEE;
            font-size: 14px;
        }
    </style>
    <script type="text/javascript" src="<c:url value='/scripts/zclip/jquery.zclip.js'/>"></script>
</head>
<body>


<div style="text-align: left">
<security:authorize ifAnyGranted="admin,operational,c_operational,o_operational">
    <input onclick="window.location.href='<c:url value="/basic/xm.do?qm=formSubject&type=gift"/>'" type="button"
           class="am-btn am-btn-default am-btn-xs"
           style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;" value="新建专题"/>
    </security:authorize>
</div>
<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>
<div >
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-6">
        </div>
        <div class="am-u-sm-12">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>
<security:authorize ifAnyGranted="admin,operational,c_operational,o_operational">
                    <th class="table-set" width="30%">操作</th>
</security:authorize>
                    <th class="table-title" width=20%">专题名称</th>
                    <th class="table-title" width="15%">专题类别</th>
                    <th class="table-title" width="15%">模板</th>
                    <th class="table-title" width="10%">序号</th>

                </tr>
                </thead>
                <tbody>


                <c:forEach items="${requestScope.pageInfo.list}" var="subject">
                    <tr id="${subject.id}">
                        <security:authorize ifAnyGranted="admin,operational,c_operational,o_operational">
                        <td>
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs">

                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                       href="<c:url value="/basic/xm.do?qm=formSubject&view=${view}&id=${subject.id}"/>">
                                        编辑
                                    </a>
                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                       href="javascript:void (0);"
                                       onclick="showConfirm('提示','是否删除',function(){removeSubject('${subject.id}')})">
                                        删除
                                    </a>


                                </div>
                            </div>
                        </td>
                        </security:authorize>
                        <td class="am-hide-sm-only"><a
                                href="<c:url value='/basic/xm.do?qm=viewGiftSubject&id=${subject.id}'/>">${subject.name}</a>
                        </td>

                        <td class="am-hide-sm-only">
                               <ming800:status name="type" dataType="Subject.type" checkedValue="${subject.type}" type="normal" />
                        </td>
                        <td class="am-hide-sm-only">
                            <ming800:status name="template" dataType="Subject.template" checkedValue="${subject.template}" type="normal" />
                        </td>
                        <td class="am-hide-sm-only">
                            ${subject.subjectIndex}
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

    function removeSubject(divId) {
        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeSubject"/>',
            cache: false,
            dataType: "json",
            data: {id: divId},
            success: function (data) {
                $("#" + divId).remove();
            }
        });
    }

    function updateShow(obj) {
        var id = $(obj).attr("subId");
        var show = $(obj).attr("show");
        $.ajax({
            type: "get",
            url: '<c:url value="/product/updateShow.do"/>',
            cache: false,
            dataType: "json",
            data: {subjectId: id,show:show},
            success: function (data) {
                if(show =="1"){
                    $(obj).text("下架");
                    $(obj).attr("show","0");
                    var span =  '<span style="color: red">上架 </span>';
                    $("#"+data+" td:eq(5)").html(span);
                }
                if(show =="0"){
                    $(obj).text("上架");
                    $(obj).attr("show","1");
                    var span =  '<span>下架 </span>';
                    $("#"+data+" td:eq(5)").html(span);
                }
            }
        });
    }

    function recommendSubject(divId) {
        $.ajax({
            type: "get",
            url: '<c:url value="/product/updateSubjectIndex.do"/>',
            cache: false,
            dataType: "json",
            data: {subjectId: divId},
            success: function (data) {
                location.reload();
            }
        });
    }
</script>

</body>
</html>
