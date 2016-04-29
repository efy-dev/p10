<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css"
          href="<c:url value="/scripts/simditor/font-awesome-4.5.0/css/font-awesome.css"/>">

</head>
<body>


<div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">新建/编辑作品</strong> /
        <small>New/edit Master Works</small>
    </div>
</div>

<hr/>

<div class="am-g">

    <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8"><%--少了这个div就出错--%>
    </div>

    <div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
        <form action="<c:url value="/basic/xm.do"/>" method="post" class="am-form am-form-horizontal">
            <input type="hidden" value="saveOrUpdateProjectWiki" name="qm">
            <input type="hidden" value="${object.id}" name="id">

            <input type="hidden" value="1" name="status">
            <div class="am-form-group">
                <label name="type" class="am-u-sm-3 am-form-label">项目类型
                    <small>*</small>
                </label>
                <div class="am-u-sm-9">
                    <ming800:status name="type" dataType="Project.type" checkedValue="${object.type}" type="select"/>
                </div>
            </div>
            <div class="am-form-group">
                <label name="name" class="am-u-sm-3 am-form-label">项目匹配</label>

                <div class="am-u-sm-9">
                    <input type="hidden" name="project.id" id="projectId" placeholder="" value="${object.project.id}">
                    <input type="text" name="project.name" id="projectName" placeholder=""
                           data-am-modal="{target: '#my-popup'}" value="${object.project.name}" required>
                </div>
            </div>

            <div class="am-form-group">
                <div class="am-u-sm-9 am-u-sm-push-3">
                    <button type="submit" class="am-btn am-btn-primary">保存</button>
                </div>
            </div>
        </form>
    </div>
</div>

<!--类别-->
<div class="am-popup" id="my-popup">
    <div class="am-popup-inner">
        <div class="am-popup-hd">
            <h4 class="am-popup-title">类别选择</h4>
      <span data-am-modal-close
            class="am-close">&times;</span>
        </div>
        <div class="am-popup-bd">
            <input type="text" name="sel" style="float: left" placeholder="编号或名称" value=""/>
            <a style="width: 10%;float: left;margin-left: 10px;"
               class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
               href="javascript:void(0);" onclick="selObj(this,'my-popup')">查找
            </a>
            <table class="am-table am-table-bd am-table-bdrs am-table-striped am-table-hover"
                   id="category">
                <tbody>
                <tr>
                    <th class="am-text-center" width="14%">操作</th>
                    <th class="am-text-center" width="17%">项目编号</th>
                    <th class="am-text-center" width="17%">项目名称</th>
                </tr>
                <c:forEach var="project" items="${projectList}">
                    <tr name="${project.name}" serial="${project.serial}">
                        <td align="center" width="33%">
                            <a style="width: 10%;"
                               class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                               href="javascript:void(0);"
                               onclick="selectObj('${project.id}','${project.name}','my-popup','project')">
                                选择
                            </a>
                        </td>
                        <td class="am-text-center" width="33%">
                                ${project.serial}
                        </td>
                        <td class="am-text-center" width="33%">
                                ${project.name}
                        </td>

                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    function selObj(obj, popup) {

        var v = $("#" + popup + " input[name='sel']").val();
        if (v == "") {
            $("#" + popup + " table tr:gt(0)").each(function () {

                $(this).show();

            });
        } else {
            $("#" + popup + " table tr:gt(0)").each(function () {
                if ($(this).attr("name").indexOf(v) != -1 || $(this).attr("serial").indexOf(v) != -1) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        }
    }

    function selectObj(id, name, popup, select) {
        $("#" + select + "Id").val(id);
        $("#" + select + "Name").val(name);
        $("#" + popup).modal('close');
    }


</script>

</body>
</html>
