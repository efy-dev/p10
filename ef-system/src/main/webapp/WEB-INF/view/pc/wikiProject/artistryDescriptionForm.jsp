<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/5/9 0009
  Time: 15:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <script type="text/javascript" charset="utf-8" src="/scripts/utf8-jsp/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="/scripts/utf8-jsp/ueditor.all.min.js"></script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="/scripts/utf8-jsp/lang/zh-cn/zh-cn.js"></script>
</head>
<body>
<div>

    <form action="<c:url value="/projectWiki/update.do"/>" class="am-form am-form-horizontal" method="post"
          enctype="multipart/form-data">
        <input type="hidden" name="projectWikiId" value="${object.id}">
        <div class="am-form-group">
            <label name="type" for="editor" class="am-u-sm-3 am-form-label">工艺描述PC
                <small>*</small>
            </label>
            <div class="am-u-sm-9" style="margin-top: 10px">

                    <%--<textarea id="editor" name="descriptionPC"--%>
                              <%--placeholder="这里输入内容">${object.artistryDescription.descriptionPC}</textarea>--%>
                <script id="editor" type="text/plain" style="width:1024px;height:500px;"></script>
                <a class="am-btn am-btn-primary" onclick="textFilter()">过滤a标签</a>
            </div>
        </div>
        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
                <input type="submit" class="am-btn am-btn-primary" value="保存"/>
            </div>
        </div>
    </form>

</div>


<script>
    var ue = UE.getEditor('editor');
</script>
</body>
</html>
