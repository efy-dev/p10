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
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">新建/编辑礼品专题</strong></div>
</div>

<hr/>

<div class="am-g">

    <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8"><%--少了这个div就出错--%>
    </div>

    <div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
        <form action="<c:url value="/basic/xm.do"/>" method="post" class="am-form am-form-horizontal">
            <input type="hidden" value="saveOrUpdateGiftSubject" name="qm">
            <input type="hidden" value="${object.id}" name="id">

            <input type="hidden" value="1" name="status">
            <div class="am-form-group">
                <label name="type" class="am-u-sm-3 am-form-label">专题名称
                    <small>*</small>
                </label>
                <div class="am-u-sm-9">
                    <input type="text" name="name" value="${object.name}">
                </div>
            </div>
            <div class="am-form-group">
                <label name="type" class="am-u-sm-3 am-form-label">专题短描述
                    <small>*</small>
                </label>
                <div class="am-u-sm-9">
                    <input type="text" name="content" value="${object.content}">
                </div>
            </div>
            <input type="hidden" name="template" value="1">
            <input type="hidden" name="type" value="lp">

            <div class="am-form-group">
                <div class="am-u-sm-9 am-u-sm-push-3">
                    <button type="submit" class="am-btn am-btn-primary">保存</button>
                </div>
            </div>
        </form>
    </div>
</div>

<!--类别-->

<script>


</script>

</body>
</html>
