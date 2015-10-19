<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title></title>
</head>
<body>

<div class="am-g">
    <div class="am-u-md-12">
        <h2>详细信息</h2>
        <div style="width: 100px;margin-bottom: 10px;">
            <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
               href="javaScript:void (0);" onclick="openUrl('${object.id}')">
                预览
            </a>
        </div>
        <table class="am-table am-table-bordered">
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">专题名称</td>
                <td class="am-u-md-3">${object.name}</td>
                <td class="am-primary am-u-md-3">封面</td>
                <td class="am-u-md-3" colspan="3">
                    <img width="35px" src="http://pro.efeiyi.com/${object.pictureUrl}@!product-model" alt="封面">
                </td>
            </tr>
            </tbody>
        </table>

    </div>
</div>
<div class="am-g">
    <div class="am-u-md-12">
        <h2>附件图片</h2>
    </div>

    <div class="am-u-md-12">
        <div class="am-panel-bd am-collapse am-in" id="collapse-panel-3" style="height: auto;overflow: hidden">

            <ul style="width: 100%" style="list-style:none" id="subjectPicture">
                <c:if test="${!empty object.subjectPictureList}">
                    <c:forEach var="subjectPicture" items="${object.subjectPictureList}">

                        <li style="float: left;margin-right: 10px; width: 200px;" name="${subjectPicture.id}">
                            <dl style="margin-top: 6px;">
                                <dt style="width: 100%">
                                    <img width="100%" name=""
                                         src="http://pro.efeiyi.com/${subjectPicture.pictureUrl}@!product-model"
                                         alt="附件图片"/>
                                        <%--<input type="hidden" name="subjectPicture" value="${subjectPicture.pictureUrl}">--%>
                                        <%--<input type="hidden" name="flag" value="0">--%>
                                        <%--<input type="hidden" name="spId" value="${subjectPicture.id}">--%>
                                </dt>

                                    <%--<dd style="width: 100%;text-align: center;" >--%>

                                    <%--<a href="javascript:void(0);" onclick="deletePicture1(this)">删除</a>--%>
                                    <%--</dd>--%>

                                    <%--<dd style="width: 100%;text-align: center;" >--%>
                                    <%--<a href="javascript:void(0);"  class="copy" url="http://pro.efeiyi.com/${subjectPicture.pictureUrl}">复制图片地址</a>--%>
                                    <%--</dd>--%>
                            </dl>
                        </li>

                    </c:forEach>
                </c:if>
            </ul>
        </div>
    </div>
</div>
<div class="am-g">
    <div class="am-u-md-12">
        <h2>关联产品</h2>
    </div>

    <div class="am-u-md-12">
        <jsp:include flush="true"
                     page="/basic/xm.do?qm=listSubjectProductModel_default&conditions=subject.id:${object.id}"/>
    </div>
</div>
<script>
    function openUrl(id){
      var   url = "http://www2.efeiyi.com/subject/"+id;
        window.open(url);
    }
</script>

</body>
</html>
