<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <script src="<c:url value='/resources/plugins/ckeditor/ckeditor.js'/>" ></script>
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
        <form action="<c:url value="/basic/xm.do"/>" method="post" class="am-form am-form-horizontal"
              enctype="multipart/form-data">
            <input type="hidden" value="saveOrUpdateMasterWork2" name="qm">
            <c:if test="${empty object.id}">
                <input type="hidden" name="serial" value="${serial}">
            </c:if>
            <c:if test="${not empty object.id}">
                <input type="hidden" name="serial" value="${object.serial}">
            </c:if>
            <input type="hidden" name="id" value="${object.id}">
            <input type="hidden" name="resultPage"
                    value="redirect:/basic/xm.do?qm=plistMasterWork2_default"/>
            <input type="hidden" value="1" name="status">
            <div class="am-form-group">
                <label for="name" class="am-u-sm-3 am-form-label">作品名称</label>

                <div class="am-u-sm-9">
                    <input type="text" id="name" name="name" placeholder="作品名称" value="${object.name}" required>
                    <%--<small>输入你要保存的类型</small>--%>
                </div>
            </div>
            <div class="am-form-group">
                <label name="name" class="am-u-sm-3 am-form-label">项目</label>

                <div class="am-u-sm-9">
                    <input type="hidden" name="project.id" id="projectId" placeholder="" value="${object.project.id}" >
                    <input type="text" name="project.name" id="projectName" placeholder="" data-am-modal="{target: '#my-popup'}" value="${object.project.name}" required>
                </div>
            </div>
            <div class="am-form-group">
                <label name="name" class="am-u-sm-3 am-form-label">作者</label>

                <div class="am-u-sm-9">
                    <input type="hidden" name="master.id" id="masterId" placeholder="" value="${object.master.id}" >
                    <input type="text" name="master.fullName" id="masterName" placeholder="" data-am-modal="{target: '#my-popup1'}" value="${object.master.fullName}" required>
                </div>
            </div>
            <div class="am-form-group">
                <label for="productDescription" class="am-u-sm-3 am-form-label">简介</label>

                <div class="am-u-sm-9">
                        <textarea id="productDescription" name="description" class="ckeditor" placeholder="介绍" required
                                  value="${object.description}">${object.description}</textarea>
                </div>
                <br>
            </div>
            <div class="am-form-group">
                <label for="size" class="am-u-sm-3 am-form-label">尺寸(规格)</label>

                <div class="am-u-sm-9">
                    <input type="text" id="size" name="size" placeholder="尺寸(规格)" value="${object.size}" required>
                </div>
            </div>
            <div class="am-form-group">
                <label for="material" class="am-u-sm-3 am-form-label">材质</label>

                <div class="am-u-sm-9">
                    <input type="text" id="material" name="material" placeholder="尺寸(规格)" value="${object.material}" required>
                </div>
            </div>
            <div class="am-form-group">
                <label for="site" class="am-u-sm-3 am-form-label">馆藏地</label>

                <div class="am-u-sm-9">
                    <input type="text" id="site" name="site" placeholder="馆藏地" value="${object.site}" required>
                </div>
            </div>
          <c:if test="${not empty object.id}">
            <div class="am-form-group">

                <label  class="am-u-sm-3 am-form-label">创建时间</label>

                <div class="am-u-sm-9">
                    <input name="createDateTime" value="${object.createDateTime}" type="hidden">
                   <fmt:formatDate value="${object.createDateTime}" pattern="yyyy-MM-dd hh:mm:ss" />
                    <%--<small>选择你要保存的轮播图</small>--%>
                </div>
            </div>
         </c:if>
            <c:if test="${empty objext.id}">
                <%
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                    String date = sdf.format(new Date());
                %>
                <input name="createDateTime" value="<%=date%>" type="hidden">
            </c:if>


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
            <input type="text" name="sel"  style="float: left" placeholder="编号或名称" value=""/>
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
                               href="javascript:void(0);" onclick="selectObj('${project.id}','${project.name}','my-popup','project')">
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
<!--大师-->
<div class="am-popup" id="my-popup1">
    <div class="am-popup-inner">
        <div class="am-popup-hd">
            <h4 class="am-popup-title">大师选择</h4>
      <span data-am-modal-close
            class="am-close">&times;</span>
        </div>
        <div class="am-popup-bd">
            <input type="text" name="sel"  style="float: left" placeholder="编号或名称" value=""/>
            <a style="width: 10%;float: left;margin-left: 10px;"
               class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
               href="javascript:void(0);" onclick="selObj(this,'my-popup1')">查找
            </a>
            <table class="am-table am-table-bd am-table-bdrs am-table-striped am-table-hover"
                   id="master">
                <tbody>
                <tr>
                    <th class="am-text-center" width="14%">操作</th>
                    <th class="am-text-center" width="17%">大师名称</th>
                    <th class="am-text-center" width="17%">大师头衔</th>
                </tr>
                <c:forEach var="master" items="${masterList}">
                    <tr name="${master.fullName}" serial="">
                        <td align="center" width="33%">
                            <a style="width: 10%;"
                               class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                               href="javascript:void(0);" onclick="selectObj('${master.id}','${master.fullName}','my-popup1','master')">
                                选择
                            </a>
                        </td>
                        <td class="am-text-center" width="33%">
                                ${master.fullName}
                        </td>
                        <td class="am-text-center" width="33%">
                                ${master.title}
                        </td>

                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script>
    function selObj(obj,popup){

        var v = $("#"+popup+" input[name='sel']").val();
        if(v==""){
            $("#"+popup+" table tr:gt(0)").each(function(){

                $(this).show();

            });
        }else {
            $("#"+popup+" table tr:gt(0)").each(function () {
                if ($(this).attr("name").indexOf(v)!=-1 || $(this).attr("serial").indexOf(v) != -1 ) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        }
    }

    function selectObj(id,name,popup,select){
        $("#"+select+"Id").val(id);
        $("#"+select+"Name").val(name);
        $("#"+popup).modal('close');
    }
    <%--function getMasterProjectTag() {--%>
        <%--$.ajax({--%>
            <%--type: "get",--%>
            <%--url: '<c:url value="/basic/xmj.do?qm=listProjectTag_default&conditions=project.id:${projectId}"/>',--%>
            <%--cache: false,--%>
            <%--dataType: "json",--%>
            <%--success: function (data) {--%>
                <%--$("#tagGroup").append(generateTagSelect(data));--%>
            <%--}--%>
        <%--});--%>
    <%--}--%>

//    function generateTagSelect(data) {
//        var html = "    <div class=\"am-form-group\"><label  class=\"am-u-sm-3 am-form-label\">作品标签</label><div class=\"am-u-sm-9\">"
//        for (var i = 0; i < data.length; i++) {
//            html += "<label class=\"am-checkbox-inline\"><input type=\"checkbox\" name=\"tag" + i + "\" value=\"" + data[i].id + "\" > " + data[i].value + "</label>"
//        }
//        html += "</div></div>"
//        return html;
//    }
//
//    $().ready(function () {
//        getMasterProjectTag();
//    });

</script>

</body>
</html>
