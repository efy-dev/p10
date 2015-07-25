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
    <script src="/scripts/ckeditor/ckeditor.js"></script>
</head>
<body>
    <div class="am-cf am-padding">
        <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">传承人资讯</strong>
            <small>Tenant introduction</small>
        </div>
    </div>

    <hr/>

    <div class="am-g">

        <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8"><%--少了这个div就出错--%>
        </div>

        <div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
            <form action="<c:url value="/basic/xm.do"/>" method="post" class="am-form am-form-horizontal">
                <input type="hidden" value="saveOrUpdateTenantNews" name="qm">
                <input type="hidden" name="id" value="${object.id}">
                <input type="hidden" name="tenant.id" value="${tenantId}">
                <input type="hidden" name="resultPage" value="redirect:/basic/xm.do?qm=viewTenant&id=${tenantId}">

                <div class="am-form-group">
                    <label for="title" class="am-u-sm-3 am-form-label">标题</label>

                    <div class="am-u-sm-9">
                        <input type="text" id="title" name="title" placeholder="标题" value="${object.title}">
                        <%--<small>输入你要保存的类型</small>--%>
                    </div>
                </div>


                <div class="am-form-group">
                    <label for="content" class="am-u-sm-3 am-form-label">资讯内容</label>

                    <div class="am-u-sm-9">
                        <textarea id="content" name="content" class="ckeditor" placeholder="输入简介"
                                  value="${object.content}">${object.content}</textarea>
                    </div>
                    <br>
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

<script>




    function getTagList(){
        $.ajax({
            type: "get",
            url: '<c:url value="/tenantNews/tagList.do"/>',
            cache: false,
            dataType: "json",
            success: function (data) {
                $("#tagGroup").append(generateTagSelect(data));
            }
        });
    }

    function generateTagSelect(data){
        var html = "    <div class=\"am-form-group\"><label  class=\"am-u-sm-3 am-form-label\">资讯标签</label><div class=\"am-u-sm-9\">"
        for (var i = 0 ; i<data.length ; i++){
            html += "<label class=\"am-checkbox-inline\"><input type=\"checkbox\" name=\"tag"+i+"\" value=\""+data[i].id+"\" > "+data[i].value+"</label>"
        }
        html += "</div></div>"
        return html;
    }

    $().ready(function(){
        getTagList();
    });

</script>

</body>
</html>
