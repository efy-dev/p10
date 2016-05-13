<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/25
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title></title>


    <style type="text/css">
        .line {
            margin-bottom: 20px;
        }

        /* 复制提示 */
        .copy-tips {
            position: fixed;
            z-index: 999;
            bottom: 50%;
            left: 50%;
            margin: 0 0 -20px -80px;
            background-color: rgba(0, 0, 0, 0.2);
            filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr=#30000000, endColorstr=#30000000);
            padding: 6px;
        }

        .copy-tips-wrap {
            padding: 10px 20px;
            text-align: center;
            border: 1px solid #F4D9A6;
            background-color: #FFFDEE;
            font-size: 14px;
        }
    </style>
    <script type="text/javascript" src="<c:url value='/scripts/zclip/jquery.zclip.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/scripts/recommended.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/resources/js/ef.util.js'/>"></script>
</head>
<body>


<%--<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>--%>
<div>
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-6">
        </div>
        <div class="am-u-sm-12">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>
                    <th class="table-set" width="30%">操作</th>
                    <th class="table-title">礼品名称</th>
                    <th class="table-title">礼品图片</th>
                </tr>
                </thead>
                <tbody>


                <c:forEach items="${requestScope.pageInfo.list}" var="productGift">
                    <tr id="${subject.id}">
                        <security:authorize ifAnyGranted="admin,operational,c_operational,o_operational">
                            <td>
                                <div class="am-btn-toolbar">
                                    <div class="am-btn-group am-btn-group-xs">

                                        <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                           onclick="createIndustrySolutionProductGift(this,'${productGift.id}')">
                                            关联
                                        </a>

                                    </div>
                                </div>
                            </td>
                        </security:authorize>
                        <td class="am-hide-sm-only" width="10%">
                            <a href="#">
                                    ${productGift.name}
                            </a>
                        </td>
                        <td class="am-hide-sm-only" width="10%">
                            <img src="http://pro.efeiyi.com/${productGift.productModel.productModel_url}@!product-model">

                            </a>
                        </td>

                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div style="clear: both">
        <c:url value="/basic/xm.do" var="url"/>
        <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
            <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
            <ming800:pcPageParam name="industrySolutionId"
                                 value="${pageContext.request.getParameter('industrySolutionId')}"/>
            <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
        </ming800:pcPageList>
    </div>
</div>
<script>

    var inductrySolutionId = '${pageContext.request.getParameter("industrySolutionId")}'

    function createIndustrySolutionProductGift(element, giftId) {
        var url = "<c:url value="/productGiftIndustrySolution/saveOrUpdate.do"/>";
        var success = function (data) {
            if (data) {
                $(element).click(function () {
                    alert("已关联");
                });
                $(element).html("已关联");
            }
        }
        ajaxRequest(url, {giftId: giftId, industryId: inductrySolutionId}, success, function () {
        }, "get");
    }

</script>

</body>
</html>
