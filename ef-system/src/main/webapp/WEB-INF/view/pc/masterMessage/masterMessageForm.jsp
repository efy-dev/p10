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
    <link href="<c:url value='/scripts/upload/uploadify.css'/>" rel="stylesheet">
    <script src="<c:url value='/resources/plugins/ckeditor/ckeditor.js'/>" ></script>
    <script src="<c:url value='/scripts/upload/jquery.uploadify.min.js'/>"></script>
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
            <input type="hidden" name="status" value="1">
            <div class="am-form-group">
                <label for="remark" class="am-u-sm-3 am-form-label">摘要</label>

                <div class="am-u-sm-9" style="text-align: left;">
                    <textarea class="" cols="6" name="remark" rows="2" id="remark" placeholder="输入短简介,限50字以内">${object.remark}</textarea>
                    <small>输入摘要,限50字以内</small>
                </div>
            </div>
            <div class="am-form-group">
                <label for="projectId" class="am-u-sm-3 am-form-label">项目名称</label>
                <div class="am-u-sm-9">
                    <select id="project.id" name="project.id" >
                        <c:if test="${object.project != null}">
                            <c:forEach items="${projectList}" var="project">
                                <c:if test="${object.project.id != project.id}">
                                    <option value="${project.id}">${project.name}</option>
                                </c:if>
                                <c:if test="${object.project.id == project.id}">
                                    <option value="${project.id}" selected="selected">${project.name}</option>
                                </c:if>
                            </c:forEach>
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
            <%
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                String date= format.format(new Date());
            %>
            <div class="am-g">
                <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8"><%--少了这个div就出错--%>
                </div>
                <div class="am-form-group">
                    <label class="am-u-sm-3 am-form-label">动态详情</label>
                    <div class="am-u-sm-9" style="margin-top: 10px;">
                        <textarea id="productDescription" name="content" class="ckeditor" id="content"
                                  placeholder="动态" required >${object.content}
                        </textarea>
                        <small>输入动态详情</small>
                    </div>
                </div>
            </div>
            <%--<div class="am-form-group">--%>
                <%--<label name="status" class="am-u-sm-3 am-form-label">状态</label>--%>

                <%--<div class="am-u-sm-9">--%>
                    <%--<input type="text" name="status" id="status" placeholder="状态" value="${object.status}"--%>
                           <%--required>--%>
                <%--</div>--%>
            <%--</div>--%>
            <div class="am-form-group">
                <label for="dataSource" class="am-u-sm-3 am-form-label">来源</label>
                <div class="am-u-sm-9">
                    <input type="text" name="dataSource" id="dataSource" placeholder="来源" value="${object.dataSource}"
                           required>
                </div>
            </div>
            <div class="am-form-group">
                <label for="createDateTime" class="am-u-sm-3 am-form-label">创建日期</label>
                <div class="am-u-sm-9">
                    <div class="am-form-group am-form-icon">
                        <i class="am-icon-calendar"></i>
                        <c:if test="${object.createDateTime != null}">
                            <input type="text" id="createDateTime" name="createDateTime" readonly="readonly" value="${object.createDateTime}"/>
                        </c:if>
                        <c:if test="${object.createDateTime == null}">
                            <input type="text" id="createDateTime" name="createDateTime" readonly="readonly" value="<%=date%>"/>
                        </c:if>
                    </div>
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
                                    <ul style="width: 100%;padding: 0;"  style="list-style:none">
                                        <c:forEach items="${object.messageAttachmentLists}" var="attachment" varStatus="att">
                                            <li style="float: left;width:100px; height:100px;margin-right:10px;margin-bottom:6px;"  name="">
                                                <img width="100%" name="frontPhotoUrl"
                                                     src="http://tenant.efeiyi.com/${attachment.pictureUrl}@!master-message-little-more"
                                                     alt="附件"/>
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
</br>
</br>
<script>
    $(function(){
        var fileUploads = function(o){
            $('#btn_upload'+o).uploadify({
                uploader: '<c:url value="/attachment/uploadify.do?msgId=${object.id}"/>',            // 服务器处理地址
                swf: '<c:url value="/scripts/upload/uploadify.swf"/>',
                buttonText: "上传图片",                 //按钮文字
                buttonClass:"am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only",         //按钮样式
                buttonCursor:"hand",                    //鼠标指针悬停在按钮上的样子
                height: 34,                             //按钮高度
                width:140,                              //按钮宽度
                auto : true,                          //自动上传
                multi:true,                            //多个文件上传
                scriptDate:{'status':'3'},
                checkExisting:true,                    //检查文件重复
                successTimeout:1000000,                 //超时
                fileSizeLimit:'2MB',
                removeTimeout:1,                        //移除时间
                fileTypeExts: "*.jpg;*.png;",           //允许的文件类型
                fileTypeDesc: "请选择图片文件",           //文件说明
                formData: { "imgType": "normal" }, //提交给服务器端的参数
                onUploadSuccess: function (file, data) {   //一个文件上传成功后的响应事件处理
                    data = data.substring(1,data.length-1)
                    var msgId = data.split(":")[0].trim();
                    var  imgUrl = data.split(":")[1];
                    var  url = "http://tenant.efeiyi.com/"+imgUrl+"@!master-message-little-more";
                    ///显示图片
                    var img ='<li style="float: left;width:100px; height:100px;margin-right:10px;margin-bottom:6px;" name="'+msgId+'">'+
                            '   <img width="100%" name="'+msgId+ '"  src="'+url+'" alt="附件">'+
                            '</li>';
                    $("#collapse-panel-10 ul").append(img);
                }
            });
        }
        $("#btn_upload0").ready(fileUploads(0));
        $("#btn_upload-button").css({"padding":"0em 0em","text-align":"center"});

    });
</script>
</body>
</html>
