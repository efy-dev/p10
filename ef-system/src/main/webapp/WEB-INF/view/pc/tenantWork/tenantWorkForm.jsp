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


<div class="admin-content">
    <div class="am-cf am-padding">
        <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">传承人作品</strong> /
            <%--<small>Tenant introduction</small>--%>
        </div>
    </div>

    <hr/>

    <div class="am-g">

        <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8"><%--少了这个div就出错--%>
        </div>

        <div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
            <form action="/basic/xmm.do" method="post" class="am-form am-form-horizontal" enctype="multipart/form-data">
                <input type="hidden" value="saveOrUpdateTenantWork" name="qm">
                <input type="hidden" name="id" value="${object.id}">
                <input type="hidden" name="tenant.id" value="${tenantId}">
                <input type="hidden" name="resultPage" value="redirect:/basic/xm.do?qm=viewTenant&id=${tenantId}">

                <div class="am-form-group">
                    <label for="name" class="am-u-sm-3 am-form-label">名称</label>

                    <div class="am-u-sm-9">
                        <input type="text" id="name" name="name" placeholder="名称" value="${object.name}">
                        <%--<small>输入你要保存的类型</small>--%>
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="price" class="am-u-sm-3 am-form-label">价格</label>

                    <div class="am-u-sm-9">
                        <input type="text" id="price" name="price" placeholder="名称" value="${object.price.intValue()}">
                        <%--<small>输入你要保存的类型</small>--%>
                    </div>
                </div>


                <div class="am-form-group">
                    <label for="productDescription" class="am-u-sm-3 am-form-label">介绍</label>

                    <div class="am-u-sm-9">
                        <textarea id="productDescription" name="productDescription" class="ckeditor" placeholder="介绍"
                                  value="${object.productDescription.content}">${object.productDescription.content}</textarea>
                    </div>
                    <br>
                </div>


                <div class="am-form-group">
                    <label for="picurl" class="am-u-sm-3 am-form-label">图片</label>

                    <div class="am-u-sm-9">
                        <input type="file" id="picurl" name="picurl" placeholder="附件">
                        <%--<small>选择你要保存的轮播图</small>--%>
                    </div>
                </div>


                <div class="am-form-group">
                    <div class="am-u-sm-9 am-u-sm-push-3">
                        <button type="submit" class="am-btn am-btn-primary">保存修改</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>


<script>

    function getTenantWorkTag(){
        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeTenantAttachment"/>',
            cache: false,
            dataType: "json",
            data: {id: divId},
            success: function (data) {
                $("#" + divId).remove();
            }
        });
    }

</script>

</body>
</html>
