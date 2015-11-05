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
<html>
<head>
    <title></title>
    <script src="<c:url value='/resources/plugins/ckeditor/ckeditor.js'/>" ></script>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">传承人动态</strong> /
        <small>Master Message</small>
    </div>
</div>

<hr/>

<div class="am-g">
    <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8"><%--少了这个div就出错--%>
    </div>
    <div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
        <form action="<c:url value="/basic/xm.do"/>" method="post" class="am-form am-form-horizontal">
            <input type="hidden" value="saveOrUpdateMasterNews" name="qm">
            <input type="hidden" name="master.id" value="${masterId}">
            <input  type="hidden" name="id" value="${object.id}"/>
            <input type="hidden" name="resultPage" value="redirect:/basic/xm.do?qm=plistMasterMessage_default&conditions=master.id:${masterId}&masterId=${masterId}" />
            <div class="am-form-group">
                <label for="remark" class="am-u-sm-3 am-form-label">摘要</label>

                <div class="am-u-sm-9" style="text-align: left;">
                    <textarea class="" cols="6" name="remark" rows="2" id="remark" placeholder="输入短简介,限50字以内">${object.remark}</textarea>
                    <small>输入摘要,限50字以内</small>
                </div>
            </div>
            <div class="am-form-group">
                <label for="content" class="am-u-sm-3 am-form-label">短简介</label>

                <div class="am-u-sm-9" style="text-align: left;">
                    <textarea class="" cols="6" name="content" rows="2" id="content" placeholder="输入短简介,限30字以内">${object.content}</textarea>
                    <small>输入短简介,限30字以内</small>
                </div>
            </div>
            <div class="am-form-group">
                <label for="project.id" class="am-u-sm-3 am-form-label">项目名称</label>

                <div class="am-u-sm-9">
                    <select id="project.id" name="project.id" >
                            <option value="0">请选择</option>
                            <c:forEach items="${masterProjectList}" var="masterProject">

                                    <option value="${masterProject.project.id}"  <c:if test="${object.project.id != masterProject.project.id}">selected="selected"</c:if>>${masterProject.project.name}</option>

                            </c:forEach>
                            <%--<option value="${object.project.id}">${object.project.name}</option>--%>
                    </select>
                </div>
            </div>
            <%--<div class="am-form-group">--%>
                <%--<label for="projectId" class="am-u-sm-3 am-form-label">项目名称</label>--%>

                <%--<div class="am-u-sm-9">--%>
                    <%--<select id="project.id" name="project.id" >--%>
                        <%--<c:if test="${object.project != null}">--%>
                            <%--<c:forEach items="${projectList}" var="project">--%>
                                <%--<c:if test="${object.project.id != project.id}">--%>
                                    <%--<option value="${project.id}">${project.name}</option>--%>
                                <%--</c:if>--%>
                                <%--<c:if test="${object.project.id == project.id}">--%>
                                    <%--<option value="${project.id}" selected="selected">${project.name}</option>--%>
                                <%--</c:if>--%>
                            <%--</c:forEach>--%>
                            <%--&lt;%&ndash;<option value="${object.project.id}">${object.project.name}</option>&ndash;%&gt;--%>
                        <%--</c:if>--%>
                        <%--<c:if test="${object.project == null}">--%>
                            <%--<option value="0">请选择</option>--%>
                            <%--<c:forEach items="${projectList}" var="project">--%>
                                <%--<option value="${project.id}">${project.name}</option>--%>
                            <%--</c:forEach>--%>
                        <%--</c:if>--%>
                    <%--</select>--%>
                <%--</div>--%>
            <%--</div>--%>
            <div class="am-form-group">
                <label for="createDateTime" class="am-u-sm-3 am-form-label">创建日期</label>

                <div class="am-u-sm-9">
                    <div class="am-form-group am-form-icon">
                        <i class="am-icon-calendar"></i>
                        <input type="text" id="createDateTime" name="createDateTime" class="am-form-field am-input-sm"
                               placeholder="创建日期"  value="${object.createDateTime}" data-am-datepicker readonly>
                    </div>
                </div>
            </div>
            <div class="am-form-group">
                <label name="dataSource" class="am-u-sm-3 am-form-label">来源</label>

                <div class="am-u-sm-9">
                    <input type="text" name="dataSource" id="dataSource" placeholder="来源" value="${object.dataSource}">
                    <!--<small>必填项*</small>-->
                </div>
            </div>

            <div class="am-form-group">
                <label for="type" class="am-u-sm-3 am-form-label">类型</label>
                <div style="margin-top: 10px;">
                    <span style="padding: 10px;">
                        <input type="radio" name="type" <c:if test="${object.type == 1}">checked="checked"</c:if> value="1"/>
                        文本
                    </span>
                    <span style="padding: 10px;">
                      <input type="radio" name="type" <c:if test="${object.type == 2}">checked="checked"</c:if> value="2"/>
                        附件
                    </span>
                    <span style="padding: 10px;">
                      <input type="radio" name="type" <c:if test="${object.type == 3}">checked="checked"</c:if> value="3"/>
                        超链接
                    </span>
                    <span style="padding: 10px;">
                      <input type="radio" name="type" <c:if test="${object.type == 4}">checked="checked"</c:if> value="4"/>
                        视频
                    </span>
                    <span style="padding: 10px;">
                      <input type="radio" name="type" <c:if test="${object.type == 5}">checked="checked"</c:if> value="5"/>
                        作品
                    </span>
                </div>
            </div>
            <div class="am-form-group">
                <div class="am-u-sm-9 am-u-sm-push-3">
                    <button type="submit" class="am-btn am-btn-primary">保存</button>
                </div>
            </div>
        </form>
        <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8"><%--少了这个div就出错--%>
        </div>
        <c:if test="${object != null && object.messageAttachmentLists != null}">
             <c:forEach items="${object.messageAttachmentLists}" var="attachment" varStatus="att">
                 <label class="am-u-sm-3 am-form-label">动态${att.index +1}</label>
                 <div class="am-u-sm-9" style="margin-top: 10px;">
                <textarea id="productDescription" name="content" class="" cols="110" rows="8"
                          placeholder="动态" required >${attachment.fileName}
                </textarea>
                 </div>
             </c:forEach>
        </c:if>
    </div>
</div>
</body>
</html>
