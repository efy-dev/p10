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
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ include file="/layouts/public.jsp" %>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="<c:url value='/scripts/upload/uploadify.css'/>"/>
    <script src="<c:url value='/scripts/upload/jquery.uploadify.js'/>"></script>
</head>
<body>
<div style="text-align: left;margin-left: 10px;">
    <input onclick="window.location.href='<c:url value="/basic/xm.do?qm=formProduct&product=product&id=${object.id}"/>'"
           type="button" class="am-btn am-btn-default am-btn-xs"
           style="margin-top: 8px;margin-bottom: 6px;margin-left:2px;height: 35px;"
           value="编辑"/>
    <input onclick="myConfirm('<c:url value="/basic/xm.do?qm=removeProduct&id=${object.id}"/>', 'D')"
           type="button" class="am-btn am-btn-default am-btn-xs am-text-danger"
           style="margin-top: 8px;margin-bottom: 6px;margin-left:2px;height: 35px;"
           value="删除" />
    <input onclick="window.history.back()"
           type="button" class="am-btn am-btn-default am-btn-xs"
           style="margin-top: 8px;margin-bottom: 6px;margin-left:2px;height: 35px;"
           value="返回" />
</div>
<jsp:include page="/layouts/myConfirm.jsp"/>
<div class="am-cf am-padding">
    <div class="am-fl am-cf">
        <strong class="am-text-primary am-text-lg">商品详细信息</strong>
    </div>
</div>
<%-- 商品基本属性 --%>
<div am-panel am-panel-default admin-sidebar-panel>
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr>
            <td>商品名称</td>
            <td>
                ${object.name}
                <c:if test="${not empty object.logo}">
                    <img src="<%=imgBasePath %>${object.logo}<%=imgListCss %>">
                </c:if>
            </td>
        </tr>
        <tr>
            <td>商品编号</td>
            <td>${object.serial}</td>
        </tr>
        <tr>
            <td>制作时间</td>
            <td><fmt:formatDate value="${object.madeYear}" pattern="yyyy-MM-dd"/></td>
        </tr>
        <tr>
            <td>非遗项目</td>
            <td>${object.productSeries.name}</td>
        </tr>
        <tr>
            <td>商户名称</td>
            <td>${object.tenant.name}</td>
        </tr>
        <tr>
            <td>制作大师</td>
            <td>${object.masterName}</td>
        </tr>
        <tr>
            <td>购买链接</td>
            <td>${object.shoppingUrl}</td>
        </tr>
        <c:if test="${tag == 'true'}">
        <tr>
            <td>防伪标签</td>
            <td>
                <a href="<c:url value="/basic/xm.do?qm=plistLabel_productLabel&conditions=purchaseOrderLabel.product.serial:${object.serial}"/>">查看标签</a>
            </td>
        </tr>
        </c:if>
    </table>
</div>
<%-- 商品图片 上传 --%>
<div style="text-align: left;margin-left: 10px;">
    <input onclick="window.location.href='<c:url value="/product/editProductSeriesProperty.do?productId=${object.id}"/>'"
           type="button" class="am-btn am-btn-default am-btn-xs"
           style="margin-bottom: 6px;margin-left:2px;height: 35px;"
           value="非遗项目属性"/>
    <input onclick="showDiv()"
           type="button" class="am-btn am-btn-default am-btn-xs"
           style="margin-bottom: 6px;margin-left:2px;height: 35px;"
           value="上传商品图片"/>
</div>
<div id="uploadProductImg" style="display:none;text-align: left;margin-left: 10px;">
        <input  id="btn_upload" style="margin-bottom: 6px;margin-left:2px;height: 35px;" />
        <input type="button" class="am-btn am-btn-primary" style="margin-bottom: 6px;margin-left:2px;height: 35px;" value="保存"
               onclick="javascript:$('#btn_upload').uploadify('upload', '*');"/>
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
                        <img src="<%=imgBasePath %>${Img.imgUrl}<%=imgListCss %>"/>
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
            <strong class="am-text-primary am-text-lg">非遗项目属性列表</strong>
        </div>
    </div>
    <div am-panel am-panel-default admin-sidebar-panel>
        <table class="am-table am-table-bordered am-table-radius am-table-striped">
            <tr>
                <td>项目属性名</td>
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
<c:if test="${!empty object.tenantProductSeries.craft}">
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
                            <img src="<%=imgBasePath %>${img.imgUrl}<%=imgListCss %>"/>
                        </c:if>
                    </c:forEach>
                </td>
            </tr>
        </table>
    </div>
</c:if>
<%-- 商品认证信息 --%>
<c:if test="${!empty object.tenantProductSeries.tenantCertification}">
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
                <td>${object.tenantProductSeries.tenantCertification.name}</td>
                <td>${object.tenantProductSeries.tenantCertification.org}</td>
                <td><fmt:formatDate value="${object.tenantProductSeries.tenantCertification.theDate}" pattern="yyyy年MM月"/></td>
                <td>
                    <ming800:status name="level" dataType="PCTenantCertification.level" checkedValue="${object.tenantProductSeries.tenantCertification.level}" type="normal" />
                </td>
                <td>
                    <c:forEach items="${object.tenantProductSeries.tenantCertification.imgList}" var="tenantCertificationImg">
                        <c:if test="${not empty tenantCertificationImg.imgUrl}">
                            <img src="<%=imgBasePath %>${tenantCertificationImg.imgUrl}<%=imgListCss %>"/>
                        </c:if>
                    </c:forEach>
                </td>
            </tr>
        </table>
    </div>
</c:if>
<script type="text/javascript">
    var flg =true;
    function showDiv(){
        var pf=document.getElementById("uploadProductImg");
        if(flg){
            pf.setAttribute("style","display");
        }else{
            pf.setAttribute("style","display:none");
        }
        flg = !flg;
    }
    $(function () {
        $('#btn_upload').uploadify({
            uploader: '<c:url value="/productImg/saveProductImg.do"/>;jsessionid=<%=request.getSession().getId()%>',            // 服务器处理地址
            swf: '<c:url value="/scripts/upload/uploadify.swf"/>',
            buttonText: "选择商品图片",                 //按钮文字
            buttonClass: "am-btn-primary",         //按钮样式
            buttonCursor: "hand",                    //鼠标指针悬停在按钮上的样子
            height: 34,                             //按钮高度true
            width: 140,                              //按钮宽度
            auto: false,                          //自动上传
            multi: true,                            //多个文件上传
            scriptDate: {'status': '3'},
            checkExisting: true,                    //检查文件重复
            successTimeout: 1000000,                 //超时
            fileSizeLimit: '2MB',
            removeTimeout: 1,                        //移除时间
            fileTypeExts: "*.jpg;*.png;",           //允许的文件类型
            fileTypeDesc: "请选择图片文件",           //文件说明
            formData: {"productId": "${object.id}"}, //提交给服务器端的参数
            onQueueComplete: function (queueData) {
                window.location.href = "<c:url value='/basic/xm.do?qm=viewProduct&product=product&id=${object.id}'/>";
            }
        });
        $("#btn_upload-button").css({"padding": "0em 0em", "text-align": "center"});
    });
</script>
</body>
</html>
