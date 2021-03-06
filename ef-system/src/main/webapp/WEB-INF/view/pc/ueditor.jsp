<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: pgwt
  Date: 5/8/16
  Time: 5:29 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>e飞蚁编辑</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <script type="text/javascript" charset="utf-8" src="<c:url value="/scripts/utf8-jsp/ueditor.config.js"/>"></script>
    <script type="text/javascript" charset="utf-8" src="<c:url value="/scripts/utf8-jsp/ueditor.all.js"/>"></script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8"
            src="<c:url value="/scripts/utf8-jsp/lang/zh-cn/zh-cn.js"/>"></script>

</head>
<body>
<div class="am-g">
    <div class="am-u-m-12" style="margin-top: 10px">
        <a class="am-btn am-btn-default am-btn-lg" href="<c:url value="${uEditor.callbackUrl}"/>">返回</a>
    </div>

    <div class="am-u-m-12" style="margin-top: 10px">
        <hr>
    </div>
    <div class="am-u-md-12">
        <form class="am-form" action="${uEditor.action}" method="post">
            <input type="hidden" name="callbackUrl" value="${uEditor.callbackUrl}">
            <input type="hidden" name="objectId" value="${uEditor.objectId}">
            <input type="hidden" name="${uEditor.paramName}" value="${uEditor.paramValue}">
            <div class="am-form-group">
                <label for="editor">
                    ${uEditor.title}
                </label>
                <script id="editor" name="${uEditor.name}" type="text/plain"
                        style="width:1024px;height:500px;"></script>
            </div>
            <button class="am-btn am-btn-primary" type="button" onclick="autotypeset()">自动排版</button>
            <input class="am-btn am-btn-primary" type="submit" value="保存">
        </form>
    </div>

</div>

<div style="display: none;" id="textContent">
    ${textContent}
</div>


<script type="text/javascript">

    //实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例


    var ue = UE.getEditor('editor');

    var defaultUploadUrl = "/ueditor/image/upload.do";


    function autotypeset() {
        ue.execCommand("autotypeset");
    }

    ue.ready(function () {
        var textContent = document.getElementById("textContent").innerHTML;
        ue.setContent(textContent);
        ue.execCommand('${uEditor.paramName}', {
            'test': '${uEditor.paramValue}'
        });

        UE.Editor.prototype._bkGetActionUrl = UE.Editor.prototype.getActionUrl;
        UE.Editor.prototype.getActionUrl = function (action) {
            if (action == 'img.do') {
                <c:if test="${not empty uEditor.uploadUrl}">
                return '${uEditor.uploadUrl}?${uEditor.paramName}=${uEditor.paramValue}';
                </c:if>
                <c:if test="${empty uEditor.uploadUrl}">
                return defaultUploadUrl;
                </c:if>
            }
            return this._bkGetActionUrl.call(this, action);
        }


    });


</script>
</body>
</html>
