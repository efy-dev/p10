<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/22
  Time: 16:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title></title>
    <script type="text/javascript">
        function showDiv(){
            var psf=document.getElementById("uploadProductImg");
            psf.setAttribute("style","display");
        }
    </script>
</head>
<body style="height: auto">
<div class="am-cf am-padding">
    <div class="am-fl am-cf">
        <strong class="am-text-primary am-text-lg">商品${object.name}详细信息</strong>
    </div>
</div>
<%-- 商品基本属性 --%>
<div am-panel am-panel-default admin-sidebar-panel>
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr>
            <td>商品名称：</td>
            <td>
                ${object.name}
                <c:if test="${!empty object.logo}">
                    <img src="http://pal.efeiyi.com/${object.logo}@!pal-img-list">
                </c:if>
            </td>
        </tr>
        <tr>
            <td>序列号：</td>
            <td>${object.serial}</td>
        </tr>
        <tr>
            <td>制作时间：</td>
            <td><fmt:formatDate value="${object.madeYear}" pattern="yyyy-MM-dd"/></td>
        </tr>
        <tr>
            <td>所属系列：</td>
            <td>${object.productSeries.name}</td>
        </tr>
        <tr>
            <td>商户名称：</td>
            <td>${object.tenant.name}</td>
        </tr>
        <tr>
            <td>制作大师：</td>
            <td>${object.masterName}</td>
        </tr>
        <tr>
            <td>购买链接：</td>
            <td>${object.shoppingUrl}</td>
        </tr>
        <c:if test="${tag == 'true'}">
        <tr>
            <td>防伪标签：</td>
            <td>
                <a href="<c:url value="/basic/xm.do?qm=plistLabel_productLabel&conditions=purchaseOrderLabel.product.id:${object.id}"/>">查看标签</a>
            </td>
        </tr>
        </c:if>
    </table>
</div>

<%-- 商品图片 上传 --%>
<div style="text-align: left;margin-left: 10px;">
    <input onclick="showDiv()"
           type="button" class="am-btn am-btn-default am-btn-xs"
           style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;"
           value="上传商品图片"/>
</div>

<div class="am-g" id="uploadProductImg" style="display:none">
    <form action="<c:url value='/productImg/saveProductImg.do'/>" method="post" enctype="multipart/form-data" class="am-form am-form-horizontal">
        <input type="hidden" name="productId" value="${object.id}">
        <div class="am-form-group">
            <label for="Img" class="am-u-sm-3 am-form-label">商品图片 <small style="color: red">*</small></label>
            <div class="am-u-sm-9">
                <input type="file" id="Img" name="Img" required>
            </div>
        </div>
        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
                <input type="submit" class="am-btn am-btn-primary" value="保存"/>
            </div>
        </div>
    </form>
</div>

<%-- 商品图片 展示 --%>
<c:if test="${!empty object.imgList}">
    <div class="am-cf am-padding">
        <div class="am-fl am-cf">
            <strong class="am-text-primary am-text-lg">商品图片</strong>/<small>小图展示</small>
        </div>
    </div>
    <div am-panel am-panel-default admin-sidebar-panel>
        <table class="am-table am-table-bordered am-table-radius am-table-striped">
            <tbody>
            <tr>
                <c:forEach items="${object.imgList}" var="Img">
                    <td>
                        <img src="http://pal.efeiyi.com/${Img.imgUrl}@!pal-img-list"/>
                    </td>
                </c:forEach>
            </tr>
            <tr>
                <c:forEach items="${object.imgList}" var="Img2">
                    <td>
                        <button onclick="window.location.href='<c:url value="/productImg/removeProductImg.do?productId=${object.id}&ImgId=${Img2.id}"/>'"
                                class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 删除</button>
                    </td>
                </c:forEach>
            </tr>
            </tbody>
        </table>
    </div>
</c:if>

<%-- 商品所属商品系列的 系列属性列表 --%>
<c:if test="${!empty object.productPropertyValueList}">
    <div class="am-cf am-padding">
        <div class="am-fl am-cf">
            <strong class="am-text-primary am-text-lg">系列属性列表</strong>
        </div>
    </div>
    <div am-panel am-panel-default admin-sidebar-panel>
        <table class="am-table am-table-bordered am-table-radius am-table-striped">
            <tr>
                <td>系列属性名</td>
                <td>商品属性值</td>
            </tr>
            <c:forEach items="${object.productPropertyValueList}" var="productPropertyValue">
                <tr>
                    <td>${productPropertyValue.productSeriesPropertyName.name}</td>
                    <td>${productPropertyValue.value}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
</c:if>

<%-- 商品溯源信息 --%>
<c:if test="${!empty object.tenantProductSeries}">
    <div class="am-cf am-padding">
        <div class="am-fl am-cf">
            <strong class="am-text-primary am-text-lg">溯源信息</strong>
        </div>
    </div>
    <div am-panel am-panel-default admin-sidebar-panel>
        <table class="am-table am-table-bordered am-table-radius am-table-striped">
            <tr style="text-align:left">
                <td>参与人</td>
                <td>制作工艺</td>
                <td>创作地区</td>
                <td>溯源图片</td>
            </tr>
            <tr>
                <td>${object.masterName}</td>
                <td>${object.tenantProductSeries.craft}</td>
                <td>${object.tenantProductSeries.region}</td>
                <td>
                    <c:forEach items="${object.tenantProductSeries.imgList}" var="img">
                        <c:if test="${not empty img.imgUrl}">
                            <img src="http://pal.efeiyi.com/${img.imgUrl}@!pal-img-list"/>
                        </c:if>
                    </c:forEach>
                </td>
            </tr>
        </table>
    </div>
</c:if>

<%-- 商品认证信息 --%>
<c:if test="${!empty object.tenantCertification}">
    <div class="am-cf am-padding">
        <div class="am-fl am-cf">
            <strong class="am-text-primary am-text-lg">认证信息</strong>
        </div>
    </div>
    <div am-panel am-panel-default admin-sidebar-panel>
        <table class="am-table am-table-bordered am-table-radius am-table-striped">
            <tr style="text-align:left">
                <td>认证证书</td>
                <td>认证机构</td>
                <td>认证时间</td>
                <td>认证结果</td>
                <td>证书图片</td>
            </tr>
            <tr>
                <td>${object.tenantCertification.name}</td>
                <td>${object.tenantCertification.org}</td>
                <td><fmt:formatDate value="${object.tenantCertification.theDate}" pattern="yyyy年MM月"/></td>
                <td>
                    <ming800:status name="level" dataType="PCTenantCertification.level" checkedValue="${object.tenantCertification.level}" type="normal" />
                </td>
                <td>
                    <c:forEach items="${object.tenantCertification.imgList}" var="tenantCertificationImg">
                        <c:if test="${not empty tenantCertificationImg.imgUrl}">
                            <img src="http://pal.efeiyi.com/${tenantCertificationImg.imgUrl}@!pal-img-list"/>
                        </c:if>
                    </c:forEach>
                </td>
            </tr>
        </table>
    </div>
</c:if>

</body>
</html>
