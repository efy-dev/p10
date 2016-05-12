<%@ page import="com.efeiyi.ec.personal.master.MasterUtil" %>
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
    <script src="<c:url value='/resources/plugins/ckeditor/ckeditor.js'/>" ></script>
</head>
<body>
    <div class="am-cf am-padding">
        <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">传承人工作坊</strong> /
            <small>Master WorkShop</small>
        </div>
    </div>

    <hr/>

    <div class="am-g">

        <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8"><%--少了这个div就出错--%>
        </div>

        <div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
            <form action="<c:url value="/basic/xmm.do"/>" method="post" class="am-form am-form-horizontal" enctype="multipart/form-data">
                <input type="hidden" value="saveOrUpdateMasterWorkShop" name="qm">
                <input type="hidden" name="id" value="${object.id}">
                <input type="hidden" name="status" value="1">
                <input type="hidden" name="master.id" value="<%=MasterUtil.findMaster().getId()%>">
                <input type="hidden" name="resultPage" value="redirect:/basic/xm.do?qm=plistMasterWorkShop_default">

                <div class="am-form-group">
                    <label for="name" class="am-u-sm-3 am-form-label">名称</label>

                    <div class="am-u-sm-9">
                        <input type="text" id="name" name="name" placeholder="名称" value="${object.name}" required>
                        <%--<small>输入你要保存的类型</small>--%>
                    </div>
                </div>

                <%--<div class="am-form-group">--%>
                <%--<label for="price" class="am-u-sm-3 am-form-label">价格</label>--%>

                <%--<div class="am-u-sm-9">--%>
                <%--<input type="text" id="price" name="price" placeholder="名称" value="${object.price.intValue()}">--%>
                <%--&lt;%&ndash;<small>输入你要保存的类型</small>&ndash;%&gt;--%>
                <%--</div>--%>
                <%--</div>--%>


                <div class="am-form-group">
                    <label for="shopIntroduction" class="am-u-sm-3 am-form-label">介绍</label>

                    <div class="am-u-sm-9">
                        <textarea id="shopIntroduction" name="shopIntroduction" class="ckeditor" placeholder="介绍" required
                                  value="${object.shopIntroduction}">${object.shopIntroduction}</textarea>
                    </div>
                    <br>
                </div>


                <div class="am-form-group">
                    <label for="picture_url" class="am-u-sm-3 am-form-label">封面</label>

                    <div class="am-u-sm-9">
                        <c:if test="${!empty object.id}">
                            <input type="hidden" name="picture_url" value="${object.picture_url}"/>
                            <img width="10%"
                                 src="<c:url value="http://tenant.efeiyi.com/${object.picture_url}@!tenant-manage-banner"/>"
                                 alt=""/>
                        </c:if>
                        <input type="file" id="picture_url" name="picture_url1" value="${object.picture_url}" placeholder="封面">
                        <%--<small>选择你要保存的轮播图</small>--%>
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="videoPath" class="am-u-sm-3 am-form-label">video</label>


                    <div class="am-u-sm-9">
                        <c:if test="${!empty object.id}">
                            <input type="hidden" name="videoPath" value="${object.videoPath}"/>
                            <video src="http://tenant.oss-cn-beijing.aliyuncs.com/${object.videoPath}" controls="controls"  width="500" height="250"></video>
                        </c:if>
                        <input type="file" id="videoPath"  name="videoPath1"  placeholder="video">
                        <small>选择你要保存的视频</small>
                    </div>
                </div>

                <div id="tagGroup">

                </div>

                <div class="am-form-group">
                    <div class="am-u-sm-9 am-u-sm-push-3">
                        <button type="submit" class="am-btn am-btn-primary">保存</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
