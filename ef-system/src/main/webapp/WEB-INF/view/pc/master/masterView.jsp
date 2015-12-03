<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title></title>
    <style>
    </style>
</head>
<body>
<%--<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>--%>

<div class="am-g">
    <div class="am-u-md-12">
        <h2>详细信息</h2>
        <table class="am-table am-table-bordered">
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">姓名拼音</td>
                <td class="am-u-md-3">${object.name}</td>
                <td class="am-primary am-u-md-3">中文名字</td>
                <td class="am-u-md-3">${object.fullName}</td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">性别</td>
                <td class="am-u-md-3">
                    <ming800:status name="sex" dataType="Master.sex" checkedValue="${object.sex}" type="normal" />
                </td>
                <td class="am-primary am-u-md-3">出生日期</td>
                <td class="am-u-md-3">${object.birthday}</td>

            </tr>
            <tr>
                <td class="am-primary am-u-md-3">籍贯</td>
                <td class="am-u-md-3">${object.provinceName}</td>
                <td class="am-primary am-u-md-3">现居地</td>
                <td class="am-u-md-3">${object.presentAddress}</td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">等级</td>
                <td class="am-u-md-3">
                    <ming800:status name="level" dataType="Master.level" checkedValue="${object.level}" type="normal" />
               </td>
                <td class="am-primary am-u-md-3" style="padding: 0rem"> </td>
                <td class="am-u-md-3" style="padding: 0rem">
                </td>
            </tr>
            </tbody>
        </table>

    </div>
    <div class="am-u-md-4" >
       <label class="am-form-label">Logo</label>
       <div class="" >
         <img src="http://tenant.efeiyi.com/${object.logoUrl}@!tenant-manage-banner">
       </div>
    </div>
    <div class="am-u-md-4">
        <label class="am-form-label">头像</label>
        <div class="">
            <img src="http://tenant.efeiyi.com/${object.favicon}@!tenant-manage-banner">
        </div>
    </div>
    
    <div class="am-u-md-4">
        <label class="am-form-label">背景</label>
        <div class="">
            <img src="http://tenant.efeiyi.com/${object.backgroundUrl}@!tenant-manage-banner">
        </div>
    </div>
</div>
<div class="am-u-md-12">
<label   class="am-u-sm-3 am-form-label">短简介 / Brief</label>
<div >
    ${object.brief}
</div>
</div>

<div class="am-g">
    <div class="am-u-md-12">
        <h2>传承人的项目</h2>
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
<div class="am-g">
    <div class="am-u-md-12">
        <h2>推荐作品</h2>
    </div>

    <div class="am-u-md-12">
        <jsp:include flush="true"
                     page="/basic/xm.do?qm=listMasterWorkRecommended_include&conditions=master.id:${object.id}"/>
    </div>
</div>

<div class="am-g">

    <div class="am-u-md-12">
        <h2>轮播图</h2>

        <div class="am-btn-toolbar">
            <div class="am-btn-group am-btn-group-xs">
<security:authorize ifAnyGranted="admin,operational,c_operational">
                <a type="button" class="am-btn am-btn-default"
                   href="<c:url value="/basic/xm.do?qm=formMasterBanner&masterId=${object.id}"/>"><span
                        class="am-icon-plus"></span> 新建轮播图</a>
</security:authorize>
            </div>
        </div>
    </div>

    <div class="am-u-md-12">
        <jsp:include flush="true"
                     page="/basic/xm.do?qm=listMasterBanner_default&conditions=master.id:${object.id}"/>
    </div>
</div>


<div class="am-g">
    <div class="am-u-md-12">
        <h2>传承人介绍</h2>

        <div class="am-btn-toolbar">
            <div class="am-btn-group am-btn-group-xs">
<security:authorize ifAnyGranted="admin,operational,c_operational">
                <a type="button" class="am-btn am-btn-default"
                   href="<c:url value="/basic/xm.do?qm=formMasterIntroduction&masterId=${object.id}"/>"><span
                        class="am-icon-plus"></span> 新建传承人介绍</a>
</security:authorize>
            </div>
        </div>
    </div>

    <div class="am-u-md-12">
        <jsp:include flush="true"
                     page="/basic/xm.do?qm=listMasterIntroduction_include&conditions=master.id:${object.id}&master.id=${object.id}"/>
    </div>
</div>
<div class="am-g">
    <div class="am-u-md-12">
        <h2>大师作品</h2>

        <div class="am-btn-toolbar">
            <div class="am-btn-group am-btn-group-xs">
                <a type="button" class="am-btn am-btn-default"
                   href="<c:url value="/basic/xm.do?qm=formMasterWork&masterId=${object.id}"/>"><span
                        class="am-icon-plus"></span>新建作品</a>
            </div>
        </div>
    </div>

    <%--<div class="am-u-md-12">--%>
        <%--<jsp:include flush="true"--%>
                     <%--page="/basic/xm.do?qm=listMasterWork_include&conditions=master.id:${object.id}&masterId=${object.id}"/>--%>
    <%--</div>--%>
</div>
</body>
</html>
