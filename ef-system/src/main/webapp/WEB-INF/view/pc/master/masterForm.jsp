<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title></title>
    <script src="<c:url value="/scripts/PCDSelect.js" />"></script>
    <script src="<c:url value='/resources/plugins/ckeditor/ckeditor.js'/>"></script>
</head>
<body>
<script>
    $(function () {
        console.log('${param.param}');
    })
</script>
<div class="am-g">

    <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8">
        <div class="am-panel am-panel-default">
        </div>
    </div>

    <div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
        <form action="<c:url value="/basic/xmm.do"/>" method="post" class="am-form am-form-horizontal"
              enctype="multipart/form-data">
            <input type="hidden" value="saveOrUpdateMaster" name="qm">
            <%--<c:if test="${'master' == param.param}">--%>
                <%--<input type="hidden" value="saveOrUpdateMaster" name="qm">--%>
            <%--</c:if>--%>
            <%--<c:if test="${'EcMaster' == param.param}">--%>
                <%--<input type="hidden" value="saveOrUpdateEcMaster" name="qm">--%>
            <%--</c:if>--%>

            <input type="hidden" name="id" value="${object.id}">
            <%--<input type="hidden" name="status" value="1"/> --%>
            <div class="am-form-group">
                <label for="name" class="am-u-sm-3 am-form-label">姓名拼音</label>

                <div class="am-u-sm-9">
                    <input type="text" id="name" name="name" placeholder="姓名拼音 / NamePinYin" value="${object.name}">
                </div>
            </div>
            <div class="am-form-group">
                <label for="fullName" class="am-u-sm-3 am-form-label">中文姓名</label>

                <div class="am-u-sm-9">
                    <input type="text" id="fullName" name="fullName" placeholder="中文姓名 / FullName"
                           value="${object.fullName}" required>
                </div>
            </div>

            <div class="am-form-group">
                <label class="am-u-sm-3 am-form-label">等级 / Level</label>
                <div class="am-u-sm-9">
                    <ming800:status name="level" dataType="Master.level" checkedValue="${object.level}" type="select"/>
                </div>
            </div>


            <div class="am-form-group">
                <label for="birthday" class="am-u-sm-3 am-form-label">出生日期</label>

                <div class="am-u-sm-9">
                    <div class="am-form-group am-form-icon">
                        <i class="am-icon-calendar"></i>
                        <input type="text" id="birthday" name="birthday" class="am-form-field am-input-sm"
                               placeholder="出生日期" value="${object.birthday}">
                    </div>
                </div>
            </div>
            <div id="pcdDiv">
                <div class="am-form-group">
                    <label name="province" for="originProvince.id" class="am-u-sm-3 am-form-label">省份
                        <small></small>
                    </label>

                    <div class="am-u-sm-9">
                        <select name="originProvince.id" class="addressProvince" id="originProvince.id"></select>
                    </div>
                </div>

            </div>

            <div class="am-form-group">
                <label for="presentAddress" class="am-u-sm-3 am-form-label">现居地</label>

                <div class="am-u-sm-9">
                    <input type="text" id="presentAddress" name="presentAddress" placeholder="现居地/ PresentAddress"
                           value="${object.presentAddress}">
                </div>
            </div>
            <div class="am-form-group">
                <label for="sex" class="am-u-sm-3 am-form-label">性别</label>

                <div class="am-u-sm-9">
                    <ming800:status name="sex" dataType="Master.sex" checkedValue="${object.sex}" type="select"
                                    required="true"/>
                </div>
            </div>

            <div class="am-form-group">
                <label for="favicon" class="am-u-sm-3 am-form-label">头像(传承人列表页面的封面)</label>

                <div class="am-u-sm-9">
                    <input type="file" id="favicon" name="favicon" placeholder="头像 / Favicon"
                           value="${object.favicon}">
                </div>
                <c:if test="${!empty object.favicon}">
                    <img src="http://tenant.efeiyi.com/${object.favicon}@!tenant-manage-photo">
                </c:if>
            </div>

            <div class="am-form-group">
                <label for="background" class="am-u-sm-3 am-form-label">背景图片(移动网站背景图片)</label>

                <div class="am-u-sm-9">
                    <input type="file" id="background" name="background" placeholder="背景图片"
                           value="${object.backgroundUrl}">
                </div>
                <c:if test="${!empty object.backgroundUrl}">
                    <img src="http://tenant.efeiyi.com/${object.backgroundUrl}@!tenant-manage-photo">
                </c:if>
            </div>


            <div class="am-form-group">
                <label for="logo" class="am-u-sm-3 am-form-label">Logo</label>

                <div class="am-u-sm-9">
                    <input type="file" id="logo" name="logo" placeholder="Logo"
                           value="${object.logoUrl}">
                </div>
                <c:if test="${!empty object.logoUrl}">
                    <img src="http://tenant.efeiyi.com/${object.logoUrl}@!tenant-manage-photo">
                </c:if>
            </div>


            <div class="am-form-group">
                <label for="user-intro" class="am-u-sm-3 am-form-label">简介 / Brief</label>

                <div class="am-u-sm-9" style="text-align: left;">
                    <textarea class="" cols="6" name="brief" rows="2" id="user-intro"
                              placeholder="输入短简介,限30字以内">${object.brief}</textarea>
                    <small>输入短简介,限30字以内</small>
                </div>
            </div>

            <div class="am-form-group">
                <label for="content" class="am-u-sm-3 am-form-label">介绍 / Content</label>

                <div class="am-u-sm-9">
                        <textarea id="content" name="content" class="ckeditor" placeholder="输入简介" required>${object.content}</textarea>
                </div>
                <br>
            </div>

            <div class="am-form-group">
                <div class="am-u-sm-9 am-u-sm-push-3">
                    <button type="submit" class="am-btn am-btn-primary">保存</button>
                </div>
            </div>
        </form>

        <c:if test="${!empty object.id}">
            <div class="am-g">
                <div class="am-u-md-12">
                    <h2>大师的项目</h2>
                    <div class="am-btn-toolbar">
                        <div class="am-btn-group am-btn-group-xs">
                            <security:authorize ifAnyGranted="admin,operational,c_operational">
                                <a type="button" class="am-btn am-btn-default"
                                   href="<c:url value="/basic/xm.do?qm=listProject_default&masterId=${object.id}&master=1"/>"><span
                                        class="am-icon-plus"></span> 新建为主项目</a>
                                <a type="button" class="am-btn am-btn-default"
                                   href="<c:url value="/basic/xm.do?qm=listProject_default&masterId=${object.id}"/>"><span
                                        class="am-icon-plus"></span> 新建项目</a>
                            </security:authorize>
                        </div>
                    </div>
                </div>

                <div class="am-u-md-12">
                    <jsp:include flush="true"
                                 page="/basic/xm.do?qm=listMasterProject_include&conditions=master.id:${object.id}"/>
                </div>
            </div>
        </c:if>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        $("#pcdDiv").pcdSelect(
                "<c:url value='/pj/address/provinceList.do'/>",
                "",
                "",
                "${object.originProvince.id}",
                "",
                ""
        )
    });
</script>
</body>
</html>
