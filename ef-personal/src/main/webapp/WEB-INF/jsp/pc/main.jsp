<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>

<html>
<head>
    <title></title>
    <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/css/seller.css?v=20151218"/> ">
</head>
<body>
    <c:if test="${review=='1'}">
    <div class="wh step">
        <div class="step1"></div>
    </div>
    <div class="wh info">
        <div class="table">
            <div class="enter-btn .wh"><a href="<c:url value="basic/xm.do?qm=viewTenant1&id=${master.id}"/> ">完&nbsp;善&nbsp;信&nbsp;息</a>
        </div>
        <div class="enter-flow wh">入&nbsp;驻&nbsp;流&nbsp;程</div>
        <div class="wh enter-wh">
            <div style="width: 100%;display: inline-block"><img src="<c:url value="/scripts/images/0309-pic.jpg"/>"
                                                                style="width: 100%;float: left"></div>
        </div>
    </div>
    </c:if>
    <c:if test="${review=='2'}">
    <div class="audit">
        <div class="wh step">
            <div class="step2"></div>
        </div>
        <div class="wh tips"><strong>e飞蚁会在7个工作日内反馈审核结果，您可登陆查看审核状态，也可通过拨打400-876-8766</strong></div>
        <div class="wh info">
            <div class="btns">
                <%--<a href="<c:url value="basic/xm.do?qm=viewTenant1&id=${master.id}"/>" class="btn-link">店铺信息</a>--%>
                <a href="<c:url value="basic/xm.do?qm=viewTenant1&id=${master.id}"/>" class="btn-link">入驻信息</a>
            </div>
            <div class="table">
                <h1>审核日志</h1>
                <table width="100%">
                    <tr>
                        <th width="20%">入驻审核结果</th>
                        <th width="20%">操作时间</th>
                        <th width="60%">详 情</th>
                    </tr>
                    <c:forEach var="masterReview" items="${masterReviewList}">
                        <tr>
                            <td class="tc">
                                <p>
                                    审核未通过
                                </p>
                            </td>
                            <td class="tc">
                                <p>
                                    <fmt:formatDate value="${masterReview.createDateTime}"
                                                    pattern="yyyy-HH-mm hh:mm:ss"/>
                                </p>
                            </td>

                            <td class="tl">
                                <p>
                                        ${masterReview.content}
                                </p>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>
    </c:if>
    <c:if test="${review=='3'}">
    <div class="audit">
        <div class="wh step">
            <div class="step1"></div>
        </div>
        <div class="wh tips"><strong>e飞蚁会在7个工作日内反馈审核结果，您可登陆查看审核状态，也可通过拨打400-876-8766</strong></div>
        <div class="wh info">
            <div class="btns">
                <a href="<c:url value="basic/xm.do?qm=viewTenant1&id=${master.id}"/>" class="btn-link">店铺信息</a>
                <a href="<c:url value="basic/xm.do?qm=viewTenant1&id=${master.id}"/>" class="btn-link">入驻信息</a>
            </div>
            <div class="table">
                <h1>审核日志</h1>
                <table width="100%">
                    <tr>
                        <th width="20%">入驻审核结果</th>
                        <th width="20%">操作时间</th>
                        <th width="60%">详 情</th>
                    </tr>
                    <c:forEach var="masterReview" items="${masterReviewList}">
                        <tr>
                            <td class="tc">
                                <p>
                                    审核未通过
                                </p>
                            </td>
                            <td class="tc">
                                <p>
                                    <fmt:formatDate value="${masterReview.createDateTime}"
                                                    pattern="yyyy-HH-mm hh:mm:ss"/>
                                </p>
                            </td>

                            <td class="tl">
                                <p>
                                    <span>${masterReview.content}</span>
                                    <a class="btn-link"
                                       href="<c:url value="basic/xm.do?qm=viewTenant1&id=${master.id}"/>">修 改</a>

                                </p>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>
    </c:if>
    <c:if test="${review=='4'}">
    <div class="audit">
        <div class="success">
            <h2>恭喜您审核通过，欢迎入驻e飞蚁商户后台！</h2>
            <div class="brid">
                <ul>
                    <li>请仔细阅读以下内容：</li>
                    <li>使用流程：</li>
                    <li><img src="<c:url value="/scripts/images/audit1.jpg"/>" alt=""/></li>
                    <li>1、查看店铺基本信息，关联大师与项目。其中，关联项目为必填项。</li>
                    <li>2、上传商品，按照要求填写商品基本信息，上传商品图片。</li>
                    <li>3、到“商品列表”页面点击“上架”，完成该商品的上架出售。</li>
                    <li>4、发货，用户可在“订单管理”页面查看并处理订单，并在“发货记录管理”中查看发货状态。</li>
                    <li>具体使用说明详见<a style="color:#f90" target="_blank" href="<c:url value="/help.do"/>">《商户后台使用手册》</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    </c:if>
</body>
</html>
