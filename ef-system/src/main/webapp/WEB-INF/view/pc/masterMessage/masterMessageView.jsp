<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
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
      <input type="hidden" value="saveOrUpdateMasterMessage" name="qm">
      <input type="hidden" name="master.id" value="${masterId}">
      <input  type="hidden" name="id" value="${object.id}"/>
      <div class="am-form-group">
        <label for="remark" class="am-u-sm-3 am-form-label">摘要</label>

        <div class="am-u-sm-9" style="text-align: left;">
          <textarea class="" cols="6" name="remark" rows="2" disabled="disabled" id="remark" placeholder="输入短简介,限50字以内">${object.remark}</textarea>
          <small>输入摘要,限50字以内</small>
        </div>
      </div>
      <div class="am-form-group">
        <label for="projectId" class="am-u-sm-3 am-form-label">项目名称</label>
        <div class="am-u-sm-9">
          <select id="project.id" name="project.id" disabled="disabled">
            <c:if test="${object.project != null}">
              <%--<c:forEach items="${projectList}" var="project">--%>
                <%--<c:if test="${object.project.id != project.id}">--%>
                  <%--<option value="${project.id}">${project.name}</option>--%>
                <%--</c:if>--%>
                <%--<c:if test="${object.project.id == project.id}">--%>
                  <%--<option value="${project.id}" selected="selected">${project.name}</option>--%>
                <%--</c:if>--%>
              <%--</c:forEach>--%>
              <option value="${object.project.id}">${object.project.name}</option>
            </c:if>
            <c:if test="${object.project == null}">
              <option value="0">请选择</option>
              <c:forEach items="${projectList}" var="project">
                <option value="${project.id}">${project.name}</option>
              </c:forEach>
            </c:if>
          </select>
        </div>
      </div>
      <div class="am-g">
        <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8"><%--少了这个div就出错--%>
        </div>
        <div class="am-form-group">
          <label class="am-u-sm-3 am-form-label">动态</label>
          <div class="am-u-sm-9" style="margin-top: 10px;">
                        <textarea id="productDescription" disabled="disabled" name="content" class="ckeditor" id="content"
                                  placeholder="动态" required >${object.content}
                        </textarea>
            <small>输入动态详情</small>
          </div>
        </div>
      </div>
      <div class="am-form-group">
        <label name="status" class="am-u-sm-3 am-form-label">状态</label>

        <div class="am-u-sm-9">
          <input type="text" name="status" id="status" disabled="disabled" placeholder="状态" value="${object.status}"
                 required>
        </div>
      </div>
      <div class="am-form-group">
        <label for="dataSource" class="am-u-sm-3 am-form-label">来源</label>
        <div class="am-u-sm-9">
          <input type="text" name="dataSource" id="dataSource" disabled="disabled" placeholder="来源" value="${object.dataSource}"
                 required>
        </div>
      </div>
      <div class="am-form-group">
        <label for="createDateTime" class="am-u-sm-3 am-form-label">创建日期</label>
        <div class="am-u-sm-9">
          <div class="am-form-group am-form-icon">
            <i class="am-icon-calendar"></i>
            <input type="text" id="createDateTime" name="createDateTime" disabled="disabled" value="${object.createDateTime}"/>
          </div>
        </div>
      </div>
    </form>
    <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8"><%--少了这个div就出错--%>
    </div>
    <c:if test="${object != null}">
      <c:if test="${object.messageAttachmentLists != null}">
        <div class="am-form-group">
          <label class="am-u-sm-3 am-form-label">附件</label>
          <fieldset>
            <legend>
              <a id="btn_upload0"></a>
            </legend>
            <div class="am-u-md-13">
              <div class="am-panel am-panel-default">
                <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-1'}">
                  <strong>附件</strong>
                  <span class="am-icon-chevron-down am-fr"></span></div>
                <div class="am-panel-bd am-collapse am-in" id="collapse-panel-10" style="height: auto;overflow: hidden">
                  <ul style="width: 100%"  style="list-style:none">
                    <c:forEach items="${object.messageAttachmentLists}" var="attachment" varStatus="att">
                      <li style="float: left;margin-right: 10px;"  name="">
                        <dl style="margin-top: 6px;">
                          <dt style="width: 50%">
                            <img width="100%" name="frontPhotoUrl"
                                 src="/scripts/tc/images/skeImg.jpg"
                                 alt="附件"/>
                          </dt>
                        </dl>
                      </li>
                    </c:forEach>
                  </ul>
                </div>
              </div>
            </div>
          </fieldset>
        </div>
      </c:if>
    </c:if>
  </div>
</div>
</body>
</html>
